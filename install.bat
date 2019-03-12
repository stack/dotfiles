set DOTFILES=%cd%

cd %USERPROFILE%

mklink /H _vimrc %DOTFILES%\vimrc
mklink /J vimfiles %DOTFILES%\vim

cd %DOTFILES%
