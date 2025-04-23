# frozen_string_literal: true

class Task < ApplicationRecord
  before_validation :set_expires_at, on: :create

  belongs_to :project
  belongs_to :parent, class_name: 'Task', optional: true
  has_many :subtasks, class_name: 'Task', foreign_key: :parent_id, inverse_of: :parent, dependent: :delete_all

  validates :name, presence: true

  def expired?
    expires_at <= Time.zone.now
  end

  private

  def set_expires_at
    self.expires_at ||= 6.months.from_now
  end
end
