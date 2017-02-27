# frozen_string_literal: true

class Tracker < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, :grade, :comments, presence: true
end
