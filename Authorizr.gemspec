# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

$:.push File.expand_path('../lib',__FILE__)
require 'authorizr/version'

Gem::Specification.new do |s|
  s.name = "authorizr"
  s.version = Authorizr::VERSION
  s.description = "Authorizr: A simple controller-centric authorization framework."

  s.authors = ["Robert Carpenter"]
  s.date = Date.today

  s.extra_rdoc_files = [
    "README.rdoc"
  ]

  s.files = `git ls-files`.split "\n"

  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Authentication and Authorization"

  s.add_dependency 'orm_adapter', '~> 0.0.5'
end

