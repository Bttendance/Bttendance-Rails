class UserMailer < ActionMailer::Base
  default from: 'Bttendance <no-reply@bttendance.com>'

  def welcome(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end
end
