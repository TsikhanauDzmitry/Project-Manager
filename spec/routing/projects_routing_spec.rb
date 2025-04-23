# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects routes', type: :routing do
  it 'routes root path to Projects#index' do
    expect(get: '/').to route_to(controller: 'projects', action: 'index')
  end

  it 'routes projects path to Projects#index' do
    expect(get: '/projects').to route_to(controller: 'projects', action: 'index', format: :turbo_stream)
  end

  it 'routes destroy project path to Projects#destroy' do
    expect(delete: '/projects/42').to route_to(
      controller: 'projects', action: 'destroy', id: '42', format: :turbo_stream
    )
  end

  it 'routes nested destroy task path to Tasks#destroy' do
    expect(delete: '/projects/42/tasks/7').to route_to(
      controller: 'tasks', action: 'destroy',
      project_id: '42', id: '7', format: :turbo_stream
    )
  end
end
