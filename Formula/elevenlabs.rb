class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API"
  homepage "https://github.com/elevenlabs/cli"
  version "1.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.9.0/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "1fdfd07528f9ad1b18af30dbfa6f2b80a7a41521c6d608d76d828d6c1a832205"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.9.0/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "f182426baf5df8a77f3d8f936c188b063b39c13256048c772acc57e9b8b8fb93"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.9.0/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c0936034be5defe460af0ef3225905103588200772266c0feb24376db51d8d8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.9.0/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f596dee533bf1333bb80800f909d3c2dea377abb658ec60f22193fbaa9a5a26"
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
