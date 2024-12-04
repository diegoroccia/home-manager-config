## AppArmor Configuration for GUI Apps

Some GUI applications, such as Google Chrome and Electron-based apps, may fail to start due to sandboxing issues. To resolve this, run the following command:

```bash
echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns
```

## Additional packages

these need to be installed system wide
- uidmap
- blueman
- docker (I am trying with rootless podman, but some stuff doesn't work ootb)

### Building python via pyenv:

```bash
❯ sudo apt install libreadline-dev \
    libssl-dev lzma liblzma-dev libbz2-dev \
    libsqlite3-dev tk libtk tk-dev libffi-dev
```

I also dumped the list of packages in [PACKAGES.md](./PACKAGES.md)
