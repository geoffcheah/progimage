require 'rails_helper'

RSpec.describe "Picture", :type => :model do
  let(:user) { User.create!(email: "g@gmail.com", password: "123456", authentication_token: "abcdefghijklmn0p")}
  let(:picture) { Picture.create!(name: "IMG_8394.JPG", description: "some description", remote_url: "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG", user: user ) }
  let(:valid_attributes) do
    {
      name: "IMG_8394.JPG",
      description: "some description",
      remote_url: "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG",
      user: user
    }
  end

  context "when looking at a picture's attributes" do
    it "should have a unique name" do
      picture_with_same_name = Picture.new(valid_attributes)
      expect(picture_with_same_name).not_to be_valid
    end

    it "name cannot be blank" do
      attributes = valid_attributes
      attributes.delete(:name)
      pic = Picture.new(attributes)
      expect(pic).not_to be_valid
    end

    it "remote url cannot be blank" do
      attributes = valid_attributes
      attributes.delete(:remote_url)
      pic = Picture.new(attributes)
      expect(pic).not_to be_valid
    end

    it "belongs to a user" do
      expect(picture.user).to eq(user)
    end
  end
end
