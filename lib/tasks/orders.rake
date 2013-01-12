namespace :orders do
  desc "Update orders, created notifications for changes"
  task :update => :environment do
    puts "Updating orders at #{Time.zone.now}"
    Order.update_orders
  end
end
