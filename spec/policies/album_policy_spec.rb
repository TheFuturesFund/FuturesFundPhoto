require "rails_helper"

describe AlbumPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it "does not allow visitors to list albums" do
      expect(subject).not_to permit(nil, build(:album))
    end

    it "allows students, teachers, and directors list albums" do
      expect(subject).to permit(build(:user, :director), build(:album))
      expect(subject).to permit(build(:user, :teacher), build(:album))
      expect(subject).to permit(build(:user, :student), build(:album))
    end
  end

  permissions :show? do
    it "does not allow visitors to view an album" do
      expect(subject).not_to permit(nil, build(:album))
    end

    it "allows students, teachers, and directors to view an album" do
      expect(subject).to permit(build(:user, :director), build(:album))
      expect(subject).to permit(build(:user, :teacher), build(:album))
      expect(subject).to permit(build(:user, :student), build(:album))
    end
  end

  permissions :create? do
    it "does not allow visitors to create albums" do
      expect(subject).not_to permit(nil, build(:album))
    end

    it "allows directors and teachers to create albums" do
      expect(subject).to permit(build(:user, :director), build(:album))
      expect(subject).to permit(build(:user, :teacher), build(:album))
    end

    it "does not allow students to create albums" do
      expect(subject).not_to permit(build(:user, :student), build(:album))
    end

    it "allows students to create albums if they are the album owner" do
      student = build(:user, :student)
      expect(subject).to permit(student, build(:album, user: student))
    end
  end

  permissions :new? do
    it "does not allow visitors to create albums" do
      expect(subject).not_to permit(nil, build(:album))
    end

    it "allows all users create albums" do
      expect(subject).to permit(build(:user, :director), build(:album))
      expect(subject).to permit(build(:user, :teacher), build(:album))
      expect(subject).to permit(build(:user, :student), build(:album))
    end
  end

  permissions :edit?, :update? do
    it "does not allow visitors to update albums" do
      expect(subject).not_to permit(nil, build(:album))
    end

    it "allows directors and teachers to update albums" do
      expect(subject).to permit(build(:user, :director), build(:album))
      expect(subject).to permit(build(:user, :teacher), build(:album))
    end

    it "does not allow students to update albums" do
      expect(subject).not_to permit(build(:user, :student), build(:album))
    end

    it "allows students to update albums if they are the album owner" do
      student = create(:user, :student)
      album = create(:album, user: student)
      expect(subject).to permit(student, album)
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy albums" do
      expect(subject).not_to permit(nil, build(:album))
    end

    it "allows directors and teachers to destroy albums" do
      expect(subject).to permit(build(:user, :director), build(:album))
      expect(subject).to permit(build(:user, :teacher), build(:album))
    end

    it "does not allow students to destroy albums" do
      expect(subject).not_to permit(build(:user, :student), build(:album))
    end

    it "allows students to destroy albums if they are the album owner" do
      student = create(:user, :student)
      album = create(:album, user: student)
      expect(subject).to permit(student, album)
    end
  end
end
