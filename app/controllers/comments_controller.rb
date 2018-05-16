class CommentsController < ApplicationController

  def new
    @job = Job.find(params[:job_id])
    @comment = Comment.new
  end 
end
