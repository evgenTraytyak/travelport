# -*- encoding: utf-8 -*-
require File.expand_path('../lib/travelport/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mikhail Bondar", "Paul Gallagher", "Nicholas Zaillian"]
  gem.email         = ["m.bondar@yahoo.com", "gallagher.paul@gmail.com", "nzaillian@gmail.com"]
  gem.description   = %q{travelport.com API wrapper for Ruby}
  gem.summary       = %q{Provides a simple interface to the travelport.com API for travel listings and booking}
  gem.homepage      = "https://github.com/evendis/travelport"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "travelport"
  #gem.require_paths = ["lib", "vendor/gems/savon/lib"]
  gem.version       = Travelport::VERSION

  gem.add_development_dependency(%q<bundler>, ["> 1.1.0"])
  gem.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
  gem.add_development_dependency(%q<rspec>, ["~> 2.11.0"])
  gem.add_development_dependency(%q<rdoc>, ["~> 3.11"])
  gem.add_development_dependency(%q<guard-rspec>, ["~> 2.1.1"])
  gem.add_development_dependency(%q<rb-fsevent>, ["~> 0.9.2"])
  gem.add_development_dependency("vcr")
  gem.add_development_dependency("fakeweb")

  gem.add_runtime_dependency("activesupport")
  gem.add_runtime_dependency("activemodel")
  gem.add_runtime_dependency(%q<nokogiri>)

  gem.add_dependency("httpclient", "~> 2.3.1")
  gem.add_dependency("savon", "~> 2.3.0")

  gem.add_dependency "builder",  ">= 2.1.2"
#  gem.add_dependency "nokogiri", ">= 1.4.0"

  # gem.add_development_dependency "rake",    "~> 0.9"
  # gem.add_development_dependency "rspec",   "~> 2.10"
  gem.add_development_dependency "mocha",   "~> 0.11"
  gem.add_development_dependency "timecop", "~> 0.3"  
end
