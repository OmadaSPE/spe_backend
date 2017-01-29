class ImagesController < ApplicationController
  def index
    @images = Image.all
    render('images/index.json')
  end

  def show
      @image = Image.find(params[:id])
      render('images/show.json')
  end

  def query
    @images = Image.joins(:tags).where("tag_name = :tag_name", {tag_name: params[:q]})
    render('images/index.json')
  end
end
