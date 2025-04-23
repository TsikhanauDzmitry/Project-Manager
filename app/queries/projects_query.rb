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
      .left_joins(:tasks)
      .select(<<~SQL.squish)
        projects.*,
        SUM(CASE WHEN tasks.expires_at <= CURRENT_TIMESTAMP THEN 1 ELSE 0 END) AS expired_tasks_count
      SQL
      .includes(tasks: { subtasks: { subtasks: :subtasks } })
      .group('projects.id')
      .order(@order => @sort)
  end
end
