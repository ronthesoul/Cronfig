# Suggestions

### Project
Good work, yet none of my remarks were implemented.
- Missing files
  - CONRIBUTIONS.md
  - TASK.md

### README
- Missing link to
  - INSTALL.md
  - CONTRIBUTORS.md
  - TASKS.md

### SCRIPT
- there no validation on the script level whether it is debian based or not
- there is no strict  error checking `set -o pipefail` or `set -o errexit`
- use `.tmpl` files as template to host ASCII art instead of EOF/EOL
- no need to use endless amount of echo files, use one and structure aliases as strings
- `curl` can create folders, so no need to create  folders for that
- you are suppose to use [[ and not [
