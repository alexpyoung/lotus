source 'https://cdn.cocoapods.org/'

platform :ios, '12.0'
plugin 'cocoapods-binary'

target 'Lotus' do
  use_frameworks!

  pod 'Apollo', '~> 0.23', :binary => true
  pod 'SwiftLint', '~> 0.39', :binary => true

  target 'LotusTests' do
    inherit! :search_paths
  end

  target 'LotusUITests' do
  end
end

