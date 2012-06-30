# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    
    Orgtype.delete_all
    Orgtype.create!(:title => 'Association')
    Orgtype.create!(:title => 'Charter Management Organization')
    Orgtype.create!(:title => 'Corporation')
    Orgtype.create!(:title => 'Federal Agency')
    Orgtype.create!(:title => 'Foundation')
    Orgtype.create!(:title => 'Higher Education Institution')
    Orgtype.create!(:title => 'Museum')
    Orgtype.create!(:title => 'Non-profit Organization')
    Orgtype.create!(:title => 'Residency Program')
    Orgtype.create!(:title => 'School District')
    Orgtype.create!(:title => 'State Leadership')
    Orgtype.create!(:title => 'Individual')
    
    #Nov 8th - run this -bret
    Orgtype.create!(:title=>'Other')
    
    
    
    State.delete_all
    State.create :name => 'Alabama', :abbreviation => 'AL'
    State.create :name => 'Alaska', :abbreviation => 'AK'
    State.create :name => 'Arizona', :abbreviation => 'AZ'
    State.create :name => 'Arkansas', :abbreviation => 'AR'
    State.create :name => 'California', :abbreviation => 'CA'
    State.create :name => 'Colorado', :abbreviation => 'CO'
    State.create :name => 'Connecticut', :abbreviation => 'CT'
    State.create :name => 'Delaware', :abbreviation => 'DE'
    State.create :name => 'District of Columbia', :abbreviation => 'DC'
    State.create :name => 'Florida', :abbreviation => 'FL'
    State.create :name => 'Georgia', :abbreviation => 'GA'
    State.create :name => 'Hawaii', :abbreviation => 'HI'
    State.create :name => 'Idaho', :abbreviation => 'ID'
    State.create :name => 'Illinois', :abbreviation => 'IL'
    State.create :name => 'Indiana', :abbreviation => 'IN'
    State.create :name => 'Iowa', :abbreviation => 'IA'
    State.create :name => 'Kansas', :abbreviation => 'KS'
    State.create :name => 'Kentucky', :abbreviation => 'KY'
    State.create :name => 'Louisiana', :abbreviation => 'LA'
    State.create :name => 'Maine', :abbreviation => 'ME'
    State.create :name => 'Maryland', :abbreviation => 'MD'
    State.create :name => 'Massachutsetts', :abbreviation => 'MA'
    State.create :name => 'Michigan', :abbreviation => 'MI'
    State.create :name => 'Minnesota', :abbreviation => 'MN'
    State.create :name => 'Mississippi', :abbreviation => 'MS'
    State.create :name => 'Missouri', :abbreviation => 'MO'
    State.create :name => 'Montana', :abbreviation => 'MT'
    State.create :name => 'Nebraska', :abbreviation => 'NE'
    State.create :name => 'Nevada', :abbreviation => 'NV'
    State.create :name => 'New Hampshire', :abbreviation => 'NH'
    State.create :name => 'New Jersey', :abbreviation => 'NJ'
    State.create :name => 'New Mexico', :abbreviation => 'NM'
    State.create :name => 'New York', :abbreviation => 'NY'
    State.create :name => 'North Carolina', :abbreviation => 'NC'
    State.create :name => 'North Dakota', :abbreviation => 'ND'
    State.create :name => 'Ohio', :abbreviation => 'OH'
    State.create :name => 'Oklahoma', :abbreviation => 'OK'
    State.create :name => 'Oregon', :abbreviation => 'OR'
    State.create :name => 'Pennsylvania', :abbreviation => 'PA'
    State.create :name => 'Rhode Island', :abbreviation => 'RI'
    State.create :name => 'South Carolina', :abbreviation => 'SC'
    State.create :name => 'South Dakota', :abbreviation => 'SD'
    State.create :name => 'Tennessee', :abbreviation => 'TN'
    State.create :name => 'Texas', :abbreviation => 'TX'
    State.create :name => 'Utah', :abbreviation => 'UT'
    State.create :name => 'Vermont', :abbreviation => 'VT'
    State.create :name => 'Virginia', :abbreviation => 'VA'
    State.create :name => 'Washington', :abbreviation => 'WA'
    State.create :name => 'West Virginia', :abbreviation => 'WV'
    State.create :name => 'Wisconsin', :abbreviation => 'WI'
    State.create :name => 'Wyoming', :abbreviation => 'WY'


