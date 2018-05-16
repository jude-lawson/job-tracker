class JobsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new()
    @categories = Category.all
    @category_options = @categories.map(&:title).zip(@categories.map(&:id)) 
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.create!(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
    @company = Company.find(params[:company_id])
  end

  def update
    @job = Job.find(params[:id])
    @company = Company.find(params[:company_id])
    @company.jobs.update(job_params)
    redirect_to company_job_path(@company, @job)
  end

  def destroy
    @job = Job.find(params[:id])
    @company = Company.find(params[:company_id])
    Job.destroy(params[:id])
    redirect_to company_jobs_path(@company)
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
