# frozen_string_literal: true

class TrackerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :grade, :comments, :editable

  def editable
    scope == object.user
  end
end
