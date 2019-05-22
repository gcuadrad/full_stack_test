class CommentsController < ApplicationController
  include ResponseHandler
  include ExceptionHandler
  before_action :set_feature, only: [:index]

  # GET  /features/:feature_id/comments
  def index
    json_response(@feature.comments)
  end
  
  # POST /features/:feature_id/comments
  def create
    @comment = Comment.create!(comment_params)
    json_response(@comment, :created)
  end

  private

  def set_feature
    @feature = Feature.find_by!(feature_id: params[:feature_id])
  end

  def comment_params
    params.permit(:feature_id, :email, :body)
  end
end
