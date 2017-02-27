class TrackerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :string, :last_name, :grade, :comments
end
