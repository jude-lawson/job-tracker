class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new()
    @categories = Category.all
    @category_options = @categories.map(&:title).zip(@categories.map(&:id)) 
  end

  def create
    @company = Company.find(job_params[:company_id])
    @job = @company.jobs.create!(job_params)
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

  # def update
  #   @job = Job.find(params[:id])
  #   @company = Company.find(params[:company_id])
  #   @company.jobs.update(job_params)
  #   redirect_to company_job_path(@company, @job)
  # end

  # def destroy
  #   @job = Job.find(params[:id])
  #   @company = Company.find(params[:company_id])
  #   Job.destroy(params[:id])
  #   redirect_to company_jobs_path(@company)
  # end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id, :company_id)
  end
end
