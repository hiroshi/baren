Gem::Specification.new do |s|
  s.name        = 'baren'
  s.version     = '0.1.0'
  s.date        = '2011-05-26'
  s.summary     = "A template engine for images"
  s.description = s.summary
  s.authors     = ["Hiroshi Saito"]
  s.email       = 'hiroshi3110@gmail.com'
  s.homepage    = 'http://github.com/hiroshi/baren'

  s.files       = ["lib/baren.rb"]

  s.add_runtime_dependency 'rails', '>= 3.1.0.rc1'
  s.add_runtime_dependency 'sprockets', '>= 2.0.0.beta.8'
  # s.add_dependency "tilt", ["~> 1.1", "!= 1.3.0"]
end
