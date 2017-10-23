
Pod::Spec.new do |s|

  s.name         = "LLImagePickerView"

  s.version      = "1.0.1"

  s.summary      = "LLImagePickerView is a MediaFramework"

  s.homepage     = "https://github.com/liuniuliuniu/LLImagePickerView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "liuniuliuniu" => "416997919@qq.com" }

  s.source       = { :git => "https://github.com/liuniuliuniu/LLImagePickerView.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.0"

  s.source_files  = "LLImagePickerView/**/*.{h,m}"

  s.resources = 'LLImagePickerView/resource/*.{bundle}'

  s.requires_arc = true

  s.dependency "TZImagePickerController" , '~> 1.7.9'

  s.dependency "MWPhotoBrowser", '~> 2.1.2'

end
