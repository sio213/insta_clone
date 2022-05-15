# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  followed_id  :bigint
#  following_id :bigint
#
# Indexes
#
#  index_relationships_on_followed_id   (followed_id)
#  index_relationships_on_following_id  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (followed_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
class Relationship < ApplicationRecord
  include Subject

  belongs_to :following, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :following_id, uniqueness: { scope: :followed_id }

  private

  def create_activity
    Activity.create(subject: self, user: followed, action_type: :followed_me)
  end
end
