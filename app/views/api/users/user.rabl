object @user

attributes :id, :name, :email

child :schools_users do
  attributes :identity, :state

  child :school do
    attributes :id, :name
  end
end
