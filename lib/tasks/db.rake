namespace :db do
  task :redo do
    system 'rake db:drop && rake db:create && rake db:migrate && rake db:seed'
  end
end