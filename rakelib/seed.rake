namespace :db do
  desc 'Seed db'
  task seed: :environment do
    Seed.new.call
  end
end
