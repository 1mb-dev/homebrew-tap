class Natcheck < Formula
  desc "NAT type diagnosis CLI for WebRTC / P2P / VPN connectivity"
  homepage "https://github.com/1mb-dev/natcheck"
  url "https://github.com/1mb-dev/natcheck/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "ea6eb2567c7283e95e232b72d462b98046225f717d6afc605d89ea0185448159"
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
