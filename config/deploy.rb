set :application, "Solr"
set :repository,  "git@github.com:unikent/SOLR-Config.git"

role :frontend, "homburg", "sombrero"
role :processing, "butch"

set :shared_path, "/opt/solr/shared"
set :releases_path, "/opt/solr/releases"
set :current_path, "/opt/solr/current"
set :indexes, [
	"solr-cartoons",
	"solr-cartoons-2",
	"solr-records",
	"solr-records-2",
	"verdi"
]

# Deploy Method
set :user, "wwwdeploy"
set :use_sudo, false
set :scm, :git
set :scm_verbose, true
set :git_enable_submodules, true
set :deploy_via, :copy
set :copy_compression, :zip

after "deploy", "deploy:create_symlink"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do ; end
  task :setup do
    run "mkdir -p #{releases_path}"
    indexes.each do |p|
      run "mkdir -p #{shared_path}/indexes/#{p}"
    end
  end
  task :create_symlink do
  	run "rm -f #{current_path} && ln -s #{latest_release} #{current_path}"
    indexes.each do |p| 
      run "mkdir -p #{current_path}/#{p}/data"
      run "ln -s #{shared_path}/indexes/#{p} #{current_path}/#{p}/data/index"
    end
  end
  task :finalize_update do
  end
end