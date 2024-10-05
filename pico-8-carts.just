
mac_carts_folder := "$HOME/Library/Application Support/pico-8/carts"
linux_carts_folder := "$HOME/.lexaloffle/pico-8/carts"
windows_carts_folder := "~/AppData/Roaming/pico-8/carts"

carts_folder := if os() == "macos" {
  mac_carts_folder
} else if os() == "linux" {
  linux_carts_folder
} else {
  windows_carts_folder
}

# Open the carts folder in Finder
open:
  open "{{carts_folder}}"

# Open the carts folder in Visual Studio Code
vscode:
  code "{{carts_folder}}"

# Install recommended Visual Studio Code extensions
vscode-install-extensions:
  code --install-extension pollywoggames.pico8-ls

# Sync carts from Pico-8 to here
import:
  #!/bin/bash

  set -euo pipefail

  mkdir -p carts
  rsync -mzarv --exclude="demos/*" --include="*/" --include="*.p8" --include="*.p8.png" --include="*.lua" --exclude="*" "{{carts_folder}}/" "./carts/"

# Sync carts from here to Pico-8
export:
  #!/bin/bash

  set -euo pipefail

  mkdir -p "{{carts_folder}}"
  rsync -mzarv --exclude="demos/*" --include="*/" --include="*.p8" --include="*.p8.png" --include="*.lua" --exclude="*" "./carts/" "{{carts_folder}}/"

# Show a diff between the code here and PICO-8
diff:
  diff -ur carts/ "{{carts_folder}}"
