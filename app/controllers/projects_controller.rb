# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = ProjectsQuery.new(
      order: params.fetch(:order, :name).to_sym,
      sort: params.fetch(:sort, :asc).to_sym
    ).call
  end

  def destroy
    @project = Project.find(params[:id]).tap(&:delete)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end
end
