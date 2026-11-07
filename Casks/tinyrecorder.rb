# Homebrew cask for TinyRecorder, published in the 33to9/homebrew-tap repository:
#   brew install --cask 33to9/tap/tinyrecorder
# CI (.github/workflows/build.yml, job "homebrew") rewrites version + sha256 on every tag release.
cask "tinyrecorder" do
  version "1.8.17"
  sha256 "c6df964914f03cc0125b2a4d1d422ecad5d1c4d30fd9e381d860328a1c9bdaa4"

  url "https://github.com/33to9/TinyRecorder/releases/download/v#{version}/TinyRecorder_v#{version}.dmg"
  name "TinyRecorder"
  desc "Lightweight screen recorder with macOS 27 support"
  homepage "https://github.com/33to9/TinyRecorder"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself with Sparkle (Check for Updates…).
  auto_updates true
  depends_on macos: :monterey

  app "TinyRecorder.app"

  # The app is self-signed, not notarized by Apple: without this, Gatekeeper
  # blocks the first launch of the quarantined copy Homebrew downloaded.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TinyRecorder.app"]
  end

  uninstall quit: "com.33to9.TinyRecorder"

  zap trash: [
    "~/Library/Caches/com.33to9.TinyRecorder",
    "~/Library/HTTPStorages/com.33to9.TinyRecorder",
    "~/Library/Preferences/com.33to9.TinyRecorder.plist",
    "~/Library/Saved Application State/com.33to9.TinyRecorder.savedState",
  ]
end
