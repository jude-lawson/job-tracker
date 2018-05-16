class CommentsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @comment = Comment.new
  end

  def create
    @job = Job.find(params[:job_id])
    @comment = @job.comments.create(comment_params)

    redirect_to job_path(@job)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body)
  end 
end
