class CommentsController < ApplicationController
    def create
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.new(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        @comment = @micropost.comments.find(params[:id])
        @comment.destroy
        redirect_back(fallback_location: root_path)
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
