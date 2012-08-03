Gem::Specification.new do |s|
  s.name        = 'ruby-gprov-dev'
  s.version     = '1.0.0'
  s.date        = '2012-08-03'
  s.summary     = "Ruby wrapper around the Google Apps provisionning API"
  s.description = "Ruby wrapper around the Google Apps provisionning API. Fork from http://github.com/adrienthebo/ruby-gprov"
  s.authors     = ["Adrien Thebo", "Thibaut Decaudain"]
  s.email       = 'thibaut.decaudain@gmail.com'
  s.files       = ["lib/gprov.rb"]
  s.homepage    = 'https://github.com/tricote/ruby-gprov'
  s.require_path = 'lib'
  s.add_dependency('httparty', ">= 0.8")
  s.add_dependency('nokogiri', ">= 1.5")
  s.add_development_dependency('rspec', '>= 2')
  s.add_development_dependency('mocha', '>= 0')

  s.add_development_dependency('mocha')
end