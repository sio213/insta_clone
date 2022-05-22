class ChangeSettingsToNotificationSettings < ActiveRecord::Migration[5.2]
  def change
    rename_table :settings, :notification_settings
  end
end
