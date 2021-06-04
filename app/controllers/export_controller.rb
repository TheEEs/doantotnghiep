class ExportController < ApplicationController
  def export
    respond_to do |format|
      format.xlsx do
        if model_name == "product"
          @histories = History.has_products(RailsAdmin::HASHER.decode(ids))
          case by
          when "month"
            @histories = @histories.merge(History.this_month)
          when "quarter"
            @histories = @histories.merge(History.this_quarter)
          when "year"
            @histories = @histories.merge(History.this_year)
          when "range"
            @histories = @histories.merge(History.in_range(first_day, last_day))
          end
        elsif model_name == "history"
          @histories = History.where(id: RailsAdmin::HASHER.decode(ids)).eager_load(:products)
        end
        #latest_update_of_each_product = History.group('product_id','action').maximum("created_at")
        #@statistic = @histories.where(created_at: latest_update_of_each_product.values).includes(:product).order('products.name')
        #@history = @histories.order(:created_at)
        if aggressive?
          @histories = @histories.group('products.id','histories.action').pluck(
          'products.name',
          'histories.action',
          'sum(history_items.amount)',
          'sum(history_items.price * history_items.amount)',
          'products.number',
          )
          render xlsx: 'Báo Cáo Tổng Kết',template: "export/aggressive"
        else
          render xlsx: 'Báo Cáo Chi Tiết',template: "export/detailed"
        end
      end
    end
  end

  private

  def model_name 
    params[:model_name]
  end

  def ids
    params[:ids]
  end

  def by
    params[:by]
  end

  def first_day
    params[:first_day]
  end

  def last_day
    params[:last_day]
  end

  def aggressive?
    params[:aggressive] == "true"
  end

end
