require "language/node"

class Aft < Formula
  desc "A prototype self-hosted backend-as-a-service"
  homepage "https://awans.github.io/aft/"
  url "https://github.com/awans/aft/archive/v0.0-brew.1.tar.gz"
  sha256 "5bef8c4c2192382df1113375c90e7d8f95c818e85731c4dca002641f7ce5e468"

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
