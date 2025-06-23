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
      sha256 "187abde35c5017f88bed639013acf851d9efb08ff9787ba81c8bbbf018e0eaef"
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
    prefix.install "LICENSE"
  end

  test do
    assert_match "sculptor version v#{version}", shell_output("#{bin}/sculptor --version")
    system "#{bin}/sculptor", "help"
  end
end