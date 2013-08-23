class WelcomeController < ApplicationController
  def index
    @deals = Deal.order('id DESC').page params[:page]
    @favorited_list = cookies[:favorited_list].split(",") || []
    respond_to do |wants|
      wants.html # index.html.erb
    end
  end
end
