class MicropostsController < ApplicationController
    def index
        if params[:tag_name]
            @microposts = Micropost.tagged_with(params[:tag_name].to_s)
            @tags = ActsAsTaggableOn::Tag.most_used(10)
        else
            @q = Micropost.ransack(params[:q])
            @microposts = @q.result(distinct: true)
        end
    end

    def show
        @micropost = Micropost.includes(:user).find(params[:id])
        @user = @micropost.user
        @comments = @micropost.comments.includes(:user).all
        @comment = Comment.new
    end

    def new
        @micropost = Micropost.new
    end

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "投稿が完了しました"
            redirect_to @micropost
        else
            flash[:danger] = "投稿に失敗しました"
            render :new
        end
    end

    def edit
        @micropost = Micropost.find(params[:id])
    end

    def update
        @micropost = Micropost.find(params[:id])
        if @micropost.update(micropost_params)
            redirect_to micropost_path(@micropost), notice: '投稿を更新しました。'
        else
            flash.now[:alert] = '入力に誤りがあります。'
            render :edit
        end
    end

    def destroy
        @micropost = Micropost.find(params[:id])
        @micropost.destroy
        flash[:success] = '投稿を削除しました。'
        redirect_to root_url
    end

    private

    def micropost_params
        params.require(:micropost).permit(:content, :title, :start_time, :tag_list)
    end
end
