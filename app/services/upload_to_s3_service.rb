class UploadToS3Service
  def initialize(aws_image_key_name, image_file)
    @image_key_name = aws_image_key_name
    @image = image_file
  end

  def call
    s3 = Aws::S3::Resource.new(region:'eu-west-1')
    obj = s3.bucket("progimage30").object("image_uploads/#{@image_key_name}")

    File.open(@image, 'rb') do |file|
      obj.put(acl: "public-read", body: file)
    end
  end
end
