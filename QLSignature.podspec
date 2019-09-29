Pod::Spec.new do |spec|
  spec.name         = "QLSignature"
  spec.version      = "0.0.4"
  spec.summary      = "iOS 手写签名"
  spec.description  = <<-DESC
            iOS 手写签名工具
                        DESC
  spec.homepage     = "https://github.com/qilong-io/QLSignature"
  spec.license 	    = "MIT"
  # spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "qilong" => "qilong.mail@qq.com" }
  spec.platform     = :ios,"9.0"
  spec.source       = { :git => "https://github.com/qilong-io/QLSignature.git", :tag => "#{spec.version}" }
  spec.source_files = "QLSignature/QLSignature/SignatureView/*.{h,m}"
end
