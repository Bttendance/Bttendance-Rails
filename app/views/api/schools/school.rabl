object @school

attributes :id, :name, :classification

child @school.courses, object_root: false do
  extends 'courses/course'
end
