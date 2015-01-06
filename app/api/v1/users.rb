module V1
  class Users < Grape::API
    include Grape::Kaminari

    resource :users do
      helpers do
        def unsecured_emails
          ['apple0@apple.com', 'apple1@apple.com', 'apple2@apple.com',
            'apple3@apple.com', 'apple4@apple.com', 'apple5@apple.com',
            'apple6@apple.com', 'apple7@apple.com', 'apple8@apple.com',
            'apple9@apple.com']
        end
      end

      desc 'Returns a list of users, paginated'
      paginate per_page: 10
      get '', rabl: 'users/users' do
        users = User.all
        @users = paginate(Kaminari.paginate_array(users))
      end


      desc 'Returns a specific user of id'
      get ':id', rabl: 'users/user' do
        @user = User.find_by_id(params[:id])
        @user ? @user : error_with('User', 404)
      end


      desc 'Returns a specific user by id and by email'
      params do
        optional :id, type: String, desc: 'ID'
        optional :email, type: String, desc: 'Email'
      end
      post 'find', rabl: 'users/user' do
        if params[:id]
          @user = User.find_by_id(params[:id])
          @user ? @user : error_with('User', 404)
        elsif params[:email]
          @user = User.find_by_email(params[:email].downcase)
          @user ? @user : error_with('User', 404)
        else
          error_with('User', 404)
        end
      end


      desc 'Registers a user and optionally a device and returns the new user object'
      params do
        requires :user, type: Hash do
          requires :email, type: String, desc: 'Email'
          requires :password, type: String, desc: 'Password'
          requires :name, type: String, desc: 'Name'
          optional :locale, type: String, desc: 'Locale'
          requires :devices_attributes, type: Array do
            requires :platform, type: String, desc: 'Platform'
            optional :uuid, type: String, desc: 'UUID'
            optional :mac_address, type: String, desc: 'MAC Address'
          end
        end
      end
      post '', rabl: 'users/user' do
        @user = User.new(permitted_params[:user])

        if @user.save
          @user
        else
          error_with(@user, 422)
        end
      end


      desc 'Updates a user and returns the updated user object'
      params do
        requires :user, type: Hash do
          optional :password, type: String, desc: 'Password'
          optional :new_password, type: String, desc: 'New Password'
          optional :email, type: String, desc: 'Email'
          optional :name, type: String, desc: 'Name'
          optional :locale, type: String, desc: 'Locale'
          optional :devices_attributes, type: Array do
            optional :id, type: Integer, desc: 'ID'
            optional :platform, type: String, desc: 'Platform'
            optional :uuid, type: String, desc: 'UUID'
            optional :mac_address, type: String, desc: 'MAC Address'
            optional :notification_key, type: String, desc: 'Notification Key'
            optional :_destroy, type: Boolean, desc: 'Destroy'
          end
          optional :schools_users_attributes, type: Array do
            optional :school_id, type: Integer, desc: 'School ID'
            optional :identity, type: String, desc: 'Identity'
            optional :state, type: String, desc: 'State'
            optional :_destroy, type: Boolean, desc: 'Destroy'
          end
          optional :courses_users_attributes, type: Array do
            optional :course_id, type: Integer, desc: 'Course ID'
            optional :state, type: String, desc: 'State'
            optional :_destroy, type: Boolean, desc: 'Destroy'
          end
        end
      end
      put ':id', rabl: 'users/user' do
        @user = User.find_by_id(params[:id])
        if @user
          update_params = permitted_params[:user]
          if update_params[:new_password].present?
            if @user.authenticate(update_params[:password])
              update_params[:password] = update_params[:new_password]
              update_params.delete :new_password
            else
              error_with(401)
            end
          end

          # Update schools join models manually
          if update_params[:schools_users_attributes].present?
            update_params[:schools_users_attributes].each do |schools_user|
              found_schools_user = @user.schools_users.find_by_school_id(schools_user[:school_id])
              if found_schools_user && schools_user[:_destroy]
                found_schools_user.destroy
              elsif found_schools_user && !schools_user[:state]
                break
              elsif found_schools_user && schools_user[:state] == found_schools_user.state
                found_schools_user.update_attributes(schools_user)
              else
                @user.schools_users.new(schools_user)
              end
            end
            update_params.delete(:schools_users_attributes)
          end

          # Update courses join models manually
          if update_params[:courses_users_attributes].present?
            update_params[:courses_users_attributes].each do |courses_user|
              found_courses_user = @user.courses_users.find_by_course_id(courses_user[:course_id])
              if found_courses_user && courses_user[:_destroy]
                found_courses_user.destroy
              elsif found_courses_user && !courses_user[:state]
                break
              elsif found_courses_user && courses_user[:state] == found_courses_user.state
                found_courses_user.update_attributes(courses_user)
              else
                @user.courses_users.new(courses_user)
              end
            end
            update_params.delete(:courses_users_attributes)
          end

          # Update device id manually
          if update_params[:devices_attributes].present?
            update_params[:devices_attributes].each do |device|
              if !device[:id]
                found_device = Device.find_by(uuid: device[:uuid], mac_address: device[:mac_address])
                if found_device
                  device[:id] = found_device.id
                end
              end
            end
          end

          # Update user model
          if @user.update_attributes(update_params)
            @user
          else
            error_with(@user, 422)
          end
        else
          error_with('User', 404)
        end
      end


      desc 'Sends a reset password email to a user'
      params do
        requires :email, type: String, desc: 'Email'
      end
      post 'reset' do
        @user = User.find_by_email(params[:email])
        if @user
          UserMailer.reset(@user).deliver
          status 204
        else
          error_with('User', 404)
        end
      end


      desc 'Authenticates a user and returns the user object'
      params do
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
        requires :devices_attributes, type: Hash do
          requires :platform, type: String, desc: 'Platform'
          optional :uuid, type: String, desc: 'UUID'
          optional :mac_address, type: String, desc: 'MAC Address'
        end
      end
      post 'login', rabl: 'users/user' do
        @user = User.find_by_email(params[:email])
        # Check for Apple.com emails
        if @user && unsecured_emails.include?(params[:email])
          @user
        elsif @user
          if @user.authenticate(params[:password])
            device = Device.find_by(permitted_params[:devices_attributes])
            # Device not yet registered to any user, add it to this user
            if !device
              if @user.devices.create(permitted_params[:devices_attributes])
                @user
              else
                # Fail silently
                # TODO: Handle (logging/retry?)
                @user
              end
            elsif device && device.user_id == @user.id
              # User owns this device already, return user
              @user
            else
              # User doesn't own this device
              error!({ error: { type: 'log', title: 'title', message: 'Device registered to another user' }}, 400)
            end
          else
            error_with(401)
          end
        else
          error_with('User', 404)
        end
      end


      desc 'Returns a user\'s courses'
      get ':id/courses', rabl: 'courses/courses' do
        @user = User.find_by_id(params[:id])

        if @user
          @courses = @user.courses
        else
          error_with('User', 404)
        end
      end


      desc 'Returns a user\'s courses'
      get ':id/schools', rabl: 'schools/schools' do
        @user = User.find_by_id(params[:id])

        if @user
          @schools = @user.schools
        else
          error_with('User', 404)
        end
      end


      desc 'Returns a user\'s preferences'
      get ':id/preferences', rabl: 'preferences/preference' do
        @user = User.find_by_id(params[:id])

        if @user
          @preferences = @user.preferences
        else
          error_with('User', 404)
        end
      end

      desc 'Updates a user\'s preferences and returns the updated preferences object'
      params do
        requires :preferences, type: Hash do
          optional :clicker, type: Boolean, desc: 'Clicker'
          optional :attendance, type: Boolean, desc: 'Attendance'
          optional :curious, type: Boolean, desc: 'Curious'
          optional :following, type: Boolean, desc: 'Following'
          optional :notice, type: Boolean, desc: 'Notice'
        end
      end
      put ':id/preferences', rabl: 'preferences/preference' do
        @preferences = Preferences.find_by_user_id(params[:id])

        if @preferences
          if @preferences.update_attributes(permitted_params[:preferences])
            @preferences
          else
            error_with(@preferences, 422)
          end
        else
          @preferences = Preferences.new(permitted_params[:preferences].merge(user_id: params[:id]))
          if @preferences.save
            @preferences
          else
            error_with(@preferences, 422)
          end
        end
      end

      #for test
      desc 'send reset mail'
      get ':id/email/reset/' do
        @user = User.find_by_id(params[:id])
        if @user
          UserMailer.reset(@user).deliver
        else
          error_with('User', 404)
        end
      end
    end
  end
end
