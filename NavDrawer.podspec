Pod::Spec.new do |s|
  s.name         = "NavDrawer"
  s.version      = "0.1.0"
  s.summary      = "A navigation bar to simulate finding something in multiple drawer."
  s.homepage     = "https://github.com/chenyongwei/NavDrawer"
  s.author       = { "Yongwei Chen" => "iamywchen@gmail.com" }
  s.source       = { :git => "https://github.com/chenyongwei/NavDrawer.git" }
  s.platform     = :ios, '6.0'
  s.source_files = 'NavDrawer/*.{h,m}'
  s.requires_arc = true
end