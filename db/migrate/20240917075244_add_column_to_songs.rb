class AddColumnToSongs < ActiveRecord::Migration[7.1]
  def change
    add_column :songs, :singer_name, :string
  end
end
