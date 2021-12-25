class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:follow])
    current_user.follow(@other_user)
    redirect_to post_path(params[:post_id])
  end

  def destroy
    # @user = current_user.relationships.find(params[:user_id]).follow
    current_user.unfollow(params[:user_id])
    redirect_to post_path(params[:post_id])
  end
end
