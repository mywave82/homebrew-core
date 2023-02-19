class Eksctl < Formula
  desc "Simple command-line tool for creating clusters on Amazon EKS"
  homepage "https://eksctl.io"
  url "https://github.com/weaveworks/eksctl.git",
      tag:      "0.130.0",
      revision: "6aa905e1aaa07d553aeeb5c4a1568c0430aaf803"
  license "Apache-2.0"
  head "https://github.com/weaveworks/eksctl.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "31181373266d72e229b3fa3d84add31907360c198b8c5ff0c83726f1adfe3abc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d8b975e47a587598a9a011ac216713145995fd980a49b621b33084d1ec7d1270"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a8ea5dff57739b9a9fdf5a59ce7ce911e5edb92014be58a8f6a7b5fb90d0388e"
    sha256 cellar: :any_skip_relocation, ventura:        "b7b85e9758572dc009ce300481eb33e96246f61040bea063f76ec205bfb150b8"
    sha256 cellar: :any_skip_relocation, monterey:       "45e683a6b555594791af8efb423442dfabfd5c74c0edf615172f82222d8fcaaf"
    sha256 cellar: :any_skip_relocation, big_sur:        "ef44ce7608eb57b064d8bb9346e11b97f0d752420ba2638aa58cdb4d742180ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af613aa278135f5391ce206a306917f1c8e9a1a6cdd14eea1d0dce180eafc4ad"
  end

  depends_on "counterfeiter" => :build
  depends_on "go" => :build
  depends_on "go-bindata" => :build
  depends_on "mockery" => :build
  depends_on "aws-iam-authenticator"

  # Eksctl requires newer version of ifacemaker
  #
  # Replace with `depends_on "ifacemaker" => :build` when ifacemaker > 1.2.0
  # Until then get the resource version from go.mod
  resource "ifacemaker" do
    url "https://github.com/vburenin/ifacemaker/archive/b2018d8549dc4d51ce7e2254d6b0a743643613be.tar.gz"
    sha256 "41888bf97133b4e7e190f2040378661b5bcab290d009e1098efbcb9db0f1d82f"
  end

  def install
    resource("ifacemaker").stage do
      system "go", "build", *std_go_args(ldflags: "-s -w", output: buildpath/"ifacemaker")
    end
    inreplace "build/scripts/generate-aws-interfaces.sh", "${GOBIN}/ifacemaker",
                                                          buildpath/"ifacemaker"

    ENV["GOBIN"] = HOMEBREW_PREFIX/"bin"
    ENV.deparallelize # Makefile prerequisites need to be run in order
    system "make", "build"
    bin.install "eksctl"

    generate_completions_from_executable(bin/"eksctl", "completion")
  end

  test do
    assert_match "The official CLI for Amazon EKS",
      shell_output("#{bin}/eksctl --help")

    assert_match "Error: couldn't create node group filter from command line options: --cluster must be set",
      shell_output("#{bin}/eksctl create nodegroup 2>&1", 1)
  end
end
