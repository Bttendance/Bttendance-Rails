module V1
  class Schools < Grape::API
    resource :schools do
      desc 'Returns a list of schools'
      get '', rabl: 'schools/schools' do
        @schools = School.all
      end


      desc 'Returns a specific school'
      get ':id', rabl: 'schools/school' do
        @school = School.find_by_id(params[:id])

        if @school
          @school
        else
          error!({ errors: ['School does not exist'] }, 422)
        end
      end


      desc 'Creates a school and returns the new school object'
      params do
        requires :school, type: Hash do
          requires :name, type: String, desc: 'Name'
          requires :classification, type: String, desc: 'Type'
          optional :courses_attributes, type: Array do
            requires :name, type: String, desc: 'Name'
            requires :instructor_name, type: String, desc: 'Instructor Name'
            requires :code, type: String, desc: 'Code'
            requires :open, type: Boolean, desc: 'Open'
            optional :information, type: String, desc: 'Information'
            optional :start_date, desc: 'Start Date'
            optional :end_date, desc: 'End Date'
          end
        end
      end
      post '', rabl: 'schools/school' do
        @school = School.new(permitted_params[:school])

        if @school.save
          @school
        else
          error!({ errors: @school.errors.full_messages }, 422)
        end
      end


      desc 'Updates a school and returns the updated school object'
      params do
        optional :name, type: String, desc: 'Name'
        optional :classification, type: String, desc: 'Type'
        optional :courses_attributes, type: Array do
          requires :name, type: String, desc: 'Name'
          requires :instructor_name, type: String, desc: 'Instructor Name'
          requires :code, type: String, desc: 'Code'
          requires :open, type: Boolean, desc: 'Open'
          optional :start_date, desc: 'Start Date'
          optional :end_date, desc: 'End Date'
        end
      end
      put ':id', rabl: 'schools/school' do
        @school = School.find_by_id(params[:id])

        if @school
          if @school.update_attributes(permitted_params[:school])
            @school
          else
            error!({ errors: @school.errors.full_messages }, 422)
          end
        else
          error!({ errors: ['School does not exist'] }, 404)
        end
      end
    end
  end
end
