module CurrentPlayer
  extend ActiveSupport::Concern

  class_methods do
    def set_current_player(**options)
      before_action :set_player, **options
    end
  end

  private

  def set_player
    Current.player ||= find_player_by_user_id
  end

  def find_player_by_user_id
    Player.find_by(user_id: Current.session.user_id)
  end
end
