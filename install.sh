current_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf $current_path/init.vim ~/.config/nvim/init.vim

echo "installing vim plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf $current_path/ftplugin ~/.config/nvim/ftplugin

echo "open vim and run :PlugInstall to install required plugins..."
