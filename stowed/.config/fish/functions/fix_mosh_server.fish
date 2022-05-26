# https://github.com/mobile-shell/mosh/issues/898

function fix_mosh_server --description "Update fw rules to point to the current mosh-server location."

	set -l socketfilterfw "/usr/libexec/ApplicationFirewall/socketfilterfw"
	set -l mosh_sym "$(which mosh-server)"
	set -l mosh_abs "$(greadlink -f "$mosh_sym")"

	sudo $socketfilterfw --add "$mosh_sym"
	sudo $socketfilterfw --unblockapp "$mosh_abs"
end
