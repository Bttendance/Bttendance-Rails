module V1
  class AttendanceAlarms < Grape::API
    resource :attendance_alarms do
      desc 'Returns a list of alarms'
      get '', rabl: 'attendance_alarms/attendance_alarms' do
        @attendance_alarms = AttendanceAlarm.all
      end


      desc 'Creates an attendance alarm and returns the new attendance alarm object'
      params do
        requires :attendance_alarm, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :schedule_id, type: Integer, desc: 'Schedule ID'
          requires :user_id, type: Integer, desc: 'User ID'
          requires :scheduled_for, type: Date, desc: 'Scheduled For'
          requires :manual, type: Boolean, desc: 'Manual'
          requires :active, type: Boolean, desc: 'Active'
        end
      end
      post '', rabl: 'attendance_alarms/attendance_alarm' do
        @attendance_alarm = AttendanceAlarm.new(permitted_params[:attendance_alarm])

        if @attendance_alarm.save
          @attendance_alarm
        else
          error!({ errors: @attendance_alarm.errors.full_messages }, 422)
        end
      end


      desc 'Updates an attendance alarm and returns the updated attendance alarm object'
      params do
        requires :attendance_alarm, type: Hash do
          optional :scheduled_for, type: Date, desc: 'Scheduled For'
          optional :manual, type: Boolean, desc: 'Manual'
          optional :active, type: Boolean, desc: 'Active'
        end
      end
      put ':id' do
        @attendance_alarm = AttendanceAlarm.find_by_id(params[:id])

        if @attendance_alarm
          if @attendance_alarm.update_attributes(permitted_params[:attendance_alarm])
            @attendance_alarm
          else
            error!({ errors: @attendance_alarm.errors.full_messages }, 422)
          end
        else
          error!({ errors: ['Attendance Alarm does not exist'] }, 404)
        end
      end


      desc 'Deletes an attendance alarm'
      delete ':id' do
        @attendance_alarm = AttendanceAlarm.find_by_id(params[:id])

        if @attendance_alarm
          if @attendance_alarm.destroy
            { success: true }
          else
            error!({ errors: @attendance_alarm.errors.full_messages })
          end
        else
          error!({ errors: ['Attendance Alarm does not exist'] }, 404)
        end
      end
    end
  end
end
