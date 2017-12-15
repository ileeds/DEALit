module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Off Campus"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def count(current_user)
    @count = Notification.actives(current_user.id).where(read_at: nil).length
    if @count != 0
      "<span id='unread' class='unread-true'>#{@count}</span>".html_safe
    else
      '<span hidden id="unread" class="unread-true"></span>'.html_safe
    end
  end

  def no_notifications
    if Notification.actives(current_user.id).length == 0
      "<li id='no-notifications'>No notifications</li>".html_safe
    else
      "<li hidden id='no-notifications'>No notifications</li>".html_safe
    end
  end

  def unread_inbox(current_user)
    count = Thredded::PrivateTopic.for_user(current_user).unread(current_user).count
    if count != 0
      "<span id='unread-inbox' class='unread-true'>#{count}</span>".html_safe
    else
      '<span hidden id="unread" class="unread-true"></span>'.html_safe
    end
  end

end
