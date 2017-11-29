class Photo < ApplicationRecord
  belongs_to :home
  has_attached_file :photo,
  :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename",
    :styles => { :medium => "160x120!" }
  do_not_validate_attachment_file_type :photo
end
