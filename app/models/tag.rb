class Tag < ApplicationRecord
    has_many :post_tags
    has_many :posts, through: :post_tags


    def self.tag_counts
        tagMap = Hash.new(0)
        Tag.all.each do |tag|
            if tag.posts.length > 0 
                tagMap[tag.name] ? tagMap[tag.name] += 1 : tagMap[tag.name] = 1
            end
        end
        tagMap
    end
end
