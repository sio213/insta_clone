namespace :subscription do
  desc 'subscription update'
  task update: :environment do
    Rails.logger.info 'START SUBSCRIPTION UPDATE'
    User.subscription_to_be_updated.each do |user|
      Rails.logger.info "START SUBSCRIPTION UPDATE FOR #{user.username}"
      ActiveRecord::Base.transaction do
        debugger
        user.pay!
      end
      Rails.logger.info "SUCCEED SUBSCRIPTION UPDATE FOR #{user.username}"
    rescue Payjp::PayjpError => e
      user.stop_script!(reason: :by_payment_failed)
      Rails.logger.error "ERROR: #{e.message}"
      Rails.logger.error "FAILED SUBSCRIPTION UPDATE FOR #{user.username}"
    end
    Rails.logger.info 'END SUBSCRIPTION UPDATE'
  end
end
