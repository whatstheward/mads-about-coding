class Post < ApplicationRecord
    has_many :post_tags
    has_many :tags, through: :post_tags
    scope :search_by_keyword, -> (keyword){where("body ILIKE ? OR title ILIKE ?", "%#{keyword}%", "%#{keyword}%")}

    def tag_names
        self.tags.map do |tag|
            tag.name
        end
    end

end
