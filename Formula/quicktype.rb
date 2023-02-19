require "language/node"

class Quicktype < Formula
  desc "Generate types and converters from JSON, Schema, and GraphQL"
  homepage "https://github.com/quicktype/quicktype"
  # quicktype should only be updated every 10 releases on multiples of 10
  url "https://registry.npmjs.org/quicktype/-/quicktype-23.0.0.tgz"
  sha256 "4c4dc5465f59a0bb1a9fe6e67d6388a2502193d7e801b07db27e06fe9b41eb82"
  license "Apache-2.0"
  head "https://github.com/quicktype/quicktype.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0e3c3108cd27c12b402b374622f88c8b6e2e6ba1bb261f323431517279c248e7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0e3c3108cd27c12b402b374622f88c8b6e2e6ba1bb261f323431517279c248e7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0e3c3108cd27c12b402b374622f88c8b6e2e6ba1bb261f323431517279c248e7"
    sha256 cellar: :any_skip_relocation, ventura:        "8bb239bba76658a810b2caadeda17f2d0eac647017b47275f20cb1075cb0e713"
    sha256 cellar: :any_skip_relocation, monterey:       "8bb239bba76658a810b2caadeda17f2d0eac647017b47275f20cb1075cb0e713"
    sha256 cellar: :any_skip_relocation, big_sur:        "8bb239bba76658a810b2caadeda17f2d0eac647017b47275f20cb1075cb0e713"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0e3c3108cd27c12b402b374622f88c8b6e2e6ba1bb261f323431517279c248e7"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"sample.json").write <<~EOS
      {
        "i": [0, 1],
        "s": "quicktype"
      }
    EOS
    output = shell_output("#{bin}/quicktype --lang typescript --src sample.json")
    assert_match "i: number[];", output
    assert_match "s: string;", output
  end
end
