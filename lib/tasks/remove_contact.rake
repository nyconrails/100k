namespace :app do
  desc "Remove Contact"
  task :remove_contact => :environment do
    puts "Remove Maya's contact as Nominee"
    
    @user = User.find_by_email("maya@ias.edu")

    @post = Post.where("user_id = '#{@user.id}'" )
       Post.delete(@post)
       puts "related posts is successfully deleted" 

    @nomination = Nomination.where("nominee_id = '#{@user.id}'")
      Nomination.delete(@nomination)
       User.delete(@user)

      puts " Maya's contact as Nominee is successfully deleted" 
    end
end


