cask "bigtty" do
  version "0.3.2"
  sha256 "7c8c8c7d04bd25f4d517012793cdc7ff333c356bfb0dffbe8336207c9445bc82"

  url "https://github.com/v1k45/bigtty/releases/download/v#{version}/bigtty-#{version}.zip"
  name "bigtty"
  desc "Client for herdr with Ghostty terminals, browser and file panes"
  homepage "https://github.com/v1k45/bigtty"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "bigtty.app"
  binary "#{appdir}/bigtty.app/Contents/MacOS/btty"

  # Ad-hoc signed, not notarized: without this, macOS blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/bigtty.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/bigtty",
    "~/Library/Caches/dev.bigtty",
    "~/Library/Caches/dev.bigtty.bigtty",
    "~/Library/HTTPStorages/dev.bigtty.bigtty",
    "~/Library/HTTPStorages/dev.bigtty.bigtty.binarycookies",
    "~/Library/Preferences/dev.bigtty.bigtty.plist",
    "~/Library/WebKit/dev.bigtty.bigtty",
  ]
end
