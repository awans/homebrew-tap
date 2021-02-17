require "language/node"

class Aft < Formula
  desc "A prototype self-hosted backend-as-a-service"
  homepage "https://awans.github.io/aft/"
  url "https://github.com/awans/aft/archive/v0.0.3.zip"
  sha256 "87985ba754215c4240e1b97b66503fae5d59c318daa05bcda12ad42253c4d087"

  depends_on "go" => :build
  depends_on "npm" => :build

  def install
    system "npm", "install", "--prefix", "./client/catalog", *Language::Node.local_npm_install_args
    system "npm", "run-script", "--prefix", "./client/catalog", "build"
    system "go", "get", "github.com/markbates/pkger/cmd/pkger"
    system "go", "run", "github.com/markbates/pkger/cmd/pkger", "-o", "./cmd/aft"
    system "go", "build", "-o", "./bin/aft", "./cmd/aft"
    bin.install "./bin/aft" => "aft"
  end

  test do
    system "#{bin}/aft"
  end
end
