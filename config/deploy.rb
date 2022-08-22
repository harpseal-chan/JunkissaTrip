# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "JunkissaTrip"
set :repo_url, "git@github.com:harpseal-chan/JunkissaTrip.git"
set :docker_compose_path, "docker-compose -f docker-compose-prod.yml"
set :RAILS_ENV, "RAILS_ENV=production"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/JunkissaTrip"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, "main"

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :ssh_options, {
  auth_methods: ['publickey'],
  keys: ['~/.ssh/jt-key.pem']
}

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/apppacker", "public/system", "vendor", "storage"
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  application = fetch :application
  docker_compose_path = fetch :docker_compose_path
  rails_env = fetch :RAILS_ENV
  rails_compile = "#{docker_compose_path} run app rails assets:precompile #{rails_env}"
  # db_drop = "#{docker_compose_path} exec -T app rails db:drop #{rails_env} DISABLE_DATABASE_ENVIRONMENT_CHECK=1"
  db_migrate = "#{docker_compose_path} exec -T app rails db:migrate #{rails_env}"
  db_create = "#{docker_compose_path} exec -T app rails db:create #{rails_env}"
  db_seed = "#{docker_compose_path} exec -T app rails db:seed_fu #{rails_env}"

  task :application_update do
    on roles(:app) do # config/deploy/production.rbのroles: %w{app}を指定している。
      execute "cd #{application};" "git pull origin master"
    end
  end

  task :application_compile do
    on roles(:app) do
      execute "cd #{application};" "#{rails_compile}"
    end
  end

  task :database_create do
    on roles(:app) do
      execute "cd #{application};" "#{db_create}"
    end
  end

  task :database_set_up do
    on roles(:app) do
      execute "cd #{application};" "#{db_create};" "#{db_migrate};" "#{db_seed};"
    end
  end

  task :database_reset do
    on roles(:app) do
      execute "cd #{application};" "#{db_drop};" "#{db_create};" "#{db_migrate};" "#{db_seed};"
    end
  end

  task :destroy_images do
    on roles(:app) do
      execute "cd #{application};" "docker rmi -f `docker images -q`"
    end
  end

  task :application_set_up do
    on roles(:all) do
      execute "cd #{deploy_to};" "git fetch origin;" "git merge origin/main;" "#{docker_compose_path} down;" "#{docker_compose_path} build;" "#{docker_compose_path} up -d"
    end
  end

  after :finished, :application_set_up
end