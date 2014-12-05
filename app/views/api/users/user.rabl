object @user

attributes :id, :name, :email

child :devices do
  attributes :id, :platform, :uuid, :mac_address
end

child :schools do
  attributes :id, :name, :classification
end

child :courses do
  attributes :id, :school_id, :name, :open
end
