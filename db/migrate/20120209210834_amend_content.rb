class AmendContent < ActiveRecord::Migration
  def up
    # partners = Content.find_by_slug :page_partners
    # partners.body = 'Updates for our partners from 100Kin10'
    # partners.save!

    Content.create!(
      :slug    => 'page_takeaction',
      :section => 'TAKE ACTION',
      :title   => 'Take Action',
      :lede => "100Kin10 is designed as a cross-sector mobilization in which everyone - from an individual to the President - can contribute to the goal of 100,000 excellent STEM teachers in the next 10 years. Teach, donate, or participate to get involved today.",
      :body    => "100Kin10 is currently built on the commitments of 100Kin10 partners and funders, each of which is supported by hundred of individuals invested in a unified goal to prepare all students with the high-quality STEM knowledge and skills needed to tackle the most pressing national and global challenges of tomorrow. We aim to meet this goal by responding to our country's need for 100,000 new, excellent STEM teachers over 10 years. It takes individuals like you -- students, teachers, parents, STEM organizations, STEM professionals, STEM aficionados, etc. -- to make this happen. From supporting teachers within our nation's classrooms to participating in partner's commitments to becoming a STEM teacher yourself, please click through the tabs to view how you can participate in 100Kin10.")

    oldfaq = Content.find_by_slug('page_faq')

    newfaq = Content.create!(
      :slug        => 'subsection_aboutus_5_faq',
      :section     => 'ABOUT US',
      :title       => 'FAQ',
      :lede        => oldfaq.lede,
      :body        => oldfaq.body)

    Content.create!(
      :slug    => 'subsection_aboutus_6_funding',
      :section => 'ABOUT US',
      :title   => 'Funding',
      :lede    => "<b>100Kin10</b> funders have the opportunity to advance an innovative, nation-wide effort that changes the national conversation and practices around STEM education and teaching.",
      :body    => "<h1>Funding</h1><div id="funders"><p><b>100Kin10</b> funders have the opportunity to advance an innovative, nation-wide effort that changes the national conversation and practices around STEM education and teaching.<b>100Kin10</b> partners will have access, through a common application form, to funding to support their efforts through the <b>100Kin10</b> funders collaborative.</p><br/><p>Carnegie Corporation of New York is coordinating philanthropic efforts to raise private support toward the goal of 100,000 excellent STEM teachers in 10 years. To date, 14 funders have pledged over $22 million to direct toward the work of 100Kin10 partner organizations whose commitments best meet their funding objectives and priorities.</p><br/><p>Funders commit a minimum of $500,000 over three years to support any of the 100Kin10 partners. Funders maintain total independence of decision-making in choosing which organizations to fund among those that are a part of this effort. Unspent dollars can be rolled over from year to year. Funders have complete visibility into all applications and will be able to communicate freely with each other.</p><br/><p>If you are interested in joining <b>100Kin10</b> as a funding partner, please reach out directly to <a href='mailto:registry@100Kin10.org'>registry@100Kin10.org</a>.<br/><h2>100KIN10 FUNDING PARTNERS*:</h2><h3 style='color: #585858'><a href="http://www.sdbjrfoundation.org/">S.D. BECHTEL, JR. FOUNDATION</a></h3><p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will fund the preparation, training, and support of effective STEM teachers in California.</p><h3 style='color: #585858'><a href="http://www.tbf.org/Home.aspx">THE BOSTON FOUNDATION</a></h3><p style='color: #585858'>Core commitment: Build the Movement</p><p>Will fund programs that prepare and support STEM teachers in Greater Boston, raise greater awareness of STEM education among The Boston Foundation's grantees, and work with 100kin10 partners to accelerate reform and strengthen the education pipeline.</p><h3 style='color: #585858'><a href="http://carnegie.org/">CARNEGIE CORPORATION OF NEW YORK</a></h3><p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will coordinate philanthropic efforts to raise at least $20 million in private support toward the goal of 100,000 excellent STEM teachers in 10 years and will fund programs that recruit, prepare, support, and retain excellent STEM teachers, as well as maximize the impact of those that build the 100Kin10 movement.</p><h3 style='color: #585858'><a href="http://www.msdf.org/">MICHAEL &amp; SUSAN DELL FOUNDATION</a></h3><p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will fund the preparation and support of high-quality STEM talent for high-need, urban schools.</p><h3 style='color: #585858'><a href="http://www.dow.com/">THE DOW CHEMICAL FOUNDATION</a></h3><p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will fund professional development, and resource support for STEM teachers.</p><h3 style='color: #585858'><a href="http://www.fcx.com/">FREEPORT-MCMORAN COPPER & GOLD FOUNDATION</a></h3><p style='color: #585858'>Core Commitment: Build the Movement</p> <p>Will fund programs to recruit, prepare, retain, develop, and motivate excellent STEM teachers in Arizona, Colorado and New Mexico.</p><h3 style='color: #585858'><a href="http://www.gatesfoundation.org/Pages/home.aspx">BILL &amp; MELINDA GATES FOUNDATION</a></h3> <p style='color: #585858'>Core Commitment: Build the Movement</p> <p>Will fund initiatives to recruit, support, retain, and maximize the impact of excellent STEM teachers.</p><h3 style='color: #585858'><a href="http://www.google.com">GOOGLE</a></h3> <p style='color: #585858'>Additional Commitment: Build the Movement</p> <p>Will pledge to support the STEM teaching work of 100Kin10 partners.</p> <h3 style='color: #585858'><a href="http://greatertexasfoundation.org/">THE GREATER TEXAS FOUNDATION</a></h3> <p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will fund initiatives to increase the number of highly qualified STEM teachers in Texas and support 100k in 10 in efforts to create new partnerships statewide and nationally.</p><h3 style='color: #585858'><a href="http://www.hewlett.org/">THE WILLIAM AND FLORA HEWLETT FOUNDATION</a></h3> <p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will seek out STEM teacher preparation and support programs for investment and will publicize Open Educational Resources to advance the field's ability to consistently support deeper learning in STEM.</p> <h3 style='color: #585858'>HEISING-SIMONS FOUNDATION</h3><p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will fund the preparation, training, and professional development of early math teachers (preK-grade 3) in California and will support efforts to expand awareness of the importance of early math.</p><h3 style='color: #585858'><a href="http://www.jpmorganchase.com/corporate/Home/home.htm">JPMORGAN CHASE FOUNDATION</a></h3><p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will invest in efforts to recruit, develop, retain, and accelerate the impact of excellent STEM teachers in schools across the country.</p><h3 style='color: #585858'><a href="http://www.newschools.org/">NEWSCHOOLS VENTURE FUND</a></h3><p style='color: #585858'>Core Commitment: Build the Movement</p><p>Will seek out entrepreneurial STEM teacher preparation programs for investment and will publicize STEM resources developed by its community members to advance the field's ability to consistently prepare quality STEM teachers.</p><h3 style='color: #585858'><a href="http://www.schusterman.org/">THE CHARLES AND LYNN SCHUSTERMAN FAMILY FOUNDATION</a></h3> <p style='color: #585858'>Core Commitment: Build the Movement</p> <p>Will fund improvement and expansion of STEM education, including teacher training and placementprograms.</p><br/> <p>*Current list of funding partners is in formation.</p><br/> <p>We have surpassed our goal of $20M for the first fund. This lead fund will close on Feb. 21, 2012. We will begin to recruit for a second, overlapping fund, in the summer of 2012.</p></div>")

    Content.create!(
      :slug    => 'subsection_takeaction_3_partnerops',
      :section => 'TAKE ACTION',
      :title   => 'Participate',
      :body    => "<p>Help to build the movement by supporting our partners in their commitment to 100Kin10. Here, we will feature rotating partner challenges asking for you to take action on behalf of their commitment. Whether you have something to offer or know someone else who can lend a hand, we encourage you to join the movement through your participation and share the message with your communities whenever possible on behalf of STEM education and 100Kin10</p><iframe src='http://www.100kpress.com/participate/' width='1024' height='1000' scrolling='no'></iframe>")

    Content.create!(
      :slug    => 'subsection_takeaction_1_stemteacher',
      :section => 'TAKE ACTION',
      :title   => 'Teach',
      :body    => "Help to increase the supply of excellent STEM teachers by becoming one of 100K. Whether you are a current student or interested in becoming a STEM teacher, browse through our 100Kin10 partner programs below to view opportunities that fit your needs in becoming a STEM teacher. We're looking for 100K. Are you one of them?")

    Content.create!(
      :slug    => 'subsection_takeaction_2_donorschoose',
      :section => 'TAKE ACTION',
      :title   => 'Donate',
      :body    => "Support the movement by retaining the excellent teachers we currently have in our nation's schools. 100Kin10 Partner, DonorsChoose.org, engages the public in public schools by giving people a simple, accountable and personal way to address educational inequity.")
  end

  def down
    %w(page_takeaction subsection_aboutus_5_faq subsection_aboutus_6_funding
      subsection_takeaction_3_partnerops subsection_takeaction_1_stemteacher
        subsection_takeaction_2_donorschoose).each do |slug|
      Content.find_by_slug(slug).try(:destroy)
    end
  end
end
