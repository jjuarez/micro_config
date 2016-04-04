# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'micro_config/version'

Gem::Specification.new do |spec|
  spec.name          = "micro_config"
  spec.version       = MicroConfig::VERSION
  spec.authors       = ["Javier Juarez"]
  spec.email         = ["jjuarez@tuenti.com"]

  spec.summary       = "foo"
  spec.description   = "bar"
  spec.homepage      = 'https://github.com/jjuarez/micro_config'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
