# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :tasks, dependent: :delete_all

  validates :name, presence: true

  def expired_tasks_count
    self[:expired_tasks_count] || tasks.select(&:expired?).size
  end

  def active_tasks
    tasks.reject(&:expired?).select { |t| t.parent_id.nil? }
  end
end
