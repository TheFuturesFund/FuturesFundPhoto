require "rails_helper"

describe "Albums API", type: :request do
  describe "GET /v1/albums" do
    before(:each) do
      create_list(:album, 5)
    end

    it "should require authentication" do
      get v1_albums_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      get v1_albums_path, {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "GET /v1/albums/:id" do
    before(:each) do
      create(:album)
    end

    it "should require authentication" do
      album = Album.first

      get v1_album_path(album), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      album = Album.first

      get v1_album_path(album), {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "POST /v1/albums" do
    it "should require authentication" do
      post v1_albums_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should create an album and render a valid JSON API response for a valid album" do
      user = create(:user)

      request_body = {
        album: {
          name: "Album name",
          user_id: user.id,
        },
      }.to_json

      post v1_albums_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 201
      expect(json["data"]).not_to be_nil
      expect(Album.find_by(name: "Album name")).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid album" do
      user = create(:user)

      request_body = {
        album: {
          name: "",
          user_id: user.id,
        },
      }.to_json

      post v1_albums_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "PATCH /v1/albums/:id" do
    before(:each) do
      create(:album)
    end

    it "should require authentication" do
      album = Album.first

      patch v1_album_path(album), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should update a album and render a valid JSON API response for a valid album" do
      user = create(:user, :teacher)

      request_body = {
        album: {
          name: "New album name",
        },
      }.to_json

      album = Album.first

      patch v1_album_path(album), request_body, authenticated_request_headers(user)

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(album.reload.name).to eq "New album name"
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid album" do
      request_body = {
        album: {
          name: "",
        },
      }.to_json

      user = create(:user, :teacher)
      album = Album.first

      patch v1_album_path(album), request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "DELETE /v1/albums/:id" do
    before(:each) do
      create(:album)
    end

    it "should require authentication" do
      album = Album.first

      delete v1_album_path(album), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should destroy an album and respond with a 204" do
      user = create(:user, :teacher)
      album = Album.first

      delete v1_album_path(album), {}, authenticated_request_headers(user)

      album = Album.where(id: album.id).first

      expect(response.status).to eq 204
      expect(album).to be_nil
    end
  end
end
