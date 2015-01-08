object @user

attributes :id, :name, :email

child :schools_users do
  attributes :identity, :is_supervisor, :is_student, :is_administrator

  child :school do
    attributes :id, :name, :classification
  end
end
