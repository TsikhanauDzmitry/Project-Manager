# frozen_string_literal: true

class TasksController < ApplicationController
  def destroy
    @task = Task.includes(:project).find(params[:id]).tap(&:destroy)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end
end
