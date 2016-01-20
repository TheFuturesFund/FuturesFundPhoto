module FullNameable
  include ActiveSupport::Concern

  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
