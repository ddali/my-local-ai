# my-local-ai 跨 Agent 安装脚本（Windows）
# 用法：在本目录下执行  pwsh -File install.ps1
# 可选参数： -ListAgents 只检测不安装； -SkillOnly 只装 Skill； -RuleOnly 只装规则； -LibOnly 只装双库骨架

param(
  [switch]$ListAgents,
  [switch]$SkillOnly,
  [switch]$RuleOnly,
  [switch]$LibOnly
)

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$homeDir = $env:USERPROFILE
$manifest = Get-Content (Join-Path $root 'manifest.json') -Raw | ConvertFrom-Json
$slug = 'my-local-ai'
$start = "<!-- ${slug}:start -->"
$end = "<!-- ${slug}:end -->"
# 兼容更早两版的旧标记，升级时识别并清理：external-thinking、fitness-coach
$legacyMarks = 'ai-external-thinking|ai-fitness-coach'
$markerPattern = "(?s)<!-- (?:$legacyMarks|$slug):start -->.*?<!-- (?:$legacyMarks|$slug):end -->"

function Ensure-Dir([string]$path) {
  if (-not (Test-Path $path)) { New-Item -ItemType Directory -Force -Path $path | Out-Null }
}

# 刷新 Skill：目录已存在时按内容覆盖拷贝，不先删目录——
# 个别机器/文件系统上递归删目录会报“目录不是空的”，删不干净再拷还会套一层子目录。
function Install-Skill([string]$destRoot) {
  $dest = Join-Path $destRoot $slug
  Ensure-Dir $dest
  $srcDir = Join-Path $root $manifest.skillDir
  Copy-Item (Join-Path $srcDir '*') $dest -Recurse -Force
  Write-Host "  Skill -> $dest"
}

# 写入（或更新）带标记的规则区块；先剥掉所有旧标记区块（含历史 slug），再写一份新的，重复执行不产生重复区块。
function Set-MarkerSection([string]$target, [string]$body) {
  Ensure-Dir (Split-Path $target -Parent)
  $block = "$start`r`n$body`r`n$end"
  if (Test-Path $target) {
    $existing = Get-Content $target -Raw
    if ($existing -match $markerPattern) {
      $stripped = [regex]::Replace($existing, $markerPattern, '').TrimEnd()
      [IO.File]::WriteAllText($target, "$stripped`r`n`r`n$block`r`n", (New-Object Text.UTF8Encoding($false)))
    } else {
      Copy-Item $target "$target.bak-$slug" -Force
      Add-Content $target "`r`n`r`n$block`r`n" -Encoding UTF8
    }
  } else {
    [IO.File]::WriteAllText($target, "$block`r`n", (New-Object Text.UTF8Encoding($false)))
  }
  Write-Host "  规则 -> $target"
}

function Remove-MarkerSection([string]$target) {
  if (-not (Test-Path $target)) { return }
  $existing = Get-Content $target -Raw
  if ($existing -notmatch "(?:$legacyMarks|$slug):start") { return }
  $stripped = [regex]::Replace($existing, "(?s)\s*<!-- (?:$legacyMarks|$slug):start -->.*?<!-- (?:$legacyMarks|$slug):end -->\s*", "`r`n")
  [IO.File]::WriteAllText($target, $stripped.TrimEnd() + "`r`n", (New-Object Text.UTF8Encoding($false)))
  Write-Host "  已清理旧规则区块 -> $target"
}

function Install-Rule($agent) {
  $sourceName = $agent.ruleSource
  if (-not $sourceName) { return }
  $body = Get-Content (Join-Path $root "rules/$sourceName") -Raw

  # memoryMd：WorkBuddy 引擎把个人目录 MEMORY.md 装配为 <user_instructions>/<user_memory> 常驻指令槽位；
  # SOUL.md 是人格/语气槽位，指令遵从度弱，仅作为旧落点清理，不再写入。
  if ($agent.ruleTargetType -eq 'memoryMd') {
    $agentRoot = Join-Path $homeDir $agent.detectDir
    $personalDirs = Get-ChildItem $agentRoot -Directory -Filter 'user-*-personal' -ErrorAction SilentlyContinue
    if (-not $personalDirs) {
      Write-Host "  未找到 $($agent.id) 个人目录（user-*-personal），规则跳过；首次启动该 Agent 后重跑脚本。"
      return
    }
    foreach ($dir in $personalDirs) {
      Set-MarkerSection (Join-Path $dir.FullName 'MEMORY.md') $body
      Remove-MarkerSection (Join-Path $dir.FullName 'SOUL.md')
    }
    # 清理旧版本误写到用户根的 AGENTS.md
    $legacy = Join-Path $homeDir (Join-Path $agent.detectDir 'AGENTS.md')
    if (Test-Path $legacy) {
      $legacyContent = Get-Content $legacy -Raw
      if ($legacyContent -match "$legacyMarks|$slug") { Remove-Item $legacy -Force }
    }
    return
  }

  # 默认：写入 AGENTS.md / CLAUDE.md / GEMINI.md 等规则文件
  if (-not $agent.ruleTarget) { return }
  $target = Join-Path $homeDir ($agent.ruleTarget -join [IO.Path]::DirectorySeparatorChar)
  Set-MarkerSection $target $body
}

function Install-Libraries {
  $dataRoot = Join-Path $homeDir ([string]$manifest.dataRoot)
  foreach ($lib in $manifest.libraries) {
    $name = Split-Path $lib -Leaf
    # 旧版本（v0.35 及以前）双库平铺在 ~/.agents/ 下；新版本迁到独立根 ~/.my-local-ai/。
    # 旧目录存在、新目录还没有时整体搬过去；两边都在则只补缺失骨架，不动已有沉淀。
    $legacy = Join-Path (Join-Path $homeDir '.agents') $name
    $dest = Join-Path $dataRoot $name
    if ((Test-Path $legacy) -and -not (Test-Path $dest)) {
      Ensure-Dir $dataRoot
      Move-Item $legacy $dest
      Write-Host "  旧库目录迁移 -> $dest"
    }
    Ensure-Dir $dest
    $src = Join-Path $root $lib
    # 只补缺，不覆盖本地已回填的沉淀条目和索引
    Get-ChildItem $src -Recurse -File | ForEach-Object {
      $rel = $_.FullName.Substring($src.Length + 1)
      $target = Join-Path $dest $rel
      if (-not (Test-Path $target)) { Ensure-Dir (Split-Path $target -Parent); Copy-Item $_.FullName $target }
    }
    Write-Host "  双库骨架 -> $dest"
  }
}

function Install-ActivePointers {
  $dataRoot = Join-Path $homeDir ([string]$manifest.dataRoot)
  $activeDir = Join-Path $dataRoot 'agent-library/companions/active'
  Ensure-Dir $activeDir
  $default = [string]$manifest.defaultCompanion
  if ([string]::IsNullOrWhiteSpace($default)) {
    $default = "<伙伴名>（名册首位主伙伴，首次使用前在 companions/index.md 指定）"
  }
  # 按端各写各的指针；已存在的活跃身份不覆写
  foreach ($a in $detected) {
    $pointer = Join-Path $activeDir "$($a.id).md"
    if (-not (Test-Path $pointer)) {
      $body = "# 本端活跃伙伴指针`r`n`r`n- 当前伙伴：$default`r`n- 更新时间：$(Get-Date -Format 'yyyy-MM-dd HH:mm')`r`n- 切换原因：默认主伙伴`r`n"
      [IO.File]::WriteAllText($pointer, $body, (New-Object Text.UTF8Encoding($false)))
      Write-Host "  活跃指针 -> $pointer"
    }
  }
}

# 检测已安装的 Agent（按独立配置目录是否存在；共享根 .agents 不作为判据）
$detected = @()
foreach ($a in $manifest.agents) {
  $agentHome = Join-Path $homeDir $a.detectDir
  if (Test-Path $agentHome) { $detected += $a }
}

Write-Host "检测到的 Agent 配置目录："
foreach ($a in $manifest.agents) {
  $agentHome = Join-Path $homeDir $a.detectDir
  $mark = if (Test-Path $agentHome) { ' [已安装]' } else { ' [未检测到]' }
  Write-Host "  $($a.id)$mark"
}

if ($ListAgents) { return }

if (-not $RuleOnly -and -not $LibOnly) {
  Write-Host "`n[1/3] 安装 Skill"
  # 共享根：dsh / codex / opencode 等共同读取 ~/.agents/skills
  Install-Skill (Join-Path $homeDir '.agents/skills')
  foreach ($a in $detected) {
    $rootPath = Join-Path $homeDir ($a.skillRoot -join [IO.Path]::DirectorySeparatorChar)
    if ((Join-Path $homeDir $a.skillRoot[0]) -ne (Join-Path $homeDir '.agents')) {
      Install-Skill $rootPath
    }
  }
}

if (-not $SkillOnly -and -not $LibOnly) {
  Write-Host "`n[2/3] 安装全局规则"
  foreach ($a in $detected) {
    Install-Rule $a
  }
}

if (-not $SkillOnly -and -not $RuleOnly) {
  Write-Host "`n[3/3] 落地双库骨架"
  Install-Libraries
  Install-ActivePointers
}

Write-Host "`n完成。豆包工作桌面版需手动粘贴 rules/doubao-preference.md 到 设置 → 工作模式设置 → 个性化 → 工作任务偏好指令。"
