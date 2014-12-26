module V1
  class Base < Grape::API
    version 'v1'

    mount V1::Users
    mount V1::Schools
    mount V1::Courses
    mount V1::AttendanceAlarms
    mount V1::Schedules
    mount V1::Attendances
    mount V1::Clickers
    mount V1::Notices
    mount V1::Curiouses
  end
end
