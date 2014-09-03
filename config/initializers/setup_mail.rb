ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => 'in-v3.mailjet.com',
  :port => 587,
  :domain => "cristoferdevin.nycdevshop.com",
  :user_name => "1c317b777491fd7c83af2eada98b77f3",
  :password => "abe64b14d07f33283dcb533e92c97c90",
  :authentication => "plain",
  :enable_starttls_auto => true
}