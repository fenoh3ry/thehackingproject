class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category
    if @task.save
      flash[:notice] = "Task created"
    else
 
      flash[:notice] = "Please try again"
    end
    respond_to do |format| 
      format.html{redirect_to root_path}
      format.js {}
    end
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    if params[:origin] == "checkbox" 
      @task = Task.find(params[:id])
      (!params[:task])? (@task.update(status: false)):(@task.update(status: true))
      respond_to do |format|
        format.html {
        redirect_to root_path }
        format.js { }
        flash[:notice] = "Task Status edited"
      end
    else 
      @task = Task.find(params[:id])
      @task.update(task_params)
      puts @task.status
      respond_to do |format|
        format.html{redirect_to root_path}
        format.js{}
      end
      flash[:notice] = "Task edited"
    end 
   
  end


  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html{redirect_back(fallback_location: root_path)}
      format.js{}
    end
    
  end


  private

  def task_params
    params.permit(:title, :deadline, :description, :status)
  end

  def category_params
    params.require(:Category)
  end

end
