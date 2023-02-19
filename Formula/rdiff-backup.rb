class RdiffBackup < Formula
  desc "Reverse differential backup tool, over a network or locally"
  homepage "https://rdiff-backup.net/"
  url "https://files.pythonhosted.org/packages/2e/8a/2cae44db2063a678937b68f24300b60aed15488ce1eb1a6da56052bf86ba/rdiff-backup-2.2.3.tar.gz"
  sha256 "0ec0e7c75277fa3f1d02fcc9c91c0b58e10c5e625cefd5ffd6b56ec293878fc9"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "0442f8b59a64d4226c41a938049cfc6ae9595cd1554f258e009025fd045d109d"
    sha256 cellar: :any,                 arm64_monterey: "d591f92a4f31ddf21df3b69fd54b3d4f0d3baf85eee6fd80bcdc4ac865cac261"
    sha256 cellar: :any,                 arm64_big_sur:  "86ef610964dfcfb6ff56cb30e01763d391c0bb5a61f34c70b4c5ac54b746bdc1"
    sha256 cellar: :any,                 ventura:        "6ad9cbc9a3c5d311456c35225aef68877c9a7dd2c2ee4b8fe24511b9fdd10f7a"
    sha256 cellar: :any,                 monterey:       "89925471a137383786ff72b7f95f9490c3eb2170c238b952f7d40377edfef57f"
    sha256 cellar: :any,                 big_sur:        "5b78c5031adb7120d0b7061071ce1d97c67b728bce502fea679899c63cbbd3d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8402f4fc9f6b3839ca55bdfd4acbbbdb0815fd5ae2a61037ac0ae5451ef5be11"
  end

  depends_on "librsync"
  depends_on "python@3.11"
  depends_on "pyyaml"

  def install
    python3 = "python3.11"
    system python3, *Language::Python.setup_install_args(prefix, python3), "--install-data=#{prefix}"
  end

  test do
    system "#{bin}/rdiff-backup", "--version"
  end
end
