# == Schema Information
#
# Table name: settings
#
#  id                      :bigint           not null, primary key
#  notification_on_comment :boolean          default(TRUE), not null
#  notification_on_follow  :boolean          default(TRUE), not null
#  notification_on_like    :boolean          default(TRUE), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint
#
# Indexes
#
#  index_settings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Setting < ApplicationRecord
  belongs_to :user
end
