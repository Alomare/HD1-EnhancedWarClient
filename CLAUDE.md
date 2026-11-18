# Rules for this repository

Shared rules: `../../CLAUDE.md` (HD1 mods) and `../../../CLAUDE.md` (the workspace).

**Every release has a changelog.** Before tagging, add a section for the version to `CHANGELOG.md`, headed `## <version>`. Each change is one list item, starting `- New:`, `- Changed:`, `- Fixed:` or `- Removed:`, and describes the change briefly and directly. The shared Release workflow publishes that section as the release notes on GitHub, and stops if the section is missing or breaks the rules for public text.

**Tests:** `luajit tests/run.lua` from the repository root (LuaJIT at `ProjectObsidian/ObsidianLauncher/target/luajit/luajit.exe`).

**How it works:** the companion mod of the `enhanced` war model in Obsidian Commander (contract: `ObsidianCommander/docs/spec-m1.md`). Obsidian switches it on when an Enhanced war is created, selected or joined (`ObsidianLauncher/core/src/commander/client.rs`). The loader tells the mod which war is played through `obsidian.war()`, `{ id, model }` or nil, from the `war` and `war_model` lines of the settings file; `src/detect.lua` reads it. Client scope until the mod changes what other players see. The archived Evolved War Engine (tag `archive/evolved-war` in the Launcher and Commander) shows how a war mod drew the galaxy map and reported missions through the relay; the relay routes it used were removed.
