ActiveAdmin::Dashboards.build do

  section "Welcome" do 
    div do 
      'You can access relevant sections in the navigation at the top.'
    end
  end

#   section "Content Areas" do
#     if can? :manage, Content
#       table_for Content.order("title desc").limit(5) do
#         column :title do |content|
#           link_to content.title, [:admin, content]
#         end
#         column :lede
#         column :is_active
#   
#       end
#       strong { link_to "View All Content Areas", admin_contents_path }
#     end
#   end
# 
# 
# 
# 
#   section "Nominations" do
#     if can? :manage, Nomination
#       strong { link_to "View Nominations", admin_nominations_path }
#     end
#   end
  
    
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
