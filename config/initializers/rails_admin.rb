RailsAdmin.config do |config|
  config.main_app_name = ["买手党", "后台"]
  config.label_methods << :username
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
  config.included_models = ["Deal", "Category", "Merchant","User","AdminUser","Picture",
    "Comment","Grade","Favorite","Discovery","Article","ArticleType", "Experience", "Credit"]
  
  config.actions do
    dashboard                     
    index
    new do
      except ['User', 'Picture',"Comment","Grade","Favorite","Experience","Discovery"]
    end
    bulk_delete
    show
    edit do
      except ["Comment","Grade","Favorite"]
    end
    delete 
    show_in_app do
      only 'Deal'
    end
    state
    history_index
    history_show
  end
end
