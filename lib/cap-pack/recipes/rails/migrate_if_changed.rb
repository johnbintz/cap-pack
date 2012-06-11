namespace :rails do
  desc 'Migrate the database if db/schema.rb has changed since the last revision'
  task :migrate_if_changed do
    if !(result = %x{git log #{current_revision}..#{revision} db/schema.rb}.strip).empty?
      top.deploy.migrate
    end
  end
end

