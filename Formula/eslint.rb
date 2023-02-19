require "language/node"

class Eslint < Formula
  desc "AST-based pattern checker for JavaScript"
  homepage "https://eslint.org"
  url "https://registry.npmjs.org/eslint/-/eslint-8.34.0.tgz"
  sha256 "31d08f3541ab11ac8662302fd1a1a94f7e52df0c6edb32a63f129205f9335db9"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "40cb76130beacb838f11c3eb9d0d84511d88ae83e1019e09bf1b60401910330c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "40cb76130beacb838f11c3eb9d0d84511d88ae83e1019e09bf1b60401910330c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "40cb76130beacb838f11c3eb9d0d84511d88ae83e1019e09bf1b60401910330c"
    sha256 cellar: :any_skip_relocation, ventura:        "05537e8bdb1ce6314b0d45c211ede2aaff2f6d4f85a31b2dc1bc4c204f039d42"
    sha256 cellar: :any_skip_relocation, monterey:       "05537e8bdb1ce6314b0d45c211ede2aaff2f6d4f85a31b2dc1bc4c204f039d42"
    sha256 cellar: :any_skip_relocation, big_sur:        "05537e8bdb1ce6314b0d45c211ede2aaff2f6d4f85a31b2dc1bc4c204f039d42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "40cb76130beacb838f11c3eb9d0d84511d88ae83e1019e09bf1b60401910330c"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/".eslintrc.json").write("{}") # minimal config
    (testpath/"syntax-error.js").write("{}}")
    # https://eslint.org/docs/user-guide/command-line-interface#exit-codes
    output = shell_output("#{bin}/eslint syntax-error.js", 1)
    assert_match "Unexpected token }", output
  end
end
