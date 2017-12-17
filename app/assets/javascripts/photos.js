//= require dropzone.min
$(document).ready(function(){
	// disable auto discover
	Dropzone.autoDiscover = false;

	// grap our upload form by its id
	$("#new_photo").dropzone({
		// restrict image size to a maximum 1MB
		maxFilesize: 1,
		// changed the passed param to one accepted by
		// our rails app
		paramName: "photo[image]",
		// show remove links on each image upload
		addRemoveLinks: true,
		// if the upload was successful
		success: function(file, response){
			// find the remove button link of the uploaded file and give it an id
			// based of the fileID response from the server
      $(file.previewTemplate).attr('id', response.fileID+"a")
			$(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
			console.log(window.location.href);
			// add the dz-success class (the green tick sign)
			$(file.previewElement).addClass("dz-success");
		},
		//when the remove button is clicked
		removedfile: function(file){
			// grap the id of the uploaded file we set earlier
			var id = $(file.previewTemplate).find('.dz-remove').attr('id');
      var home = window.location.href.split("/")[2]
			// make a DELETE ajax request to delete the file
			$('#'+id+'a').hide();
			$.ajax({
				type: 'DELETE',
				url: '/homes/'+home+'/photos/' + id,
				success: function(data){
					console.log(data.message);
				}
			});
		}
	});
});
