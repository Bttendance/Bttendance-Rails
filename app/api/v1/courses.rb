module V1
  class Courses < Grape::API
    resource :courses do
      get '', rabl: 'courses/courses' do
        @courses = Course.all
      end
    end
  end
end
