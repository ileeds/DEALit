$(document).ready ->
  private_posts = $ '*[id^="private_post"]'
  if private_posts.length > 0
    private_posts_to_bottom = -> private_posts.scrollTop(private_posts.prop("scrollHeight"))

    private_posts_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
        channel: "PrivateTopicsChannel"
        private_topic_id: parseInt $('*[id^="private_topic"]')[0].id.slice(-1)
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $(data['private_post']).insertAfter($('*[id^="private_post"]')[$('*[id^="private_post"]').length-1])
        private_posts_to_bottom()

      send_private_post: (private_post, private_topic_id) ->
        @perform 'send_private_post', private_post: private_post, private_topic_id: private_topic_id

    $('#new_post').submit (e) ->
      $this = $(this)
      textarea = $this.find('#post_content')
      if $.trim(textarea.val()).length >= 1
        App.global_chat.send_private_post textarea.val(), parseInt $('*[id^="private_topic"]')[0].id.slice(-1)
        textarea.val('')
      e.preventDefault()
      return false
