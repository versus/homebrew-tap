# sculptor.rb
class Sculptor < Formula
  desc "Tool to help you generate CloudFormation templates from AWS CDK constructs"
  homepage "https://github.com/sequring/sculptor"
  version "0.8.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_amd64.tar.gz"
      sha256 "8038f1f6ddbc6fde452f0b62853fd54958cee291e0204befb6032281ea718b95"
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_arm64.tar.gz"
      sha256 "936ae2bdcabe32baa406f008d61093d64ba2814ebca7e2a4a04c87db1a885a3c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_amd64.tar.gz"
      sha256 "57990c1b41561b8b5cc1dc0a0fcd087becef989d7840980d7dda12a888873437"
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_arm64.tar.gz"
      sha256 "1ce6c33d459e6215f5d22c32ad2fe5bf7a338ce854d2e010a1b3771773c66c5d"
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