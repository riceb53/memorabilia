class RenameZipToZipCodeinStore < ActiveRecord::Migration[5.2]
  def change
    rename_column :stores, :zip, :zip_code
  end
end
