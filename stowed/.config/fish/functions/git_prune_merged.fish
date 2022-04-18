# https://stackoverflow.com/a/67507704/18714042
function git_prune_merged --description 'Prune merged branches'
    set -l merged_branches (git branch --format '%(refname:short)' --merged | grep --invert-match 'main\|master\|stable');

    if test -n "$merged_branches"
        git branch --delete $merged_branches
    end
end
