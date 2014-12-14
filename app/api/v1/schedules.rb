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
          error_with(@schedule, 422)
        end
      end


      desc 'Deletes a schedule'
      delete ':id' do
        @schedule = Schedule.find_by_id(params[:id])

        if @schedule
          if @schedule.destroy
            status 204
          else
            error_with(@schedule, 422)
          end
        else
          error_with('Schedule', 404)
        end
      end
    end
  end
end
