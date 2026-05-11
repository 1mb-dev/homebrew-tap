class Natcheck < Formula
  desc "NAT type diagnosis CLI for WebRTC / P2P / VPN connectivity"
  homepage "https://github.com/1mb-dev/natcheck"
  url "https://github.com/1mb-dev/natcheck/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "c503ce8a25df9092c87321cf8ba4e50a5d986dceb4f9fb8519b4af1595cf89ba"
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
