class AddExtensionAndProcessedToImage < ActiveRecord::Migration
  def up
    add_column :photos, :processed, :boolean, default: false
    add_column :photos, :extension, :string
    add_column :photos, :token, :string

    photo_rows = execute "SELECT id FROM photos"
    photo_rows.each do |row|
      execute "UPDATE photos SET token='#{SecureRandom.urlsafe_base64}' WHERE id=#{row["id"]}"
    end

    change_column :photos, :token, :string, null: false
  end

  def down
    remove_column :photos, :processed
    remove_column :photos, :extension
    remove_column :photos, :token
  end
end
