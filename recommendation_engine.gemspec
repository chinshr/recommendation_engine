# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

require File.expand_path("../lib/recommendation_engine/version", __FILE__)

Gem::Specification.new do |s|
  s.name              = "recommendation_engine"
  s.version           = RecommendationEngine::VERSION
  s.authors           = ["Alex Harding", "Juergen Fesslmeier"]
  s.email             = ["jfesslmeier@gmail.com"]
  s.homepage          = ""
  s.summary           = "A light-weight recommendation engine."
  s.rubyforge_project = "recommendation_engine"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths     = ["lib"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency "activerecord", ">= 3.1.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "yard"
  s.add_development_dependency "debugger"
  s.description = <<-EOM
EOM

  s.post_install_message = <<-EOM
NOTE: This is a port of the original acts_as_recommendable plugin.

https://github.com/maccman/acts_as_recommendable
EOM

end
