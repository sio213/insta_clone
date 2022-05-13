# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  images     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  mount_uploaders :images, PostImageUploader
  serialize :images, JSON

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :body, presence: true, length: { minimum: 1, maximum: 1000 }

  scope :body_contain, ->(word) { where('posts.body LIKE ?', "%#{word}%") }
  scope :comment_contain, ->(word) { where('comments.body LIKE ?', "#{word}") }
end
