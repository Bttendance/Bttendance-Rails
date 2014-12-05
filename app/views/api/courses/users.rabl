object @users

child :supervising => :supervising do
  attributes :id, :name
end

child :attending => :attending do
  attributes :id, :name
end

child :dropped => :dropped do
  attributes :id, :name
end

child :kicked => :kicked do
  attributes :id, :name
end
