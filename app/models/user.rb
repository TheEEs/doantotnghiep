class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable,
         #:recoverable, :
         :rememberable, 
         :validatable

  enum role: [
    :root,
    :admin,
    :user
  ]

  rails_admin do
    create do
      field :email
      field :name
      field :role
      field :password
      field :password_confirmation
    end
    edit do
      field :name
      field :role do 
        visible do 
          #true
          bindings[:view].controller.current_user.root?
        end
      end
      field :password
      field :password_confirmation
    end
    list do
      field :created_at do 
        strftime_format do 
          "%d/%m/%y"
        end
      end
      field :email
      field :name
      field :updated_at do 
        strftime_format do 
          "%d/%m/%y"
        end
      end
    end
  end
end
