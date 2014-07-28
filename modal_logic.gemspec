$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'modal_logic/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'modal_logic'
  s.version     = ModalLogic::VERSION
  s.authors     = ['Adam Hallett']
  s.email       = ['adam.t.hallett@gmail.com']
  s.homepage    = 'http://github.com/atomical/modal_logic'
  s.summary     = 'The simplicity of Rails forms coupled with Bootstrap modal'
  s.description = 'The simplicity of Rails forms coupled with Bootstrap modal'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>=4'
  s.add_dependency 'handlebars_assets', '0.14.1'
end
