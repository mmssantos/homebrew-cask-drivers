cask "elgato-wave-link" do
  version "1.2.0.2595,1.2"
  sha256 "c74f84693860364ef178e2d29bbb8e3efa2c84289050c99f772ac31872ed97ad"

  url "https://edge.elgato.com/egc/macos/wavelink/#{version.after_comma}/WaveLink_#{version.before_comma}.pkg"
  name "Elgato Wave Link"
  desc "Intuitive software custom-built for content creation"
  homepage "https://www.elgato.com/en/wave-1"

  livecheck do
    url "https://help.elgato.com/hc/en-us/articles/360043289491-Elgato-Wave-Link-Release-Notes"
    strategy :page_match do |page|
      page.split(/class=['"]?toggle-content['"]?/).map do |toggle_content|
        match = toggle_content.match(
          %r{href=.*?/(\d+(?:\.\d+)*)/WaveLink_(\d+(?:\.\d+)*)\.pkg}mi,
        )
        "#{match[2]},#{match[1]}" if match
      end.compact
    end
  end

  depends_on macos: ">= :sierra"

  pkg "WaveLink_#{version.before_comma}.pkg"

  uninstall launchctl: "com.elgato.WaveLink",
            quit:      "com.elgato.WaveLink",
            pkgutil:   "com.elgato.pkg.WaveLink"

  zap trash: [
    "~/Library/Logs/WaveLink",
    "~/Library/Preferences/com.elgato.WaveLink.plist",
  ]
end
