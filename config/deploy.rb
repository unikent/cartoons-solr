set :application, "Solr"
set :repository,  "git@github.com:unikent/SOLR-Config.git"

role :frontend, "homburg", "sombrero"
role :processing, "butch"

set :app_path, "/opt/solr/app/example"
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
  task :start do
    #run "cd #{app_path} && nohup java -jar start.jar > /opt/solr/shared/app.log 2>&1 &", :roles => :frontend
  end

  task :stop do
    #run "/usr/ucb/ps -auxwww | grep jetty | grep -v grep | awk '{print $2}' | xargs kill -KILL", :roles => :frontend
  end

  task :restart do
    stop
    start
  end

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

    run "ln -s #{latest_release}/solr.xml #{latest_release}/config/solr-master.xml", :roles => :processing
    run "ln -s #{latest_release}/solr.xml #{latest_release}/config/solr-fe.xml", :roles => :frontend
  end

  task :finalize_update do
  end
end