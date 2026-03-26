# claude-sounds

> v0.2 — early release, more sounds and themes coming soon

Your Claude Code shouldn't be silent. Carefully selected sounds for 10 key events — writes, reads, bash, web, agents, prompts. 21 sound files with random selection for variety. Drop your own mp3s to customize.

## Install

```bash
claude plugins marketplace add https://github.com/culminationAI/claude-marketplace
claude plugins install claude-sounds@culmination-marketplace
```

Restart Claude Code after installation.

> macOS, Linux, Windows

## Sound Map

| Event | Pattern | Description |
|-------|---------|-------------|
| Write / Edit | `write-*.mp3` | Pen & pencil scratching |
| Read / Grep / Glob | `read-*.mp3` | Page flipping |
| Bash | `bash-pre-*.mp3` | Force pulse |
| WebSearch | `web-search-*.mp3` | Electric crackle |
| WebFetch | `web-fetch-*.mp3` | Curse spell |
| Agent started | `agent-start-*.mp3` | Spawn sound |
| Agent finished | `agent-stop-*.mp3` | Completion chime |
| User prompt | `user-prompt-*.mp3` | Stone tap |
| Stop | `stop-*.mp3` | Birds chirping |
| Notification | `notification-*.mp3` | Alert ping |

## Customize

All hooks use random selection from matching files. To add variety, just drop more mp3s following the naming pattern:

```
sounds/
├── write-01.mp3
├── write-02.mp3    ← add your own
├── write-03.mp3
├── read-01.mp3
├── bash-pre-01.mp3
├── bash-pre-02.mp3 ← add your own
└── ...
```

## Sound Sources

Included sounds sourced from:
- [Kenney](https://kenney.nl) (CC0)
- [OpenGameArt](https://opengameart.org) (CC0 / CC-BY)
- [BigSoundBank](https://bigsoundbank.com) (CC0)
- Custom recordings

## Roadmap

- [ ] More sound themes (sci-fi, nature, retro)
- [ ] Linux support (`paplay`/`aplay`)
- [ ] Theme switching command
- [ ] Volume control per hook

## License

MIT
