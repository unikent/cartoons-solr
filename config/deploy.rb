set :application, "Solr"
set :repository,  "git@github.com:unikent/SOLR-Config.git"

role :frontend, "homburg", "sombrero"
role :processing, "butch"

set :releases_path, "/opt/solr/releases"
set :current_path, "/opt/solr/current"

# Deploy Method
set :user, "wwwdeploy"
set :use_sudo, false
set :scm, :git
set :scm_verbose, true
set :git_enable_submodules, true
set :deploy_via, :copy
set :copy_compression, :zip

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do ; end
  task :setup do
    run "mkdir #{releases_path}"
  end
  task :finalize_update do
  end
end