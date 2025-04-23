# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET index' do
    let!(:projects) { create_list(:project, 2) }

    before { get :index }

    it 'responds with 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns @projects' do
      expect(assigns(:projects)).to match_array(projects)
    end
  end

  describe 'DELETE destroy' do
    let!(:project) { create(:project) }

    it 'deletes the project' do
      expect do
        delete :destroy, params: { id: project.id }
      end.to change(Project, :count).by(-1)
    end

    it 'redirects to root_path' do
      delete :destroy, params: { id: project.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
