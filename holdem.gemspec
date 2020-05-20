# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'holdem/version'

Gem::Specification.new do |spec|
  spec.name          = "holdem"
  spec.version       = Holdem::VERSION
  spec.authors       = ["Jamie Berczel"]
  spec.email         = ["jxberc@gmail.com"]
  spec.summary       = %q{A ruby module for creating and comparing Texas Holdem poker hands.}
  spec.description   = %q{A ruby module for creating and comparing Texas Holdem poker hands.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency 'minitest', '~> 5.14.1'
  spec.add_development_dependency 'minitest-reporters', '~> 1.4.2'
end
