class Api::V1::PicturesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [ :create ]
  def show
    @picture = Picture.find(params[:id])
    authorize @picture
  end

  def create
    @picture = Picture.new(name: params["name"], description: params["description"])
    @picture.user = current_user
    uploaded_io = params["picture"]
    aws_image_key = uploaded_io.original_filename
    image_to_upload = uploaded_io.tempfile

    UploadToS3Service.new(aws_image_key, image_to_upload).call

    @picture.remote_url = "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/#{params["name"]}"
    authorize @picture
    if @picture.save
      render :show, status: :created
    else
      render_error
    end
  end

  def convert
    @picture = Picture.find(params[:id])
  end


  private

  # def picture_params
  #   params.require(:picture).permit(:name, :description, :picture)
  # end
end
