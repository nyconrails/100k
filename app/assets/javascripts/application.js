// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
// require active_admin
//= require jquery.limit-1.2.source
//= require jquery.simplyCountable
//= require jquery.validate
//= require twitter-widget
//= require applications
//= require sessions
//= require tabs
//= require_self
// require_tree .

var $QUERY_PARAMS = {};
$(document).ready(function() {

    $("#mainnav ul li").hover(function() {
      $(this).find(".head").css('background', '#fcb347');
    }, function() {
      $(this).find(".head").css('background', '#585858');
    });

    // Modified on 10-Mar-2012 to provide Editable Screen to Regular Users
    //Start Modification
    $('div.submit_orgtype').hide();
    $('.submit_date').hide();
    $('div.submit_contactinfo').hide();
    $('a.edit_org').live('click',function(e){
        $(this).parent().find('div.org_type').hide();
        $(this).parent().find('.submit_orgtype').show();
        return false;
    });
    $('a.edit_date').live('click',function(e){
        $(this).parent().find('div.org_type').hide();
        var variable1 = $(this).parent().find('.submit_date');
        $(variable1).show();
        $(variable1).find('fieldset.buttons ol li.commit input[type="submit"]').css('margin-left','10%');
        return false;
    });
    $('a.edit_contact').live('click',function(e){
        var id = $(this).attr('id');
        var variable = $(this).parent().parent().parent().find('div.org_user');
        $('div.submit_contactinfo').attr('id',id)
        $(variable).next().show();
        $(variable).next().find('input#user_first_name').focus();
        $(variable).hide();
        return false;
    });
    //End Modification
    $("#posts-list .list .edit-inline-post").live('click', function(e){
        var domId = "#post-"+$(this).attr('rel');
        $(domId+" .post-content .body, "+ domId+" .post-content .form-submit").toggle();
        $(domId+" .post-content .form-submit textarea").focus().select();
        return false;
    });

    $("#posts-list .list li div.author").live('hover', function(){
        $(this).find('span.action').toggle();
    });

    $("#nomination_back").live("click", function() {
        $.post("/nominations.js?edit=true", $("#nomination_form").serialize());
        return false;
    });

    $("#nomination_submit").live("click", function() {
        $.post("/nominations.js", $("#nomination_form").serialize());
        $("#nomination_submit").attr('disabled', 'disabled');
        return false;
    });

    setTimeout( "jQuery('.flash').fadeOut('fast');",3000 );

    /* Added on 27 Mar 2012 to handle multiple clicks when posting status */
    /* Start Here */
    $('form#post-status').ajaxStart(function(){
        if ($('textarea#post_body').val() != ""){
            $('input[value="POST"]').attr('disabled', 'disabled')
            $('input[value="POST"]').val('Processing...')
        }
    });
    $('form#post-status').ajaxStop(function(){
        $('input[value="Processing..."]').val('POST')
        $('input[value="POST"]').removeAttr('disabled')
    })
    /* End Here */

    $('div#maincontent div.subsection div.commitment_subtabs').css('text-align', 'justify');
    $('div#maincontent div.subsection h1').css('padding-bottom', '15px');

    $('input#contacted_organization_firstname,input#contacted_organization_lastname').focus(function(){
        $(this).next('p').hide();
        return false;
    });
    $('input#contacted_organization_emailid,textarea#contacted_organization_question,input#contacted_organization_phonenumber').focus(function(){
        $(this).next('p').hide();
        return false;
    });
    $('select#contacted_organization_reason').click(function(){
        $(this).next('p').hide();
        return false;
    });

$("#nomination-form").validate();

});
