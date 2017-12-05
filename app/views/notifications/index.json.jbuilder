json.array! @notifications do |notification|
  # json.recipient notification.recipient # dont need thing
  json.id notification.id
  json.actor notification.actor.name
  json.action notification.action
  #json.notifiable notification.notifiable
  json.notifiable do
    if !notification.action.include?("replied")
      json.type ""
    else
      json.type "about #{notification.notifiable.subject}"
    end
  end
  json.url conversation_path(notification.notifiable)
  json.unread notification.read_at == nil
end
