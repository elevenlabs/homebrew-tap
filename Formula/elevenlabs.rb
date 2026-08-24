class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API"
  homepage "https://github.com/elevenlabs/cli"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "6ddaba567da1fb1b83d137755daf3921a73108e9d1f835fd2d38b10190e08b13"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "5ef88d865c12b83d275cde44f7004c97ba5bc52aea05843cbf35250a00ff68b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cae386eea20ba435562fdbf8f47591f89bf10006cdc3c17e71955c726a7f9c5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dedcbb0aa095f7a66181a42f533d7cd2f5e7ac1b5fee9f763ce9731ea91e57cf"
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
