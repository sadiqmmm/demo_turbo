class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update show destroy]
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'comment_form',
            partial: 'comments/form',
            locals: { comment: Comment.new }
          )
        end
        format.html { render partial: 'comments/form', locals: { comment: Comment.new } }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'comment_form',
            partial: 'comments/form',
            locals: { comment: @comment }
          )
        end
        format.html { render partial: 'comments/form', locals: { comment: @comment } }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @project = Project.find(params[:project_id])
    @comment = @project.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
