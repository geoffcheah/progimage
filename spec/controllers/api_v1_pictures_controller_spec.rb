require 'rails_helper'
require 'api/v1/pictures_controller'

RSpec.describe Api::V1::PicturesController, :type => :controller do
  let(:user) { User.create!(email: "g@gmail.com", password: "123456", authentication_token: "abcdefghijklmn0p")}
  let(:valid_attributes) do
    {
      name: "IMG_8394.JPG",
      description: "some description",
      remote_url: "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG",
      user: user
    }
  end

  let(:invalid_params) do
    {
      name: "",
      description: "some description",
    }
  end

  describe "GET show" do
    it "assigns @picture to the requested picture" do
      picture = Picture.create!(valid_attributes)
      get :show, params: { :id => picture.to_param }
      expect(assigns(:picture)).to  eq(picture)
    end

    it "returns a 200 OK status" do
      picture = Picture.create!(valid_attributes)
      get :show, params: { :id => picture.to_param }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new picture" do
        picture = Picture.create!(valid_attributes)
        expect {
          post :create, params: { :picture => valid_attributes}
        }.to change(Picture, :count).by(1)
      end

      it "assigns a newly created picture as @picture" do
        post :create, params: { :picture => valid_attributes }
        expect(assigns(:picture)).to be_a(Picture)
        expect(assigns(:picture)).to be_persisted
      end

      it "returns a 201 created status" do
        post :create
        expect(response).to have_http_status(:created)
      end

      it "renders the json template for an individual picture (show)" do
        post :create, params: { :picture => valid_attributes }
        expect(response).to render_template(:show)
      end
    end

    context "with invalid params" do
      it "sends back an error" do
        post :create, params: { :picture => invalid_params }
        expect(response).to render_template(:error)
      end

      it "returns a 422 error status" do
        post :create, params: { :picture => invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe "POST convert" do
  #   let(:valid_request) do
  #     {
  #       id: "1",
  #       format: "png"
  #     }
  #   end

  #   context "with valid request parameters" do
  #     it "gets the right picture and its url" do
  #       post :convert, params { :}
  #       picture = Picture.find(valid_request[:id])
  #       expect(picture).to be
  #     end
  #   end
  # end

end
