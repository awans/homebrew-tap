require "language/node"

class Aft < Formula
  desc "A prototype self-hosted backend-as-a-service"
  homepage "https://awans.github.io/aft/"
  url "https://github.com/awans/aft/archive/v0.0.4.zip"
  sha256 "159a1306573461b29fbaae33424f6658f80feb0ae128f86d80bfd14c0478a978"

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
