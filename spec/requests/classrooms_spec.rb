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
      expect(json["data"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "GET /v1/classroom/:id" do
    before(:each) do
      create(:classroom)
    end

    it "should require authentication" do
      classroom = Classroom.first

      get v1_classroom_path(classroom), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should render a valid JSON API response" do
      classroom = Classroom.first

      get v1_classroom_path(classroom), {}, authenticated_request_headers

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "POST /v1/classrooms" do
    it "should require authentication" do
      post v1_classrooms_path, {}, request_headers

      expect(response.status).to eq 401
    end

    it "should create a classroom and render a valid JSON API response for a valid classroom" do
      request_body = {
        classroom: {
          name: "Classroom name",
        },
      }.to_json

      user = create(:user, :teacher)

      post v1_classrooms_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 201
      expect(json["data"]).not_to be_nil
      expect(Classroom.find_by(name: "Classroom name")).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid classroom" do
      request_body = {
        classroom: {
          name: "",
        },
      }.to_json

      user = create(:user, :teacher)

      post v1_classrooms_path, request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "PATCH /v1/classrooms/:id" do
    before(:each) do
      create(:classroom)
    end

    it "should require authentication" do
      classroom = Classroom.first

      patch v1_classroom_path(classroom), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should update a classroom and render a valid JSON API response for a valid classroom" do
      request_body = {
        classroom: {
          name: "New classroom name",
        },
      }.to_json

      user = create(:user, :teacher)
      classroom = Classroom.first

      patch v1_classroom_path(classroom), request_body, authenticated_request_headers(user)

      classroom.reload

      expect(response.status).to eq 200
      expect(json["data"]).not_to be_nil
      expect(classroom.name).to eq "New classroom name"
      expect(response).to match_response_schema("json_api")
    end

    it "should render a 422 with errors for an invalid classroom" do
      request_body = {
        classroom: {
          name: "",
        },
      }.to_json

      user = create(:user, :teacher)
      classroom = Classroom.first

      patch v1_classroom_path(classroom), request_body, authenticated_request_headers(user)

      expect(response.status).to eq 422
      expect(json["errors"]).not_to be_nil
      expect(response).to match_response_schema("json_api")
    end
  end

  describe "DELETE /v1/classrooms/:id" do
    before(:each) do
      create(:classroom)
    end

    it "should require authentication" do
      classroom = Classroom.first

      delete v1_classroom_path(classroom), {}, request_headers

      expect(response.status).to eq 401
    end

    it "should destroy a classroom and respond with a 204" do
      user = create(:user, :teacher)
      classroom = Classroom.first

      delete v1_classroom_path(classroom), {}, authenticated_request_headers(user)

      classroom = Classroom.where(id: classroom.id).first

      expect(response.status).to eq 204
      expect(classroom).to be_nil
    end
  end
end
