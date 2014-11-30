object @school

attributes :id, :name, :classification

child :users, object_root: false do
  attributes :id, :name
end

child :courses, object_root: false do
  attributes :id, :name
end
