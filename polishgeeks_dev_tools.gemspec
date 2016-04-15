$:.push File.expand_path("../lib", __FILE__)

require 'rake'
require 'polishgeeks/dev-tools/version'

Gem::Specification.new do |s|
  s.name        = 'polishgeeks-dev-tools'
  s.version     = PolishGeeks::DevTools::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Maciej Mensfeld']
  s.email       = ['maciej@mensfeld.pl']
  s.homepage    = ''
  s.summary     = %q(Set of tools used when developing Ruby based apps)
  s.description = %q(Set of tools used when developing Ruby based apps)

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'

  s.add_dependency 'simplecov'
  s.add_dependency 'rubycritic', '1.2.1'
  s.add_dependency 'pry'
  s.add_dependency 'yard'
  s.add_dependency 'faker'
  s.add_dependency 'shoulda'
  s.add_dependency 'rspec'
  s.add_dependency 'rubocop'
  s.add_dependency 'timecop'
  s.add_dependency 'brakeman', '3.0.5'
  s.add_dependency 'haml_lint'
  s.add_dependency 'mongoid-rspec'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = %w( lib )
end
