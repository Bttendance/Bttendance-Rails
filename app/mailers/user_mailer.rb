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

  def createCourse(courses_user)
    @courses_user = courses_user
    @user = User.find_by_id(params[@courses_user.user_id])
    @course = Course.find_by_id(params[@courses_user.course_id])
    @school = School.find_by_id(params[@course.school_id])
    I18n.locale = @user.locale
    mail(to: @user.email)
  end

  def attendCourse(courses_user)
    @courses_user = courses_user
    @user = User.find_by_id(params[@courses_user.user_id])
    @course = Course.find_by_id(params[@courses_user.course_id])
    @school = School.find_by_id(params[@course.school_id])
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
