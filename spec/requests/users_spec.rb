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
      get v1_user_path(User.first), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      get v1_user_path(User.first), {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(response).to match_response_schema("json_api")
    end
  end
end
