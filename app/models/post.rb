class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 10 }
  validates :content, presence: true, length: { maximum: 255 }

  belongs_to :user
end
