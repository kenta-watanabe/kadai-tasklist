class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page]).per(3)
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
    # redirect_to "http://www.yahoo.co.jp/"
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Taskが正常に投稿されました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskが投稿されませんでした"
      render :new
    end
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
    params.require(:task).permit(:content, :Status)
  end
end
