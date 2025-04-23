# frozen_string_literal: true

class BaseQuery
  def initialize
    super if defined?(super)
  end

  def call
    raise NotImplementedError, 'Subclasses must implement #call'
  end
end
