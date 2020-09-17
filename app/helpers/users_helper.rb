module UsersHelper
  def friendship_status(usr)
    return unless current_user.id != usr.id

    return if current_user.friend?(usr)


    html = ""

    
    if current_user.pending_friends.include?(usr)
      html += "Invitation sent"
    elsif current_user.friend_requests.include?(usr)
      html += link_to "Accept", accept_path(user_id: usr.id), class: 'accept'
      html += "  "
      html += link_to "Reject", reject_path(user_id: usr.id), method: :delete, class: 'reject'
    elsif current_user.friends.include?(usr)
      html += "Already Friends"
    else
      html += link_to "Invite", invite_path(user_id: current_user.id, friend_id: usr), class: 'invite'
    end

    html.html_safe
  end

end
