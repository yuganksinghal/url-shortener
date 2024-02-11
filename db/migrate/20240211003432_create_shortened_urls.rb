class CreateShortenedUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :shortened_urls do |t|
      t.string :url
      t.string :shortened_url

      t.timestamps
    end
  end
end
