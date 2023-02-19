class Wxmaxima < Formula
  desc "Cross platform GUI for Maxima"
  homepage "https://wxmaxima-developers.github.io/wxmaxima/"
  url "https://github.com/wxMaxima-developers/wxmaxima/archive/Version-23.02.0.tar.gz"
  sha256 "56323c2d3884df4f6c88aab0e1b3f026c4c9af5830f0648210dc3540f9b290d5"
  license "GPL-2.0-or-later"
  head "https://github.com/wxMaxima-developers/wxmaxima.git", branch: "main"

  bottle do
    sha256 arm64_ventura:  "6f74e4c363edb4dc0b8ab62109ab7862c053be507f1906eae6184a3f06ade621"
    sha256 arm64_monterey: "94515265d74da6227d9073cb3d96150053f6ab62f61c7251d82b16a5ea2c3bca"
    sha256 arm64_big_sur:  "84d39b3fec61ef36853febce70cc1ca7c813d89d166656828a356ae8c3b266d9"
    sha256 ventura:        "0e29da4d1464fafee4e1eeb9a07531f8cdf7e3c86e5f1c2e9ae804edfb8f0af3"
    sha256 monterey:       "5728f0d663b611c5796c79fd15f03fa18d6d5de6f824a483ce7ebe36b62f7c9c"
    sha256 big_sur:        "5660e9817816b506afd3e437570318907307c5b0f884aeec3ddfd21e089e8261"
  end

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "ninja" => :build
  depends_on "maxima"
  depends_on "wxwidgets"

  def install
    system "cmake", "-S", ".", "-B", "build-wxm", "-G", "Ninja", *std_cmake_args
    system "cmake", "--build", "build-wxm"
    system "cmake", "--install", "build-wxm"
    bash_completion.install "data/wxmaxima"

    return unless OS.mac?

    prefix.install "build-wxm/src/wxMaxima.app"
    bin.write_exec_script prefix/"wxMaxima.app/Contents/MacOS/wxmaxima"
  end

  def caveats
    <<~EOS
      When you start wxMaxima the first time, set the path to Maxima
      (e.g. #{HOMEBREW_PREFIX}/bin/maxima) in the Preferences.

      Enable gnuplot functionality by setting the following variables
      in ~/.maxima/maxima-init.mac:
        gnuplot_command:"#{HOMEBREW_PREFIX}/bin/gnuplot"$
        draw_command:"#{HOMEBREW_PREFIX}/bin/gnuplot"$
    EOS
  end

  test do
    # Error: Unable to initialize GTK+, is DISPLAY set properly
    return if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]

    assert_match "algebra", shell_output("#{bin}/wxmaxima --help 2>&1")
  end
end
