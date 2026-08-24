class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API Documentation"
  homepage "https://github.com/elevenlabs/cli"
  version "1.0.0-alpha.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.3/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "91db62d85f1140a32e21636e56b0133ee06d94eebecf610ce0315346c96dab89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.3/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "665d7f66b0a4ce4a4ea765e26dc868635595d6b2019d159094ee2ba727f0dcf3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.3/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "67be996d03d7339107e08222dceba77529861578fc82da4b7269c9698b914909"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.0.0-alpha.3/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d8758eedf2829d106592a9e4e942c7ed3e4900917cb573e950a17477ed98dc42"
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
