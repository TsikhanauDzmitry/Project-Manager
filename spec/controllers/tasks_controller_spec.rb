# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:project) { create(:project) }
  let!(:task)    { create(:task, project: project) }

  describe 'DELETE destroy' do
    it 'deletes the task' do
      expect do
        delete :destroy, params: { project_id: project.id, id: task.id }
      end.to change(Task, :count).by(-1)
    end

    it 'redirects to root_path' do
      delete :destroy, params: { project_id: project.id, id: task.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
