module V1
  class Schedules < Grape::API
    resources :schedules do
      desc 'Creates a schedule and returns the new schedule object'
      params do
        requires :schedule, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :day_of_week, type: String, desc: 'Day of Week'
          requires :time, type: String, desc: 'Time'
          requires :timezone, type: String, desc: 'Timezone'
        end
      end
      post '', rabl: 'schedules/schedule' do
        @schedule = Schedule.new(permitted_params[:schedule])

        if @schedule.save
          @schedule
        else
          error_with(@schedule)
        end
      end


      desc 'Deletes a schedule'
      delete ':id' do
        @schedule = Schedule.find_by_id(params[:id])

        if @schedule
          if @schedule.destroy
            { "success": true }
          else
            error_with(@schedule)
          end
        else
          error!({ errors: ['Schedule does not exist'] }, 404)
        end
      end
    end
  end
end
