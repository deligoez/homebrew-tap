class Tp < Formula
  desc "Spec-to-task lifecycle manager for AI coding agents"
  homepage "https://github.com/deligoez/tp"
  version "0.20.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/deligoez/tp/releases/download/v0.20.0/tp_0.20.0_macOS_arm64.tar.gz"
      sha256 "21b0cf635d78c5934fca7ad20c2c0c364dc1d843fc27064ae460aa18266bc33f"
    end

    on_intel do
      url "https://github.com/deligoez/tp/releases/download/v0.20.0/tp_0.20.0_macOS_x86_64.tar.gz"
      sha256 "0c0207e2356d7ad9b32aa428b47e96317ac612d1b9674d82a8510f57aed20ed4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/deligoez/tp/releases/download/v0.20.0/tp_0.20.0_linux_arm64.tar.gz"
      sha256 "d598bc2eef68d9d7097b01b8397d3f6876487fd966a560d493f70c2e0857afaf"
    end

    on_intel do
      url "https://github.com/deligoez/tp/releases/download/v0.20.0/tp_0.20.0_linux_x86_64.tar.gz"
      sha256 "f8923d0ad2774e0dd916871a48f9b32a06966c5523d2cd4bd561c5b3783770d2"
    end
  end

  def install
    bin.install "tp"
  end

  test do
    assert_match "tp version", shell_output("#{bin}/tp --version")
  end
end
