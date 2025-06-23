class Yawsso < Formula
  include Language::Python::Virtualenv

  desc "Yet Another AWS SSO - sync up AWS CLI v2 SSO login session to legacy CLI v1 credentials"
  homepage "https://github.com/victorskl/yawsso"
  url "https://github.com/victorskl/yawsso/archive/refs/tags/1.2.1.tar.gz"
  sha256 "db5f77cb57d8b164b591b94d395e2fa2ccd45b68c80c04d189ace8799a928064"


  
  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin / "yawsso -h"
  end
end
