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

Edit the `FROM` instruction in `Dockerfile`. For example, you can run on the `python` image like the following:

```Dockerfile
FROM python:3.14-slim
```

### "How to lint my Python app?"

Add settings to `extensions` and `vscode` in `devcontainer.json`. It is the same with `extensions.json` and `settings.json`.

```json
  "customizations": {
    "extensions": [
      "charliermarsh.ruff",
      ...
    ],
    "vscode": {
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

### "VS Code does not recognize `.git` on the parent directory"

Mount the parent as a workspace and configure the subdirectory as `workspaceFolder` like the follwoing:

```json
  "workspaceMount": "source=${localWorkspaceFolder}/..,target=/workspace,type=bind,consistency=delegated",
  "workspaceFolder": "/workspace/myapp",
```

## License

See [LICENSE.md](/LICENSE.md).
