module UsersHelper
  def friendship_status(usr)
    return unless current_user.id != usr.id

    return if current_user.friend?(usr)


    html = ""

    
    if current_user.pending_friends.include?(usr)
      html += "Invitation sent"
    elsif current_user.friend_requests.include?(usr)
      html += link_to "Accept", invite_path(user_id: usr.id), method: :put
      html += "  "
      html += link_to "Reject", reject_path(user_id: usr.id)
    elsif current_user.friends.include?(usr)
      html += "Already Friends"
    else
      html += link_to "Invite", invite_path(user_id: usr.id)
    end

    html.html_safe
  end

end
