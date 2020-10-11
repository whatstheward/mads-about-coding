class Post < ApplicationRecord
    has_many :post_tags
    has_many :tags, through: :post_tags
    scope :search_by_keyword, -> (keyword){where("body ILIKE ? OR title ILIKE ?", "%#{keyword}%", "%#{keyword}%")}

    def tag_names
        self.tags.map do |tag|
            tag.name
        end
    end

    def add_tags(tag_str)
        tag_arr = tag_str.split(',')
        tag_arr.each do |name|
            tag = Tag.find_by(name: name.strip)
            if !tag
                tag = Tag.create(name: name.strip)
            end
            PostTag.create(post: self, tag: tag)
        end
    end

    def tag_str
        self.tags.reduce('') do |a,b|
            if a.length < 1
                a + b.name
            else
                a + ', ' + b.name
            end
        end
    end

end
