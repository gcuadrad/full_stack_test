class FeaturesController < ApplicationController
  include ResponseHandler
  include ExceptionHandler
  before_action :set_feature, only: [:show]

  # GET  /features
  def index
    @features = Feature.all
    json_response(@features)
  end

# GET  /features/:id
  def show
    json_response(@feature)
  end

  private

  def set_feature
    @feature = Feature.find_by!(feature_id: params[:id])
  end
end
