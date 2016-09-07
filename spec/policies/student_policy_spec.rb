require "rails_helper"

describe StudentPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it "does not allow visitors to list students" do
      expect(subject).not_to permit(nil, build(:user, :student))
    end

    it "allows all users to list students" do
      expect(subject).to permit(build(:user, :director), build(:user, :student))
      expect(subject).to permit(build(:user, :teacher), build(:user, :student))
      expect(subject).to permit(build(:user, :student), build(:user, :student))
    end
  end

  permissions :index? do
    it "does not allow visitors to view students" do
      expect(subject).not_to permit(nil, build(:user, :student))
    end

    it "allows all users to view students" do
      expect(subject).to permit(build(:user, :director), build(:user, :student))
      expect(subject).to permit(build(:user, :teacher), build(:user, :student))
      expect(subject).to permit(build(:user, :student), build(:user, :student))
    end
  end

  permissions :new?, :create? do
    it "does not allow visitors to create students" do
      expect(subject).not_to permit(nil, build(:user, :student))
    end

    it "allows directors and teachers to create students" do
      expect(subject).to permit(build(:user, :director), build(:user, :student))
      expect(subject).to permit(build(:user, :teacher), build(:user, :student))
    end

    it "does not allow students to create students" do
      expect(subject).not_to permit(build(:user, :student), build(:user, :student))
    end
  end

  permissions :edit?, :update? do
    it "does not allow visitors to update students" do
      expect(subject).not_to permit(nil, build(:user, :student))
    end

    it "allows directors and teachers to update students" do
      expect(subject).to permit(build(:user, :director), build(:user, :student))
      expect(subject).to permit(build(:user, :teacher), build(:user, :student))
    end

    it "does not allow students to update students" do
      expect(subject).not_to permit(build(:user, :student), build(:user, :student))
    end

    it "allows the current student to update themselves" do
      student = build(:user, :student)
      expect(subject).to permit(student, student)
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy students" do
      expect(subject).not_to permit(nil, build(:user, :student))
    end

    it "allows directors and teachers to destroy students" do
      expect(subject).to permit(build(:user, :director), build(:user, :student))
      expect(subject).to permit(build(:user, :teacher), build(:user, :student))
    end

    it "does not allow students to destroy students" do
      expect(subject).not_to permit(build(:user, :student), build(:user, :student))
    end
  end
end
