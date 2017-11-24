class Photo < ApplicationRecord
  belongs_to :home
  has_attached_file :photo,
  :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename",
    :styles => { :medium => "160x160!" }
  attr_accessible :photo_file_name
  do_not_validate_attachment_file_type :photo
end
