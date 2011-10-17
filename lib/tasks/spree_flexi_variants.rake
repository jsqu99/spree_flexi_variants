require 'active_record'
require 'custom_fixtures'
require 'fileutils'
include FileUtils::Verbose

namespace :db do
  desc "Standart migrations"
  task :migrate do
    Rake::Task["spree_flexi_variants:db:migrate"].invoke
  end

  desc "Loads a specified fixture using rake db:load_file[filename.rb]"
  task :seed do
    Rake::Task["spree_flexi_variants:db:load_dir"].invoke("default")
  end
end

namespace :spree_flexi_variants do
  namespace :db do
    desc "Custom migrations"
    task :migrate do
      require 'erb'
      require 'logger'
      require 'active_record'
      reference = YAML::load(ERB.new(IO.read("#{Rails.root}/config/database.yml")).result)
      env = RAILS_ENV = ENV['RAILS_ENV'] || 'development'
      ActiveRecord::Base.logger = Logger.new(STDOUT)
      ActiveRecord::Base.logger.level = Logger::WARN
      ActiveRecord::Base.configurations = reference.dup
      reference.each_key do |name|
        next unless name.include? env
        puts "Migrating #{name} spree_flexi_variants"
        ActiveRecord::Base.clear_active_connections!
        ActiveRecord::Base.configurations[env] = reference[name]
        ActiveRecord::Base.establish_connection RAILS_ENV
        ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
        ActiveRecord::Migrator.migrate("#{File.expand_path('../..', File.dirname(__FILE__))}/db/migrate", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
        Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
      end
    end

    desc "Loads a specified fixture using rake db:load_file[filename.rb]"
    task :seed do
      Rake::Task["spree_flexi_variants:db:load_dir"].invoke("default")
    end

    desc "Loads a specified fixture using rake db:load_file[filename.rb]"
    task :load_file, [:file] => :environment do |t, args|
      file = args.file
      ext = File.extname file
      if ext == ".csv" or ext == ".yml"
        puts "loading fixture " + file
        Fixtures.create_fixtures(File.dirname(file), File.basename(file, '.*'))
      else
        if File.exists? file
          puts "loading ruby    " + file
          require file
        end
      end
    end

    desc "Loads fixtures from the the dir you specify using rake db:load_dir[loadfrom]"
    task :load_dir, [:dir] => :environment do |t, args|
      dir = args.dir
      fixtures = ActiveSupport::OrderedHash.new
      ruby_files = ActiveSupport::OrderedHash.new
      Dir.glob(File.join(File.expand_path('../..', File.dirname(__FILE__)), "db", dir, '*.{yml,csv,rb}')).each do |fixture_file|
        ext = File.extname fixture_file
        if ext == ".rb"
          ruby_files[File.basename(fixture_file, '.*')]  = fixture_file
        else
          fixtures[File.basename(fixture_file, '.*')]  = fixture_file
        end
      end
      fixtures.sort.each do |fixture, fixture_file|
        # an invoke will only execute the task once
        Rake::Task["db:load_file"].execute(Rake::TaskArguments.new([:file], [fixture_file]))
      end
      ruby_files.sort.each do |fixture, ruby_file|
        # an invoke will only execute the task once
        Rake::Task["db:load_file"].execute(Rake::TaskArguments.new([:file], [ruby_file]))
      end
    end
  end
end
