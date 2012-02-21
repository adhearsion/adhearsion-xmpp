# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adhearsion/xmpp/version"

Gem::Specification.new do |s|
  s.name        = "adhearsion-xmpp"
  s.version     = Adhearsion::XMPP::VERSION
  s.authors     = ["Juan de Bravo", "Ben Langfeld", "Jason Goecke", "Ben Klang"]
  s.email       = ["juandebravo@gmail.com", "ben@langfeld.me", "jsgoecke@voxeo.com", "bklang@mojolingo.com"]
  s.homepage    = "https://github.com/adhearsion/adhearsion-xmpp"
  s.summary     = %q{Send and receive XMPP messages in your Adhearsion application}
  s.description = %q{This gem provides the XMPP plugin to Adhearsion, allowing your Adhearsion application to send and receive messages and react to presence changes.}

  s.rubyforge_project = "adhearsion-xmpp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "adhearsion", ">= 2.0.0.alpha3"
  s.add_runtime_dependency "activesupport", [">= 3.0.10"]
  s.add_runtime_dependency "i18n", ">= 0.5.0"
  s.add_runtime_dependency "blather", ">= 0.5.7"
  s.add_runtime_dependency "jruby-openssl" if defined?(JRUBY_VERSION)

  s.add_development_dependency "rspec", "~> 2.7.0"
  s.add_development_dependency "rake", ">= 0.9.2"
end
