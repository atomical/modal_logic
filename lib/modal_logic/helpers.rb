module ModalLogic
  module Helpers
    def modal_form_response( model, opts = {})
      response = {}
      case params[:action]
      when 'new', 'edit'
        response[:body]  = render_to_string path_to_current_controller_form, layout: false
        response[:title] = opts[:title] || modal_title(model)

      when 'create', 'update'
        if ! model.valid? || ! model.persisted? || opts[:errors].present?
          response[:body]   = render_to_string path_to_current_controller_form
          response[:errors] = opts[:errors] || model.errors
          response[:flash]  = flash
          response[:title]  = opts[:title] || modal_title(model)
        else
          response[:redirect_location] = opts[:redirect_location] if opts[:redirect_location]
          response[:close] = true
        end
      end

      response
    end

    def modal_title(model)
      action = model.persisted? ? :edit : :new
      "#{action.to_s.titleize} #{File.basename(params[:controller]).singularize.titleize}" #without namespace (i.e. /admin/collections)
    end

    def path_to_current_controller_form( opts = {} )
      File.join(Rails.root, 'app/views', params[:controller], opts[:filename] || '_form')
    end
  end
end