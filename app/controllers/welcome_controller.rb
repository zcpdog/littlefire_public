class WelcomeController < ApplicationController
  def index
    @deals = Deal.order('id DESC').page params[:page]
    respond_to do |wants|
      wants.html # index.html.erb
    end
  end
  def notify
  end
end
