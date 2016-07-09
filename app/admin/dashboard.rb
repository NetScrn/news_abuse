ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "All Categories" do
          ul do
            Category.all.map do |category|
              li link_to category.name, "/admin/categories/#{category.id}"
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Recent Articles" do
          ul do
            User.last(5).map do |user|
              li link_to user.username, "/admin/users/#{user.id}"
            end
          end
        end
      end
      column do
        panel "Recent Articles" do
          ul do
            Article.last(5).map do |article|
              li link_to article.username, "/admin/articles/#{article.id}"
            end
          end
        end
      end
    end
  end # content
end
