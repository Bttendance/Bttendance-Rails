module V1
  class Base < Grape::API
    version 'v1'

    mount V1::Users
    mount V1::Schools
    mount V1::Courses
    mount V1::Devices
  end
end
