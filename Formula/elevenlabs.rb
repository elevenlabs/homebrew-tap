class Elevenlabs < Formula
  desc "CLI for the ElevenLabs API"
  homepage "https://github.com/elevenlabs/cli"
  version "1.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.12.0/elevenlabs-cli-aarch64-apple-darwin.tar.gz"
      sha256 "8d3182517a1c123dd56bf9c800edf4f5e830c468716a23b98683aa07df1079fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.12.0/elevenlabs-cli-x86_64-apple-darwin.tar.gz"
      sha256 "f892cb9cc195527aebaa1dedbed966e6f125538e50da6f754495e0334fb24532"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/elevenlabs/cli/releases/download/v1.12.0/elevenlabs-cli-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d68e9e453b149d2815d05bfe29c56f1da9db2a0c064e02aa395cd74f65aab388"
    end
    if Hardware::CPU.intel?
      url "https://github.com/elevenlabs/cli/releases/download/v1.12.0/elevenlabs-cli-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5037d409ea06cca34d380a48827472055b49ad0367ffa98c71c69f650835408"
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
