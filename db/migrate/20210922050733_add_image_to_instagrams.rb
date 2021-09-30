class AddImageToInstagrams < ActiveRecord::Migration[6.1]
  def change
    add_column :instagrams, :image, :string
  end
end
