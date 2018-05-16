class JobsController < ApplicationController
  def index
    if params[:category]
      @category = Category.find_by(title: params[:category])
      @jobs = @category.jobs
    else
      @jobs = Job.all
    end
  end

  def new
    @job = Job.new()
    @categories = Category.all
    @category_options = @categories.map(&:title).zip(@categories.map(&:id)) 
  end

  def create
    @job = Job.create!(job_params)
    @company = @job.company
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    @company = @job.company
    @company.jobs.update(job_params)
    redirect_to job_path(@job)
  end

  def destroy
    @job = Job.find(params[:id])
    @company = @job.company
    Job.destroy(params[:id])
    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id, :company_id)
  end
end
