# Shared AsciiDoc source

`src/asciiApp.template.html` is the single application source for both Windows launchers. `build.ps1` generates the viewer and editor pages with their mode baked into the source. This avoids query strings and fragments, which can be lost when Windows opens local `file:` URLs.

- `asciiView.cmd` opens viewer mode by delegating to `asciiEdit.cmd --view`.
- `asciiEdit.cmd` opens editor mode; `asciiEdit.cmd --view` opens viewer mode.
- `asciiView/index.html` and `asciiEdit/index.html` are compatibility redirects to the generated pages. The editor opens in single-pane Visual mode; use Visual, Source, and Split to switch layouts.

On Windows, run `build.ps1` after changing the template and use `asciiEdit.cmd` or `asciiView.cmd` to launch. From WSL or another Bash shell, run `bash ./build.sh` after changing the template, then use `bash ./launch.sh` for the editor or `bash ./launch.sh view` for the viewer. The Bash launcher tries `wslview`, `xdg-open`, then Windows `cmd.exe`. Save writes to the opened AsciiDoc file when the browser grants a writable file handle; Save As uses the browser's native system save dialog. The browser and desktop environment choose the actual picker UI. These save actions require a browser with File System Access support. The app loads Asciidoctor.js from jsDelivr, so rendering requires internet access.


