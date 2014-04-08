class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :restrict_access
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected

    def configure_permitted_parameters
      if resource_class == User
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, 
          :password, :password_confirmation) }
      end
    end
  
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
    
    def restrict_access
      if IpFinder::Ip.find(request.remote_ip)=="中国"
        render :file => "#{Rails.public_path}/401.html", :status => :unauthorized
        return
      end
    end

end
