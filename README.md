# homebrew-tap

[Homebrew](https://brew.sh) tap for [burrow](https://github.com/0443n/burrow) —
turn any SSH server into a local SOCKS5 + HTTP proxy.

## Install

```sh
brew install 0443n/tap/burrow-tunnel
```

or:

```sh
brew tap 0443n/tap
brew install burrow-tunnel
```

This installs the `burrow` CLI. **macOS ships the proxy only** — the system-wide
VPN is Linux/Windows. Quick start:

```sh
burrow profile add work --host example.com --user alice
burrow up work          # SOCKS5 + HTTP on 127.0.0.1:1080
curl -x socks5h://127.0.0.1:1080 https://ifconfig.me
```

See the [main repository](https://github.com/0443n/burrow) for full docs.
