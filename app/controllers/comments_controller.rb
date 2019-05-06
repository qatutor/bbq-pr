class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]

  # POST /comments
  # POST /comments.json
  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      redirect_to @event, notice: I18n.t('controllers.comments.created')
    else
      render 'events/show', alert: I18n.t('controllers.comments.error')
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = @event.comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comments).permit(:body, :user_name)
    end
end
