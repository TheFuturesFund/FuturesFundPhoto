require 'rails_helper'

describe ClassroomPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it "does not allow visitors to list classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows teachers and directors to list classrooms" do
      expect(subject).to permit(build(:director_user), build(:classroom))
      expect(subject).to permit(build(:teacher_user), build(:classroom))
    end

    it "does not allow students to list classrooms" do
      expect(subject).not_to permit(build(:student_user), build(:classroom))
    end
  end

  permissions :show? do
    it "does not allow visitors to view a classroom" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows directors and teachers to view a classroom" do
      expect(subject).to permit(build(:director_user), build(:classroom))
      expect(subject).to permit(build(:teacher_user), build(:classroom))
    end

    it "allows students to view their classroom" do
      user = create(:student_user)
      classroom = create(:classroom)
      classroom_student = create(:classroom_student, classroom: classroom, student: user.role)
      user.reload
      expect(subject).to permit(user, classroom)
    end

    it "does not allow students to view any classroom" do
      expect(subject).not_to permit(build(:student_user), build(:classroom))
    end
  end

  permissions :new?, :create? do
    it "does not allow visitors to create classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows all directors and teachers to create classrooms" do
      expect(subject).to permit(build(:director_user), build(:classroom))
      expect(subject).to permit(build(:teacher_user), build(:classroom))
    end

    it "does not allow students to create classrooms" do
      expect(subject).not_to permit(build(:student_user), build(:classroom))
    end
  end

    permissions :edit?, :update? do
    it "does not allow visitors to update classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows directors and teachers to update classrooms" do
      expect(subject).to permit(build(:director_user), build(:classroom))
      expect(subject).to permit(build(:teacher_user), build(:classroom))
    end

    it "does not allow students to update classrooms" do
      expect(subject).not_to permit(build(:student_user), build(:classroom))
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows directors and teachers to destroy classrooms" do
      expect(subject).to permit(build(:director_user), build(:classroom))
      expect(subject).to permit(build(:teacher_user), build(:classroom))
    end

    it "does not allow students to destroy classrooms" do
      expect(subject).not_to permit(build(:student_user), build(:classroom))
    end
  end

end
