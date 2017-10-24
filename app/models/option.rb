class Option < ApplicationRecord
  has_one :home, :dependent => :destroy
  accepts_nested_attributes_for :home
end
