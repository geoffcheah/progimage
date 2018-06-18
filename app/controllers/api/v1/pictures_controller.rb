class Api::V1::PicturesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [ :create, :convert ]

  def show
    @picture = Picture.find(params[:id])
    authorize @picture
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user
    uploaded_io = params["picture"]
    aws_image_key = uploaded_io.original_filename
    image_to_upload = uploaded_io.tempfile
    UploadToS3Service.new(aws_image_key, image_to_upload).call
    @picture.remote_url = "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/#{aws_image_key}"
    authorize @picture
    if @picture.save
      render :show, status: :created
    else
      render_error
    end
  end

  def convert
    picture = Picture.find(params["id"].to_i)
    image_url = picture.remote_url
    new_format = params["convert_to"]
    old_image_name_without_type = picture.name.slice(/.*(?=\.)/)
    new_image_name = "#{old_image_name_without_type}.#{new_format}"
    image_to_upload = ConvertImageService.new(image_url, new_format).call
    UploadToS3Service.new(new_image_name, image_to_upload).call
    @picture = Picture.new(name: new_image_name, description: picture.description, user: picture.user )
    @picture.remote_url = "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/#{new_image_name}"
    authorize @picture
    if @picture.save
      render :show, status: :created
    else
      render_error
    end
  end


  private

  def render_error
    render json: { errors: @picture.errors.full_messages },
      status: :unprocessable_entity
  end

  def picture_params
    params.permit(:name, :description)
  end
end
