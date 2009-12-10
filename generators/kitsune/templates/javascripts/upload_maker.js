$.fn.upload_maker = function(destination) {
	$(this).each(function() {
		//Get some vars
		var id = $(this).attr('id');
		var image_input_id = id + '_image_url';
		//write the iframe
		$(this).before('<iframe src="'+destination+'?destination=' + image_input_id +'" frameborder="0"></iframe>');
		//write hidden input
		$(this).after('<input id="' + image_input_id +'" name="' + image_input_id +'" style="position:absolute;left:-9999em" />');
		$('#' + image_input_id).focus(function() {
			var url = $(this).val();
			if (tinyMCE && (ed = tinyMCE.get(id))) {
				ed.execCommand('mceInsertContent', false, '<img src="' + url + '" alt="' + url + '" />');		
			} else {
				insertTag(id, '<img src="' + url + '" alt="' + url + '" />');
			}
	  });
	})
}
