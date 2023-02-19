require "language/node"

class Cdk8s < Formula
  desc "Define k8s native apps and abstractions using object-oriented programming"
  homepage "https://cdk8s.io/"
  url "https://registry.npmjs.org/cdk8s-cli/-/cdk8s-cli-2.1.136.tgz"
  sha256 "2daa16245900fe8f9ff469b10c5e3966151fc478e3ecf6b45d1b3461d6b07452"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "50ac53f2ad5b748d4075c925fb91146a417275c0665872cb56bd81fe42243f57"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "Cannot initialize a project in a non-empty directory",
      shell_output("#{bin}/cdk8s init python-app 2>&1", 1)
  end
end
