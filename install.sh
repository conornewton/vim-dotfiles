current_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf $current_path/vimrc ~/.vimrc

echo "installing vim plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.vim/colors
cd ~/.vim/colors

echo "installing colorscheme"
curl https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim > badwolf.vim

mkdir -p ~/.vim/ftplugin
ln -sf $current_path/ftplugin/tex.vim ~/.vim/ftplugin/tex.vim

echo "open vim and run :PlugInstall to install required plugins..."
