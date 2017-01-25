class ImagesController < ApplicationController
  def index
    @images = Image.all
    render('images/index')
  end

  def query
    @images = Image.joins(:tags).where("tag_name = :tag_name", {tag_name: params[:q]})
    render('images/index')
  end
end
