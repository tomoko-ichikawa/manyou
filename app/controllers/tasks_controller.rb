class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "taskを作成しました"
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path,notice:"taskを編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"taskを削除しました"
  end

  def confirm
      @task = Task.new(task_params)
  end

  private

  def task_params
    params.require(:task).permit(:task_name,:deadline,:priority,:status,:content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
