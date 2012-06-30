/*var $QUERY_PARAMS;*/
$(document).ready(function(){
  $(".outer-search .search-button").click(function(e){
    document.body.style.cursor = 'wait';
    var keyword = $(this).closest('.outer-search').find('.input-content').val();
    /*var type = $(this).attr('rel');*/
    $QUERY_PARAMS['page'] = 1;
    $QUERY_PARAMS['keywords'] = keyword;
    $.get('/search/donates?format=js', $.param($QUERY_PARAMS), function(data){
      $("#graybox_teach_opportunities").height($("#donates").height() - 250);
    });
    e.preventDefault();
  });

  $('.paginations .pagination').live('click', function(){
    document.body.style.cursor = 'wait';
    var page = $(this).attr('id');
    var type = $(this).attr('rel');
    $.get('/search/'+type+'?format=js',$.param($QUERY_PARAMS)+"&page="+page,function(){
      $("#graybox_teach_opportunities").height($("#donates").height() - 250);
    });
  });

  $('.sorting.teacher-opportunities a').click(function(){
    $('.sorting.teacher-opportunities a').removeClass('current');
    $(this).addClass('current');
    var column = $(this).attr('rel');
    $QUERY_PARAMS['page'] = 1;
    $QUERY_PARAMS['sort_by'] = column;
    $.get('/search/opportunities?format=js', $.param($QUERY_PARAMS), function(){
      $("#graybox_teach_opportunities").height($("#opportunities").height() + 300);
    });
  });

  $('.subjects .subject > a.sup').click(function(){
    document.body.style.cursor = 'wait';
    $('.subjects .subject .subsubjects').hide();
    $('.subjects .subject .sup').removeClass('current');
    $('.subjects .subject .sub').removeClass('current');
    $('.subjects .subject a.sup .number-facets').show();
    $(this).closest('.subjects').find('.subsubjects .number-facets').hide();
    $(this).find('.number-facets').hide();
    $(this).addClass('current');
    $(this).next().toggle();
    var subject = $(this).attr('rel').split('=');
    /*just set facets for one subject*/
    $QUERY_PARAMS['subject1'] = '';
    $QUERY_PARAMS['subject2'] = '';
    $QUERY_PARAMS['subject3'] = '';
    $QUERY_PARAMS['subject4'] = '';
    $QUERY_PARAMS['subject5'] = '';
    $QUERY_PARAMS['subject6'] = '';
    $QUERY_PARAMS['subject7'] = '';
    $QUERY_PARAMS[subject[0]] = subject[1];
    $QUERY_PARAMS['page'] = 1;
    $.get('/search/donates?format=js', $.param($QUERY_PARAMS), function(){
      $("#graybox_teach_opportunities").height($("#donates").height() - 250);
    });
  });
  $('.subjects .subject a.sub').click(function(){
    document.body.style.cursor = 'wait';
    var subject = $(this).attr('rel').split('=');
    $('.subjects .subject a.sub').removeClass('current');
    $('.subjects .subject a.sup .number-facets').hide();
    $('.subjects .subject a.sup.sub .number-facets').hide();
    $('.subjects .subject a.sup').removeClass('current');
    $(this).closest('.subsubjects').find('.number-facets').show()
    $(this).find('.number-facets').hide();
    $(this).closest('.subject').find('a.sup').addClass('current')
    $(this).addClass('current');
    $QUERY_PARAMS['subject1'] = '';
    $QUERY_PARAMS['subject2'] = '';
    $QUERY_PARAMS['subject3'] = '';
    $QUERY_PARAMS['subject4'] = '';
    $QUERY_PARAMS['subject5'] = '';
    $QUERY_PARAMS['subject6'] = '';
    $QUERY_PARAMS['subject7'] = '';
    $QUERY_PARAMS[subject[0]] = subject[1];
    $QUERY_PARAMS['page'] = 1;
    $.get('/search/donates?format=js', $.param($QUERY_PARAMS), function(){
      $("#graybox_teach_opportunities").height($("#donates").height() - 250);
    });
  });

  $(".cost-to-complete #costToComplete").change(function(){
    document.body.style.cursor = 'wait';
    var complete = $(this).val();
    $QUERY_PARAMS['costToComplete'] = complete;
    $.get('/search/donates?format=js', $.param($QUERY_PARAMS), function(){});
  });
  
  $(".rated-by .sorted a.rate-sorting").click(function(){
    document.body.style.cursor = 'wait';
    var rated = $(this).attr('rel');
    $(".rated-by .sorted a.rate-sorting").removeClass('current');
    $(this).addClass('current');
    $QUERY_PARAMS['sortBy'] = rated;
    $.get('/search/donates?format=js', $.param($QUERY_PARAMS), function(){
      $("#graybox_teach_opportunities").height($("#donates").height() - 250);
    });
  });

  $(".outer-search select#state ").change(function(){
    document.body.style.cursor = 'wait';
    var state = $(this).val();
    $QUERY_PARAMS['state'] = state;
    $QUERY_PARAMS['cityName'] = '';    
    /*reset subject scope*/
    $QUERY_PARAMS['subject1'] = '';
    $QUERY_PARAMS['subject2'] = '';
    $QUERY_PARAMS['subject3'] = '';
    $QUERY_PARAMS['subject4'] = '';
    $QUERY_PARAMS['subject5'] = '';
    $QUERY_PARAMS['subject6'] = '';
    $QUERY_PARAMS['subject7'] = '';
    $('.subjects .subject a').removeClass('current');
    $('.subjects .subject .subsubjects').hide();
    $.get('/search/donates?format=js', $.param($QUERY_PARAMS), function(){});
  });
  $(".locations .cities #cityName").live('change', function(){
    document.body.style.cursor = 'wait';
    var city = $(this).val();
    $QUERY_PARAMS['cityName'] = city;
    $.get('/search/donates?format=js', $.param($QUERY_PARAMS), function(){
      $("#graybox_teach_opportunities").height($("#donates").height() - 250);
    });
  });
});
