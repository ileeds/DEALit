$(document).ready ->
  private_posts = $ '*[id^="private_post"]'
  current_user_id = $('#current_user').attr('data-user-id')
  set_messages_class = ->
    $.each private_posts, (index, post) ->
      if $(post).attr('data-user') == current_user_id
        $(post).addClass("current-user-message")
      else
        $(post).addClass("other-user-message")
      return
  set_messages_class()

  if private_posts.length > 0

    App.global_chat = App.cable.subscriptions.create {
        channel: "PrivateTopicsChannel"
        private_topic_id: parseInt $('*[id^="private_topic"]')[0].id.slice($('*[id^="private_topic"]')[0].id.lastIndexOf('_')+1)
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $(data['private_post']).insertAfter($('*[id^="private_post"]')[$('*[id^="private_post"]').length-1])
        $.ajax
          type: 'PUT'
          url: '/mark_read'
          data: {
            "postable_id": parseInt $('*[id^="private_topic"]')[0].id.slice($('*[id^="private_topic"]')[0].id.lastIndexOf('_')+1)
          }
        private_posts = $ '*[id^="private_post"]'
        set_messages_class()

      send_private_post: (private_post, private_topic_id) ->
        @perform 'send_private_post', private_post: private_post, private_topic_id: private_topic_id

    $('#new_post').submit (e) ->
      $this = $(this)
      textarea = $this.find('#post_content')
      if $.trim(textarea.val()).length >= 1
        App.global_chat.send_private_post textarea.val(), parseInt $('*[id^="private_topic"]')[0].id.slice($('*[id^="private_topic"]')[0].id.lastIndexOf('_')+1)
        textarea.val('')
      e.preventDefault()
      return false
