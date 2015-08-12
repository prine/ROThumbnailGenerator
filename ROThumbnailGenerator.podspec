#
# Be sure to run `pod lib lint ROStorageBar.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "ROThumbnailGenerator"
s.version          = "1.0.1"
s.summary          = "Creates thumbnails of different file types very easily"
s.description      = <<-DESC
It does create a thumbnail by the given file url. Creation of PDF, Image and Video thumbnails is per default supported.
With implementing the ROThumbnailGenerator it is very simple to add an additional ThumbnailGenerator for a missing file type.
DESC
s.homepage         = "https://github.com/prine/ROThumbnailGenerator"
#s.screenshots     = "https://raw.githubusercontent.com/prine/ROThumbnailGenerator/master/Screenshot.png"
s.license          = 'MIT'
s.author           = { "Robin Oster" => "robin.oster@rascor.com" }
s.source           = { :git => "https://github.com/prine/ROThumbnailGenerator.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/prinedev'

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files = 'Source/**/*'
s.resource_bundles = {
'ROBarcodeScanner' => ['Pod/Assets/*.png']
}

#s.resources = ["Source/*.Storyboard"]

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
