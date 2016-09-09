require "rails_helper"

describe "OAuth authentication", type: :request do
  context "with password grant type" do
    it "should respond with a valid access token for valid credentials" do
      user = create(
        :user,
        email: "user@example.com",
        password: "password",
      )

      request_body = {
        grant_type: "password",
        username: "user@example.com",
        password: "password",
      }.to_json

      post oauth_token_path, request_body, request_headers

      access_token = Doorkeeper::AccessToken.where(token: json["access_token"]).first
      refresh_token = json["refresh_token"]
      created_at = json["created_at"]
      expires_in = json["expires_in"]

      expect(access_token).not_to be_nil
      expect(access_token.resource_owner_id).to eq user.id
      expect(access_token.refresh_token).to eq refresh_token
      expect(created_at + expires_in).to be > Time.current.to_i
    end

    it "should respond with a 401 for invalid credentials" do
      request_body = {
        grant_type: "password",
        username: "user@example.com",
        password: "passw0rd",
      }.to_json

      post oauth_token_path, request_body, request_headers

      expect(response.status).to eq 401
    end
  end

  context "with refresh grant type" do
    it "should respond with a valid access token for a valid refresh token" do
      user = create(:user)
      access_token = access_token_for_user(user)

      request_body = {
        grant_type: "refresh_token",
        refresh_token: access_token.refresh_token,
      }.to_json

      post oauth_token_path, request_body, request_headers

      new_access_token = Doorkeeper::AccessToken.where(token: json["access_token"]).first
      refresh_token = json["refresh_token"]
      created_at = json["created_at"]
      expires_in = json["expires_in"]

      expect(new_access_token).not_to be_nil
      expect(new_access_token.resource_owner_id).to eq user.id
      expect(new_access_token.refresh_token).to eq refresh_token
      expect(created_at + expires_in).to be > Time.current.to_i
    end

    it "should respond with a 401 for an invalid refresh token" do
      request_body = {
        grant_type: "refresh_token",
        refresh_token: "invalid refresh token",
      }.to_json

      post oauth_token_path, request_body, request_headers

      expect(response.status).to eq 401
    end
  end
end
