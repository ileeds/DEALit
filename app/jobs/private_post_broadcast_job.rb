class PrivatePostBroadcastJob < ApplicationJob
  queue_as :default
  include Pundit

  def perform(private_post)
    ActionCable.server.broadcast "private_topics_#{private_post.postable.id}_channel",
                                 private_post: render_private_post(private_post)
  end

  private

    def render_private_post(private_post)
      private_post = Thredded::TopicPostsPageView.new(private_post.user, private_post.postable, private_post.postable.posts.reverse_order.limit(1))
      Thredded::ApplicationController.renderer.new().render(partial: 'thredded/private_posts/single_private_post', locals: {private_post: private_post})
    end
end
