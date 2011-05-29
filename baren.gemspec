Gem::Specification.new do |s|
  s.name        = 'baren'
  s.version     = '0.1.0'
  s.summary     = "Generate .png form .pjs, processing.js script."
  s.description = "An asset pipeline processor, and a template engine for images."
  s.authors     = ["Hiroshi Saito"]
  s.email       = 'hiroshi3110@gmail.com'
  s.homepage    = 'http://github.com/hiroshi/baren'

  s.files       = ["README.md", "lib/baren.rb", "opt/Rakefile", "opt/phantomjs/pjs2png.js.erb"]
  s.extensions  = ["opt/Rakefile"]

  s.add_runtime_dependency 'railties', '>= 3.1.0.rc1'
  s.add_runtime_dependency 'sprockets', '>= 2.0.0.beta.8'
  # s.add_dependency "tilt", ["~> 1.1", "!= 1.3.0"]
end
