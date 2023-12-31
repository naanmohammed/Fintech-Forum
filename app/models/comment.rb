class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  validates :text, presence: true

  after_create :update_post_comments_counter

  def update_post_comments_counter
    post.update_comments_counter
  end
end
