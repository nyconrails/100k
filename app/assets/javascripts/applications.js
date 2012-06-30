$(document).ready(function() {
  $('#application_further_info').simplyCountable({
    counter: '#add_furtherCharsLeft',
    countType: 'words',
    maxCount: 250,
    countDirection: 'down',
    strictMax: true
  });

  $('#application_description').simplyCountable({
    counter: '#application_descriptionCharsLeft',
    countType: 'words',
    maxCount: 250,
    countDirection: 'down',
    strictMax: true
  });

  $('#application_primary_commitment').simplyCountable({
    counter: '#application_primary_commitmentCharsLeft',
    countType: 'characters',
    maxCount: 250,
    countDirection: 'down',
    strictMax: true
  });
      
  $('#application_add_info').simplyCountable({
    counter: '#add_infoCharsLeft',
    countType: 'words',
    maxCount: 250,
    countDirection: 'down',
    strictMax: true
  });

  $('#application_supp_commitment').simplyCountable({
    counter: '#application_supp_commitmentCharsLeft',
    countType: 'characters',
    maxCount: 250,
    countDirection: 'down',
    strictMax: true
  });

  $('#application_supp_add_commitment').simplyCountable({
    counter: '#application_supp_add_commitmentCharsLeft',
    countType: 'words',
    maxCount: 500,
    countDirection: 'down',
    strictMax: true
  });

  $('#application_supp_further_info').simplyCountable({
    counter: '#application_supp_further_infoCharsLeft',
    countType: 'words',
    maxCount: 250,
    countDirection: 'down',
    strictMax: true
  });

  $('#application_supp_add_info').simplyCountable({
    counter: '#application_supp_add_infoCharsLeft',
    countType: 'words',
    maxCount: 250,
    countDirection: 'down',
    strictMax: true
  });
  
  $('#organization_orgtype_id').change(function() {

    if($("#organization_orgtype_id option:selected").text()=='Other') {
      $('#org_other').show();
    } else {
      $('#org_other').hide();
      $('#organization_other').val('');
    }
  });
                 
});




  
