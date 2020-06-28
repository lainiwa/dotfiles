
.PHONY: install
install:
	./install

.PHONY: update-dotbot
update-dotbot:
	git submodule update --remote dotbot

.PHONY: build_pyenv-deps
build_pyenv-deps:
	equivs-build ~/.dotfiles/metapackages/pyenv-deps
	sudo apt install --yes ./pyenv-deps_*.deb
	rm ./pyenv-deps_*.deb
