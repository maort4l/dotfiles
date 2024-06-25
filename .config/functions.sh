function update_nvim()
{
	pushd ~/nvim-macos-arm64
	rm -rf ~/nvim-macos-arm64/backup
	mkdir -p ~/nvim-macos-arm64/backup
	mv ~/nvim-macos-arm64/* ~/nvim-macos-arm64/backup
	curl -L -o nvim-macos.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
	xattr -c ./nvim-macos.tar.gz
	tar xzvf nvim-macos.tar.gz -C ~
	popd
}
