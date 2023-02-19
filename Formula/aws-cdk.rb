require "language/node"

class AwsCdk < Formula
  desc "AWS Cloud Development Kit - framework for defining AWS infra as code"
  homepage "https://github.com/aws/aws-cdk"
  url "https://registry.npmjs.org/aws-cdk/-/aws-cdk-2.65.0.tgz"
  sha256 "8ba465393105266540d05bcec50ce14be8524094ad230ad9d6ea8dad547ee25c"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "43f5fb3d65d7aa4955a6583ae94914b96455397a9980c647a5f80e87a7d7f765"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "43f5fb3d65d7aa4955a6583ae94914b96455397a9980c647a5f80e87a7d7f765"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "43f5fb3d65d7aa4955a6583ae94914b96455397a9980c647a5f80e87a7d7f765"
    sha256 cellar: :any_skip_relocation, ventura:        "9291e1ab785a282f89d042fb32717e5dbf0d78b65370aeeb9c387dde8f1010a3"
    sha256 cellar: :any_skip_relocation, monterey:       "9291e1ab785a282f89d042fb32717e5dbf0d78b65370aeeb9c387dde8f1010a3"
    sha256 cellar: :any_skip_relocation, big_sur:        "9291e1ab785a282f89d042fb32717e5dbf0d78b65370aeeb9c387dde8f1010a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f3353814bc4a2f82cc06579a485fc2db54b3585422a33dbbc402cfe6eda87238"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Replace universal binaries with native slices.
    deuniversalize_machos
  end

  test do
    # `cdk init` cannot be run in a non-empty directory
    mkdir "testapp" do
      shell_output("#{bin}/cdk init app --language=javascript")
      list = shell_output("#{bin}/cdk list")
      cdkversion = shell_output("#{bin}/cdk --version")
      assert_match "TestappStack", list
      assert_match version.to_s, cdkversion
    end
  end
end
