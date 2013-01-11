set_default(:smtp_password) { Capistrano::CLI.password_prompt "SMTP Password: " }

namespace :smtp do
  desc "Generate the application.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "application.yml.erb", "#{shared_path}/config/application.yml"
  end
  after "deploy:setup", "smtp:setup"

  desc "Symlink the application.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after "deploy:finalize_update", "smtp:symlink"
end