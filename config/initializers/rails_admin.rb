require_relative "../../lib/rails_admin/pdf_export"
require_relative "../../lib/rails_admin/statistic"
RailsAdmin.config do |config|
  ### Popular gems integration
  config.main_app_name = ["Kho cảng Gia Đức", "Quản lý xuất nhập"]
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    bulk_delete
    show
    edit do
      except History
    end
    delete
    show_in_app
    export_docx do
      only [Product, History]
    end
    statistic
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
