lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'ruby/hooks/version'

Gem::Specification.new do |spec|
  spec.name        = 'ruby-hooks'
  spec.version     = ::Ruby::Hooks::VERSION
  spec.licenses    = ['MIT']

  spec.authors     = ['Michal Papis']
  spec.email       = ['mpapis@gmail.com']

  spec.homepage    = 'https://github.com/remote-exec/ruby-hooks'
  spec.summary     =
  spec.description = 'Helpers for multiple publish/subscribe hooks'

  spec.add_development_dependency('rake')

  spec.files        = Dir.glob('lib/**/*.rb')
  spec.test_files   = Dir.glob('test/**/*.rb')
end
