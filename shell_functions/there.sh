function here {
  id="$1"
  if [ $# -eq 0 ]; then
    id='default'
  fi
  here_path="$HOME/.here/$id"
  pwd > $here_path
}

function there {
  id="$1"
  if [ $# -eq 0 ]; then
    id='default'
  fi
  here_path="$HOME/.here/$id"
  if test -f $here_path; then
    cat "$here_path"
    cd `cat "$here_path"`
  else
    echo "No saved path $id."
  fi
}

function where {
  if [ $# -eq 0 ]; then
    #ls $HOME/.here
    for f in `ls $HOME/.here`
    do
      echo $f '==>' `cat $HOME/.here/$f`
    done
  else
    id="$1"
    here_path="$HOME/.here/$id"
    cat $here_path
  fi
}


function nowhere {
  for f in $*
  do
    rm "$HOME/.here/$f"
  done
}



