class CommentsController < ApplicationController

    before_action :authenticate_user!

    def create
    instagram = Instagram.find(params[:instagram_id])
      comment = instagram.comments.build(comment_params) 
      comment.user_id = current_user.id
      if comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end

    def destroy
      comment = Comment.find(params[:id])
      comment.destroy
      redirect_to action: :index
    end
  
    private
  
      def comment_params
        params.require(:comment).permit(:content)
    end

end
