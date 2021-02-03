current_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "installing vim plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "open vim and run :PlugInstall to install required plugins..."
