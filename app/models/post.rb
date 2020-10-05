class Post < ApplicationRecord
    has_many :post_tags
    has_many :tags, through: :post_tags

    def tag_names
        self.tags.map do |tag|
            tag.name
        end
    end

end
