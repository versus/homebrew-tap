# This file was generated by GoReleaser. DO NOT EDIT.
class Tfswitch < Formula
  desc "The tfswitch command lets you switch between terraform versions."
  homepage "https://versus.github.io/terraform-switcher"
  version "0.10.4"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/versus/terraform-switcher/releases/download/0.10.4/terraform-switcher_0.10.4_darwin_amd64.tar.gz"
    sha256 "2570a93e86572de3510f5bccb1bec27e2880d7fccd30139bf9a89f701bf257f4"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/versus/terraform-switcher/releases/download/0.10.4/terraform-switcher_0.10.4_linux_amd64.tar.gz"
      sha256 "0a36566df37c126a75ddd7014ccf8af1e286ecfd7d962db68f681fd459703684"
    end
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
