class Photo < ActiveRecord::Base
  enum category: [
    :outtake_category,
    :select_category,
    :top_select_category
  ]

  belongs_to :album
end
