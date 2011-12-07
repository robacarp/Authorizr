# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "Authorizr"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robert Carpenter"]
  s.date = "2011-12-07"
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "lib/authorizr.rb",
    "lib/authorizr/controller.rb",
    "lib/authorizr/engine.rb",
    "lib/authorizr/model.rb"
  ]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Authentication and Authorization"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_runtime_dependency(%q<Authorizr>, [">= 0"])
      s.add_runtime_dependency(%q<orm_adapter>, [">= 0"])
    else
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<Authorizr>, [">= 0"])
      s.add_dependency(%q<orm_adapter>, [">= 0"])
    end
  else
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<Authorizr>, [">= 0"])
    s.add_dependency(%q<orm_adapter>, [">= 0"])
  end
end

