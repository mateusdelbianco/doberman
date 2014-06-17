# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doberman/version'

Gem::Specification.new do |spec|
  spec.name          = "doberman"
  spec.version       = Doberman::VERSION
  spec.authors       = ["Mateus Del Bianco"]
  spec.email         = ["mateus@delbianco.net.br"]
  spec.summary       = %q{Doberman is your favorite watchdog timer.}
  spec.description   = %q{Doberman makes sure your code is still alive, barking out loud if there's silence for too long.}
  spec.homepage      = "https://github.com/mateusdelbianco/doberman"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
