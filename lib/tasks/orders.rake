namespace :orders do
  desc "Update orders, created notifications for changes"
  task :update => :environment do
    puts "Updating orders at #{Time.zone.now}"
    order_api = OrderApi.new
    order_api.update_orders
  end
end
