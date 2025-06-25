# sculptor.rb
class Sculptor < Formula
  desc "Tool to help you generate CloudFormation templates from AWS CDK constructs"
  homepage "https://github.com/sequring/sculptor"
  version "0.8.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_amd64.tar.gz"
      sha256 "9bc4c072b8853e8b65468cedea779e4d629452538dd6c152a9eb09fd9fd96cef" # darwin amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_arm64.tar.gz"
      sha256 "c99c9f2ebf562d82b4ce4fdd07c67c11a1b8523689906e86b759f9defd0da3a4" # darwin arm64
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_amd64.tar.gz"
      sha256 "82b59bb063d258b37bd4e2124078b8f5412d3d111cd47820b967aca24644c2ae" # linux amd64
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_arm64.tar.gz"
      sha256 "546bbc16a32a3079095a526345ba12854098316f927c174ef2a4f03f21ed0ecf" # linux arm64
    end
  end

  def install
    bin.install "sculptor"
    prefix.install "LICENSE"
  end

  test do
    assert_match "sculptor version v#{version}", shell_output("#{bin}/sculptor --version")
    system "#{bin}/sculptor", "help"
  end
end