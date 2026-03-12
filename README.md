# claude-devcontainer-slim

Run native Claude Code in devcontainer with minimum dependencies. It is based on the [official example](https://github.com/anthropics/claude-code/tree/main/.devcontainer) but run the native build without Node.js. It also removes unnecessary packages and settings.

## Usage

1. Copy `.devcontainer` directory to your workspace:

```bash
$ git clone https://github.com/okapies/claude-devcontainer-slim.git
$ cp -r claude-devcontainer-slim/.devcontainer ${YOUR_WORKSPACE}
```

2. _Ctrl+Shift+P_ in VS Code and run _"Remote-Containers: Reopen in Container"_

## FAQ

### "I want to use XXX image"

You can use any Debian/Ubuntu based image by just editing `FROM` instruction in `Dockerfile` like the following:

```Dockerfile
FROM python:3.14-slim
```

### "How to lint my Python codes?"

Add settings to `extensions` and `vscode` in `devcontainer.json`. It is the same with `extensions.json` and `settings.json`.

```json
  "customizations": {
    "extensions": [
      "charliermarsh.ruff",
      ...
    ],
    "vscode": {
      "python.defaultInterpreterPath": "/usr/local/bin/python3",
      "[python]": {
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
          "source.organizeImports": "explicit"
        },
        "editor.defaultFormatter": "charliermarsh.ruff"
      },
      "ruff.enable": true,
      ...
    }
  }
```

### "How to setup app dependencies when building container?"

Configure `postCreateCommand` [lifecycle script](https://containers.dev/implementors/json_reference/#lifecycle-scripts) in `devcontainer.json`:

```json
  "postCreateCommand": "bash .devcontainer/setup.sh",
```

then place the setup script:

```bash
#!/bin/bash
set -euo pipefail

pip3 install -r /workspace/requirements.txt
```

### "VS Code does not recognize `.git` on the parent directory"

Mount the parent as a workspace and configure the subdirectory as `workspaceFolder` like the follwoing:

```json
  "workspaceMount": "source=${localWorkspaceFolder}/..,target=/workspace,type=bind,consistency=delegated",
  "workspaceFolder": "/workspace/myapp",
```

## Changelog

### 2026/03/12

- Make Claude Code setup as a local feature
- Migrate bookworm into trixie
- Update LICENSE and NOTICE

### 2026/03/11

- Initial commit

## License

See [LICENSE](/LICENSE) and [NOTICE](/NOTICE).
