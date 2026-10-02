cask "bigtty" do
  version "0.6.1"
  sha256 "14e06680beffca0114cf44a828512e95950c22b8ac0a561c67371c1bbbea8719"

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

  caveats <<~EOS
    bigtty is a window onto herdr, which runs your terminals and agents.
    If herdr isn't installed yet:
      curl -fsSL https://herdr.dev/install.sh | sh
  EOS
end
