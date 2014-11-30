module V1
  class ClickerSets < Grape::API
    resource :clicker_sets do
      desc 'Creates a clicker set and returns the new clicker set object'
      params do
        requires :clicker_set, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :user_id, type: Integer, desc: 'User ID'
          optional :type, type: String, desc: 'Type'
          optional :message, type: String, desc: 'Message'
          optional :time_length, type: Integer, desc: 'Time Length'
          optional :cheating, type: Boolean, desc: 'Cheating'
          optional :privacy, type: String, desc: 'Privacy'
        end
      end
      post '', rabl: 'clicker_sets/clicker_set' do
        @clicker_set = ClickerSet.new(permitted_params[:clicker_set])

        if @clicker_set.save
          @clicker_set
        else
          error!({ errors: @clicker_set.errors.full_messages })
        end
      end


      desc 'Updates a clicker set and returns the updated clicker set object'
      params do
        requires :clicker_set do
          optional :type, type: String, desc: 'Type'
          optional :message, type: String, desc: 'Message'
          optional :time_length, type: Integer, desc: 'Time Length'
          optional :cheating, type: Boolean, desc: 'Cheating'
          optional :privacy, type: String, desc: 'Privacy'
        end
      end
      put ':id', rabl: 'clicker_sets/clicker_set' do
        @clicker_set = ClickerSet.find_by_id(params[:id])

        if @clicker_set
          if @clicker_set.update_attributes(permitted_params[:clicker_set])
            @clicker_set
          else
            error!({ errors: @clicker_set.errors.full_messages })
          end
        else
          error!({ errors: ['Clicker set does not exist'] })
        end
      end


      desc 'Deletes a clicker set'
      delete ':id' do
        @clicker_set = ClickerSet.find_by_id(params[:id])

        if @clicker_set.destroy
          { success: true }
        else
          error!({ errors: @clicker_set.errors.full_messages })
        end
      end
    end
  end
end
