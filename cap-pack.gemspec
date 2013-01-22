# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cap-pack/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Things I do for Capistrano deploys.}
  gem.summary       = %q{Things I do for Capistrano deploys.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cap-pack"
  gem.require_paths = ["lib"]
  gem.version       = Cap::Pack::VERSION
end
