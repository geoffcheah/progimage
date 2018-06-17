class Picture < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :remote_url, presence: true, uniqueness: true

end
