Gem::Specification.new do |s|
  s.name = 'coins_paid_api'
  s.authors = ['Artem Biserov(artembiserov)', 'Oleg Ivanov(morhekil)']
  s.version = '2.2.0'
  s.files = `git ls-files`.split("\n")
  s.summary = 'Coins Paid Integration'
  s.license = 'MIT'

  s.add_runtime_dependency 'dry-struct', '~> 1.0'
  s.add_runtime_dependency 'faraday', '~> 0.12'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.11'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 3.7'
end
