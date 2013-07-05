module ModalLogic
  module Helpers
    def modal_form_response( model, opts = {})
      response = {}
      case params[:action]
      when 'new', 'edit'
        response[:html]  = render_to_string path_to_current_controller_form, layout: false
        response[:title] = opts[:title] || modal_title(model)

      when 'create', 'update'
        if ! model.valid? || ! model.persisted?
          response[:html]   = render_to_string path_to_current_controller_form
          response[:errors] = model.errors
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
      filename = opts[:filename] || '_form'
      request_base_path = request.path.split(params[:action].to_s).last
      File.join(Rails.root, 'app/views', request_base_path, filename )
    end
  end
end