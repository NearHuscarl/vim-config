#!/bin/env bash

# Usage:
# $ ./skeleton.sh

# Dependencies:

SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
USAGE="Usage: $SCRIPT_NAME [-h]"
HELP="\
$SCRIPT_NAME <command>
Commands:
  -h, --help      print this help message"

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

function die() { # {{{
	echo "$*" >&2
	exit 1
}
# }}}
function usage() { # {{{
	die "$USAGE"
}
# }}}
function help() { # {{{
	echo "$HELP"
}
# }}}
function main() { # {{{
	local cmd="${1:-}"

	case "$#" in
		0)
			usage ;;
		*)
			case "$cmd" in
				-h|--help)
					help ;;
				*)
					usage ;;
			esac
	esac
}

main "$@"
# }}}
