# frozen_string_literal: true

class ProjectsQuery < BaseQuery
  ALLOWED_ORDER_COLUMNS = %i[name created_at updated_at].freeze
  ALLOWED_SORT          = %i[asc desc].freeze

  def initialize(order: :name, sort: :asc)
    super()
    @order = ALLOWED_ORDER_COLUMNS.include?(order) ? order : :name
    @sort  = ALLOWED_SORT.include?(sort)           ? sort  : :asc
  end

  def call
    Project
      .includes(active_parent_tasks: { subtasks: { subtasks: :subtasks } })
      .includes(:expired_tasks, :tasks)
      .order(@order => @sort)
  end
end
