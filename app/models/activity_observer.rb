class ActivityObserver < ActiveRecord::Observer
  observe :nomination, :application, :content, :user, :admin_user
 
  
  def after_rollback(model)
     if model.errors.any? 
       Activity.create(:trackable_type=>model.class.name,:trackable_id=>(model.id || 0),:action=>'rollback',:data=>{:model=>model,:errors=>model.errors})
     end  
  end
  
  def after_save(model)
    case 
      when (model.kind_of? User)
        if model.crypted_password_changed?
          Activity.create(:trackable_type=>model.class.name,:trackable_id=>model.id,:action=>'after_save: password change',:data=>{:model=>model})             
        end
      else
        Activity.create(:trackable_type=>model.class.name,:trackable_id=>model.id,:action=>'after_save',:data=>{:model=>model})
    end
  end
  
end
