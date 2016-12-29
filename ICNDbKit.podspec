Pod::Spec.new do |s|
  s.name         = "ICNDbKit"
  s.version      = "1.0.0"
  s.summary      = "Swift library for fetching data from the Internet Chuck Norris Database"
  s.homepage     = "https://github.com/harrywynn/ICNDbKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Harry Wynn" => "harrywynn@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/harrywynn/ICNDbKit.git", :tag => "v#{s.version}" }
  s.source_files  = "ICNDbKit"
  s.exclude_files = "Classes/Exclude"
end
