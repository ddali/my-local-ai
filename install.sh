#!/usr/bin/env bash
# my-local-ai 跨 Agent 安装脚本（macOS / Linux）
# 用法： bash install.sh
# 注意：本脚本的 Agent 映射与 manifest.json 保持一致；改映射时两边同步。

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"
SLUG='my-local-ai'
# 兼容更早两版的旧标记，升级时识别并清理：external-thinking、fitness-coach
LEGACY='ai-external-thinking|ai-fitness-coach'
MARK_START="<!-- ${SLUG}:start -->"
MARK_END="<!-- ${SLUG}:end -->"

install_skill() {
  local dest_root="$1"
  local dest="$dest_root/$SLUG"
  mkdir -p "$dest"
  # 按内容覆盖拷贝，不先删目录，避免个别文件系统删不干净再套一层子目录。
  cp -R "$ROOT/skill/$SLUG/." "$dest/"
  echo "  Skill -> $dest"
}

# 写入（或更新）带标记的规则区块；重复执行不产生重复区块，已有区块刷新为最新正文。
set_marker_section() {
  local target="$1" body="$2"
  mkdir -p "$(dirname "$target")"
  local block="$MARK_START
$body
$MARK_END"
  if [ ! -f "$target" ]; then
    printf '%s\n' "$block" > "$target"
  elif grep -qE "($LEGACY|$SLUG):start" "$target"; then
    awk -v legacy="$LEGACY" -v slug="$SLUG" '
      BEGIN { re = "<!-- (" legacy "|" slug "):" }
      $0 !~ re "start -->" { if (!in_block) print }
      $0 ~ re "start -->" { in_block=1 }
      $0 ~ re "end -->" { in_block=0 }' "$target" > "$target.tmp" && mv "$target.tmp" "$target"
    { echo; echo; echo "$block"; } >> "$target"
  else
    cp "$target" "$target.bak-$SLUG"
    { echo; echo; echo "$block"; } >> "$target"
  fi
  echo "  规则 -> $target"
}

# 删除旧落点（SOUL.md）里的规则标记区块。
strip_marker() {
  local target="$1"
  [ -f "$target" ] || return 0
  grep -qE "($LEGACY|$SLUG):start" "$target" || return 0
  awk -v legacy="$LEGACY" -v slug="$SLUG" '
    BEGIN { re = "<!-- (" legacy "|" slug "):" }
    $0 !~ re "start -->" { if (!in_block) print }
    $0 ~ re "start -->" { in_block=1 }
    $0 ~ re "end -->" { in_block=0 }' "$target" > "$target.tmp" && mv "$target.tmp" "$target"
  echo "  已清理旧规则区块 -> $target"
}

install_rule() {
  local id="$1" detect_dir="$2" rule_src="$3" rule_type="$4" rule_tgt="$5"
  [ -z "$rule_src" ] && return 0
  local body
  body="$(cat "$ROOT/rules/$rule_src")"

  # memoryMd：WorkBuddy 引擎把个人目录 MEMORY.md 装配为常驻指令槽位；
  # SOUL.md 是人格/语气槽位，指令遵从度弱，只作旧落点清理，不再写入。
  if [ "$rule_type" = "memoryMd" ]; then
    local found=0
    for dir in "$HOME_DIR/$detect_dir"/user-*-personal; do
      [ -d "$dir" ] || continue
      found=1
      set_marker_section "$dir/MEMORY.md" "$body"
      strip_marker "$dir/SOUL.md"
    done
    if [ "$found" -eq 0 ]; then
      echo "  未找到 $id 个人目录（user-*-personal），规则跳过；首次启动该 Agent 后重跑脚本。"
    fi
    local legacy="$HOME_DIR/$detect_dir/AGENTS.md"
    if [ -f "$legacy" ] && grep -qE "$LEGACY|$SLUG" "$legacy"; then rm -f "$legacy"; fi
    return 0
  fi

  [ -z "$rule_tgt" ] && return 0
  set_marker_section "$HOME_DIR/$rule_tgt" "$body"
}

# 格式： id|detectDir|skillRoot|ruleSource|ruleTargetType|ruleTarget
AGENTS=(
  "dsh|.dsh|.agents/skills|AGENTS.md|agentsMd|.agents/AGENTS.md"
  "codex|.codex|.agents/skills|AGENTS.md|agentsMd|.codex/AGENTS.md"
  "claude-code|.claude|.claude/skills|CLAUDE.md|agentsMd|.claude/CLAUDE.md"
  "workbuddy|.workbuddy|.workbuddy/skills|WORKBUDDY.md|memoryMd|"
  "codebuddy|.codebuddy|.codebuddy/skills|AGENTS.md|agentsMd|.codebuddy/AGENTS.md"
  "pi|.pi|.pi/agent/skills|AGENTS.md|agentsMd|.pi/agent/AGENTS.md"
  "prime-agent|.prime|.prime/agent/skills|AGENTS.md|agentsMd|.prime/agent/AGENTS.md"
  "gemini-antigravity|.gemini|.gemini/config/skills|GEMINI.md|agentsMd|.gemini/GEMINI.md"
  "cursor-cli|.cursor|.cursor/skills|cursor.mdc|agentsMd|.cursor/rules/my-local-ai.mdc"
  "opencode|.opencode|.agents/skills|||"
  "qwen-code|.qwen|.qwen/skills|||"
  "kimi-code|.kimi-code|.kimi-code/skills|||"
  "zcode|.zcode|.zcode/skills|||"
  "traecode|.trae-cn|.trae-cn/skills|||"
  "copilot-cli|.copilot|.copilot/skills|||"
  "grok-build|.grok|.grok/skills|||"
  "cline-cli|.cline|.cline/data/settings/skills|||"
  "factory-droid|.factory|.factory/skills|||"
)

echo "检测到的 Agent 配置目录："
for entry in "${AGENTS[@]}"; do
  IFS='|' read -r id detect_dir skill_root rule_src rule_type rule_tgt <<< "$entry"
  if [ -d "$HOME_DIR/$detect_dir" ]; then echo "  $id [已安装]"; else echo "  $id [未检测到]"; fi
done

echo; echo "[1/3] 安装 Skill"
install_skill "$HOME_DIR/.agents/skills"
for entry in "${AGENTS[@]}"; do
  IFS='|' read -r id detect_dir skill_root rule_src rule_type rule_tgt <<< "$entry"
  case "$skill_root" in .agents/*) continue;; esac
  if [ -d "$HOME_DIR/$detect_dir" ]; then
    install_skill "$HOME_DIR/$skill_root"
  fi
done

echo; echo "[2/3] 安装全局规则"
for entry in "${AGENTS[@]}"; do
  IFS='|' read -r id detect_dir skill_root rule_src rule_type rule_tgt <<< "$entry"
  if [ -d "$HOME_DIR/$detect_dir" ]; then
    install_rule "$id" "$detect_dir" "$rule_src" "$rule_type" "$rule_tgt"
  fi
done

# 双库独立根，与共享技能根 ~/.agents/skills 分开，避免和其他插件的通用目录互相踩。
DATA_ROOT="$HOME_DIR/.my-local-ai"

echo; echo "[3/3] 落地双库骨架"
for lib in agent-library methodology-library; do
  legacy="$HOME_DIR/.agents/$lib"
  dest="$DATA_ROOT/$lib"
  # 旧版本双库平铺在 ~/.agents/ 下；新目录不存在时整体搬过来，两边都在则只补缺失骨架。
  if [ -d "$legacy" ] && [ ! -d "$dest" ]; then
    mkdir -p "$DATA_ROOT"
    mv "$legacy" "$dest"
    echo "  旧库目录迁移 -> $dest"
  fi
  mkdir -p "$dest"
  # 只补缺，不覆盖本地已回填的沉淀条目和索引
  (cd "$ROOT/libraries/$lib" && find . -type f | while read -r f; do
    rel="${f#./}"
    [ -f "$dest/$rel" ] || { mkdir -p "$(dirname "$dest/$rel")"; cp "$ROOT/libraries/$lib/$rel" "$dest/$rel"; }
  done)
  echo "  双库骨架 -> $dest"
done

# 按端生成活跃伙伴指针；已存在的活跃身份不覆写（默认主伙伴取 manifest.defaultCompanion，留空则写占位）
DEFAULT_COMPANION=""
if [ -z "$DEFAULT_COMPANION" ]; then
  DEFAULT_COMPANION="<伙伴名>（名册首位主伙伴，首次使用前在 companions/index.md 指定）"
fi
ACTIVE_DIR="$DATA_ROOT/agent-library/companions/active"
mkdir -p "$ACTIVE_DIR"
for entry in "${AGENTS[@]}"; do
  IFS='|' read -r id detect_dir skill_root rule_src rule_type rule_tgt <<< "$entry"
  [ -d "$HOME_DIR/$detect_dir" ] || continue
  pointer="$ACTIVE_DIR/$id.md"
  if [ ! -f "$pointer" ]; then
    printf '# 本端活跃伙伴指针\n\n- 当前伙伴：%s\n- 更新时间：%s\n- 切换原因：默认主伙伴\n' "$DEFAULT_COMPANION" "$(date '+%Y-%m-%d %H:%M')" > "$pointer"
    echo "  活跃指针 -> $pointer"
  fi
done

echo; echo "完成。豆包工作桌面版需手动粘贴 rules/doubao-preference.md 到 设置 → 工作模式设置 → 个性化 → 工作任务偏好指令。"
