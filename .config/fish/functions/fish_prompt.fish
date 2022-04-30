set fish_prompt_pwd_dir_length 0

function fish_prompt
    set _status $status

    set _user (set_color brblue)(whoami)
    set _at (set_color -o normal)@
    set _host (set_color brblue)(uname -n)
    set _colon (set_color -o normal)' : '
    set _pwd (set_color brcyan)(prompt_pwd)
    set _cmd (set_color -o normal)'> '(set_color normal)

    if [ $_status != 0 ]
        set _status (set_color brred)' ('$_status')'
    else
        set _status ''
    end

    if [ $SSH_CLIENT ]
        set _ssh (set_color brred)' ['(echo $SSH_CONNECTION | awk '{print $3}')']'
    else
        set _ssh ''
    end

    set _git_info (git_info)
    if [ $_git_info ]
        set _git_info (set_color normal)' ('$_git_info(set_color normal)')'
    else
        set _git_info ''
    end

    printf '%s%s%s%s%s%s%s%s\n%s' $_user $_at $_host $_ssh $_colon $_pwd $_status $_git_info $_cmd
end

function git_info
    set _git_branch_name (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    set _git_tag_name (git describe --tags --exact-match 2>/dev/null)
    set _is_git_dirty (git status -s --ignore-submodules=dirty 2>/dev/null)

    if [ -n "$_git_tag_name" ]
        if [ -n "$_is_git_dirty" ]
            printf '%s' (set_color brred)$_git_tag_name
        else
            printf '%s' (set_color bryellow)$_git_tag_name
        end
    else if [ -n "$_git_branch_name" ]
        if [ -n "$_is_git_dirty" ]
            printf '%s' (set_color brred)$_git_branch_name
        else
            printf '%s' (set_color bryellow)$_git_branch_name
        end
    end

    printf ''
end

