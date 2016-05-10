module PlayersHelper
  def player_status_options
    Player.statuses.each_with_object({}) do |(enum, _), options|
      translated_enum = I18n.t(enum, scope: %w(activerecord enums player status))
      options[translated_enum] = enum
    end
  end
end
