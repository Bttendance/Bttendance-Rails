class UserMailer < ActionMailer::Base
  def welcome(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end

  def reset(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end

  def createCourse(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end

  def attendCourse(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end

  # Attachments
  def exportGrade(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end

  def updatePassword(user)
    @user = user
    I18n.locale = @user.locale
    mail(to: @user.email)
  end

end
