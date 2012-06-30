class CacheDonorSubjectsInLocal < ActiveRecord::Migration
  def up
    maths = DonorSubject.create!({
      :name => "Math & Science",
      :ident => -4
    })
    music = DonorSubject.create!({
      :name => "Music & The Arts",
      :ident => -1
    })
    health = DonorSubject.create!({
      :name =>  "Health & Sports",
      :ident => -2
    })
    literacy = DonorSubject.create!({
      :name => "Literacy & Language",
      :ident => -6
    })
    special = DonorSubject.create!({
      :name => "Special Needs",
      :ident => -7
    })
    learning = DonorSubject.create!({
      :name => "Applied Learning",
      :ident => -5
    })
    history = DonorSubject.create!({
      :name => "History & Civics",
      :ident => -3
    })
   
    #subsubjects of math & science
    [['Health & Life Science', 4],[ 'Applied Sciences', 6],
     ['Environmental Science', 7], [ 'Mathematics', 8]].each do |name, ident|
      DonorSubject.create!(:name => name, :ident => ident, :parent => maths)
     end
    
    #subsubjects of music of the arts
    [["Performing Arts", 1],['Visual Arts',11], ['Music',12]].each do |name, ident|
      DonorSubject.create!(:name => name, :ident => ident, :parent => music)
    end
    
    #subsubjects of health & sport
    [["Sports",2], ["Health & Wellness", 27], 
     ["Nutrition", 28], [ "Gym & Fitness",29]].each do |name, ident|
      DonorSubject.create!(:name => name, :ident => ident, :parent => health)
     end
    
    #subsubjects of literacy & language
    [['ESL',25], ['Literacy', 10], ['Foreign Languages', 22], ['Literature & Writing',3]].each do |name, ident|
      DonorSubject.create!(:name => name, :ident => ident, :parent => literacy)
    end
    
    #subsubjects of applied learning
    [["Character Education", 26], ["Parent Involvement", 20], 
     ["Community Service", 21], ["Other", 19], ["College & Career Prep", 16], 
     ["Early Development", 18], ["Extracurricular", 17]].each do |name, ident|
      DonorSubject.create!(:name => name, :ident => ident, :parent => learning)
     end
    
    #subsubjects of history & civics
    [['Economics', 14], ['Social Sciences',15], 
     ['Civics & Government', 13], ['History & Geography',9]].each do |name, ident|
      DonorSubject.create!(:name => name, :ident => ident, :parent => history)
     end
  end

  def down
    DonorSubject.delete_all
  end
end
