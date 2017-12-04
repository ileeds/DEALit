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
      json.type "about #{notification.notifiable.subject}"    #"a comment #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    end

    #json.type "a comment #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
  json.url conversation_path(notification.notifiable)#, anchor: dom_id(notification.notifiable))
  json.unread notification.read_at == nil
  #byebug
  #json.url polymorphic_path(notification.notifiable)
end
