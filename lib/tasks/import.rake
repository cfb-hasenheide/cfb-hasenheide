require 'csv'

namespace :import do
  desc 'Import user data from CSV (export cms_users.csv from legacy app)'
  task :users, [:csv_file_path] => :environment do |_t, args|
    csv_file_path = args[:csv_file_path]

    unless csv_file_path
      puts("Usage: rake 'import:users[/PATH/TO/FILE.csv]'") && return
    end

    User.destroy_all
    puts 'DESTROYED: all existing users'

    CSV.foreach(csv_file_path, headers: true) do |row|
      username = row['username']

      begin
        user = User.new(
          username:           username,
          encrypted_password: row['password'],
          legacy_password:    true,
          email:              row['email'] || "#{username}@cfb-hasenheide.de"
        )

        user.save!(validate: false)
        puts "IMPORTED: #{username}"

      rescue StandardError => e
        puts "SKIPPED: #{username} (#{e})"
        next
      end
    end
  end
end
