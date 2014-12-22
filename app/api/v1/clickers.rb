module V1
  class Clickers < Grape::API
    resource :clickers do
      desc 'Creates a clicker and returns the new clicker object'
      params do
        requires :clicker, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :user_id, type: Integer, desc: 'User ID'
          optional :type, type: String, desc: 'Type'
          optional :message, type: String, desc: 'Message'
          optional :saved, type: Boolean, desc: 'Saved'
          optional :time_length, type: Integer, desc: 'Time Length'
          optional :cheating, type: Boolean, desc: 'Cheating'
          optional :privacy, type: String, desc: 'Privacy'
        end
      end
      post '', rabl: 'clickers/clicker' do
        @clicker = Clicker.new(permitted_params[:clicker])

        if @clicker.save
          @clicker
        else
          error_with(@clicker, 422)
        end
      end


      desc 'Returns a specific clicker'
      get ':id', rabl: 'clickers/clicker' do
        @clicker = Clicker.find_by_id(params[:id])

        if @clicker
          @clicker
        else
          error_with('Clicker', 404)
        end
      end


      desc 'Updates a clicker and returns the updated clicker object'
      params do
        requires :clicker do
          optional :type, type: String, desc: 'Type'
          optional :message, type: String, desc: 'Message'
          optional :saved, type: Boolean, desc: 'Saved'
          optional :time_length, type: Integer, desc: 'Time Length'
          optional :cheating, type: Boolean, desc: 'Cheating'
          optional :privacy, type: String, desc: 'Privacy'
        end
      end
      put ':id', rabl: 'clickers/clicker' do
        @clicker = Clicker.find_by_id(params[:id])

        if @clicker
          if @clicker.update_attributes(permitted_params[:clicker])
            @clicker
          else
            error_with(@clicker, 422)
          end
        else
          error_with('Clicker', 404)
        end
      end


      desc 'Deletes a clicker'
      delete ':id' do
        @clicker = Clicker.find_by_id(params[:id])

        if @clicker.destroy
          status 204
        else
          error_with(@clicker, 422)
        end
      end
    end
  end
end
