class NotifyController < ApplicationController
  layout "devise"
  def show
    @email = params[:email]
  end
end