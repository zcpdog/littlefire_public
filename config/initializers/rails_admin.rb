RailsAdmin.config do |config|
  config.main_app_name = ["买手党", "后台"]
  
  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin_user
  end
  config.current_user_method &:current_admin_user
  
  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'AdminUser', 'PaperTrail::Version' 
  
  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.included_models = ["Deal", "Category", "Merchant","User","AdminUser","Picture"]
  
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['User', 'Picture']
    end
    #export
    bulk_delete
    show
    edit
    delete 
    show_in_app do
      only 'Deal'
    end
    state

    ## With an audit adapter, you can add:
    history_index
    history_show
  end
end
