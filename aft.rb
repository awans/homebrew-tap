require "language/node"

class Aft < Formula
  desc "A prototype self-hosted backend-as-a-service"
  homepage "https://awans.github.io/aft/"
  url "https://github.com/awans/aft/archive/v0.0-brew.2.tar.gz"
  sha256 "fa6ebfecdbdb1d32c4368ec9f41a92b968b5dd322879b198556bbaa2a07dcf7d"

  depends_on "go" => :build
  depends_on "npm" => :build

  def install
    system "npm", "install", "--prefix", "./client/catalog", *Language::Node.local_npm_install_args
    system "npm", "run-script", "--prefix", "./client/catalog", "build"
    system "go", "build", "-o", bin/"aft", "./cmd/aft"
  end

  test do
    system "#{bin}/aft"
  end
end
