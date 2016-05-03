namespace :players do
  desc 'Import Players from Users and UserProfiles'
  task import: :environment do
    User.all.each do |user|
      Player.create!(
        club_email: "#{user.username}@cfb-hasenheide.de",
        nickname: user.user_profile.alias,
        player_pass: user.player_pass,
        user_id: user.id
      )
    end
  end
end
