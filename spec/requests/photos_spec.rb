require "rails_helper"

describe "Photos API", type: :request do
  describe "GET /v1/photos" do
    before(:each) do
      create_list(:photo, 5)
    end

    it "should require authentication" do
      get v1_photos_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      get v1_photos_path, {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "GET /v1/photos/:id" do
    before(:each) do
      create(:photo)
    end

    it "should require authentication" do
      photo = Photo.first

      get v1_photo_path(photo), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      photo = Photo.first

      get v1_photo_path(photo), {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "POST /v1/photos" do
    it "should require authentication" do
      post v1_photos_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should create an photo and render a valid JSON API response for a valid photo" do
      user = create(:user)
      album = create(:album, user: user)

      request_body = {
        photo: {
          name: "Photo name",
          album_id: album.id,
        },
      }.to_json

      post v1_photos_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 201
      expect(json["data"]).not_to be_nil
      expect(Photo.find_by(name: "Photo name")).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid photo" do
      user = create(:user, :teacher)

      request_body = {
        photo: {
          name: "Photo name",
          alubm_id: nil,
        },
      }.to_json

      post v1_photos_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "PATCH /v1/photos/:id" do
    before(:each) do
      create(:photo)
    end

    it "should require authentication" do
      photo = Photo.first

      patch v1_photo_path(photo), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should update a photo and render a valid JSON API response for a valid pohto" do
      user = create(:user, :teacher)

      request_body = {
        photo: {
          name: "New photo name",
        },
      }.to_json

      photo = Photo.first

      patch v1_photo_path(photo), request_body, authenticated_request_headers(user)

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(photo.reload.name).to eq "New photo name"
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid photo" do
      request_body = {
        photo: {
          album_id: nil,
        },
      }.to_json

      user = create(:user, :teacher)
      photo = Photo.first

      patch v1_photo_path(photo), request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "DELETE /v1/photos/:id" do
    before(:each) do
      create(:photo)
    end

    it "should require authentication" do
      photo = Photo.first

      delete v1_photo_path(photo), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should destroy an photo and respond with a 204" do
      user = create(:user, :teacher)
      photo = Photo.first

      delete v1_photo_path(photo), {}, authenticated_request_headers(user)

      photo = Photo.where(id: photo.id).first

      expect(response.status).to eq 204
      expect(photo).to be_nil
    end
  end
end
