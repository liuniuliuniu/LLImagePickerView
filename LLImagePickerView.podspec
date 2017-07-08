
Pod::Spec.new do |s|

  s.name         = "LLImagePickerView"

  s.version      = "0.0.1"

  s.summary      = "LLImagePickerView is a MediaFrameword"

  s.homepage     = "https://github.com/liuniuliuniu/LLImagePickerView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "liuniuliuniu" => "416997919@qq.com" }

  s.source       = { :git => "https://github.com/liuniuliuniu/LLImagePickerView.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.0"

  s.source_files  = "LLImagePickerView", "LLImagePickerView/**/*.{h,m}"

  s.requires_arc = true

  s.dependency "TZImagePickerController"
  s.dependency "MWPhotoBrowser", '~> 2.1.2'
  s.dependency "ACAlertController"
  s.dependency "SDWebImage"

end
