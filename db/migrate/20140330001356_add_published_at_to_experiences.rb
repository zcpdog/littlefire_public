class AddPublishedAtToExperiences < ActiveRecord::Migration
  def migrate(direction)
    super
    if direction == :up
      begin
        Experience.find_each do |experience|
          if experience.active? and experience.published_at.nil?
            experience.published_at = experience.created_at
            experience.save
          end
        end
      rescue Exception => e
        puts "#{e.inspect}"
      end
    end
  end
  def change
    add_column :experiences, :published_at, :datetime
    add_column :experiences, :top,          :boolean, default: false
  end
end
