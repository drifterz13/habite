module ProfilesHelper
  def map_player_items_to_slots(player_items)
    slots = []
    (1..20).each do |n|
      found = player_items.find { |player_item| player_item.pos == n }
      slots << [ n, found&.item ]
    end

    slots.to_h
  end
end
