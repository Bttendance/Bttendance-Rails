module V1
  class Courses < Grape::API
    include Grape::Kaminari

    resource :courses do
      desc 'Returns a list of courses, paginated'
      paginate per_page: 10
      get '', rabl: 'courses/courses' do
        courses = Course.all
        @courses = paginate(Kaminari.paginate_array(courses))
      end


      desc 'Returns a specific course'
      get ':id', rabl: 'courses/course' do
        @course = Course.find_by_id(params[:id])

        if @course
          @course
        else
          error_with('Course', 404)
        end
      end


      desc 'Returns a specific course by id and by code'
      params do
        optional :id, type: String, desc: 'ID'
        optional :code, type: String, desc: 'Code'
      end
      post 'search', rabl: 'courses/course' do
        if params[:id]
          @course = Course.find_by_id(params[:id])
          @course ? @course : error_with('Course', 404)
        elsif params[:code]
          @course = Course.find_by_code(params[:code].upcase)
          @course ? @course : error_with('Course', 404)
        else
          error_with('Course', 404)
        end
      end


      desc 'Returns a course\'s users by type'
      get ':id/users', rabl: 'courses/users' do
        @course = Course.find_by_id(params[:id])

        if @course
          # Plain Ruby hashes are not well supported by RABL, use OpenStruct
          @users = OpenStruct.new({
            "supervising" => [],
            "attending" => [],
            "dropped" => [],
            "kicked" => []
          })

          @course.courses_users.each do |courses_user|
            @users[courses_user.state].push(courses_user.user)
          end

          @users
        else
          error_with('Course', 404)
        end
      end


      desc 'Creates a course and returns the new course object'
      params do
        requires :course, type: Hash do
          requires :school_id, type: Integer, desc: 'School ID'
          requires :name, type: String, desc: 'Name'
          requires :instructor_name, type: String, desc: 'Instructor Name'
          optional :open, type: Boolean, desc: 'Open'
          optional :information, type: String, desc: 'Information'
          optional :start_date, type: Date, desc: 'Start Date'
          optional :end_date, type: Date, desc: 'End Date'
        end
      end
      post '', rabl: 'courses/course' do
        params[:course].delete :code
        @course = Course.new(permitted_params[:course])

        if @course.save
          @course
        else
          error_with(@course, 422)
        end
      end


      desc 'Updates a course and returns the updated course object'
      params do
        requires :course, type: Hash do
          optional :name, type: String, desc: 'Name'
          optional :instructor_name, type: String, desc: 'Instructor Name'
          optional :open, type: Boolean, desc: 'Open'
          optional :information, type: String, desc: 'Information'
          optional :start_date, type: Date, desc: 'Start Date'
          optional :end_date, type: Date, desc: 'End Date'
          optional :courses_users_attributes, type: Array do
            optional :user_id, type: Integer, desc: 'User ID'
            optional :state, type: String, desc: 'State'
            optional :_destroy, type: Boolean, desc: 'Destroy'
          end
        end
      end
      put ':id', rabl: 'courses/course' do
        params[:course].delete :code
        @course = Course.find_by_id(params[:id])

        if @course
          update_params = permitted_params[:course]
          if update_params[:courses_users_attributes].present?
            update_params[:courses_users_attributes].each do |courses_user|
              found_courses_user = @course.courses_users.find_by_user_id(courses_user[:user_id])
              if found_courses_user && courses_user[:_destroy]
                found_courses_user.destroy
              elsif found_courses_user
                found_courses_user.update_attributes(courses_user)
              else !found_courses_user
                @course.courses_users.new(courses_user)
              end
            end
            update_params.delete(:courses_users_attributes)
          end

          if @course.update_attributes(update_params)
            @course
          else
            error_with(@course, 422)
          end
        else
          error_with('Course', 404)
        end
      end


      desc 'Deletes a course'
      delete ':id' do
        @course = Course.find_by_id(params[:id])

        if @course
          if @course.destroy
            status 204
          else
            error_with(@course, 422)
          end
        else
          error_with('Course', 404)
        end
      end


      desc 'Returns a course\'s attendances, paginated'
      paginate per_page: 10
      get ':id/attendances', rabl: 'attendances/attendances' do
        @course = Course.find_by_id(params[:id])

        if @course
          @attendances = paginate(Kaminari.paginate_array(@course.attendances))
        else
          error_with('Course', 404)
        end
      end


      desc 'Returns a course\'s clickers, paginated'
      paginate per_page: 10
      get ':id/clickers', rabl: 'clickers/clickers' do
        @course = Course.find_by_id(params[:id])

        if @course
          @clickers = paginate(Kaminari.paginate_array(@course.clickers))
        else
          error_with('Course', 404)
        end
      end


      desc 'Returns a course\'s notices, paginated'
      paginate per_page: 10
      get ':id/notices', rabl: 'notices/notices' do
        @course = Course.find_by_id(params[:id])

        if @course
          @notices = paginate(Kaminari.paginate_array(@course.notices))
        else
          error_with('Course', 404)
        end
      end


      desc 'Returns a course\'s curiouses, paginated'
      paginate per_page: 10
      get ':id/curiouses', rabl: 'curiouses/curiouses' do
        @course = Course.find_by_id(params[:id])

        if @course
          @curiouses = paginate(Kaminari.paginate_array(@course.curiouses))
        else
          error_with('Course', 404)
        end
      end
    end
  end
end
