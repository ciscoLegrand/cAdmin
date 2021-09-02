require_relative "lib/cadmin/version"

Gem::Specification.new do |spec|
  spec.name        = "cadmin"
  spec.version     = Cadmin::VERSION
  spec.authors     = ["ciscolegrand"]
  spec.email       = ["cisco.glez@gmail.com"]
  spec.homepage    = "http://www.cappweb.ga"
  spec.summary     = "Admin page"
  spec.description = "Admin page"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ciscoLegrand/cAdmin.git"
  
  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
end
