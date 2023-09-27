class CommentsController < ApplicationController
    before_action :authenticate_user!

  def create
    active = Active.find(params[:active_id])
    comment = active.comments.build(comment_params) 
    comment.user_id = current_user.id
    if comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path) 
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path) 
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      redirect_to actives_path
    else
      redirect_to :action => "edit"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to actives_path
  end


  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
