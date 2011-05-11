# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "validations/version"

Gem::Specification.new do |s|
  s.name        = "validations"
  s.version     = Validations::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Innovatis Inc."]
  s.email       = ["dev@innovatisinc.ca"]
  s.homepage    = ""
  s.summary     = %q{Provides handy HTML5 validations for forms}
  s.description = %q{Provides handy HTML5 validations for forms}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
