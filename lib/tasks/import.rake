require 'csv'

namespace :import do
  desc 'Import user data from CSV (export cms_users.csv from legacy app)'
  task :users, [:csv_file_path] => :environment do |t, args|
    csv_file_path = args[:csv_file_path]

    unless csv_file_path
      puts "Usage: rake 'import:users[/PATH/TO/FILE.csv]'" and return
    end

    CSV.foreach(csv_file_path, headers: true) do |row|
      begin
        user = User.new(
          username:           row['username'],
          encrypted_password: row['password'],
          legacy_password:    true,
          email:              row['email'] || "#{row['username']}@cfb-hasenheide.de"
        )

        user.save!(validate: false)
        puts "IMPORTED: #{user.username}"

      rescue Exception => e
        puts "SKIPPED: #{user.username} (#{e})"
        next
      end
    end
  end
end
