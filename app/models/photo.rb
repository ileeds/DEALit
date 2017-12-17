class Photo < ActiveRecord::Base
  belongs_to :home
  attr_accessor :avatar_file_name
  has_attached_file :image,
  :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename",
    :styles => { :medium => "160x120!" }
    validates_attachment :image,
  						 :presence => true,
  						 :content_type => { :content_type => /\Aimage\/.*\Z/ },
  						 :size => { :less_than => 1.megabyte }
end
