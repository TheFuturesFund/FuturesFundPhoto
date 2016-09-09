require "rails_helper"

describe "Classrooms API", type: :request do
  describe "GET /v1/classrooms" do
    before(:each) do
      create_list(:classroom, 5)
    end

    it "should require authentication" do
      get v1_classrooms_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      get v1_classrooms_path, {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "GET /v1/classroom/:id" do
    before(:each) do
      create(:classroom)
    end

    it "should require authentication" do
      get v1_classroom_path(Classroom.first), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      get v1_classrooms_path(Classroom.first), {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(response).to match_response_schema("json_api")
    end
  end
end
