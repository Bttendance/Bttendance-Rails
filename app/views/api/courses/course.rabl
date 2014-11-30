object @course

attributes :id, :school_id, :name, :instructor_name, :code, :open, :start_date, :end_date

child :users, object_root: false do
  attributes :id, :name
end

child :schedules, object_root: false do
  attributes :id, :day_of_week, :time, :timezone
end

child :clicker_sets, object_root: false do
  attributes :id, :user_id, :type, :message, :time_length, :cheating, :privacy
end
