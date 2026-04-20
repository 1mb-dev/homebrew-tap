class Gowsay < Formula
  desc "Modern cowsay in Go: CLI, REST API, and web UI in a single binary"
  homepage "https://github.com/1mb-dev/gowsay"
  url "https://github.com/1mb-dev/gowsay/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "331ab35ec51ad58566d54717a257feed8595ddfad46ef38715e2c57a443072c7"
  license "MIT"
  head "https://github.com/1mb-dev/gowsay.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"gowsay"), "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gowsay -v")
  end
end
