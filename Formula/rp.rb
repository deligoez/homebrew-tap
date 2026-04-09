class Rp < Formula
  desc "Repo manager CLI — organize, sync, and bootstrap your Developer workspace"
  homepage "https://github.com/deligoez/rp"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/deligoez/rp/releases/download/v0.4.2/rp_0.4.2_macOS_arm64.tar.gz"
      sha256 "1700e040a0ade3f6b864b8a079d084776f553f9300c2817d475ae4aca007b965"
    end

    on_intel do
      url "https://github.com/deligoez/rp/releases/download/v0.4.2/rp_0.4.2_macOS_x86_64.tar.gz"
      sha256 "03aa652d9b9eb96dda116d88b0e77ccd3048e3e5b6e830206ebe84ac83a105a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/deligoez/rp/releases/download/v0.4.2/rp_0.4.2_linux_arm64.tar.gz"
      sha256 "d1b9e65bbfbf2117e6b4ca4768da39d14932185a7b556f1c1269d6a8c5967191"
    end

    on_intel do
      url "https://github.com/deligoez/rp/releases/download/v0.4.2/rp_0.4.2_linux_x86_64.tar.gz"
      sha256 "e706960180848b455fdc4390760cdc47a3dd76b606680e1efa4f30681c5d2b56"
    end
  end

  def install
    bin.install "rp"
  end

  test do
    assert_match "rp version", shell_output("#{bin}/rp --version")
  end
end
