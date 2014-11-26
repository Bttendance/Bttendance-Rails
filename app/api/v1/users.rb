module V1
  class Users < Grape::API
    resource :users do
      desc 'Returns a list of users'
      get do
        User.all
      end

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
      post 'register' do
        user = User.new(permitted_params[:user])

        if user.save
          UserMailer.welcome(user).deliver
          user
        else
          error!({ errors: user.errors.full_messages })
        end
      end
    end
  end
end
