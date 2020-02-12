Pod::Spec.new do |spec|

  spec.name            = "UpsellViewController"
  spec.version         = "1.0.2"
  spec.summary         = "Customizable view controller for promoting your app's products to users."

  spec.description     = <<-DESC
Customizable view controller for promoting your app's products to users.
                   DESC

  spec.homepage        = "https://github.com/ChopinDavid/UpsellViewController"

  spec.license         = { :type => 'MIT', :file => 'LICENSE' }

  spec.author          = { "David Chopin" => "dchopin1@live.maryville.edu" }

  spec.platform        = :ios, "11.0"
  spec.swift_versions  = "5.0"

  spec.source          = { :git => "https://github.com/ChopinDavid/UpsellViewController.git", :tag => "1.0.2" }

  spec.source_files    = "UpsellViewController"
  spec.resource_bundles = {
    'UpsellViewController' => ['UpsellViewController/*.xib']
  }

end
