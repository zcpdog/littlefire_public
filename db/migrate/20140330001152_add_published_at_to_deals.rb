class AddPublishedAtToDeals < ActiveRecord::Migration
  def migrate(direction)
    super
    if direction == :up
      begin
        Deal.find_each do |deal|
          if deal.active? and deal.published_at.blank?
            deal.published_at = deal.created_at
            deal.save
          end
        end
      rescue Exception => e
        puts "#{e.inspect}"
      end
    end
  end
  def change
    add_column :deals, :published_at, :datetime
    add_column :deals, :top,          :boolean, default: false
  end
end
