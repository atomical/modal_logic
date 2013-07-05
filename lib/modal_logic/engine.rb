require 'modal_logic/helpers'
module ModalLogic
  class Engine < ::Rails::Engine
    ActiveSupport.on_load :action_controller do |app|
      puts app.inspect
      app.send(:include, ModalLogic::Helpers)
    end
  end
end