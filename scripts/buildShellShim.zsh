if [ $1 = "--rcfile" ]; then
  # as last step of rc file start zsh
  echo -e "\nzsh" >> $2
  bash $2
else
  # if then command should simply be executed lets use bash
  # since we only need zsh for interactive stuff
  bash $1
fi
