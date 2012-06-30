require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
# == Schema Information
#
# Table name: applications
#
#  id                      :integer         not null, primary key
#  user_id                 :integer
#  primary_commitment      :text
#  collab_org              :text
#  description             :text
#  commitmentcat           :string(255)
#  year1                   :text
#  year2                   :text
#  year3                   :text
#  year4                   :text
#  org_commitment_type     :string(255)
#  further_info            :text
#  add_info                :text
#  avatar                  :string(255)
#  is_consent              :boolean
#  secondary_id            :integer
#  vetting_id              :integer
#  created_at              :datetime
#  updated_at              :datetime
#  is_submitted            :boolean         default(FALSE)
#  supp_commitment         :text
#  supp_add_commitment     :text
#  supp_add_commitemnt_cat :string(255)
#  supp_year1              :text
#  supp_year3              :text
#  supp_year5              :text
#  supp_commitment_type    :string(255)
#  supp_launch             :string(255)
#  supp_further_info       :text
#  supp_add_info           :text
#  supp_year2              :text
#  year5                   :text
#  supp_year4              :text
#

