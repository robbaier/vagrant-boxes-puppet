#------------------------------------------------------------------------------
# ls aliases
#------------------------------------------------------------------------------
alias ls='ls -AlhF --color'     # show almost all in human-readable format with file-type indicators and color
alias la='ls -Al --color'       # show hidden files
alias lx='ls -lXB --color'      # sort by extension
alias lk='ls -lSr --color'      # sort by size, biggest last
alias lc='ls -ltcr --color'     # sort by and show change time, most recent last
alias lu='ls -ltur --color'     # sort by and show access time, most recent last
alias lt='ls -ltr --color'      # sort by date, most recent last
alias lm='ls -al --color|more'  # pipe through 'more'
alias lr='ls -lR --color'       # recursive ls
alias tree='tree -Csu'          # nice alternative to 'recursive ls'

#------------------------------------------------------------------------------
# cd aliases
#------------------------------------------------------------------------------
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'

#------------------------------------------------------------------------------
# chmod shortcuts
#------------------------------------------------------------------------------
# recursively set directories (only) to 775
alias 'modd'='find . -type d -exec chmod 775 {} \;'

# recursively set files (only) to 664
alias 'modf'='find . -type f -exec chmod 664 {} \;'
