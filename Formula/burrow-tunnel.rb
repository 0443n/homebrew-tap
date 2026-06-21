# Homebrew formula for burrow — prebuilt CLI (no compiling). Maintained by CI
# (publish-packages.yml bumps url + sha256 each release). macOS proxy CLI only.
class BurrowTunnel < Formula
  desc "Turn any SSH server into a local proxy and a system-wide VPN"
  homepage "https://github.com/0443n/burrow"
  version "0.3.1"
  url "https://github.com/0443n/burrow/releases/download/v0.3.1/burrow-0.3.1-universal-apple-darwin.tar.gz"
  sha256 "4d544c2ab659b4dbdb0cb8fffdb1c4f5e4b2c17e9fadcbeb185975b94a2c410d"
  license "GPL-3.0-or-later"

  depends_on :macos

  def install
    bin.install "burrow"
  end

  def caveats
    <<~EOS
      macOS ships the proxy CLI only — the system-wide VPN is Linux/Windows.

        burrow profile add work --host example.com --user alice
        burrow up work        # SOCKS5 + HTTP on 127.0.0.1:1080

      Point apps at socks5h://127.0.0.1:1080 (socks5h keeps DNS on the server).
    EOS
  end

  test do
    assert_match "burrow", shell_output("#{bin}/burrow --version")
  end
end
