module Donor
  class Search < Base
    COST_COMPLETES       = {
      "$99 or less"      => 1,
      "$100-$200"        => 2,
      "$200-$1,000"      => 3,
      "$1,000-above"     => 4
    }
    SORTED               = {
      "Most Urgent"      => 0,
      "Lowest Cost"      => 2,
      "Highest Poverty"  => 1,
      "Fewest Days Left" => 3,
      "Most Donors"      => 4
    }

    SUBJECTS = {
      "Math & Science" => {'id' => "subject4=-4",
                           'Health & Life Science' => "subject4=4",
                           'Applied Sciences' => "subject4=6",
                           'Environmental Science' => "subject4=7",
                           'Mathematics' => "subject4=8"},
      "Music & The Arts" => {'id' => "subject1=-1",
                             "Performing Arts" => "subject1=1",
                             'Visual Arts' => "subject1=11",
                             'Music' => "subject1=12"},
      "Health & Sports" => {'id' => "subject2=-2",
                            "Sports" => "subject2=2",
                            "Health & Wellness" => "subject2=27",
                            "Nutrition" => "subject2=28",
                            "Gym & Fitness" => "subject2=29"},
      "Literacy & Language" => {'id' => "subject6=-6",
                                'ESL' => "subject6=25",
                                'Literacy' => "subject6=10",
                                'Foreign Languages' => "subject6=22",
                                'Literature & Writing' => "subject6=3"},
      "Special Needs" => {'id' => "subject7=-7"},
      "Applied Learning" => {'id' => "subject5=-5",
                             "Character Education" => "subject5=26",
                             "Parent Involvement" => "subject5=20",
                             "Community Service" => "subject5=21",
                             "Other" => "subject5=19",
                             "College & Career Prep" => "subject5=16",
                             "Early Development" => "subject5=18",
                             "Extracurricular" => "subject5=17"},

    "History & Civics" => {'id' => 'subject3=-3',
                           'Economics' => 'subject3=14',
                           'Social Sciences' => 'subject3=15',
                           'Civics & Government' => 'subject3=13',
                           'History & Geography' => 'subject3=9'}
    }

    HASH_SUBJECTS = {
      -4         => "Math & Science",
       4         => 'Health & Life Science',
       6         => 'Applied Sciences',
       7         => 'Environmental Science',
       8         => 'Mathematics',
       -1        => "Music & The Arts",
       1         => "Performing Arts",
       11        => 'Visual Arts',
       12        => 'Music',
       -2        => "Health & Sports",
        2        => "Sports",
        27       => "Health & Wellness",
        28       => "Nutrition",
        29       => "Gym & Fitness",
        -6       => "Literacy & Language",
        25       => 'ESL',
        10       => 'Literacy',
        22       => 'Foreign Languages',
        3        => 'Literature & Writing',
        -7       => "Special Needs",
        -5       => "Applied Learning",
        26       => "Character Education",
        20       => "Parent Involvement",
        21       => "Community Service",
        19       => "Other",
        16       => "College & Career Prep",
        18       => "Early Development",
        17       => "Extracurricular",
        -3       => "History & Civics",
        14       => 'Economics',
        15       => 'Social Sciences',
        13       => 'Civics & Government',
        9        => 'History & Geography'
    }


    cattr_accessor :api_url, :api_key
    class << self
      def api_url
        api_url ||= "api.donorschoose.org/common/json_feed.html"
      end
      def api_key
        api_key ||= "ngw9kn2jd63q"
      end
    end

    def self.find(params = {})
      begin
        params.merge!({"APIKey" => Search.api_key})
        url = "http://#{Search.api_url}?#{params.to_param}"
        Rails.logger.info(url)
        return JSON.parse(open(url).read)
      rescue Exception => ex
        return {:exception => ex.message}.to_json
      end
    end

  end
end
