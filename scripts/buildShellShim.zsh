if [ $1 = "--rcfile" ]; then
  # we ignore anything that is passed as an rc file. Fuckit!
  zsh
else
  # if then command should simply be executed lets use bash
  # since we only need zsh for interactive stuff
  bash $1
fi
