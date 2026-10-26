# Shared AsciiDoc source

`src/asciiApp.template.html` is the single application source for both Windows launchers. `build.ps1` generates the viewer and editor pages with their mode baked into the source. This avoids query strings and fragments, which can be lost when Windows opens local `file:` URLs.

- `asciiView.cmd` opens viewer mode by delegating to `asciiEdit.cmd --view`.
- `asciiEdit.cmd` opens editor mode; `asciiEdit.cmd --view` opens viewer mode.
- `asciiView/index.html` and `asciiEdit/index.html` are compatibility redirects to the generated pages. The editor opens in single-pane Visual mode; use Visual, Source, and Split to switch layouts.

Run `build.ps1` after changing the template. Run a launcher by full path or add this folder to Windows `PATH`. The app loads Asciidoctor.js from jsDelivr, so rendering requires internet access.


