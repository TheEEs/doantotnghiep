require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class Statistic < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end

        register_instance_option :pjax? do
          true
        end

        register_instance_option :show_in_sidebar do 
          true 
        end

        register_instance_option :show_in_navigation do 
          false 
        end

        register_instance_option :link_icon do 
          "icon-tasks"
        end

        register_instance_option :controller do
          Proc.new do
            respond_to do |format|
              format.html do
                latest_transaction_of_each_product = HistoryItem.eager_load(:product).eager_load(:history).group('product_id','histories.action').maximum("created_at")
                histories = HistoryItem.where(created_at: latest_transaction_of_each_product.values).eager_load(:product).order('products.name')
                render action: @action.template_name, 
                  locals: { 
                    histories: histories
                  }
              end
              format.xlsx do 
                latest_transaction_of_each_product = HistoryItem.eager_load(:product).eager_load(:history).group('product_id','histories.action').maximum("created_at")
                histories = HistoryItem.where(created_at: latest_transaction_of_each_product.values).includes(:product).order('products.name')
                render xlsx: "Thống kê", template: "rails_admin/statistics/export.xlsx.axlsx", locals:{
                  histories: histories
                }
              end
            end
          end
        end
      end
    end
  end
end
