object @school

attributes :id, :name, :classification

child :users do
  attributes :id, :name
end

child :courses do
  attributes :id, :name
end
