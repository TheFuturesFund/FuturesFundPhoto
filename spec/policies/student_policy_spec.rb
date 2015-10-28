require 'rails_helper'

describe StudentPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it "does not allow visitors to list students" do
      expect(subject).not_to permit(nil, build(:student))
    end

    it "allows all users to list students" do
      expect(subject).to permit(build(:director_user), build(:student))
      expect(subject).to permit(build(:teacher_user), build(:student))
      expect(subject).to permit(build(:student_user), build(:student))
    end
  end

  permissions :new?, :create? do
    it "does not allow visitors to create students" do
      expect(subject).not_to permit(nil, build(:student))
    end

    it "allows directors and teachers to create students" do
      expect(subject).to permit(build(:director_user), build(:student))
      expect(subject).to permit(build(:teacher_user), build(:student))
    end

    it "does not allow students to create students" do
      expect(subject).not_to permit(build(:student_user), build(:student))
    end
  end

    permissions :edit?, :update? do
    it "does not allow visitors to update students" do
      expect(subject).not_to permit(nil, build(:student))
    end

    it "allows directors and teachers to update students" do
      expect(subject).to permit(build(:director_user), build(:student))
      expect(subject).to permit(build(:teacher_user), build(:student))
    end

    it "does not allow students to update students" do
      expect(subject).not_to permit(build(:student_user), build(:student))
    end

    it "allows the current student to update themselves" do
      user = build(:student_user)
      student = user.role
      expect(subject).to permit(user, student)
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy students" do
      expect(subject).not_to permit(nil, build(:student))
    end

    it "allows directors and teachers to destroy students" do
      expect(subject).to permit(build(:director_user), build(:student))
      expect(subject).to permit(build(:teacher_user), build(:student))
    end

    it "does not allow students to destroy students" do
      expect(subject).not_to permit(build(:student_user), build(:student))
    end
  end

end
