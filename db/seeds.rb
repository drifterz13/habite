# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

class Seeder
  def seed
    puts "Creating admins..."
    @admin1, @admin2 = create_admins

    puts "Creating players..."
    @player1, @player2 = create_players

    puts "Creating quests..."
    @quest1, @quest2 = create_quests

    puts "Creating gears..."
    @gear1, @gear2, @gear3 = create_gears

    puts "Creating quest rewards..."
    create_quest_rewards

    puts "Creating player quests..."
    create_player_quests

    puts "Creating player tasks..."
    create_player_tasks
  end

  private

  def create_admins
    User.create!([
      { email_address: "admin1@test.com", password: "P@ssw0rd", password_confirmation: "P@ssw0rd" },
      { email_address: "admin2@test.com", password: "P@ssw0rd", password_confirmation: "P@ssw0rd" }
    ])
  end

  def create_players
    user1, user2 = User.create!([
      { email_address: "player1@test.com", password: "P@ssw0rd", password_confirmation: "P@ssw0rd" },
      { email_address: "player2@test.com", password: "P@ssw0rd", password_confirmation: "P@ssw0rd" }
    ])

    Player.create!([
      { user: user1, name: "player_1", hp: 100, exp: 0, atk: 10, def: 8, gold: 10 },
      { user: user2, name: "player_2", hp: 80, exp: 0, atk: 15, def: 6, gold: 10 }

    ])
  end

  def create_quests
    start = Time.now.beginning_of_day + 9.hours + 30.minutes
    quest1 = Quest.create!(
      title: "Check in before 9:30 am for 3 days",
      description: "To check-in in Discord before 9:30 am for 3 days",
      start_at: start,
      end_at: start + 7.days,
    )
    quest1.tasks.create!([
      { title: "Check in #1 #{(start + 1.days).strftime("%Y-%m-%d")}", description: "Day 1 for chek-in before 9:30 am" },
      { title: "Check in #2 #{(start + 2.days).strftime("%Y-%m-%d")}", description: "Day 2 for chek-in before 9:30 am" },
      { title: "Check in #3 #{(start + 3.days).strftime("%Y-%m-%d")}", description: "Day 3 for chek-in before 9:30 am" }
    ])

    quest2 = Quest.create!(
      title: "Review 2 MR. today",
      description: "Review at least 2 merge requests by today",
      start_at: start,
      end_at: Time.now.end_of_day,
    )
    quest2.tasks.create!([
      { title: "Review 1st merge request" },
      { title: "Review 2nd merge request" },
      { title: "Review 3rd merge request" }
    ])

    [ quest1, quest2 ]
  end

  def create_gears
    Gear.create!([
      {
        title: "Axe 1",
        description: "A standard-issue axe, reliable in close combat.",
        asset_key: "axe_1"
      },
      {
        title: "Helmet 1",
        description: "A simple helmet, offering basic protection.",
        asset_key: "helmet_1"
      },
      {
        title: "Sword 1",
        description: "A finely crafted sword.",
        asset_key: "sword_1"
      }
    ])
  end

  def create_quest_rewards
    QuestReward.create!([
      { quest: @quest1, rewardable: ExpReward.create!(amount: 15) },
      { quest: @quest1, rewardable: GoldReward.create!(amount: 10) },
      { quest: @quest1, rewardable: @gear1 },
      { quest: @quest2, rewardable: @gear3 }
    ])
  end

  def create_player_quests
    PlayerQuest.create!([
      { player: @player1, quest: @quest1 },
      { player: @player1, quest: @quest2 },
      { player: @player2, quest: @quest1 }
    ])
  end

  def create_player_tasks
    quest1_tasks = @quest1.tasks
    quest2_tasks = @quest2.tasks

    PlayerTask.create!([
      { player: @player1, task: quest1_tasks[0] },
      { player: @player1, task: quest1_tasks[1] },
      { player: @player1, task: quest1_tasks[2] },
      { player: @player1, task: quest2_tasks[0] },
      { player: @player1, task: quest2_tasks[1] },
      { player: @player1, task: quest2_tasks[2] },
      { player: @player2, task: quest1_tasks[0] },
      { player: @player2, task: quest1_tasks[1] },
      { player: @player2, task: quest1_tasks[2] }
    ])
  end
end

seeder = Seeder.new
seeder.seed
