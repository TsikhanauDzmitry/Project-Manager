# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { build(:task) }

  context 'with a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:parent).class_name('Task').optional }
    it { is_expected.to have_many(:subtasks).class_name('Task').with_foreign_key('parent_id').dependent(:delete_all) }
  end

  describe '#expired?' do
    it 'returns true when expires_at in the past' do
      t = build(:task, expires_at: 1.day.ago)
      expect(t.expired?).to be true
    end

    it 'returns false when expires_at in the future' do
      t = build(:task, expires_at: 1.day.from_now)
      expect(t.expired?).to be false
    end
  end

  describe 'callbacks' do
    it 'sets expires_at six months ahead if not provided' do
      t = create(:task, expires_at: nil)
      expect(t.expires_at).to be_within(1.second).of(6.months.from_now)
    end
  end
end
