# Homebrew formula for the burrow proxy CLI.
#
# Named `burrow-tunnel` to match the AUR package and because `burrow` already
# exists in homebrew-core (a different project). The installed binary is still
# `burrow`. This is the canonical copy; the published copy lives in the tap repo
# `0443n/homebrew-tap` at `Formula/burrow-tunnel.rb`. On a release: bump `url` to
# the new tag and refresh `sha256` (`brew fetch ./packaging/homebrew/burrow-tunnel.rb`
# prints it, or `shasum -a 256` the tarball), then sync it into the tap.
#
# Scope: macOS ships the proxy CLI only — `burrow` (SOCKS5/HTTP, unprivileged).
# The system-wide VPN (burrow-helper) is Linux/Windows for now, and the Slint GUI
# is not built on macOS by design.
class BurrowTunnel < Formula
  desc "Turn any SSH server into a local proxy and a system-wide VPN"
  homepage "https://github.com/0443n/burrow"
  url "https://github.com/0443n/burrow/releases/download/v0.2.1/burrow-0.2.1-universal-apple-darwin.tar.gz"
  sha256 "47744c9215ca8673e0d3198eb81d9e2e359ee78c4846b0a6ae35e9ca77db4ceb"
  license "GPL-3.0-or-later"
  head "https://github.com/0443n/burrow.git", branch: "main"

  depends_on "cmake" => :build # aws-lc-sys (russh's crypto backend) builds C
  depends_on "rust" => :build

  def install
    # Build just the `burrow` binary from its workspace crate — this never pulls
    # in the VPN helper or the Slint GUI member. `std_cargo_args` supplies
    # --locked --root #{prefix}; we override --path to the CLI crate.
    system "cargo", "install", *std_cargo_args(path: "crates/burrow-cli")
  end

  def caveats
    <<~EOS
      macOS ships the proxy CLI only — the system-wide VPN is Linux/Windows for
      now. The proxy needs no privileges:

        burrow profile add work --host example.com --user alice
        burrow up work        # SOCKS5 + HTTP on 127.0.0.1:1080

      Point apps at socks5h://127.0.0.1:1080 (socks5h keeps DNS on the server).
    EOS
  end

  test do
    assert_match "burrow", shell_output("#{bin}/burrow --version")
  end
end
