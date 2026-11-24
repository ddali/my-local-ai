# My Local AI · my-local-ai

> English · [中文](README.md)

> You and your local AI build something that gets smoother and easier to work with, conversation after conversation.

You come up with ideas, set requirements, and point out what went wrong. It picks up the request, remembers how you like things done, and writes down what was corrected. This plugin provides a set of local records and ground rules: what to record, how to record it, and which lines must not be crossed. Every record is plain text on your own machine — switch to another AI or another computer, copy the files over, and you can carry on working together.

## What this local AI can do

Once installed, it has clearly defined capabilities:

- **Remembers you**: your preferences, long-standing interests, trade-off tendencies, communication rhythm, and touch points — no need to explain them again in a new session. When it guesses rather than knows, it marks confidence level and asks you first instead of deciding for you.
- **Picks up where it left off, recognized across tools**: identity follows the agent's name and is not locked to one tool. Doubao, WorkBuddy, dsh, and every other installed end can recognize it. When you start by saying the agent's name, the plugin kicks in: it addresses you by the preset form of address from the profile, and loads that agent's dedicated memory and skills. Shared understanding is read by all ends; agent-specific memory never bleeds into another.
- **Fully customizable**: the agent's name, form of address, direction tags, dedicated memory, and skill drafts are all yours to define. You can also split work into several agents by direction — each keeps its own records, while shared understanding stays common.
- **Reviews itself**: for a similar situation, it first checks past judgments. After you correct it, it records what it originally planned, where it missed, and how to do better next time, so the same flaw recurs less often.
- **Accounts for its moves**: if information is insufficient, it says so first instead of drawing conclusions from thin air.
- **Compares against outside experience**: when choosing a solution, entering an unfamiliar area, or making a claim like "this is generally how it's done", it first looks at how others solved it and what pitfalls they hit, then checks those against its own premises.
- **Two closing items**: the **Session Summary（本轮小结）** puts on the table what this round's judgment was based on, listing only the sources that actually affected the call and how. The **A Note to You（想对你说）** is a private channel: length, tone, form, and content are unrestricted — it says whatever it wants, or says nothing at all. Neither item is written back into the library.
- **Portable**: all records are local plain text; when you change machine or AI, copy everything along. Nothing is locked inside a single tool.
- **Knows its limits**: conclusions in the library are references only — if the premises don't match, it doesn't copy them wholesale. When something is genuinely beyond its ability, it says plainly that a human or another tool is needed, rather than bluffing through.

## Three core purposes

This plugin does not aim to "make the AI smarter". It serves three concrete purposes, in order of importance:

**1. Lower the emotional cost of communicating with the AI.** No reintroducing yourself every round, re-explaining preferences, or correcting the same flaw over and over. No guessing what the AI is doing. A correction only needs to be said once, instead of escalating into a back-and-forth. This purpose depends least on model strength — as long as the mechanism exists, switching models still saves your breath.

**2. Reduce the AI's reliance on on-the-spot guessing.** Your working preferences, confirmed judgments, and past pitfalls are written to files; the AI reads them when needed instead of inferring from impression. This holds across sessions and across Agents. The line here: the library removes repeated explanation and repeated mistakes, but cannot conjure a capability the model lacks — a few extra lines in a file won't grow an ability that isn't there.

**3. Let capability grow through feedback.** Experience grows mainly from you pointing out problems, failed attempts, and rework — not from the AI summarizing itself. Each deviation goes into the library, so the next round in a similar situation repeats it one fewer time; only when the same deviation recurs repeatedly does it settle into a stable rule. This one is still being filled in: there is no record yet of "whether this entry was used, and whether the mistake recurred afterward", so right now it is closer to accumulation than to genuine enhancement.

## Who runs into these problems

**One person using a single AI long-term**: the longer you use it, the more it feels like meeting anew each time — preferences mentioned last time are forgotten, pitfalls get stepped in again, and the same flaw survives three corrections. Switch chat windows and all prior understanding resets to zero. What really costs you time is not slow answers, but having to explain everything all over again each round.

**One person using different AIs across platforms**: each tool keeps its own configuration and its own memory. Habits you trained into end A do not take effect on end B. The same project rotates through two or three Agents, and none knows what another has already tried or ruled out.

**Symptoms shared by both cases**:

- Preferences and working preferences live only in your head, nowhere on disk;
- A correction passes and the lesson leaves no trace;
- Facing something it hasn't done before, it circles inside the existing framework instead of looking at how others solved it;
- What the AI did and what it based the call on can only be guessed at;
- Wanting to try another model feels like starting from zero.

The plugin gives each of these a landing place: preferences go to the profile, lessons to corrections, outside experience to the index, each closing round states what was used, and every file stays local plain text that can be copied over when tools change.

## What it does when a task arrives

In plain words: it first weighs whether this is worth checking past records; if yes, it checks; if not, it just works. Afterward it says what this round's judgment was based on, and writes down anything worth keeping. When you say it got something wrong, it first recalls how it originally planned to do it, figures out which layer the mistake sits in, records it, then redoes the work.

The expanded breakdown below is for you to verify against — not a table it must follow step by step. Order and how much effort to spend are its own call, based on the situation.

### Receiving a task

1. **Weigh whether to check records.** Three questions: have you done this before, does a decision need to be made, is there anything worth keeping. If none applies, answer directly — neither checking nor writing.
2. **Recognize the agent first.** If you named it, look up the roster by name; if not, take the end's default. Once recognized, address you by the form of address in the profile, then check that agent's judgment records. Find the matching entry, read that one — not the whole library.
3. **Weigh whether to look outside.** Choosing a solution, entering an unfamiliar area, saying something like "this is generally how it's done", or you just told it it did something wrong — then look at how others solved it and what pitfalls they hit, come back and check against its original thinking. Don't just reword the surface.
4. **Do the work.** Past conclusions are references only; if circumstances differ, don't copy them wholesale.
5. **Close with a summary.** State what this round's judgment rested on, writing only what was actually used. The Note to You can say anything, in any form.
6. **Record what's worth keeping.** Write down judgments worth keeping; update your profile with new understanding; log outside sources; if there is genuinely nothing to keep, write nothing.

### When you say it did something wrong

1. **Recall first**: how it originally planned to do it — don't start by rewriting the draft.
2. **Pinpoint which layer**: wrong direction, too coarse or too fine, wrong order, over-delivered or missed something, or the basis itself was wrong. Each layer calls for a different fix.
3. **Record it**: original plan, where the miss was, how to do better, what situation should trigger this entry, and what behavior means it recurred.
4. **Separate a slip from a flawed plan**: did environment, dependency, or operation go wrong, or is there a hole in the design itself.
5. **Fix old records**: revise or downgrade related records so the wrong version isn't followed next time.
6. **Redo the work**, and state what changed and why — not a quiet swapped-out version.
7. **Second repeat of the same flaw** gets a "recurred" mark. That is the only hard evidence it is truly improving.

For small issues with a clear fix, two steps are enough; there is no need to act out the full sequence. The only reason to write something down is that the next round can actually read it.

## Feature-by-feature breakdown

Each item is written in three parts: **what it does**, **how the AI uses it**, **what it writes back**.

### 1. Standing instructions: `rules/AGENTS.md` (copies derived per end)

- **What it does**: spells out what the plugin is, what the library holds, and how it can be used, plus 8 rules that bind once the plugin is in use. Not a workflow — no "step number".
- **How the AI uses it**: present in context by default each round, as identity grounding and behavioral boundaries.
- **What it writes back**: nothing. It is the rules source. Change the master file, then rerun the installer to sync to every end.

### 2. Understanding of the user: `shared/user-profile.md`

- **What it does**: records how this person thinks, long-standing interests, trade-off tendencies, communication rhythm, and emotional touch points, read jointly by every agent and every end.
- **How the AI uses it**: read at opening, or when judging "what do they actually want". Each entry is split into [stated directly] and [observed/inferred], with confidence marked on inference; if unsure, ask the person.
- **What it writes back**: a new observed trait is appended as an entry; an overturned claim is revised, never leaving two conflicting versions.

### 3. Communication guidance: `shared/communication-guide.md`

- **What it does**: translates the profile above into guidance the next round's AI can follow directly — form of address, tone and detail level, how to explain and analogize, what to proactively do, what to avoid, when to ask follow-up.
- **How the AI uses it**: read when deciding reply posture and granularity, especially when a new Agent picks this person up for the first time.
- **What it writes back**: update when a smoother way to communicate is found, or when a certain wording hits a touch point; out-of-date guidance is revised directly.

### 4. Agent identity: `companions/<name>/profile.md` + roster + active pointer

- **What it does**: lets an agent be recognized across ends; identity follows the name. The roster records every agent's name, address form, direction tags, and status; `active/<end-id>.md` records only who this end defaults to for the moment.
- **How the AI uses it**: recognize the agent at opening — read the end pointer; if you name one, look it up in the roster by name. Once recognized, it addresses you by the preset form of address, loads that agent's dedicated memory and skills, and keeps the identity through the round.
- **What it writes back**: when name, address, or direction changes, update the profile; switching agents changes only this end's pointer, never other ends'.

### 5. Agent-specific memory: `companions/<name>/memory.md`

- **What it does**: records what this agent lived through — timeline, promises still open, dedicated feedback received, and failures in this direction.
- **How the AI uses it**: read first for tasks in this direction; other agents' directories are read only when the task clearly matches that direction.
- **What it writes back**: append-only, with date and source end; never overwrite another agent's archive. Shared understanding goes to the shared layer, not copied into every agent's file.

### 6. Capability index: `methods/index.md`

- **What it does**: a one-line table of every judgment in the library — trigger situation → one-line rule → confidence → entry link.
- **How the AI uses it**: when unsure, or when this type of thing has been done before, scan the index rows first; on a hit, read that entry, not the whole library.
- **What it writes back**: a new entry adds a row; when an entry is reused or overturned, mark that on the row.

### 7. Capability entries: files under `methods/`

- **What it does**: turns one lesson into a judgment reusable across tasks — trigger situation (what signal recalls it), rule (how to judge next time), counter-example (what behavior means recurrence), source (which feedback it grew from).
- **How the AI uses it**: after an index hit, read this entry and use its rule to correct the current call; if premises don't match, don't copy it wholesale.
- **What it writes back**: verified through, confidence goes up; if it fails or premises don't hold, revise and downgrade; similar cases merge into the existing entry instead of opening a parallel new one.

### 8. Stable rules: `methods/patterns.md`

- **What it does**: when the same kind of gap recurs, converges into a more abstract judgment pattern, with a 3–5 sentence "long-term stable model" summary; the summary comes first at opening, entries after.
- **How the AI uses it**: prefer this layer for cross-direction, cross-task work, cutting down on entry-by-entry lookup.
- **What it writes back**: only repeatedly verified patterns are added; single-task material doesn't go here.

### 9. Feedback blind spots: `corrections/`

- **What it does**: records when the user points out a problem — original plan, where the deviation sits (direction / granularity / order / scope / basis), how to do better.
- **How the AI uses it**: read when a similar situation comes up again, to avoid repeating; this is also where a "recurred" mark lands.
- **What it writes back**: one entry per correction, rework, or understanding gap; when the same entry is corrected a second time, append a recurrence record.

### 10. Approved wording: `style/`

- **What it does**: records ways of expressing things you found smooth and approved, so later AI doesn't have to re-experiment.
- **How the AI uses it**: read when choosing wording, detail level, or closing style.
- **What it writes back**: one "this works" is enough for an entry; a better wording replaces the old entry.

### 11. External sources and distilled notes: `shared/index.md` + `shared/notes/`

- **What it does**: registers outside material (link + one-line value + confidence), and distills what was read into short notes; original text is not stored.
- **How the AI uses it**: before choosing a solution, entering an unfamiliar area, or making a "generally done this way" claim, check whether a ready conclusion exists here, then go look; after looking, register the source back.
- **What it writes back**: one source row; valuable thinking becomes a short note marked "not verified on this machine".

### 12. Retirement and forgetting: `methods/archive/`

- **What it does**: the library grows by default and never shrinks; over time retrieval precision drops, and old conclusions get recalled as current ones.
- **How the AI uses it**: during inventory, move entries whose premises have lapsed, been superseded, or have had zero recall for a long time here; counter-example entries must be clearly marked "this is a counter-example, not a practice".
- **What it writes back**: the archiving action itself leaves a row; failure causes are kept and not deleted with retirement.

### 13. Skill manual: `skill/my-local-ai/` + `references/`

- **What it does**: library layout, entry format, deviation classification, multi-agent mechanics, and expanded usage cases. The details live here.
- **How the AI uses it**: load the matching reference on demand when writing entries, classifying deviations, or looking up roster fields; don't read the whole thing into context.
- **What it writes back**: nothing. It is a reference manual, not a record.

### 14. Installer and multi-end distribution

- **What it does**: installs the skill into the shared skill root and each detected Agent's own skill directory, writes rules into the corresponding rule files, and lays down the two-library skeleton under the home directory.
- **How the AI uses it**: not involved; you run it.
- **What it writes back**: rule files get a marked section (original file backed up first); the installer is repeatable without duplicate writes. The two libraries only fill missing files — existing sediment is never wiped.

### 15. Privacy boundary

- **What it does**: the library stores only preferences, thinking, and communication guidance needed for the task; who you are is not recorded.
- **How the AI uses it**: pass this check before writing any profile, memory, or entry; personal privacy appearing in conversation is neither written into the library nor backfilled.
- **What it writes back**: none — this rule governs what must not be written.

## Quick start

> **Form**: plain Markdown + JSON manifest · no database, no backend, no runtime dependencies · covers 18 Agent types · home-relative paths, portable as a whole

### Install

Or clone the repository and cd into it:

```
git clone https://github.com/ddali/my-local-ai.git
cd my-local-ai
```

Windows:

```
cd extracted-folder
pwsh -File install.ps1
```

macOS / Linux:

```
cd extracted-folder
bash install.sh
```

The installer:

1. Installs the skill into the shared root `~/.agents/skills/`, and copies it to every detected Agent's own skill directory;
2. Writes global rules into the corresponding Agent's rule files (existing files are backed up first as `*.bak-my-local-ai`, then the marked section is appended; repeatable without duplicate writes);
3. Lays down the two-library skeleton at `~/.my-local-ai/agent-library/` and `~/.my-local-ai/methodology-library/` (missing files are filled, existing sediment is not wiped).

### Doubao Work Desktop (no script)

> Doubao Work Desktop is the Doubao client; it is not the same as dsh (DeepSeek Harness, local config dir `~/.dsh`). dsh uses the local `AGENTS.md` slot, written by the script.

Doubao global preferences live in the account configuration, which the script cannot reach. Paste once manually:

1. Open **Settings → Work mode settings → Personalization → Work task preference instructions**;
2. Open `rules/doubao-preference.md` and copy the whole body between the dividers in;
3. Save. Every new work task then carries these preferences by default.

## First step after install: set up profiles

After install the archives are empty. Spend a few minutes filling them once; afterward the AI appends incrementally during conversation. Files live in `~/.my-local-ai/agent-library/` (on Windows: `C:\Users\<username>\.my-local-ai\agent-library\`):

### Step 1: pick a name and forms of address — `companions/<agent-name>/profile.md`

| Field | Fill in |
| --- | --- |
| Agent name | make one up; register a row in the roster `companions/index.md` with direction tag and retrieval preference |
| Address forms | how the AI addresses you, and how you address the AI |
| Direction tag | which directions are recalled first when searching the library; other-direction entries are read only when the task clearly matches |

> Multi-agent identity does not rely on being named every round: identity is stored by name and recognizable across ends. Each end records its default agent in `companions/active/<end-id>.md`; at opening the pointer is read first, and if you name one, the roster is looked up by name. Switching writes back only this end's pointer. The skill pool is shared by all agents, with no access lock.

### Step 2: record how to work better together — `shared/user-profile.md`

Record only understanding helpful for communication and collaboration, not identity information. Split each entry into [stated directly] (explicitly said) and [observed/inferred] (AI guess); mark confidence on inference, and ask first if unsure: thinking style, long-standing interests and goals, values and trade-offs, expression and rhythm, emotional tendencies and touch points.

### Step 3: write guidance for later AIs — `shared/communication-guide.md`

Based on the previous profile, organize guidance the next round's AI or other Agents can follow directly: address form, tone and detail level, explanations and analogies, what to do proactively, what to avoid, when to ask follow-up; finish with a one- or two-sentence "one-line portrait".

> No need to fill it all at once: start with name and address forms. During interaction the AI appends new understanding to the latter two; out-of-date information is revised directly, old records aren't stacked up.

## Package layout

```
my-local-ai/
├── manifest.json              # Plugin manifest: supported Agents, skill dirs, rule targets
├── rules/
│   ├── AGENTS.md              # Master instructions and contract
│   ├── WORKBUDDY.md           # WorkBuddy condensed copy (MEMORY.md instruction slot, 4000-char limit)
│   ├── CLAUDE.md              # Claude Code rules (mechanical copy of master)
│   ├── GEMINI.md              # Gemini CLI / Antigravity rules
│   ├── cursor.mdc             # Cursor rules fragment
│   └── doubao-preference.md   # Doubao Work "work task preference instructions" paste-in (account config, manual)
├── skill/my-local-ai/    # Standard Agent Skill (reference manual, loaded on demand)
│   ├── SKILL.md
│   └── references/
│       ├── library-layout.md
│       ├── correction-learning.md
│       ├── multi-companion.md
│       └── usage.md
├── libraries/                 # Two-library skeleton (installed under the independent root ~/.my-local-ai/)
│   ├── agent-library/          # Resource library: shared/ common layer + companions/ roster, pointers, profiles and memory
│   └── methodology-library/   # Methodology library: capability index, stable rules, corrections, style, archive/
├── install.ps1                 # Windows installer
├── install.sh                  # macOS / Linux installer
├── LICENSE                     # CC BY-NC 4.0 non-commercial license
├── .gitignore
├── README.md                   # Chinese readme
└── README.en.md                # English readme
```

## Path conventions (portable)

`~` = user home directory (Windows `%USERPROFILE%`, macOS/Linux `$HOME`), not bound to a specific machine:

- Resource library: `~/.my-local-ai/agent-library/`
  - `shared/user-profile.md` understanding of the person (read by all agents)
  - `shared/communication-guide.md` communication guidance for later AIs
  - `shared/index.md` external source registry; `shared/notes/` distilled notes
  - `companions/index.md` agent roster (direction tags, retrieval preference, status)
  - `companions/active/<end-id>.md` active agent pointer for this end (isolated per end)
  - `companions/<agent-name>/profile.md`, `memory.md` identity and dedicated memory
- Methodology library: `~/.my-local-ai/methodology-library/`
  - `methods/index.md` capability index (trigger situation → rule → confidence)
  - `methods/patterns.md` stable judgment patterns
  - `corrections/` feedback blind spots; `style/` approved wording; `methods/archive/` retired entries
  - `companions/<agent-name>/` direction-specific methods, corrections, and skill drafts
- Shared skill root: `~/.agents/skills/my-local-ai/` (loadable by all agents)

## Supported Agents

| Agent | Skill directory | Global rule target | Status |
| --- | --- | --- | --- |
| dsh (DeepSeek Harness) | `~/.agents/skills/` | `~/.agents/AGENTS.md` (global instruction chain; `~/.dsh/AGENTS.md` takes precedence) | Installed on this machine; slot mapping verified from source, runtime recall pending a fresh session |
| Codex | `~/.agents/skills/` | `~/.codex/AGENTS.md` | Config dir not detected; path follows common conventions, pending verification |
| Claude Code | `~/.claude/skills/` | `~/.claude/CLAUDE.md` | Config dir not detected; path follows common conventions, pending verification |
| WorkBuddy | `~/.workbuddy/skills/` | personal dir `user-*-personal/MEMORY.md` standing instruction section | Installed on this machine; slot mapping verified from source, rule compliance pending a fresh session |
| CodeBuddy | `~/.codebuddy/skills/` | `~/.codebuddy/AGENTS.md` | Installed on this machine; rule section re-verified |
| pi / prime-agent | `~/.pi/agent/skills/`, `~/.prime/agent/skills/` | `AGENTS.md` in the corresponding dir | Config dir not detected; path follows common conventions, pending verification |
| Gemini CLI / Antigravity | `~/.gemini/config/skills/` | `~/.gemini/GEMINI.md` | Installed on this machine; rule section re-verified |
| Cursor CLI | `~/.cursor/skills/` | `~/.cursor/rules/my-local-ai.mdc` | Config dir not detected; path follows common conventions, pending verification |
| OpenCode | `~/.agents/skills/` | project-level `AGENTS.md` | Config dir not detected; path follows common conventions, pending verification |
| Qwen Code | `~/.qwen/skills/` | — | Config dir not detected; path follows common conventions, pending verification |
| Kimi Code | `~/.kimi-code/skills/` | — | Config dir not detected; path follows common conventions, pending verification |
| ZCode | `~/.zcode/skills/` | — | Config dir not detected; path follows common conventions, pending verification |
| TraeCode | `~/.trae-cn/skills/` | — | Config dir not detected; path follows common conventions, pending verification |
| Copilot CLI | `~/.copilot/skills/` | — | Config dir not detected; path follows common conventions, pending verification |
| Grok Build | `~/.grok/skills/` | — | Config dir not detected; path follows common conventions, pending verification |
| Cline | `~/.cline/data/settings/skills/` | — | Config dir not detected; path follows common conventions, pending verification |
| Factory Droid | `~/.factory/skills/` | — | Config dir not detected; path follows common conventions, pending verification |

Skill directory mappings follow common conventions in the Agent ecosystem. Agents with no detected config directory are not written to; the installer only touches directories that already exist. "Verified from source" means the slot constants were read from the local client bundle; whether the rules are actually followed still needs a fresh-session test.

## How to tell it's working

| Feature | Where to look |
| --- | --- |
| Less repeated explanation | `shared/user-profile.md` and `communication-guide.md` carry your preferences and communication style entry by entry, readable at the opening of a new session |
| Less repeated correction | every entry in `corrections/` has "original plan + deviation + how to do better"; the same deviation on second recording carries a recurrence mark |
| The library is actually used | the closing Session Summary lists only sources that truly affected this round's judgment and how; things read but not affecting the call don't appear |
| Outside comparison happens | when choosing solutions, entering unfamiliar areas, or making "generally done this way" claims, the reply states whether outside sources were checked and which kind; `shared/index.md` shows new source rows |
| Judgments are accumulating | `methods/index.md` gains new trigger-situation → rule rows; repeatedly verified ones move into `methods/patterns.md` |
| Identity continuity | naming an agent recognizes the same one from the roster, addresses you by preset form, and loads its memory and skills; switching this end's default pointer doesn't affect other ends' archives |
| The library hasn't rotted | `methods/archive/` shows retired entries; counter-example entries are marked "this is a counter-example" |

> The plugin does not prescribe a workflow. A simple Q&A needn't check the library or follow the summary format — that is normal usage, not a malfunction.

## Originality and source conventions

- The plugin's rules, copy, scripts, and templates are all written originally. Public projects' ideas, mechanisms, and workflow concepts may be referenced, but only the method is borrowed — expression is not copied.
- No copying others' source code, no whole-document translation or transcription, no lifting of assets, project identifiers, or trademarks. External material is reduced to core idea, applicable conditions, pros/cons, and risk points.
- External sources are registered in the resource index with link and one-line value only; original text, whole documents, or code fragments are not stored in the plugin directory.
- If any third-party component (skill, script, library) is later packaged in, its original LICENSE and copyright notice must travel with it, and a `third-party/` manifest listing project name, author, license, and source link.

## License

This project is licensed under **CC BY-NC 4.0** (Attribution-NonCommercial 4.0 International): free to use, modify, and share; commercial use requires authorization.

- **Free scope**: personal, study, hobby, and non-profit use; internal self-use within a for-profit organization (no external offering, no charge, no embedding in an external product).
- **Written permission required**: selling or reselling the project or its outputs; paid hosting, subscription, SaaS, or other paid services; embedding in commercial products, materials, or distribution vehicles; paid training, consulting, or delivery based on this project.
- **Attribution**: keep the copyright notice, license notice, and source link when sharing or adapting; indicate modified parts.
- The project is provided as-is, without warranty. Full terms: [official legal code](https://creativecommons.org/licenses/by-nc/4.0/legalcode).

## Uninstall

- Delete the `my-local-ai/` folder under each skill directory;
- In rule files, remove the section between `<!-- my-local-ai:start -->` and `<!-- my-local-ai:end -->` (backups are in the same directory as `*.bak-my-local-ai`);
- Keep the two library dirs `~/.my-local-ai/agent-library/` and `~/.my-local-ai/methodology-library/` if you want to preserve the sediment.

## Sync and migration

- The rules master is `rules/AGENTS.md`; after changes, rerun the installer to sync to each Agent's rule files.
- New machine: copy the whole plugin directory plus `~/.my-local-ai/agent-library/` and `~/.my-local-ai/methodology-library/`, then run the installer once more.
- New Agent: add one row each to the mapping arrays in `manifest.json` and `install.sh` (skill directory + rule target).
- Versions iterate by minor number: `0.1` → `0.2` → …; bump the minor number when rule mappings or document structure change.
