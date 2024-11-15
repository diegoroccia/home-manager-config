## AppArmor Configuration for GUI Apps

Some GUI applications, such as Google Chrome and Electron-based apps, may fail to start due to sandboxing issues. To resolve this, run the following command:

```bash
echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns
```

## Additional packages

these need to be installed system wide
- uidmap

```

I also dumped the list of packages in [PACKAGES.md](./PACKAGES.md)
