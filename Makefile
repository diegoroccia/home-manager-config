.PHONY: update
update:
	home-manager switch --impure --flake .#diegoroccia

.PHONY: clean
clean:
	nix-collect-garbage -d
