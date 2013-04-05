namespace :redis do
  desc "Install latest stable release of redis"
  task :install, roles: :web do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install redis-server"
  end
  after "deploy:install", "redis:install"

  desc "Setup redis configuration"
  task :setup, roles: :web do
    template "redis.erb", "/tmp/redis_conf"
    run "#{sudo} mv /etc/redis/redis.conf /etc/redis/redis.conf.default"
    run "#{sudo} mv /tmp/redis_conf /etc/redis/redis.conf"
    restart
  end
  after "deploy:setup", "redis:setup"

  %w[start stop restart].each do |command|
    desc "#{command} redis"
    task command, roles: :web do
      run "#{sudo} service redis-server #{command}"
    end
  end
end
