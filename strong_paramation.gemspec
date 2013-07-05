$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "strong_paramations/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "strong_paramations"
  s.version     = StrongParamations::VERSION
  s.authors     = ["AOKI Yuuto"]
  s.email       = ["aoki@u-ne.co"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_development_dependency "sqlite3"
end
