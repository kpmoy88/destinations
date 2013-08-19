class Profile < ActiveRecord::Base
	belongs_to :user

	has_one :avatar
	accepts_nested_attributes_for :avatar
	has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "100x100>"}, :default_url => "/images/:style/missing.png"

	has_many :locations,through: :users
  	has_many :comments,through: :users
  	has_many :visiteds,through: :users
  	has_many :bookmarks,through: :users

	#Array for state field on profile
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
	
end
