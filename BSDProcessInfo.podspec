Pod::Spec.new do |spec|
  spec.name = 'BSDProcessInfo'
  spec.version = '0.1'
  spec.platform = :osx
  spec.license = { :type => 'BSD' }
  spec.summary = 'Objective-c wrapper for accessing BSD process information'
  spec.homepage = 'https://github.com/eahrold/BSDProcessInfo'
  spec.authors  = { 'Eldon Ahrold' => 'eldon.ahrold@gmail.com' }
  spec.source   = { :git => 'https://github.com/eahrold/BSDProcessInfo.git', :tag => "v#{spec.version}" }
  spec.requires_arc = true
  spec.public_header_files = 'BSDProcessInfo/*.h'
  spec.source_files = 'BSDProcessInfo/*.{h,m}'
end
