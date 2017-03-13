class Image < ApplicationRecord
    has_and_belongs_to_many :tags
    has_and_belongs_to_many :emuobjects

    def self.basic_search(q)
        Image.where("images.title LIKE ? OR images.description LIKE ?", "%#{q}%", "%#{q}%")
            .union(Image.joins(:tags).where("tag_name LIKE ?", "%#{q}%"))
            .union(Image.joins(:emuobjects).where("emuobjects.title LIKE ? OR images.description LIKE ?", "%#{q}%", "%#{q}%")).limit(20)
    end

    def self.advanced_search(searchHash)
        puts searchHash[:title]
        Image.where("images.title LIKE ? OR images.description LIKE ? OR images.mimeformat LIKE ? OR images.department LIKE ? OR images.subjects LIKE ? OR images.notes LIKE ?", "%#{searchHash[:title]}%", "%#{searchHash[:description]}%", "%#{searchHash[:format]}%", "%#{searchHash[:department]}%", "%#{searchHash[:subjects]}%", "%#{searchHash[:notes]}%" )
            .union(Image.joins(:emuobjects).where("emuobjects.title LIKE ? OR emuobjects.description LIKE ? or emuobjects.taxonomy LIKE ?", "%#{searchHash[:title]}%", "%#{searchHash[:description]}%", "%#{searchHash[:taxonomy]}")).limit(20)
    end

end
