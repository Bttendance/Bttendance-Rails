module V2 #Made by HeeHwan
	class Users < Grape::API
		resource :users do
			helpers do
        def unsecured_emails
          ['apple0@apple.com', 'apple1@apple.com', 'apple2@apple.com',
            'apple3@apple.com', 'apple4@apple.com', 'apple5@apple.com',
            'apple6@apple.com', 'apple7@apple.com', 'apple8@apple.com',
            'apple9@apple.com']
        end

        def error_with_user
          error!({ errors: @user.errors.full_messages }, 422)
        end
      end
			
			#signup post
			desc 'Registers a user and optionally a device and returns the new user object'
      params do
        requires :user, type: Hash do
          requires :email, type: String, desc: 'Email'
          requires :password, type: String, desc: 'Password'
          requires :name, type: String, desc: 'Name'
          optional :locale, type: String, desc: 'Locale'
          optional :devices_attributes, type: Array do
            requires :platform, type: String, desc: 'Platform'
            optional :uuid, type: String, desc: 'UUID'
            optional :mac_address, type: String, desc: 'MAC Address'
            optional :notification_key, type: String, desc: 'Notification Key'
          end
        end
      end
      post 'signUp', rabl: 'users/user' do
        @user = User.new(permitted_params[:user])
        if @user.save
          UserMailer.welcome(@user).deliver
          @user
        else
          error_with_user
        end
      end
			
			#autoSignin get
      desc 'Automatic sign in'
      params do
      	requires :email, type: String, desc: 'Email'
      	requires :password, type: String, desc: 'Password'
      	requires :device, type: Hash do
          requires :uuid, type: String, desc: 'UUID'
          optional :platform, type: String, desc: 'Platform'
        end
        requires :appVersion, type: String, desc: 'App Version'
      end
      get 'autoSignIn' rabl: 'users/user' do
      	@user = User.find_by_email(params[:email])
      	if @user
      		if @user.authenticate(params[:password])
      			#device
						device = Device.find_by_uuid(params[:device][:uuid])
      			if device && device.user_id == @user.id
      				#If version of user's app is greater than 2.0
	      			if params[:appVersion].to_f >= 2
	      				@user
	      			else
	      				error!({ errors: ['Update available'] })
	      			end
      			elsif device && device.user_id != @user.id      				
	      			error!({ errors: ['Device registered to another user'] })
	      		else
	      			error!({ errors: ['Device was not registered'] })
	      		end
      		else
      			error!({ errors: ['Authentication failed'] })
      		end
      	else
      		error!({ errors: ['User does not exist'] })
      	end
      end

      #signin post
      desc 'Authenticates a user and returns the user object'
      params do
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
        requires :device, type: Hash do
          requires :uuid, type: String, desc: 'UUID'
          optional :platform, type: String, desc: 'Platform'
        end
      end
      post 'signIn', rabl: 'users/user' do
        @user = User.find_by_email(params[:email])
        # Check for Apple.com emails
        if @user && unsecured_emails.include?(user[:email])
          @user
        elsif @user
          if @user.authenticate(params[:password])
            device = Device.find_by_uuid(params[:device][:uuid])
            # Device not yet registered to any user, add it to this user
            if !device
              if @user.devices.create(permitted_params[:device])
                @user
              else
              	error!({errors: ['Registering device failed'] })
              end
            elsif device && device.user_id == @user.id
              # User owns this device already, return user
              @user
            else
              # User doesn't own this device
              error!({ errors: ['Device registered to another user'] })
            end
          else
            error!({ errors: ['Authentication failed'] })
          end
        else
          error!({ errors: ['User does not exist'] })
        end
      end

      #forgotPassword put
      desc 'Sends a reset password email to a user'
      params do
      	requires :email, type: String, desc: 'Email'
      end
      put 'forgotPassword' do
        @user = User.find_by_email(params[:email])
        if @user
        	#Reset new password
        	password = SecureRandom.hex(4)        	
        	@user.password = password #need to passwordhash 

          UserMailer.reset(@user).deliver
          true
        else
          error!({ errors: ['User with that email does not exist']})
        end
      end

      #update put
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
          if permitted_params[:user][:new_password].present?
            if @user.authenticate(permitted_params[:user][:password])
              update_params[:password] = update_params[:new_password]
              update_params.delete :new_password
            else
              error!({ errors: ['Authentication failed'] })
            end
          end

          # Update schools and courses join models manually
          # TODO: Abstract (app-level)
          if update_params[:schools_users_attributes].present?
            update_params[:schools_users_attributes].each do |schools_user|
              found_schools_user = @user.schools_users.find_by_school_id(schools_user[:school_id])
              if found_schools_user && schools_user[:_destroy]
                found_schools_user.destroy
              elsif found_schools_user
                found_schools_user.update_attributes(schools_user)
              else !found_schools_user
                @user.schools_users.new(schools_user)
              end
            end
            update_params.delete(:schools_users_attributes)
          end
          if update_params[:courses_users_attributes].present?
            update_params[:courses_users_attributes].each do |courses_user|
              found_courses_user = @user.courses_users.find_by_course_id(courses_user[:course_id])
              if found_courses_user && courses_user[:_destroy]
                found_courses_user.destroy
              elsif found_courses_user
                found_courses_user.update_attributes(courses_user)
              else !found_courses_user
                @user.courses_users.new(courses_user)
              end
            end
            update_params.delete(:courses_users_attributes)
          end

          if @user.update_attributes(update_params)
            @user
          else
            error_with_user
          end
        else
          error!({ errors: ['User does not exist'] })
        end
      end

      #search get
			desc 'Returns a specific user'
      get ':id', rabl: 'users/user' do
        @user = User.find_by_id(params[:id])
        @user ? @user : error!({ errors: ['User does not exist'] })
      end

      #course get
      desc 'Return courses'
      params do
      	requires :email, type: String, desc: 'Email'
      end
      get 'courses' rabl: 'users/user' do
      	@user = User.find_by_email(params[:email])      	
      	if @user
      		@courses = OpenStruct.new({
      			"supervising" => [],
      			"resigned" => [],
            "attending" => [],
            "dropped" => [],
            "kicked" => []
      		})

      		@user.courses_user.each do |courses_user|
      			@courses[courses_user.state].push(courses_user.course)
      		end

      		supervising_courses = @courses.send("supervising")
      		attending_courses = @courses.send("attending")
      		@total_courses = supervising_courses + attending_courses
      		
      	else
      		error!({ errors: ['User does not exist'] })
      	end
      end

      #deviceUpdate put

		end
	end
end