shopt -s extglob
complete -f -X '*.@(o|so|so.!(conf|*/*)|a|[rs]pm|gif|jp?(e)g|mp3|mp?(e)g|avi|asf|ogg|class|foo|bar|pdf)' v vi vim gvim rvim view rview rgvim rgview gview
