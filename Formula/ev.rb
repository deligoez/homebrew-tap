class Ev < Formula
  desc "Agent-first home inventory"
  homepage "https://github.com/deligoez/ev"
  version "0.19.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.19.0/ev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b88dd3eb430887a332670d905130ed0508ae5d33f8b727bbcacc9a75ad6d5847"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.19.0/ev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "90282227b92f7d443165bbde3e0471137818242ce02acb211b0f3bf3575ba380"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.19.0/ev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "de9cb3892f082ca137b002bbaea0852a9e056d3f0c28cf45f17e84459416499e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.19.0/ev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "73465a28bf6752748957531cb8169448adfc9cb23d22c1c0dc5681560a977aa4"
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
