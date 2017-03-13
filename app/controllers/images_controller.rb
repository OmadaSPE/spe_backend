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
        @images = Image.basic_search(params[:q])
        render('images/index.json')
    end

    def advanced_query
        puts params.to_unsafe_hash
        @images = Image.advanced_search(params.to_unsafe_hash)
        render('images/index.json')
    end
end
