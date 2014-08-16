namespace :migrations do
  task :run_all => :environment do
    migrations = %w(episodes)
    migrations.each do |migration|
      Rake::Task["migrations:#{migration}"].invoke
    end
  end
end
