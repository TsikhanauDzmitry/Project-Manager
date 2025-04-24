# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: %i[edit update destroy]

  def edit
    respond_to do |format|
      format.turbo_stream { render :edit }
      format.html         { redirect_to root_path }
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream { render :update }
        format.html         { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :edit, status: :unprocessable_entity }
        format.html         { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name)
  end
end
