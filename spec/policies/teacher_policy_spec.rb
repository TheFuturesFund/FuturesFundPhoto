require 'rails_helper'

describe TeacherPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it "does not allow visitors to create teachers" do
      expect(subject).not_to permit(nil, build(:teacher))
    end

    it "allows all users to list teachers" do
      expect(subject).to permit(build(:director_user), build(:teacher))
      expect(subject).to permit(build(:teacher_user), build(:teacher))
      expect(subject).to permit(build(:student_user), build(:teacher))
    end
  end

  permissions :show? do
    it "does not allow visitors to create teachers" do
      expect(subject).not_to permit(nil, build(:teacher))
    end

    it "allows all users to list teachers" do
      expect(subject).to permit(build(:director_user), build(:teacher))
      expect(subject).to permit(build(:teacher_user), build(:teacher))
      expect(subject).to permit(build(:student_user), build(:teacher))
    end
  end

  permissions :new?, :create? do
    it "does not allow visitors to create teachers" do
      expect(subject).not_to permit(nil, build(:teacher))
    end

    it "allows directors and teachers to create teachers" do
      expect(subject).to permit(build(:director_user), build(:teacher))
      expect(subject).to permit(build(:teacher_user), build(:teacher))
    end

    it "does not allow students to create teachers" do
      expect(subject).not_to permit(build(:student_user), build(:teacher))
    end
  end

    permissions :edit?, :update? do
    it "does not allow visitors to update teachers" do
      expect(subject).not_to permit(nil, build(:teacher))
    end

    it "allows directors and teachers to update teachers" do
      expect(subject).to permit(build(:director_user), build(:teacher))
      expect(subject).to permit(build(:teacher_user), build(:teacher))
    end

    it "does not allow students to update teachers" do
      expect(subject).not_to permit(build(:student_user), build(:teacher))
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy teachers" do
      expect(subject).not_to permit(nil, build(:teacher))
    end

    it "allows directors and teachers to destroy teachers" do
      expect(subject).to permit(build(:director_user), build(:teacher))
      expect(subject).to permit(build(:teacher_user), build(:teacher))
    end

    it "does not allow students to destroy teachers" do
      expect(subject).not_to permit(build(:student_user), build(:teacher))
    end
  end

end
