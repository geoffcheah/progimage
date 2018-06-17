class ConvertImageService
  def initialize(image_url, new_format)
    @image_url = image_url
    @new_format = new_format
  end

  def call
    image = MiniMagick::Image.open(@image_url)
    image.format(@new_format)
    return image.tempfile
  end

end
