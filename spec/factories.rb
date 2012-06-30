FactoryGirl.define do

  factory :user do 
    sequence(:email) {|n| "nominator#{n}@test.com" }
    sequence(:first_name) {|n| "Nominator#{n}" }
    sequence(:last_name) {|n| "Last#{n}" }
    organization
    password "test"    
    
    is_nominator false
    
    factory :nominator do 
      #nominations
      is_nominator true 
    end
    
    factory :nominee do 
      application
      #nomination
      is_nominator false
    end
    
  end

  factory :nomination do 
    #nominator
    #nominee
    #causes circular reference FIXME
    reason "Because you are the best."
    message "Please apply"
  end
  
  factory :organization do 
    name "Org"
  end
  
  factory :application do 
    primary_commitment "Primary Commitment"
    collab_org "Collaborating Organization"
    description "Description"
    
    #vetting_id
    #is_submitted
    
  end

  factory :admin_user do 
    email "admin@admin.com"
    password "admin"
    super_user true
  end
  
  

end