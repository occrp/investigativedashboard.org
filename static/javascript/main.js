$(document).ready(function(){

  // activate current nav link and content, disable the rest
  var regionNav = $('.regions-container ul li');
	regionNav.click(function(){
		var tab_id = $(this).attr('data-tab');
		regionNav.removeClass('current');
		$('.regions-container .tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})
})

