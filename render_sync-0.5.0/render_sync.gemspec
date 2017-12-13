# -*- encoding: utf-8 -*-
# stub: render_sync 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "render_sync".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.4".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris McCord".freeze]
  s.date = "2016-05-04"
  s.description = "RenderSync turns your Rails partials realtime with automatic updates through Faye".freeze
  s.email = "chris@chrismccord.com".freeze
  s.homepage = "http://github.com/chrismccord/render_sync".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Realtime Rails Partials".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<em-http-request>.freeze, [">= 0"])
      s.add_development_dependency(%q<faye>.freeze, [">= 0"])
      s.add_development_dependency(%q<thin>.freeze, [">= 0"])
      s.add_development_dependency(%q<pusher>.freeze, ["~> 0.11.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, ["~> 3.2.13"])
      s.add_development_dependency(%q<cache_digests>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 0.13.3"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["< 5.0.0"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, [">= 0"])
    else
      s.add_dependency(%q<em-http-request>.freeze, [">= 0"])
      s.add_dependency(%q<faye>.freeze, [">= 0"])
      s.add_dependency(%q<thin>.freeze, [">= 0"])
      s.add_dependency(%q<pusher>.freeze, ["~> 0.11.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, ["~> 3.2.13"])
      s.add_dependency(%q<cache_digests>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, ["~> 0.13.3"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["< 5.0.0"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<em-http-request>.freeze, [">= 0"])
    s.add_dependency(%q<faye>.freeze, [">= 0"])
    s.add_dependency(%q<thin>.freeze, [">= 0"])
    s.add_dependency(%q<pusher>.freeze, ["~> 0.11.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, ["~> 3.2.13"])
    s.add_dependency(%q<cache_digests>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, ["~> 0.13.3"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["< 5.0.0"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, [">= 0"])
  end
end

