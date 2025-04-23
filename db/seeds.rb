# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Task.delete_all
Project.delete_all

100.times do |i|
  project = Project.create!(name: "Project #{i + 1}")

  tasks = 25.times.map do |j|
    expires_at = Faker::Time.between(from: 1.year.ago, to: 1.year.from_now)
    Task.create!(
      name: "Task #{j + 1} for Project #{i + 1}",
      expires_at: expires_at,
      project_id: project.id
    )
  end

  children = tasks.sample((tasks.size * 2.0 / 3).round)
  children.each do |child|
    parent = (tasks - [child]).sample
    child.update!(parent: parent)
  end
end
