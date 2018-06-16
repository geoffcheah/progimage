require 'rails_helper'
require 'api/v1/pictures_controller'
require 'json'

describe "Pictures API" do
  hash_for_json = { id: "1",
      name: "IMG_8394.JPG",
      description: "some description",
      remote_url: "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG"
    }

  json = JSON.generate(hash_for_json)
  let(:parsed_json) { JSON.parse(json) }

  context "when calling the GET pictures/:id (show) endpoint or returning newly created image information" do
    it "returns a json with the picture's key information" do
      get '/api/v1/pictures/:id'
      expect(response).to be_success
      expect(parsed_json["name"]).to eq("IMG_8394.JPG")
      expect(parsed_json["remote_url"]).to eq("https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG")
    end
  end

  context "when calling the POST api/v1/pictures) endpoint" do
    it "returns a json with the newly created picture's key information" do
      post "/api/v1/pictures"
      expect(response).to be_success
      get 'api/v1/pictures/:id'
      expec(response).to be_success
      expect(parsed_json["name"]).to eq("IMG_8394.JPG")
      expect(parsed_json["remote_url"]).to eq("https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG")
    end
  end

end
