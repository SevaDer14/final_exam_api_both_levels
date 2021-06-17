class Api::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.create(params.permit(:body, :article_id))
    if comment.persisted?
      render json: { message: 'Your comment has been created' }, status: 201
    else
      render json: { error_message: 'Comment can not be empty' }, status: 422
    end
  end
end
