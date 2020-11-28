# This file was generated by GoReleaser. DO NOT EDIT.
class Tfswitch < Formula
  desc "The tfswitch command lets you switch between terraform versions."
  homepage "https://versus.github.io/terraform-switcher"
  version "0.11.1"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/versus/terraform-switcher/releases/download/0.11.1/terraform-switcher_0.11.1_darwin_amd64.tar.gz"
    sha256 "06a874b4ac46a0c36e07e1b19abb62cdb22acb91ef6ebf1d36800a7632c6ec21"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/versus/terraform-switcher/releases/download/0.11.1/terraform-switcher_0.11.1_linux_amd64.tar.gz"
    sha256 "9732f6b30fdab7b5872cb970c1094568b5e28ffc8aaca9b1dcbc5d61c52c58f7"
  end
  
  conflicts_with "terraform"

  def install
    bin.install "tfswitch"
  end

  def caveats; <<~EOS
    Type 'tfswitch' on your command line and choose the terraform version that you want from the dropdown. This command currently only works on MacOs and Linux
  EOS
  end

  test do
    system "#{bin}/tfswitch --version"
  end
end
