module User::CommentsHelper
  def display_emotion
      Comment::EMOTIONS.map{|em|image_tag("#{em}.png", title: em)}.join().html_safe
  end
end
