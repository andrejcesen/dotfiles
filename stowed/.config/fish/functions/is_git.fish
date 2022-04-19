function is_git
  # git symbolic-ref HEAD &> /dev/null

  # Check if we are inside a work-tree (i.e. not in a bare repo)
  # https://stackoverflow.com/a/52654913/18714042
  set --local is_inside_git_work_tree (command git rev-parse --is-inside-work-tree 2>/dev/null)
  test "$is_inside_git_work_tree" = "true"
end
