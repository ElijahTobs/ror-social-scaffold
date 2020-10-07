module UsersHelper
  def friendship_options(user)
    html = ''

    if current_user.friend_invites(user)
      html << (link_to 'Invitation sent', class: 'btn btn-warning').to_s
    elsif current_user.receive_invitation(user)
      html << link_to('Accept', accept_path(user_id: user.id), class: 'btn btn-primary')
      html << ' '
      html << link_to('Decline', reject_path(user_id: user.id), method: :delete, class: 'btn btn-danger')
    elsif !current_user.friend?(user) && current_user.id != user.id
      html << link_to('Add Friend', invite_path(user_id: user.id), class: 'btn btn-success')
    elsif current_user.friend?(user)
      html << link_to('A friend', class: 'btn btn-warning')
      html << ' '
      html << link_to('Remove friend', remove_friend_path(user_id: user.id), class: 'btn btn-danger', method: :delete, data: { confirm: 'Are you sure you want to remove friend?' })
    end

    # users.each do |user|
    # end
    html.html_safe
  end
end
