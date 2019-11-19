class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :read_params, only:[:show]

  def index

    @expired_tasks = Task.expired.where(user_id: current_user.id)

    if params[:sort_priority]
      @tasks = current_user.tasks.important
    elsif params[:sort_expired]
      @tasks = current_user.tasks.expired
    elsif params[:task] == nil
      @tasks = current_user.tasks.latest
    elsif params[:task][:search]
      @tasks = current_user.tasks.search(params)
      if params[:task][:label_id].present?
        @tags = Tag.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks = @tasks.where(id: @tags)
      end
    end

    @tasks = @tasks.page(params[:page]).per(7)

    @label_ids = Tag.where(task_id: @tasks.ids).pluck(:label_id)
    @labels = Label.where(id: @label_ids)
    @graph = @labels.group_by(&:itself)

  end

  def new
    if params[:back]
      @task = Task.new(task_params)
      label_ids = params[:task][:label_ids]
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    label_ids = params[:task][:label_ids]
    @task.images.attach(ActiveStorage::Blob.find_by(key: params[:blob_keys]))
    if @task.save
      redirect_to tasks_path, notice: "taskを作成しました"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
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
    @task.user_id = current_user.id
    render :new if @task.invalid?
  end

  private

  def task_params
    params.require(:task).permit(:task_name, :deadline, :priority, :status, :content, images: [], label_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def read_params
    if params[:r]
      unless current_user.reads.find_by(task_id: params[:r])
        current_user.reads.create(task_id: params[:r])
      end
    end
  end
end
