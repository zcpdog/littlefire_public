namespace :app do
  desc "sync data from web spider database"
  task :web_spider => :environment do
    #puts "I am working"
    deals = DealFactory::Deal.recent
    deals.each do |raw_deal|
      begin
        puts "Creating deal from #{raw_deal.id}"
        deal = Deal.unscoped.new
        deal.title = raw_deal.title
        deal. body = raw_deal.content
        deal.original_site = raw_deal.source
        deal.original_link = raw_deal.task_url
        deal.merchant = Merchant.find_by(name: raw_deal.merchant)
        deal.categories.push raw_deal.category.split(",").
          map{|cat_name|Category.find_by(name: cat_name.strip)}.reject { |c| c.nil? }
          raw_deal.image.split(",").each do |image_url|
          picture = Picture.new
          picture.remote_image_url = image_url
          deal.pictures.push picture
        end
        deal.clone = true
        deal.save!
      rescue Exception => e
        puts e.message
        puts "Skipping ==> #{raw_deal.id}"
      end
      
    end
    SyncBatch.create(:batch_id => deals.last.id) if deals.length > 0
  end
end
