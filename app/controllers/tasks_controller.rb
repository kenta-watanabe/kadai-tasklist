class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
#    @tasks = Task.all.page(params[:page]).per(10)
    if logged_in?
#      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])   
    end
  end

  def show
  end

  def new
    # Taskクラスのインスタンスが作られる。
    # 受け皿だけの状態
    @task = Task.new
    # @task = Task.find(2)
  end

  def create
    
    @task = current_user.tasks.build(task_params)
      
    if @task.save
      flash[:success] = "成功"
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = "失敗"
      render "tasks/index"
    end

#    @task = Task.new(task_params)
#    if @task.save
#      flash[:success] = "Taskが正常に投稿されました"
#      redirect_to @task
#    else
#      flash.now[:danger] = "Taskが投稿されませんでした"
#      render :new
#    end
    # @task = Task.new(content: params[:task][:content])
  end

  def edit
  end

  def update
    # redirect_to "http://www.yahoo.com/"
    
    if @task.update(task_params)
      flash[:success] = "Taskは正常に更新されました"
      redirect_to @task
    else
      flash[:danger] = "Taskは更新されませんでした"
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = "Taskは正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    # formで書かれた情報をまとめて受け取ることができる
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @micropost = current_user.tasks.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
  
end
