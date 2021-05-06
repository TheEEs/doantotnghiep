class History < ApplicationRecord
  has_many :history_items
  belongs_to :product

  validates :amount, numericality: {
    :greater_than => 0
  }
  validates :price, :numericality => { greater_than: 0 }

  validates :action, presence: true

  enum action: [
    I18n.t("activerecord.attributes.history.action_import"),
    I18n.t("activerecord.attributes.history.action_export")
  ]

  scope :this_month, -> () {
    where(created_at: Date.today.beginning_of_month..Date.today.end_of_month.tomorrow)
  }

  scope :this_quarter, -> () {
    where(created_at: Date.today.beginning_of_quarter..Date.today.end_of_quarter.tomorrow)
  }

  scope :this_year, -> () {
    where(created_at: Date.today.beginning_of_year..Date.today.end_of_year.tomorrow)
  }

  scope :in_range, ->(first_day, last_day) {
    where(:created_at => Date.parse(first_day)..Date.parse(last_day).tomorrow)
  }

  scope :has_products, ->(ids) {
    eager_load(:product).where(:products => { id: ids })
  }

  rails_admin do
    list do
      field :created_at do
        strftime_format do 
          "%d/%m/%y"
        end
        column_width 80
      end
      field :product
      field :amount do
        css_class "text-center"
        #column_width 50
      end
      field :price do
        css_class "text-center"
        pretty_value do
          bindings[:view].number_with_delimiter value, delimiter: "."
        end
        #column_width 70
      end
      field :total do 
        css_class "text-center"
        pretty_value do
          bindings[:view].number_with_delimiter value, delimiter: "."
        end
        column_width 150
      end
      field :action do
        column_width 85
      end
      
      field :object
      
      field :note
    end
  end

  def name
    "#{id}"
  end

  def total 
    self.price * self.amount
  end

  validate do |history|
    product = history.product
    amount = history.amount
    if history.action == I18n.t("activerecord.attributes.history.action_export")
      amount = -amount
    end
    unless product.update(number: product.number + amount)
      errors.add :amount, :too_large, { available: product.reload.number }
    end
  end

  before_destroy :modify_product_amount

  def modify_product_amount
    product = self.product
    amount = self.amount
    if self.action == I18n.t("activerecord.attributes.history.action_import") then
      amount = -amount
    end
    puts "Destroy History #{product.number + amount}"
    unless product.update(number: product.number + amount)
      errors.add(:base, :cannot_delete, message: "OMG")
      throw :abort
    end
  end
end
