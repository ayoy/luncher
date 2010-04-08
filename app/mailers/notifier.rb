class Notifier < ActionMailer::Base
  default_url_options[:host] = "lunch.ayoy.net"

  def password_reset_instructions(user)
    subject       "[Luncher] Password Reset Instructions"
    from          "luncher@ayoy.net"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token), :user => user
  end
end
