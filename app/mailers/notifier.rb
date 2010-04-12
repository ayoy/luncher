class Notifier < ActionMailer::Base
  default_url_options[:host] = "lunch.ayoy.net"

  def password_reset_instructions(user)
    subject       "[Luncher] Password Reset Instructions"
    from          "luncher@ayoy.net"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token), :user => user
  end

  def lunch_notification(vendor, users)
    subject       "[Luncher] Lunches from #{vendor} have arrived"
    from          "luncher@ayoy.net"
    bcc           users.map(&:email)
    sent_on       Time.now
    body          :vendor => vendor
  end
end
