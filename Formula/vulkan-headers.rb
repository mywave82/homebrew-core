class VulkanHeaders < Formula
  desc "Vulkan Header files and API registry"
  homepage "https://github.com/KhronosGroup/Vulkan-Headers"
  url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.3.241.tar.gz"
  sha256 "4322fd17d456c0687ed947b1b75d7b10b121ec20ed43d1cfa76e721f7e803bec"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "397ba747806dd1876fca536c047b46592f77d04b206cf7e112e8bde42c31f61c"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <vulkan/vulkan_core.h>

      int main() {
        printf("vulkan version %d", VK_VERSION_1_0);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test"
    system "./test"
  end
end
