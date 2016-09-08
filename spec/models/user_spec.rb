require "rails_helper"

describe User, type: :model do
  it "should have a valid factory" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "should have a valid student factory" do
    student = build(:user, :student)
    expect(student).to be_valid
  end

  it "should have a valid teacher factory" do
    teacher = build(:user, :teacher)
    expect(teacher).to be_valid
  end

  it "should have a valid director factory" do
    director = build(:user, :director)
    expect(director).to be_valid
  end

  describe "validations" do
    it "should validate the presence and format of email" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors).to include :email

      user = build(:user, email: "not an email")
      expect(user).to be_invalid
      expect(user.errors).to include :email
    end

    it "should validate the presence and length of first_name" do
      user = build(:user, first_name: nil)
      expect(user).to be_invalid
      expect(user.errors).to include :first_name

      user = build(:user, first_name: "aa")
      expect(user).to be_invalid
      expect(user.errors).to include :first_name
    end

    it "should validate the presence and length of last_name" do
      user = build(:user, last_name: nil)
      expect(user).to be_invalid
      expect(user.errors).to include :last_name

      user = build(:user, last_name: "aa")
      expect(user).to be_invalid
      expect(user.errors).to include :last_name
    end

    it "should validate the presence and length of password" do
      user = build(:user, password: nil, password_confirmation: nil)
      expect(user).to be_invalid
      expect(user.errors).to include :password

      user = build(:user, password: "abc", password_confirmation: "abc")
      expect(user).to be_invalid
      expect(user.errors).to include :password
    end

    it "should validate the presence of role" do
      user = build(:user, role: nil)
      expect(user).to be_invalid
      expect(user.errors).to include :role
    end

    context "student" do
      it "should validate the presence of classroom" do
        user = build(:user, classroom: nil)
        expect(user).to be_invalid
        expect(user.errors).to include :classroom
      end
    end

    context "teacher" do
      it "should validate the absence of classroom" do
        user = build(:user, :teacher, classroom: build(:classroom))
        expect(user).to be_invalid
        expect(user.errors).to include :classroom
      end
    end

    context "director" do
      it "should validate the absence of classroom" do
        user = build(:user, :director, classroom: build(:classroom))
        expect(user).to be_invalid
        expect(user.errors).to include :classroom
      end
    end
  end

  describe "#full_name" do
    it "should return the full name calucated from frist_name and last_name" do
      user = build(:user, first_name: "Jon", last_name: "Doe")
      expect(user.full_name).to eq "Jon Doe"
    end
  end

  describe ".ordered_alphabetically_by_last_name" do
    it "should return the users sorted alphabetically by name" do
      user_a = create(:user, last_name: "AAA")
      user_b = create(:user, last_name: "BBB")

      expect(User.ordered_alphabetically_by_last_name).to eq [user_a, user_b]
    end
  end
end
