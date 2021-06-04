class History < ApplicationRecord
  has_many :history_items, dependent: :destroy, :inverse_of => :history
  has_many :products, through: :history_items

  accepts_nested_attributes_for :history_items, :allow_destroy => true

  validates :action, presence: true

  enum action: [
    I18n.t("activerecord.attributes.history.action_import"),
    I18n.t("activerecord.attributes.history.action_export")
  ]

  scope :this_month, -> () {
    where(created_at: Date.today.beginning_of_month..Date.today.end_of_month.end_of_day)
  }

  scope :this_quarter, -> () {
    where(created_at: Date.today.beginning_of_quarter..Date.today.end_of_quarter.end_of_day)
  }

  scope :this_year, -> () {
    where(created_at: Date.today.beginning_of_year..Date.today.end_of_year.end_of_day)
  }

  scope :in_range, ->(first_day, last_day) {
    where(:created_at => Date.parse(first_day)..Date.parse(last_day).end_of_day)
  }

  scope :has_products, ->(ids) {
    eager_load(:products).where(:products => { id: ids })
  }

  rails_admin do

    create do 
      field :history_items
      field :action do 
        partial :radio_buttons
      end
      field :object 
      field :note
    end

    edit do 
      field :history_items
      field :action do 
        read_only true
      end
      field :object 
      field :note
    end

    list do
      field :created_at do
        strftime_format do 
          "%d/%m/%y"
        end
      end

      field :history_items do 
        pretty_value do 
          view = bindings[:view]
          @value = value
          view.render partial: "history_items", locals: {
            items: value
          }
        end
        column_width 450
      end
      
      field :action do
  
      end
      
      field :object
      
      field :note
    end
  end
end
