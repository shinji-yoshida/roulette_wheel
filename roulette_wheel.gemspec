# -*- encoding: utf-8 -*-
require File.expand_path('../lib/roulette_wheel/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["shinji-yoshida"]
  gem.email         = ["yoshida.shinji.gm@gmail.com"]
  gem.description   = <<-EOF
    roulette_wheel is random value selector with given discrete probability distribution.
  EOF
  gem.summary       = %q{roulette_wheel is random value selector with given discrete probability distribution.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "roulette_wheel"
  gem.require_paths = ["lib"]
  gem.version       = RouletteWheel::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "turnip"
  gem.add_development_dependency "abanalyzer"
end
