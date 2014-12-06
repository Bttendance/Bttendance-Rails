object @course

attributes :id, :school_id, :name, :instructor_name, :code, :open, :start_date, :end_date

child :users do
  attributes :id, :name
end

child :schedules do
  attributes :id, :day_of_week, :time, :timezone
end

child :clickers do
  attributes :id, :user_id, :type, :message, :saved, :time_length, :cheating, :privacy
end
