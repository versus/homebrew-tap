# sculptor.rb
class Sculptor < Formula
  desc "Tool to help you generate CloudFormation templates from AWS CDK constructs"
  homepage "https://github.com/sequring/sculptor"
  version "0.8.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_amd64.tar.gz"
      sha256 "9f79bb2333feb58f18c6ef597406beec3bf58c290f96a573baddf4f7fd6d86e3"
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_arm64.tar.gz"
      sha256 "f07a001a18c66e4a2d1d07b4618e7e224e23c0269f8c6b5ccb483c6dd4c442cf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_amd64.tar.gz"
      sha256 "c7564de19cbc0ab2d63a116b5672eb66a56cc82a6a782bdddbda2e1a8be79645"
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_arm64.tar.gz"
      sha256 "04513daeb710e6f20753ce79b65b90b92866e6a589ddc605aae38f3fc327ba04"
    end
  end

  def install
    bin.install "sculptor"
    bash_completion.install "completions/sculptor.bash" => "sculptor"
    zsh_completion.install "completions/sculptor.zsh" => "_sculptor"
    fish_completion.install "completions/sculptor.fish"
    prefix.install "LICENSE"
  end

  test do
    assert_match "sculptor version v#{version}", shell_output("#{bin}/sculptor --version")
    system "#{bin}/sculptor", "help"
  end
end