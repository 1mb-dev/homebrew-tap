class Natcheck < Formula
  desc "NAT type diagnosis CLI for WebRTC / P2P / VPN connectivity"
  homepage "https://github.com/1mb-dev/natcheck"
  url "https://github.com/1mb-dev/natcheck/archive/refs/tags/v0.1.2.1.tar.gz"
  sha256 "db9568ef1867414835bd1daa25995ceb415131a935ca51c02773ff09f41fa026"
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
