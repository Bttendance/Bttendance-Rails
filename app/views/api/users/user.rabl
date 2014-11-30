object @user

attributes :id, :name, :email

child :devices, object_root: false do
  attributes :id, :platform, :uuid, :mac_address
end

child :schools, object_root: false do
  attributes :id, :name, :classification
end

child :courses, object_root: false do
  attributes :id, :school_id, :name, :open
end
