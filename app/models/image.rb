class Image < ApplicationRecord
    has_and_belongs_to_many :tags
    has_and_belongs_to_many :emuobjects

    def self.basic_search(q, page = 0)
        # OLD WAY
        # Image.where("images.title LIKE ? OR images.description LIKE ?", "%#{q}%", "%#{q}%")
        #     .union(Image.joins(:tags).where("tag_name LIKE ?", "%#{q}%"))
        #     .union(Image.joins(:emuobjects).where("emuobjects.title LIKE ? OR images.description LIKE ?", "%#{q}%", "%#{q}%")).limit(20)

        # NEW WAY using FUZZILY
        Image.joins(:images_tags).where("tag_id IN (?)", Tag.find_by_fuzzy_tag_name(q).map { |e| e.id }).limit(20).offset(page*20)
    end

    def self.advanced_search(searchHash, page)
        images = Image
        object = Image.joins(:emuobjects)
        if(searchHash[:title])
            images = images.where("images.title IS NOT NULL AND images.title LIKE ?", "%#{searchHash[:title]}%")
            object = object.where("emuobjects.title IS NOT NULL AND emuobjects.title LIKE ?", "%#{searchHash[:title]}%")
        end
        if(searchHash[:description])
            images = images.where("images.description IS NOT NULL AND images.description LIKE ?", "%#{searchHash[:description]}%")
            object = object.where("emuobjects.description IS NOT NULL AND emuobjects.description LIKE ?", "%#{searchHash[:description]}%")
        end
        images = images.where("images.mimeformat IS NOT NULL AND images.mimeformat LIKE ?","%#{searchHash[:format]}%") if searchHash[:mimeformat]
        images = images.where("images.department IS NOT NULL AND images.department LIKE ?", "%#{searchHash[:department]}%") if searchHash[:department]
        images = images.where("images.subjects IS NOT NULL AND images.subjects LIKE ?", "%#{searchHash[:subjects]}%") if(searchHash[:subjects])
        images = images.where("images.notes IS NOT NULL AND images.notes LIKE ?", "%#{searchHash[:notes]}%") if(searchHash[:notes])
        object = object.where("emuobjects.taxonomy IS NOT NULL AND emuobjects.taxonomy LIKE ?", "%#{searchHash[:taxonomy]}") if(searchHash[:taxonomy])
        #, "%#{searchHash[:department]}%", "%#{searchHash[:subjects]}%", "%#{searchHash[:notes]}%"  OR images.description LIKE ? OR images.mimeformat LIKE ? OR images.department LIKE ? OR images.subjects LIKE ? OR images.notes LIKE ?
        #images.union(Image.joins(:emuobjects).where("emuobjects.title LIKE ? OR emuobjects.description LIKE ? or emuobjects.taxonomy LIKE ?", "%#{searchHash[:title]}%", "%#{searchHash[:description]}%", "%#{searchHash[:taxonomy]}")).limit(20).offset(page*20)
        images.union(object).limit(20).offset(page*20)
    end

end
