# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.references :project, null: false, foreign_key: { on_delete: :cascade }
      t.references :parent, foreign_key: { to_table: :tasks, on_delete: :cascade }
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :tasks, :expires_at
  end
end
