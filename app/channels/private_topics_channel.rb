class PrivateTopicsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "private_topics_#{params['private_topic_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_private_post(data)
    current_user.private_posts.create!(content: data['private_post'], postable: Thredded::PrivateTopic.find(data['private_topic_id']))
  end
end
