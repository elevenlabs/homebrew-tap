class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API"
  homepage "https://github.com/elevenlabs/cli"
  version "1.14.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.14.1/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "f3cc8f5e1ef4755e0a6d7398a2a09e7b13f45c7da968779be35df49252b33a59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.14.1/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "a2413c09c91e8198599b6aee5c5a51249483315c1c8f3f5ee6bbf71b5bcb60a1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.14.1/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "63beceb8655c1e28f7bc5f3bae4f1c69ee96f736d7dd445c759c6b43c15ecbaf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.14.1/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d4074d975873bb2db8079b9b688a6aac7b137305d3a9d067a49b03f7f1d3a54"
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
