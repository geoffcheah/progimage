class Api::V1::PicturesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [ :create ]
  def show
    @picture = Picture.find(params[:id])
    authorize @picture
  end

  def create
    @picture = Picture.new(name: params["name"], description: params["description"])
    puts current_user.email
    @picture.user = current_user
    authorize @picture

  end


  private

  # def picture_params
  #   params.require(:picture).permit(:name, :description, :picture)
  # end
end
