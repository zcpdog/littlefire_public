class UeditorImagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  def create
    @ueditor_image = UeditorImage.new(image: params[:upfile])
    respond_to do |format|
      if @ueditor_image.save
        data = {:url=> @ueditor_image.image.url, :title => params[:title], :original => params[:upfile].original_filename, :state => 'SUCCESS'}
      else
        data = {:title => params[:title], :original => params[:upfile].original_filename, :state => 'FAIL'}
      end
      format.js {render :json => data.to_json}
    end
  end
end