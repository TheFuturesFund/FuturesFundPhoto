require "rails_helper"

describe ClassroomPolicy, type: :policy do
  subject { described_class }

  describe ClassroomPolicy::Scope do
    it "should be empty for visitors" do
      create_list(:classroom, 3)
      scope = ClassroomPolicy::Scope.new(nil, Classroom)
      expect(scope.resolve.length).to eq 0
    end

    it "should contain all classrooms for students" do
      create_list(:classroom, 3)
      student = build(:user, :student, classroom: Classroom.first)
      scope = ClassroomPolicy::Scope.new(student, Classroom)
      expect(scope.resolve.length).to eq 3
    end

    it "should contain all classrooms for teachers" do
      create_list(:classroom, 3)
      scope = ClassroomPolicy::Scope.new(build(:user, :teacher), Classroom)
      expect(scope.resolve.length).to eq 3
    end

    it "should contain all classrooms for directors" do
      create_list(:classroom, 3)
      scope = ClassroomPolicy::Scope.new(build(:user, :director), Classroom)
      expect(scope.resolve.length).to eq 3
    end
  end

  permissions :index? do
    it "does not allow visitors to list classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows students, teachers, and directors list classrooms" do
      expect(subject).to permit(build(:user, :director), build(:classroom))
      expect(subject).to permit(build(:user, :teacher), build(:classroom))
      expect(subject).to permit(build(:user, :student), build(:classroom))
    end
  end

  permissions :show? do
    it "does not allow visitors to view a classroom" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows students, teachers, and directors to view a classroom" do
      expect(subject).to permit(build(:user, :director), build(:classroom))
      expect(subject).to permit(build(:user, :teacher), build(:classroom))
      expect(subject).to permit(build(:user, :student), build(:classroom))
    end
  end

  permissions :new?, :create? do
    it "does not allow visitors to create classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows all directors and teachers to create classrooms" do
      expect(subject).to permit(build(:user, :director), build(:classroom))
      expect(subject).to permit(build(:user, :teacher), build(:classroom))
    end

    it "does not allow students to create classrooms" do
      expect(subject).not_to permit(build(:user, :student), build(:classroom))
    end
  end

  permissions :edit?, :update? do
    it "does not allow visitors to update classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows directors and teachers to update classrooms" do
      expect(subject).to permit(build(:user, :director), build(:classroom))
      expect(subject).to permit(build(:user, :teacher), build(:classroom))
    end

    it "does not allow students to update classrooms" do
      expect(subject).not_to permit(build(:user, :student), build(:classroom))
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy classrooms" do
      expect(subject).not_to permit(nil, build(:classroom))
    end

    it "allows directors and teachers to destroy classrooms" do
      expect(subject).to permit(build(:user, :director), build(:classroom))
      expect(subject).to permit(build(:user, :teacher), build(:classroom))
    end

    it "does not allow students to destroy classrooms" do
      expect(subject).not_to permit(build(:user, :student), build(:classroom))
    end
  end
end
