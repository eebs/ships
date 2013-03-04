namespace :jobs do
  desc "Update industry jobs"
  task :update => :environment do
    puts "Updating jobs at #{Time.zone.now}"
    job_api = JobApi.new
    job_api.update_jobs
  end
end
