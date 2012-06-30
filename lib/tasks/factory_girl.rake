namespace :db do
  namespace :factory_girl do
    desc "Load Factory Girl factories into the current environment's database."
    task :load => :environment do
      FactoryGirl.factories.each do |factory|
        FactoryGirl.create factory.name
      end
    end
    
    task :reset => ['db:reset','load'] # do 
#       desc "Reset database and load factories into the current environment's database."
#       
#     end
  end
end

#need to db:drop, db:create, db:schema:load, db:fixtures:load db:seed or just db:reset to drop,create, load and seed