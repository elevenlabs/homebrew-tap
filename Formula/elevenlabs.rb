class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API"
  homepage "https://github.com/elevenlabs/cli"
  version "1.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.5.2/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "75722c9b0471a86d1a4788f85299a75e53726bf9145189bd76196cc7281445c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.5.2/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "29ae8fa1a9741a6fcd1114ee1b714149485757ec2954c42a7f7e5c666f5d9924"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.5.2/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ccfee831ff040c388103c451af44ecdd2e4db392e553e8851f2391581f8a9240"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.5.2/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31d0499aff66ecc920888731bca972de67c0c647658feb569ad58f39f86c135c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "elevenlabs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "elevenlabs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "elevenlabs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "elevenlabs"
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
