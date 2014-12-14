# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'usernamegen/version'

Gem::Specification.new do |spec|
  spec.name          = "usernamegen"
  spec.version       = Usernamegen::VERSION
  spec.authors       = ["Sven Pachnit"]
  spec.email         = ["sven@bmonkeys.net"]
  spec.summary       = %q{Usernamegen - a not so serious name generator}
  spec.description   = %q{This gem uses two lists (descriptive words and nouns) and multiplies them with each and another resulting in a list of mostly meaningful and often silly name combinations.}
  spec.homepage      = "https://github.com/2called-chaos/usernamegen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
