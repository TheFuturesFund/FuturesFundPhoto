require "rails_helper"

describe UserPolicy, type: :policy do
  describe UserPolicy::Scope do
    it "should be empty for visitors" do
      create_list(:user, 3)
      scope = UserPolicy::Scope.new(nil, User)
      expect(scope.resolve.length).to eq 0
    end

    it "should contain all users for students" do
      create_list(:user, 3)
      scope = UserPolicy::Scope.new(User.first, User)
      expect(scope.resolve.length).to eq 3
    end

    it "should contain all users for teachers" do
      create_list(:user, 3)
      scope = UserPolicy::Scope.new(User.first, User)
      expect(scope.resolve.length).to eq 3
    end

    it "should contain all users for directors" do
      create_list(:user, 3)
      scope = UserPolicy::Scope.new(User.first, User)
      expect(scope.resolve.length).to eq 3
    end
  end
end
