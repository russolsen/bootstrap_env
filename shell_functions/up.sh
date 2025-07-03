function up {
  N=${1:-1}
  for i in `seq 1 $N`
  do
    cd ..
  done
  pwd
}

alias ..="cd .."
alias ...="up 1"
alias ....="up 2"
alias .....="up 3"
alias ......="up 4"

