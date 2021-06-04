class HistoryItem < ApplicationRecord
  belongs_to :product, inverse_of: :history_items
  belongs_to :history, :inverse_of => :history_items

  validates :price, numericality: {
    greater_than: 0
  }

  validates :amount, numericality: {
    greater_than: 0
  }

  def name 
    self.product.name
  end

  validate do |item|
    if item.new_record?
      product = item.product
      history = item.history
      amount = item.amount
      if history.action == I18n.t("activerecord.attributes.history.action_export")
        amount = -amount
      end
      unless product.update(number: product.number + amount)
        errors.add :amount, :too_large, { available: product.reload.number }
      end
    elsif item.amount_changed?
      product = item.product
      history = item.history
      amount = item.amount
      diff = item.amount - item.amount_was
      if item.history.action == I18n.t("activerecord.attributes.history.action_export")
        diff = -diff
      end
      unless product.update(number: product.number + diff)
        errors.add :amount, :too_large, { available: product.reload.number }
      end
    end
  end

  before_destroy :modify_product_amount

  def modify_product_amount
    product = self.product
    amount = self.amount
    if self.history.action == I18n.t("activerecord.attributes.history.action_import") then
      amount = -amount
    end
    unless product.update(number: product.number + amount)
      errors.add(:base, :cannot_delete, message: "OMG")
      throw :abort
    end
  end

  def unit 
    self.product.unit 
  end

  def category 
    self.history.action
  end

  def total 
    self.amount * self.price 
  end

  rails_admin do
    visible false
    edit do 
      field :product
      field :amount 
      field :price
    end

    list do 
      field :history do 
        pretty_value do 
          value.created_at.strftime("%d/%m/%y")
        end
      end
      field :product
      field :unit 
      field :amount 
      field :price 
      field :total do 
        css_class "text-center"
      end 
    end
  end
end
