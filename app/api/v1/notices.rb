module V1
  class Notices < Grape::API
    resource :notices do
      desc 'Creates a notice and returns the new notice object'
      params do
        requires :notice, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :user_id, type: Integer, desc: 'User ID'
          optional :targeted, type: Boolean, desc: 'Targeted'
          optional :message, type: String, desc: 'Message'
          optional :notice_targets_attributes, type: Array do
            requires :user_id, type: Integer, desc: 'User ID'
          end
        end
      end
      post '', rabl: 'notices/notice' do
        @notice = Notice.new(permitted_params[:notice])

        if @notice.save
          @notice
        else
          error!({ errors: @notice.errors.full_messages })
        end
      end


      desc 'Updates a notice and returns the updated notice object'
      params do
        requires :notice, type: Hash do
          optional :targeted, type: Boolean, desc: 'Targeted'
          optional :message, type: String, desc: 'Message'
          optional :notice_targets_attributes, type: Array do
            optional :id, type: Integer, desc: 'ID'
            optional :_destroy, type: Boolean, desc: 'Destroy'
          end
        end
      end
      put ':id', rabl: 'notices/notice' do
        @notice = Notice.find_by_id(params[:id])

        if @notice
          if @notice.update_attributes(permitted_params[:notice])
            @notice
          else
            error!({ errors: @notice.errors.full_messages })
          end
        else
          error!({ errors: ['Notice does not exist'] })
        end
      end
    end
  end
end
