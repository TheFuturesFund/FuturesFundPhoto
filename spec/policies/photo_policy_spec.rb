require 'rails_helper'

describe PhotoPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it "does not allow visitors to list photos" do
      expect(subject).not_to permit(nil, build(:photo))
    end

    it "allows all users to list photos" do
      expect(subject).to permit(build(:director_user), build(:photo))
      expect(subject).to permit(build(:teacher_user), build(:photo))
      expect(subject).to permit(build(:student_user), build(:photo))
    end
  end

  permissions :show? do
    it "does not allow visitors to view photos" do
      expect(subject).not_to permit(nil, build(:photo))
    end

    it "allows all users to view photos" do
      expect(subject).to permit(build(:director_user), build(:photo))
      expect(subject).to permit(build(:teacher_user), build(:photo))
      expect(subject).to permit(build(:student_user), build(:photo))
    end
  end

  permissions :new?, :create? do
    it "does not allow visitors to create photos" do
      expect(subject).not_to permit(nil, build(:photo))
    end

    it "allows all directors and teachers to create photos" do
      expect(subject).to permit(build(:director_user), build(:photo))
      expect(subject).to permit(build(:teacher_user), build(:photo))
    end

    it "does not allow students to create photos outside their albums" do
      expect(subject).not_to permit(build(:student_user), build(:photo))
    end

    it "allows students to create photos for their albums" do
      user = create(:student_user)
      album = create(:album, student: user.role)
      user.reload
      photo = create(:photo, album: album)
      expect(subject).to permit(user, photo)
    end
  end

    permissions :edit?, :update? do
    it "does not allow visitors to update photos" do
      expect(subject).not_to permit(nil, build(:photo))
    end

    it "allows directors and teachers to update photos" do
      expect(subject).to permit(build(:director_user), build(:photo))
      expect(subject).to permit(build(:teacher_user), build(:photo))
    end

    it "does not allow students to update photos outside their albums" do
      expect(subject).not_to permit(build(:student_user), build(:photo))
    end

    it "allows a student to update photos in their albums" do
      user = create(:student_user)
      album = create(:album, student: user.role)
      user.reload
      photo = create(:photo, album: album)
      expect(subject).to permit(user, photo)
    end
  end

  permissions :destroy? do
    it "does not allow visitors to destroy photos" do
      expect(subject).not_to permit(nil, build(:photo))
    end

    it "allows directors and teachers to destroy photos" do
      expect(subject).to permit(build(:director_user), build(:photo))
      expect(subject).to permit(build(:teacher_user), build(:photo))
    end

    it "does not allow students to destroy photos outside their albums" do
      expect(subject).not_to permit(build(:student_user), build(:photo))
    end

    it "allows users to destroy photos in their albums" do
      user = create(:student_user)
      album = create(:album, student: user.role)
      user.reload
      photo = create(:photo, album: album)
      expect(subject).to permit(user, photo)
    end
  end

end
