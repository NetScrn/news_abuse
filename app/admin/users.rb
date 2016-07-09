ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :username, :email, :password, :password_confirmation

index do
  selectable_column
  id_column
  column :username
  column :email
  column :current_sign_in_at
  column :sign_in_count
  column :created_at
  actions
end

form do |f|
  f.inputs "User Details" do
    f.input :username
    f.input :email
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end


end
