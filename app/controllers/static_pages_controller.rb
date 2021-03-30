class StaticPagesController < ApplicationController
    def home
        @micropost_new = Micropost.order(created_at: :desc).limit(5)
        @tags = ActsAsTaggableOn::Tag.most_used(10)
        if logged_in?
          @user = current_user
        end
    end
end
