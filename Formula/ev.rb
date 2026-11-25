class Ev < Formula
  desc "Agent-first home inventory"
  homepage "https://github.com/deligoez/ev"
  version "0.33.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.33.2/ev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e9160ee184280d07dcd2019302ed613c6e1fe938fd372cf199a42182b87059f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.33.2/ev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c78ee75d9e733f154dfe8b5d8aae1a635dd27769267b0a4f4676bb1edf7e203e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/deligoez/ev/releases/download/v0.33.2/ev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e35b2457fdde4f67793160abc47dcd135be1afd2c8fcef2f1102b1c07f819af0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/deligoez/ev/releases/download/v0.33.2/ev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2ec2a0385c1d0b6252c0de50af6e64202625a49f4152fe0c1c0c13c08d4d80be"
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
