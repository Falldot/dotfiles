rm -rf $HOME/.config/VSCodium/User
ln -s $(pwd)/settings/VSCodium/User $HOME/.config/VSCodium

rm -rf $HOME/.vscode-oss/extensions

while IFS= read -r line
do
    echo "$line"
    vscodium --install-extension $line
done < $(pwd)/settings/VSCodium/extensions