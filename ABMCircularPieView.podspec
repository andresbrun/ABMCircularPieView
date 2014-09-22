#
# Be sure to run `pod lib lint ABMCircularPieView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ABMCircularPieView"
  s.version          = "0.1.0"
  s.summary          = "A short description of ABMCircularPieView."
  s.description      = <<-DESC
                       An optional longer description of ABMCircularPieView

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/andresbrun/ABMCircularPieView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "andresmoreno" => "andresbrunmoreno@gmail.com" }
  s.source           = { :git => "https://github.com/andresbrun/ABMCircularPieView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/andrewsBrun'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'ABMCircularPieView/ABMCircularPieView/**/*.{h,swift}'
  s.frameworks = 'Swift'
end
