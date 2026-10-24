class Shim < Formula
  desc "Anthropic Messages API proxy with built-in request measurement"
  homepage "https://github.com/1mb-dev/shim"
  url "https://github.com/1mb-dev/shim/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "09121009dff0ab06a1a1063a8a37e735c4204c93a3c406c05d2eed8168bab8f0"
  license "MIT"
  head "https://github.com/1mb-dev/shim.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"shim"), "./cmd/shim"
  end

  service do
    run [opt_bin/"shim"]
    keep_alive true
    log_path var/"log/shim.log"
    error_log_path var/"log/shim.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/shim version")
  end
end
