# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mbanker/version"

Gem::Specification.new do |s|
  s.name        = "mbanker"
  s.version     = Mbanker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michał Taszycki"]
  s.email       = ["mtaszycki@gmail.com"]
  s.homepage    = "https://github.com/mehowte/mbanker"
  s.summary     = %q{Missing API for online mBank services}
  s.description = %q{Provides access to online mBank services.}

  s.rubyforge_project = "mbanker"

  s.add_dependency "mechanize"

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "growl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
