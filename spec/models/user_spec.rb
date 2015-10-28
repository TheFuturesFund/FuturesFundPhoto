require 'rails_helper'

roles = [:director, :teacher, :student]
roles.each do |role|
  describe User, "\##{role}?", type: :model do
    it "should return true when the user is a #{role}" do
      user = build("#{role}_user".to_sym)
      expect(user.send("#{role}?".to_sym)).to eq(true)
    end

    it "should return false if the user is not a #{role}" do
      other_role = (roles - [role]).first
      user = build("#{other_role}_user".to_sym)
      expect(user.send("#{role}?".to_sym)).to eq(false)
    end
  end
end
