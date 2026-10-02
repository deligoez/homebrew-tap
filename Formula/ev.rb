class Ev < Formula
  desc "Agent-first home inventory"
  homepage "https://github.com/deligoez/ev"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.20.0/ev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d1f40425dbdfd5823bf4392a01b778336765bab0909daa8c1f3ffbec9b9f3533"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.20.0/ev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4507d60bf942cd611c0926f3861fc2783602a5cbd361fa20bef0f13c1d718656"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.20.0/ev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "41f1654f593a19057cfb00f9a55510ca49bd72b5345046468d97302f29411c7f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.20.0/ev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ebba761c751e88880e13c0539969b6fde8ed04a30a3e45b7b9d72803756faaf"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ev"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ev"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ev"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ev"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
