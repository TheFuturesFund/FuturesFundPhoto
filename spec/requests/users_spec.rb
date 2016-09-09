require "rails_helper"

describe "Users API", type: :request do
  describe "GET /v1/users" do
    before(:each) do
      create_list(:user, 5)
    end

    it "should require authentication" do
      get v1_users_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      get v1_users_path, {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "GET /v1/users/:id" do
    before(:each) do
      create(:user)
    end

    it "should require authentication" do
      user = User.first

      get v1_user_path(user), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      user = User.first

      get v1_user_path(user), {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "POST /v1/users" do
    it "should require authentication" do
      post v1_users_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should create a user and render a valid JSON API response for a valid user" do
      request_body = {
        user: {
          email: "user@example.com",
          first_name: "Example",
          last_name: "User",
          role: "student",
          classroom_id: create(:classroom).id,
          password: "password",
        },
      }.to_json

      user = create(:user, :teacher)

      post v1_users_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 201
      expect(json["data"]).not_to be_nil
      expect(User.find_by(email: "user@example.com")).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid user" do
      request_body = {
        user: {
          first_name: "Example",
          last_name: "User",
          role: "student",
          classroom_id: create(:classroom).id,
        },
      }.to_json

      user = create(:user, :teacher)

      post v1_users_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "PATCH /v1/users/:id" do
    before(:each) do
      create(:user)
    end

    it "should require authentication" do
      user = User.first

      patch v1_user_path(user), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should update a user and render a valid JSON API response for a valid user" do
      request_body = {
        user: {
          first_name: "New name",
        },
      }.to_json

      user = create(:user, :teacher)
      target = User.first

      patch v1_user_path(target), request_body, authenticated_request_headers(user)

      target.reload

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(target.first_name).to eq "New name"
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid user" do
      request_body = {
        user: {
          first_name: "",
        },
      }.to_json

      user = create(:user, :teacher)
      target = User.first

      patch v1_user_path(target), request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "DELETE /v1/users/:id" do
    before(:each) do
      create(:user)
    end

    it "should require authentication" do
      user = User.first

      delete v1_user_path(user), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should destroy a user and respond with a 204" do
      user = create(:user, :teacher)
      target = User.first

      delete v1_user_path(target), {}, authenticated_request_headers(user)

      target = User.where(id: target.id).first

      expect(response.status).to eq 204
      expect(target).to be_nil
    end
  end
end
