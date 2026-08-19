class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API Documentation"
  homepage "https://github.com/elevenlabs/cli"
  version "1.0.0-alpha.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.2/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "e98e45b81b52026eaf4bd3f6bfb59149b4deaaf896292616f9bf1c48ae50bfec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.2/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "96a40f3ef50d4fe43a11cb2944bb5f1e5dd9e5dbf98cc1e7721f750e3469a52f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.2/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "325d39ff120808f91e3bb4d851876e75b7fa86cbc04dbabba5fbb48cdb6af13a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.2/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7a8c442874be0f67bafeeae45a17d3631862f9197ce1357928b53acdac1b3237"
    end
  end
  license "Apache-2.0"

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
