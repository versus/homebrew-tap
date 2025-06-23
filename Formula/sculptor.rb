# sculptor.rb
class Sculptor < Formula
  desc "Tool to help you generate CloudFormation templates from AWS CDK constructs"
  homepage "https://github.com/sequring/sculptor"
  version "0.8.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_amd64.tar.gz"
      sha256 "5e40523c91039229417cdecef48cc1ef5e0bf67177ba831592c5e23ffe989ffe"
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_darwin_arm64.tar.gz"
      sha256 "16e0a458b8fb28aa7aa9ba4463b51e790a2076241b5c20623f065fd96208defe"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_amd64.tar.gz"
      sha256 "30e93a19bee4a2a5b6268ace8b567934cb6d874d0860e2ec6d7b83e5bd2139dc"
    elsif Hardware::CPU.arm?
      url "https://github.com/sequring/sculptor/releases/download/v#{version}/sculptor_#{version}_linux_arm64.tar.gz"
      sha256 "707adbadb944d2f727eb350d9905d1a94760c90dedf0523760f0759c08a2e34d"
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