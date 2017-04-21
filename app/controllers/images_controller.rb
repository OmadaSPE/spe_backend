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
        page = 0
        page = params[:page].to_i if(params[:page])
        @images = Image.basic_search(params[:q], page)
        render('images/index.json')
    end

    def advanced_query
        page = 0
        page = params[:page].to_i if(params[:page])
        @images = Image.advanced_search(params.to_unsafe_hash, page)
        render('images/index.json')
    end
end
