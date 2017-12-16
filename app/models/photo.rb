class Photo < ApplicationRecord
  belongs_to :home
  has_attached_file :photo,
  :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename",
    :styles => { :medium => "300x200!" },
    :convert_options => { :medium => "-quality 100" }
  do_not_validate_attachment_file_type :photo
end
