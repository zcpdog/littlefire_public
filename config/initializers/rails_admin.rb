RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin_user
  end
  config.current_user_method &:current_admin_user
  
  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.included_models = ["Deal", "Category", "Merchant","User","AdminUser","Picture"]
  
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    #export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    history_index
    history_show
  end
  
  config.model Deal do
    list do
      field :name
      field :state
      field :picture
    end
    edit do
      field :categories do
        nested_form false
        inverse_of :deals
      end
      field :merchant
      field :purchase_link
      field :title, :ck_editor
      field :content, :ck_editor
      field :due_date, :datetime
      field :amazing_price
      field :picture
    end
  end
  
  config.model Picture do
    edit do
      field :image
    end
  end
  
  config.model Category do
    edit do
      field :name
      field :parent
      field :children do
        inverse_of :categories
      end
    end
  end
  
end
