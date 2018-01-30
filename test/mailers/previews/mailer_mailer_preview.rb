# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/mailer_mailer
class MailerMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/mailer_mailer/account_activation
  def account_activation
    MailerMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/mailer_mailer/password_reset
  def password_reset
    MailerMailer.password_reset
  end
end
