# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#noinspection RubyResolve
require 'mvr/version'

Gem::Specification.new do |spec|
  spec.name        = 'mvr'
  spec.version     = Mvr::VERSION
  spec.authors     = ['Eric Henderson']
  spec.email       = ['henderea@gmail.com']
  spec.summary     = %q{regex rename}
  spec.description = %q{a Ruby script that allows you to rename a group of files via regular expression}
  spec.homepage    = 'https://github.com/henderea/mvr'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'everyday-cli-utils', '~> 1.8', '>= 1.8.1'
  spec.add_dependency 'everyday-plugins', '~> 1.2'
end
