class Photo < ActiveRecord::Base
  belongs_to :home
  has_attached_file :image,
  :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename",
    :styles => { :medium => "300x200!", :large => "626x399" },
    :convert_options => { :medium => "-quality 100", :large => "-quality 100" }
    validates_attachment :image,
  						 :presence => true,
  						 :content_type => { :content_type => /\Aimage\/.*\Z/ },
  						 :size => { :less_than => 1.megabyte }
end
