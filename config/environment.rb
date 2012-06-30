# Load the rails application
require File.expand_path('../application', __FILE__)


ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app1053523@heroku.com',
  :password       => 'ojwggfsu',
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp




# Initialize the rails application
Goodinc::Application.initialize!


