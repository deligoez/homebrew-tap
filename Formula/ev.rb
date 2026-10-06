class Ev < Formula
  desc "Agent-first home inventory"
  homepage "https://github.com/deligoez/ev"
  version "0.30.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.30.0/ev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "426e50e85a96c21c18a5024f1fe8d700a880b44b991af4f4d8ead9f89488e9f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.30.0/ev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9df8c48ccdb08909497ee077aa86a70084dcaeec37c50a0a2b2440b8a21dd798"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.30.0/ev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28ae0891a9e6dc893491b8fb2729c7c7b8289fa6beb4202c3a2106ee7cba900e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.30.0/ev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3f7009e73845a2f8c8fa02e08802b5bf1597618731733d98207240db45c68db4"
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
