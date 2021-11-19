class Company < ApplicationRecord
 belongs_to :user
 validates :name,:salary,:address, presence: true, presence: true
end
