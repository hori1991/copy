class LikesController < ApplicationController
    def create
        @like = current_user.likes.create(micropost_id: params[:micropost_id])
        redirect_back(fallback_location: root_path)
    end

    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        @like = current_user.likes.find_by(micropost_id: @micropost.id)
        @like.destroy
        redirect_back(fallback_location: root_path)
    end
end
