require 'rails_helper'
require 'api/v1/pictures_controller'
require 'json'

RSpec.describe "Picture API endpoints", :type => :request do

  describe "Pictures API" do
    hash_for_json = { id: "1",
        name: "IMG_8394.JPG",
        description: "some description",
        remote_url: "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG"
      }

    json = JSON.generate(hash_for_json)
    let(:parsed_json) { JSON.parse(json) }

    let(:valid_body) { id: 18, convert_to: "png" }
    let (:invalid_body) { id: "", convert_to: "" }

    valid_body_json = JSON.generate(valid_body)
    invalid_body = JSON.generate(invalid_body)

    context "when calling GET pictures/:id endpoint" do
      it "returns a json with the picture's key information" do
        get '/api/v1/pictures/1'
        expect(response).to be_success
        expect(parsed_json["name"]).to eq("IMG_8394.JPG")
        expect(parsed_json["remote_url"]).to eq("https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG")
      end
    end

    context "with valid body, when calling the POST create api/v1/pictures) endpoint" do
      it "returns a json with the newly created picture's key information" do
        post "/api/v1/pictures"
        expect(response).to be_success
        get 'api/v1/pictures/:id'
        expec(response).to be_success
        expect(parsed_json["name"]).to eq("IMG_8394.JPG")
        expect(parsed_json["remote_url"]).to eq("https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG")
      end
    end

    # context "with invalid body, when calling the POST api/v1/pictures endpoint"
    # it "returns an error informing user of error messages"

    # context "with a valid body when calling the POST convert api/v1/pictures/convert endpoint"
    # it "returns a json with the information of the new converted picture"
    # it "uses the ConvertImageService to convert an image"
    # it "uses the UploadToS3Service to upload an image"

    # context "with a invalid body, POST convert endpoint"
    # it "returns an error message informing user of error messages"
  end
end
