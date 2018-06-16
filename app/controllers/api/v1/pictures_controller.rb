class Api::V1::PicturesController < Api::V1::BaseController
  def show
    @picture = Picture.find(params[:id])
    authorize @picture
  end

end
