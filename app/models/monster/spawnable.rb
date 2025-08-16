module Monster::Spawnable
  extend ActiveSupport::Concern

  included do
    validate :validate_can_spawn, on: :create
  end

  class_methods do
    def can_spawn? = Monster.defeated.count == Monster.count
  end

  def spawn!(level = randomize_monster_level)
    monster = monsters_data.find { _1["level"] == level }
    Monster.create! monster
  end


  def validate_can_spawn
    errors.add(:monster, "cannot spawn new monster when some monsters still alive") unless Monster.can_spawn?
  end

  private

  def randomize_monster_tier
    monster_tiers = %i[lesser champion boss]
    weights = [ 85, 10, 5 ]
    cumulative = 0
    random = rand weights.sum

    weights.each_with_index do |weight, idx|
      cumulative += weight
      return monster_tiers[idx] if cumulative >= random
    end
  end

  def randomize_monster_level
    tier = randomize_monster_tier
    rand level_range_from(tier)
  end

  def level_range_from(tier)
    case tier
    when :lesser
      1..20
    when :champion
      21..40
    else
      41..64
    end
  end
end
