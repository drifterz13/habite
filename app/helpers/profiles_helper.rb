module ProfilesHelper
  def total_item_slot_row = 5
  def total_item_slot_col = 4

  def map_player_items_to_slots(player_items)
    slots = []
    (1..20).each do |n|
      found = player_items.find { |player_item| player_item.pos == n }
      slots << [ n, found&.item ]
    end

    slots.to_h
  end

  def get_item_info(item)
    if item.is_a? Gear
      gear_text = if item.is_weapon?
        "<b>atk:</b> #{item.atk}"
      else
        "<b>def:</b> #{item.def} <b>hp:</b> #{item.hp}"
      end

      return "<b>#{item.title}</b><br>#{gear_text}"
    end

    "Unknown item"
  end
end
