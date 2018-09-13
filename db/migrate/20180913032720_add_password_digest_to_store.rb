class AddPasswordDigestToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :password_digest, :string
  end
end
