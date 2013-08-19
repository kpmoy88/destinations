class AddAttachmentPhotoToGalleries < ActiveRecord::Migration
  def self.up
    change_table :galleries do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :galleries, :photo
  end
end
