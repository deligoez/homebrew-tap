class Ev < Formula
  desc "Agent-first home inventory"
  homepage "https://github.com/deligoez/ev"
  version "0.21.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.21.0/ev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "89522996093f0fac91062d86298b111c4055e00631d40338480cd64f32914210"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.21.0/ev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3c6443c0284e6b0bf1c9f30d0d85b04508463c0436da7b3500fad71d03c83486"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.21.0/ev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93b0c4795100efff67a3b38de01d52d753f3f285e1909fe1699f9a3c6f15b2e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.21.0/ev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "228a49f818978027464b79d7b414b4a8d967635ff10e2fa27a8bdb0c2a6da175"
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
