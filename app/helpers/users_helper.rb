module UsersHelper
  def friendship_status(usr)
    return unless current_user.id != usr.id

    return if current_user.friend?(usr)


    html = ""

    
    if current_user.pending_friends.include?(usr)
      html += "Invitation sent"
    elsif current_user.friend_requests.include?(usr)
      html += link_to "Accept", friendships_path(user_id: usr.id), method: :put, class: 'accept'
      html += "  "
      html += link_to "Reject", friendships_path(user_id: usr.id), method: :delete, class: 'reject'
    elsif current_user.friends.include?(usr)
      html += "Already Friends"
    else
      html += link_to "Invite", friendships_path(user_id: current_user.id, friend_id: usr), method: :post, class: 'invite'
    end

    html.html_safe
  end

end
