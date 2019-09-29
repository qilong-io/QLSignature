Pod::Spec.new do |spec|
  spec.name         = 'QLSignature'
  spec.version      = '0.0.7'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/qilong-io/QLSignature'
  spec.authors      = { 'qilong' => 'qilong.mail@qq.com' }
  spec.summary      = 'iOS 手写签名'
  spec.source       = { :git => 'https://github.com/qilong-io/QLSignature.git', :tag => '#{spec.version}' }
  spec.source_files = 'QLSignatureView.{h,m}'
end
