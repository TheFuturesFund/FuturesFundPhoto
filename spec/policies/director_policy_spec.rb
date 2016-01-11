require 'rails_helper'

describe DirectorPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it "does not allow visitors to list directors" do
      expect(subject).not_to permit(nil, build(:director))
    end

    it "allows directors to list directors" do
      expect(subject).to permit(build(:director_user), build(:director))
    end

    it "does not allow teachers or students to list directors" do
      expect(subject).not_to permit(build(:teacher_user), build(:director))
      expect(subject).not_to permit(build(:student_user), build(:director))
    end
  end

  permissions :show? do
    it "does not allow visitors to view directors" do
      expect(subject).not_to permit(nil, build(:director))
    end

    it "allows teachers or directors to view directors" do
      expect(subject).to permit(build(:director_user), build(:director))
      expect(subject).to permit(build(:teacher_user), build(:director))
    end

    it "does not allow students to list directors" do
      expect(subject).not_to permit(build(:student_user), build(:director))
    end
  end

  permissions :new?, :create? do
    it "does not allow visitors to create directors" do
      expect(subject).not_to permit(nil, build(:director))
    end

    it "allows directors to create directors" do
      expect(subject).to permit(build(:director_user), build(:director))
    end

    it "does not allow teachers or students to create directors" do
      expect(subject).not_to permit(build(:teacher_user), build(:director))
      expect(subject).not_to permit(build(:student_user), build(:director))
    end
  end
  
  permissions :edit?, :update? do
    it "does not allow visitors to edit directors" do
      expect(subject).not_to permit(nil, build(:director))
    end

    it "allows directors to update directors" do
      expect(subject).to permit(build(:director_user), build(:director))
    end

    it "does not allow teachers or students to update directors" do
      expect(subject).not_to permit(build(:teacher_user), build(:director))
      expect(subject).not_to permit(build(:student_user), build(:director))
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy directors" do
      expect(subject).not_to permit(nil, build(:director))
    end

    it "allows directors to destroy directors" do
      expect(subject).to permit(build(:director_user), build(:director))
    end

    it "does not allow teachers or students to destroy directors" do
      expect(subject).not_to permit(build(:teacher_user), build(:director))
      expect(subject).not_to permit(build(:student_user), build(:director))
    end
  end

end
