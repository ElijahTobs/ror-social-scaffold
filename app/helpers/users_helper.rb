module UsersHelper
  def friendship_status(obj)
    html = ""

    if current_user.friend_requests.include?(obj)
      html += link_to "Accept", friendship_path(create_params), method: :put
      html += "  "
      html += link_to "Reject", action: "destroy", id: delete
    elsif current_user.pending_friends.include?(obj)
      html += "Pending Request"
    elsif current_user.friends.include?(obj)
      html += "Already Friends"
    else
      html += link_to "Invite", action: "new"
    end

    html.html.safe
  end

end