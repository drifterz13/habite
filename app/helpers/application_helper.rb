module ApplicationHelper
  def get_reward_info(rewardable)
    case rewardable.class.to_s
    when "Gear"
      item = rewardable
      gear_text = if item.is_weapon?
        "<b>atk:</b> #{item.atk}"
      else
        "<b>def:</b> #{item.def} <b>hp:</b> #{item.hp}"
      end
      "<b>#{item.title}</b><br>#{gear_text}"

    when "ExpReward"
      "<b>Amount: #{rewardable.amount}</b>"
    when "GoldReward"
      "<b>Amount: #{rewardable.amount}</b>"
    else
      "Unknown item"
    end
  end
end
