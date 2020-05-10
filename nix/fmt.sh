#! /usr/bin/env nix-shell
#! nix-shell ../shell.nix -i sh --arg isDevelopmentShell false
# Format nix files and check their formatting.
#
# USAGE:
#     ./nix/fmt.sh [--check]
# FLAGS:
#     --check    Only test if the formatter would change the files

set -euo pipefail
IFS=$'\n'

# These files are automatically generated.
ignore=(
./Cargo.nix
./nix/carnix/crates-io.nix
)
all=($(find . -name '*.nix'))
check=()

for i in "${all[@]}"; do
	skip=
	for j in "${ignore[@]}"; do
		[[ $i == $j ]] && { skip=1; break; }
	done
	[[ -n $skip ]] || check+=("${i}")
done

echo "${check[@]}" | xargs nixpkgs-fmt ${1-}
