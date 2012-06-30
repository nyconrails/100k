class UserMailer < ActionMailer::Base

  default from: 'info@100kin10.org' #"support@dblsystems.com"
  
  def test_emails
    Rails.env.production? ? [] : TEST_EMAILS
  end
  
  
  def nomination_confirmation(nominee, nominator, nomination, nominee_password)  
    @nominee = nominee
    @nominator = nominator
    @nomination = nomination
    @nominee_password = nominee_password

    mail(:to => nominee.email, :bcc=>test_emails, :subject => "100Kin10: You Have Been Nominated.")
  end  

  def nominee_confirmation(nominee, nominator, nomination)  
    @nominee = nominee
    @nominator = nominator
    @nomination = nomination

    mail(:to => nominator.email, :bcc=>test_emails, :subject => "Thank You For Your Nomination.")
  end  
    
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #

  def reset_password_email(user)
    @user = user
    @url  = "http://100kin10.org/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email, :bcc => ['rhonda@harbingerpro.com']+test_emails, :subject => "Your password has been reset")
  end
  
  def send_welcome_email(user)
    @user = user
    @url  = "http://100kin10.org/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email, :bcc => ['rhonda@harbingerpro.com']+test_emails, :subject => "Welcome to 100Kin10.org")
  end
  
  def send_nomination_email(user, password)
    @user = user
    @password  = password
    mail(:to => user.email, :bcc => test_emails, :subject => "100Kin10: Nominate New Partners Through October 28th, 2011")

  end
  
  def secondary_confirmation(user, password)
    @user = user
    @password  = password
    mail(:to => user.email, :bcc => test_emails, :subject => "100Kin10: Your Organizations's Login Information")
  end

  def nominator_application_submission_notice(application)
    @nominee = application.user
    @nominator = application.user.nomination.nominator
    
    mail(:to => @nominator.email, :bcc => test_emails, :subject => "100Kin10: Your Nominee Submitted an Application")
  end
  
  def nominee_applications_now_open(nominee, password)
    @nominee = nominee
    @password = password 
    
    mail(:to => nominee.email,:bcc => test_emails, :subject => "100Kin10: Applications Now Open")
  end
  
  def welcome_partner_new_site(partner)
    @partner=partner
    mail(:to => partner.email,:bcc => test_emails, :subject => "100Kin10: New 100Kin10 Website is Now Live")
  end
  
  def partner_portal_login_credentials(partner)
    @partner=partner
    mail(:to => partner.email,:bcc => test_emails, :subject => "100Kin10: Partner Portal Login Credentials")    
  end

  def contactus_application_form(contactus_data,all_emails)
    @contactus_details = contactus_data
    mail(:to => '', :bcc => all_emails, :subject => "New contact request submitted")
  end
  
  class Preview < MailView
    # Pull data from existing fixtures
    def nomination_confirmation
      nomination=Nomination.last 
      UserMailer.nomination_confirmation(nomination.nominee, nomination.nominator, nomination, 'test')
    end
    
    def nominee_confirmation
      nomination=Nomination.last 
      UserMailer.nominee_confirmation(nomination.nominee, nomination.nominator, nomination)
    end
    
    def nominator_application_submission_notice
      application=Application.last 
      UserMailer.nominator_application_submission_notice(application)
    end
    
    def welcome_partner_new_site
      partner=Organization.all_partners.last.users.first 
      UserMailer.welcome_partner_new_site(partner)
    end
    
    def partner_portal_login_credentials
      partner=Organization.all_partners.last.users.first 
      UserMailer.partner_portal_login_credentials(partner)
    end

    # Factory-like pattern
    #     def welcome
    #       user = User.create!
    #       mail = Notifier.welcome(user)
    #       user.destory
    #       mail
    #     end
  end
end
