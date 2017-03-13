class Tag < ApplicationRecord
    fuzzily_searchable :tag_name

    has_and_belongs_to_many :images
end
