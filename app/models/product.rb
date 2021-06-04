class Product < ApplicationRecord
  include Hashid::Rails

  has_many :history_items, dependent: :destroy, inverse_of: :product
  
  validates :number, :numericality => { greater_than_or_equal_to: 0 }
  validates :min, :numericality => { greater_than_or_equal_to: 0 }

  after_validation :set_need_importing

  rails_admin do
    list do
      field :created_at do 
        strftime_format do 
          "%d/%m/%y"
        end
      end
      field :name do 
      end
      field :number do
        css_class "text-center"
      end
      field :min do
        css_class "text-center"
      end
      field :unit
      field :need_import
      
      field :updated_at do 
        strftime_format do 
          "%d/%m/%y"
        end
      end
    end

    create do 
      field :name 
      field :number 
      field :min 
      field :unit 
    end 

    modal do 
      field :name 
      field :number 
      field :min 
      field :unit 
    end 

    edit do
      configure :need_import do
        visible false
      end
      configure :histories do
        visible false
      end
    end
  end

  scope :need_importing, -> () {
    where("number <= min")
  }

  private

  def set_need_importing
    if self.number <= self.min
      self.need_import = true
    else
      self.need_import = false
    end
  end
end
