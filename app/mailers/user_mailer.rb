class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("user_mailer.alert.account_activation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("user_mailer.alert.password_reset")
  end
end
