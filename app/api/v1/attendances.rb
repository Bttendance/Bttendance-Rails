module V1
  class Attendances < Grape::API
    resource :attendances do
      desc 'Creates an attendance and returns the new attendance object'
      params do
        requires :attendance, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :user_id, type: Integer, desc: 'User ID'
          requires :state, type: String, desc: 'State'
        end
      end
      post '', rabl: 'attendances/attendance' do
        @attendance = Attendance.new(permitted_params[:attendance])

        if @attendance.save
          @attendance
        else
          error!({ errors: @attendance.errors.full_messages })
        end
      end
    end
  end
end
