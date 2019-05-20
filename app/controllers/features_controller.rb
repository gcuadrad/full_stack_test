class FeaturesController < ApplicationController
  def index
    features = Feature.all
    render json: features.to_json
  end

  private

  def feature_params
    params.require(:feature).permit(:id)
  end
end
