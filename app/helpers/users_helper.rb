module UsersHelper
  def table_row_class_for(user)
    case user.role
    when 'admin' then 'danger'
    when 'player' then 'success'
    else ''
    end
  end
end
