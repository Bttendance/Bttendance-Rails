class UserMailer < ActionMailer::Base
  def welcome(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end
end
