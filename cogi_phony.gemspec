# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cogi_phony/version', __FILE__)

Gem::Specification.new do |spec|
  spec.authors        = ['Nobi Hoang']
  spec.email          = 'nobi.hoa@gmail.com'
  spec.description    = 'This gem provide you library to validate, parsing and format phone number, detect phone network in Vietnam.'
  spec.summary        = 'This gem provide you library to validate, parsing and format phone number, detect phone network in Vietnam.'
  spec.homepage       = 'https://github.com/hoahm/cogi_phony'
  spec.license        = 'MIT'

  spec.files          =  Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  spec.executables    = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.test_files     = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.name           = 'cogi_phony'
  spec.require_paths  = ['lib']
  spec.version        = CogiPhony::VERSION
  spec.date           = '2016-08-27'

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 2.0'

  spec.add_dependency 'phony', '~> 2.15'

  spec.rdoc_options << '--title' << 'Rake -- Ruby Make' <<
    '--main' << 'README' <<
    '--line-numbers'
end
