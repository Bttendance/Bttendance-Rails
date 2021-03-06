module V1
  class Schools < Grape::API
    include Grape::Kaminari

    resource :schools do
      desc 'Returns a list of schools, paginated'
      paginate per_page: 10
      get '', rabl: 'schools/schools' do
        schools = School.order(created_at: :asc).all
        @schools = paginate(Kaminari.paginate_array(schools))
      end


      desc 'Returns a specific school'
      get ':id', rabl: 'schools/school' do
        @school = School.find_by_id(params[:id])

        if @school
          @school
        else
          error_with('School', 404)
        end
      end


      desc 'Returns search result of schools by name'
      paginate per_page: 10
      params do
        requires :query, type: String, desc: 'Search Query'
      end
      post 'search', rabl: 'schools/schools' do
        schools = School.name_like(params[:query])
        @schools = paginate(Kaminari.paginate_array(schools))
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
          error_with(@school, 422)
        end
      end


      desc 'Updates a school and returns the updated school object'
      params do
        requires :school, type: Hash do
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
      end
      put ':id', rabl: 'schools/school' do
        @school = School.find_by_id(params[:id])

        if @school
          if @school.update_attributes(permitted_params[:school])
            @school
          else
            error_with(@school, 422)
          end
        else
          error_with('School', 404)
        end
      end
    end
  end
end
