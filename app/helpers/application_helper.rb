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



  def link_to_toggle_post_favorite(home)

    if Following.where(user_id: current_user.id, home_id: home.id).length == 1
      @following = Following.where(user_id: current_user.id, home_id: home.id).first
      url_destroy = following_path(Following.where(user_id: current_user.id, home_id: home.id).first)
      link_to_with_icon('fa fa-heart fa-2x', url_destroy, {
        method: :delete,
        remote: true,
        class: 'followed',
        id: 'heart-'+home.id.to_s
      })
    else
      url_create = followings_path(:following => { home_id: home.id } )
      link_to_with_icon('fa fa-heart fa-2x', url_create, {
        method: 'POST',
        remote: true,
        class: 'notfollowed',
        id: 'heart2-'+home.id.to_s
      })
    end
  end

  def link_to_with_icon(icon_css, url, options = {})
    icon = content_tag(:i, nil, class: icon_css)
    title_with_icon = icon
    link_to(title_with_icon, url, options)
  end

end
