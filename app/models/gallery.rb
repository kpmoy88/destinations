class Gallery < ActiveRecord::Base
	
	belongs_to :location

	has_many :photo
	accepts_nested_attributes_for :photo
	has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => "100x100>"},:default_url => "/images/:style/missing.png"

end
