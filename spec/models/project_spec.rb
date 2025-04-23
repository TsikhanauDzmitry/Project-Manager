# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { build(:project) }

  context 'with a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:delete_all) }
  end

  describe '#expired_tasks_count' do
    let(:project) { create(:project) }

    before do
      create_list(:task, 2, :expired, project: project)
      create_list(:task, 3, project: project)
    end

    it 'counts only expired tasks' do
      expect(project.expired_tasks_count).to eq(2)
    end
  end

  describe '#active_tasks' do
    let(:project) { create(:project) }
    let!(:parent) { create(:task, project: project) }

    before do
      create(:task, project: project, parent: parent)
      create(:task, :expired, project: project)
    end

    it 'returns only non-expired top-level tasks' do
      expect(project.active_tasks).to contain_exactly(parent)
    end
  end
end
