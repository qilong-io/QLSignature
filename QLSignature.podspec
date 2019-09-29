Pod::Spec.new do |spec|
  spec.name         = 'QLSignature'
  spec.version      = '0.1.9'
  spec.platform     = :ios, '9.0'
  spec.requires_arc = true
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/qilong-io/QLSignature'
  spec.authors      = { 'qilong' => 'qilong.mail@qq.com' }
  spec.summary      = 'iOS 手写签名'
  spec.source       = { :git => 'https://github.com/qilong-io/QLSignature.git', :tag => '0.1.0' }
  spec.source_files = 'QLSignature/QLSignature/SignatureView/*.{h,m}'
  spec.resources    = 'image/*'
end
