module V1
  class Attendances < Grape::API
    resource :attendances do
      desc 'Creates an attendance and returns the new attendance object'
      params do
        requires :attendance, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :user_id, type: Integer, desc: 'User ID'
          optional :auto, type: Boolean, desc: 'Auto'
        end
      end
      post '', rabl: 'attendances/attendance' do
        @attendance = Attendance.new(permitted_params[:attendance])

        if @attendance.save
          @attendance
        else
          error_with(@attendance, 422)
        end
      end
    end
  end
end
