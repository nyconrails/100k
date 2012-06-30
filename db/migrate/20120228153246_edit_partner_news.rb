class EditPartnerNews < ActiveRecord::Migration
  def up
    pn = Content.find_by_slug('partner_news') ||
      Content.new(:slug => 'partner_news')
    pn.title = 'Partner News'
    pn.lede  = 'News for partners from 100kin10'
    pn.body  = nil
    pn.save!
  end

  def down
  end
end
