class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.create({ body: params[:body], article_id: params[:article_id], user_id: current_user.id })
    if comment.persisted?
      render json: {message: 'Your comment has been created'}, status: 201
    else
      render json: {error_message: 'oops'}, status: 500
    end
  end
end
