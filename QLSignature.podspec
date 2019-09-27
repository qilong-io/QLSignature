Pod::Spec.new do |spec|
  spec.name         = "QLSignature"
  spec.version      = "0.0.2"
  spec.summary      = "iOS 手写签名."
  spec.description  = <<-DESC
                  iOS 手写签名
  			DESC
  spec.homepage     = "https://github.com/qilong-io/QLSignature"
  spec.license 	 = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "qilong" => "915464855@qq.com" }
  spec.platform	 = :ios
  spec.platform  = :ios,"9.0"
  spec.source    = { :git => "https://github.com/qilong-io/QLSignature.git", :tag => "#{s.version}" }
  spec.source_files  = "QLSignature/SignatureView/*.{h,m}"
end
