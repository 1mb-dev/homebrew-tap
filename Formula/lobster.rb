class Lobster < Formula
  desc "Intelligent web stress testing CLI with auto URL discovery"
  homepage "https://github.com/1mb-dev/lobster"
  url "https://github.com/1mb-dev/lobster/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "570c77d672c5a998c93e10e3ae5cdef99d7fab61f0c628fa7fd3081f2e4cbbbf"
  license "MIT"
  head "https://github.com/1mb-dev/lobster.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"lobster"),
           "./cmd/lobster"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lobster -version")
  end
end
