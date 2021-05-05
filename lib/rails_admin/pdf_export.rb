require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  HASHER = Hashids.new("fc123d24-3b92-4db7-a817-3a37a5b58b71")
  module Config
    module Actions
      class ExportDocx < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection? do
          true
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :show_in_menu do
          false
        end

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :link_icon do
          'icon-print'
        end

        register_instance_option :controller do
          Proc.new do
            respond_to do |format|
              format.html do
                hash_ids = HASHER.encode(params[:bulk_ids])
                render action: @action.template_name, 
                  locals: { 
                    hash_ids: hash_ids , 
                    model_name: @abstract_model.to_s.downcase
                  }
              end
            end
          end
        end
      end
    end
  end
end
