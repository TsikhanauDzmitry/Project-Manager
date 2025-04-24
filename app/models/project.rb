# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :tasks, dependent: :delete_all
  has_many :active_parent_tasks, -> { active.where(parent_id: nil) },
           class_name: 'Task', foreign_key: :project_id, inverse_of: :project, dependent: :delete_all
  has_many :expired_tasks, -> { expired },
           class_name: 'Task', foreign_key: :project_id, inverse_of: :project, dependent: :delete_all

  validates :name, presence: true
end
