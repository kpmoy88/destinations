class Location < ActiveRecord::Base
	acts_as_commentable
	validates :title, :address, :city, :state, :description, presence: true
	belongs_to :user
	has_many :comments, through: :user

	has_one :image
	accepts_nested_attributes_for :image
	has_attached_file :image, :styles => {:medium => "400x400>", :thumb => "100x100>"}, :default_url => "/images/:style/missing.png"

	has_many :gallery
	accepts_nested_attributes_for :gallery

	has_many :visiteds, through: :user
	has_many :bookmarks, through: :user

	#Array for drop down menu for States field
	STATES = ['Alabama', 'Alaska', 'Arizona', 'Arkansas',
				'California', 'Colorado', 'Connecticut',
				'Delaware', 'Florida', 'Georgia', 'Hawaii',
				'Idaho', 'Illinois', 'Indiana', 'Iowa',
				'Kansas', 'Kentucky', 'Louisiana', 'Maine',
				'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
				'Mississippi', 'Missouri', 'Montana', 'Nebraska',
				'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico',
				'New York', 'North Carolina', 'North Dakota', 'Ohio',
				'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
				'South Carolina', 'South Dakota', 'Tennessee', 'Texas',
				'Utah', 'Vermont', 'Virginia','Washington',
				'West Virginia', 'Wisconsin', 'Wyoming']

	#Array to search by specific field
	SEARCH_BY = [['Title','title'],['City', 'city'],['State','state'],
					['Description','description']]
	
	#Allows a custom search otherwise it only searches title
	#Also on index shows last 20 posts
	def self.search(search,search_by)
		if search && search_by != ""
			Location.where(search_by + " ILIKE ?","%#{search}%")
		elsif search
			Location.where('title ILIKE :search',{:search => "%#{search}%"})
		else
			Location.limit(20).order('id desc')
		end 
	end

end
