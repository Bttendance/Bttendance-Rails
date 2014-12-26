module V1
  class Curiouses < Grape::API
    resource :curiouses do
      desc 'Returns a specific curious'
      get ':id', rabl: 'curiouses/curious' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @curious
        else
          error_with('Curious', 404)
        end
      end


      desc 'Creates a curious and returns the new curious object'
      params do
        requires :curious, type: Hash do
          requires :course_id, type: Integer, desc: 'Course ID'
          requires :user_id, type: Integer, desc: 'User ID'
          requires :title, type: String, desc: 'Title'
          optional :message, type: String, desc: 'Message'
        end
      end
      post '', rabl: 'curiouses/curious' do
        @curious = Curious.new(permitted_params[:curious])

        if @curious.save
          @curious
        else
          error_with(@curious, 422)
        end
      end


      desc 'Updates a curious and returns the updated curious object'
      params do
        requires :curious, type: Hash do
          optional :title, type: String, desc: 'Title'
          optional :message, type: String, desc: 'Message'
        end
      end
      put ':id', rabl: 'curiouses/curious' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          if @curious.update_attributes(permitted_params[:curious])
            @curious
          else
            error_with(@curious, 422)
          end
        else
          error_with('Curious', 404)
        end
      end


      desc 'Returns a curiouses comments'
      get ':id/comments' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @comments = @curious.comments
        else
          error_with('Curious', 404)
        end
      end


      desc 'Adds a comment to a curious and returns the new comment object'
      params do
        requires :user_id, type: Integer, desc: 'User ID'
        requires :message, type: String, desc: 'Message'
      end
      post ':id/comments', rabl: 'comments/comment' do
        @curious = Curious.find_by_id(params[:id])
        @user = User.find_by_id(params[:user_id])

        if @curious
          if @user
            @comment = @curious.comments.build(author: @user, message: params[:message])

            if @comment.save
              @comment
            else
              error_with(@comment, 422)
            end
          else
            error_with('User', 404)
          end
        else
          error_with('Curious', 404)
        end
      end


      desc 'Updates a comment on a curious and returns the updated comment object'
      params do
        requires :message, type: String, desc: 'Message'
      end
      put ':id/comments/:comment_id', rabl: 'comments/comment' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @comment = @curious.comments.find_by_id(params[:comment_id])

          if @comment
            if @comment.update_attributes(message: params[:message])
              @comment
            else
              error_with(@comment, 422)
            end
          else
            error_with('Comment', 404)
          end
        else
          error_with('Curious', 422)
        end
      end


      desc 'Deletes a comment from a curious'
      delete ':id/comments/:comment_id' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @comment = @curious.comments.find_by_id(params[:comment_id])

          if @comment
            if @comment.destroy
              status 204
            else
              error_with(@comment, 422)
            end
          else
            error_with('Comment', 404)
          end
        else
          error_with('Curious', 404)
        end
      end


      desc 'Likes a curious'
      params do
        requires :user_id, type: Integer, desc: 'User ID'
      end
      post ':id/like' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @user = User.find_by_id(params[:user_id])

          if @user
            @like = @curious.likes.build(user: @user)
            if @like.save
              status 201
            else
              error_with(@like, 422)
            end
          else
            error_with('User', 404)
          end
        else
          error_with('Curious', 404)
        end
      end


      desc 'Unlikes a curious'
      params do
        requires :user_id, type: Integer, desc: 'User ID'
      end
      post ':id/unlike' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @like = @curious.likes.find_by_user_id(params[:user_id])

          if @like
            if @like.destroy_all
              status 204
            else
              error_with(@like, 422)
            end
          else
            error_with('Like', 404)
          end
        else
          error_with('Curious', 404)
        end
      end


      desc 'Follows a curious'
      params do
        requires :user_id, type: Integer, desc: 'User ID'
      end
      post ':id/follow' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @user = User.find_by_id(params[:user_id])

          if @user
            @follower = @curious.followers.build(user: @user)

            if @follower.save
              status 201
            else
              error_with(@follower, 422)
            end
          else
            error_with('User', 404)
          end
        else
          error_with('Curious', 404)
        end
      end


      desc 'Unfollows a curious'
      params do
        requires :user_id, type: Integer, desc: 'User ID'
      end
      post ':id/unfollow' do
        @curious = Curious.find_by_id(params[:id])

        if @curious
          @follower = @curious.followers.find_by_user_id(params[:user_id])

          if @follower
            if @follower.destroy_all
              status 204
            else
              error_with(@follower, 422)
            end
          else
            error_with('Follower', 404)
          end
        else
          error_with('Curious', 404)
        end
      end
    end
  end
end
