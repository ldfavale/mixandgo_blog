class Post < ApplicationRecord
    scope :im_the_author, -> { where(user: self.user)}
    
    belongs_to :user
end
