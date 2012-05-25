# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth-nk/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-nk"
  gem.version       = Omniauth::Nk::VERSION
  gem.authors       = ["Arkadiusz Kuryłowicz, Nasza Klasa Spółka z ograniczoną odpowiedzialnością"]
  gem.date          = '2012-05-25'
  gem.email         = ["arkadiusz.kurylowicz@nasza-klasa.pl"]
  gem.description   = %q{OmniAuth Strategy for nk.pl using OAuth2}
  gem.summary       = %q{OmniAuth Strategy for nk.pl using OAuth2}
  gem.homepage      = "https://github.com/naszaklasa/omniauth-nk"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0'
  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_dependency 'oauth', '~> 0.4.6'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.8'
end