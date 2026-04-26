class Natcheck < Formula
  desc "NAT type diagnosis CLI for WebRTC / P2P / VPN connectivity"
  homepage "https://github.com/1mb-dev/natcheck"
  url "https://github.com/1mb-dev/natcheck/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "5f8d82294e8ee5bc75a240dd7f2b82f5080a690ce3ffc699742a7ec343c0cb84"
  license "MIT"
  head "https://github.com/1mb-dev/natcheck.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"natcheck"),
           "./cmd/natcheck"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/natcheck --version")
  end
end
