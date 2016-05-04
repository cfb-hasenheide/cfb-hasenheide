require 'csv'

# NOTE: https://gist.github.com/jboesch/5605747
# # You have your csv data and it looks like so... It's in a file named "my_data.csv" and we want to import it into a table named "my_things".
#
# "1", "Something", "0.50", "2013-05-05 10:00:00"
# "2", "Another thing", "1.50", "2013-06-05 10:30:00"
#
# # Now you want to import it, go to the command line and type:
#
# $ PGPASSWORD=PWHERE psql -h HOSTHERE -U USERHERE DBNAMEHERE -c "\copy my_things FROM 'my_data.csv' WITH CSV;"
#
# # Voila! It's impoted. Now if you want to wipe it out and import a fresh one, you would do this:
#
# $ heroku pg:psql
# $ TRUNCATE table my_things;
#
# Now re-do the PGPASSWORD command above:
#
# $ PGPASSWORD=PWHERE psql -h HOSTHERE -U USERHERE DBNAMEHERE -c "\copy my_things FROM 'my_data.csv' WITH CSV;"

namespace :import do
  desc 'Import user and player data from CSV (export cms_users.csv from legacy app)'
  task :users, [:csv_file_path] => :environment do |_t, args|
    csv_file_path = args[:csv_file_path]

    unless csv_file_path
      puts("Usage: rake 'import:users[/PATH/TO/FILE.csv]'") && return
    end

    User.destroy_all
    puts 'DESTROYED: all existing users'

    Player.destroy_all
    puts 'DESTROYED: all existing players'

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

        player = Player.new(
          user_id: user.id,
          nickname: row['title'],
          first_name: row['name'],
          last_name: row['surname'],
          date_of_birth: row['birthday'] ? Date.parse(row['birthday']) : nil,
          street: row['street'],
          zipcode: row['zip'],
          city: row['location'],
          phone1: row['mobile'],
          phone2: row['phone'],
          club_email: "#{username}@cfb-hasenheide.de",
          player_pass: row['firm'] == 'liga',
          status: row['firm'] == 'liga' ? :active : :inactive
        )

        player.save!

        puts "IMPORTED: #{username}"

      rescue StandardError => e
        puts "SKIPPED: #{username} (#{e})"
        next
      end
    end
  end
end
