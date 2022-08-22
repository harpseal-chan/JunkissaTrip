# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "JunkissaTrip"
set :repo_url, "git@github.com:harpseal-chan/JunkissaTrip.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, "main"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/JunkissaTrip"

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
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :ssh_options, {
  auth_methods: ['publickey'],
  keys: ['~/.ssh/jt-key.pem']
}

# rbenvの設定
# set :rbenv_type, :user
# set :rbenv_ruby, '2.7.4'

namespace :deploy do
  task :init_permission do
    on release_roles :all do
      execute :sudo, :chown, '-R', "#{fetch(:user)}:#{fetch(:group)}", deploy_to
    end
  end

  task :reset_permission do
    on release_roles :all do
      execute :sudo, :chown, '-R', "root:root", deploy_to
    end
  end

  before :starting, :init_permission
  after :finished, :reset_permission
end