class ApplicationController < ActionController::Base
  def modal_form_response
  end
  include ModalLogic::Helpers
end