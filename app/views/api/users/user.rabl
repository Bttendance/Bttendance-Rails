object @user

attributes :id, :name, :email

child :devices, object_root: false do
  attributes :id, :platform, :uuid, :mac_address
end
