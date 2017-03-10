var uploadProgressPanelHTML = "<div class=\"panel panel-default\"><div class=\"panel-heading\">Uploading \"{{ filename }}\"</div><div class=\"panel-body\"><div class=\"progress\"><div class=\"progress-bar progress-bar-striped active\" role=\"progressbar\" style=\"width: {{ progress }}%;\">{{ progress-description }}</div></div></div></div>"
var UPLOAD_STATUS = {
  UPLOADING: "uploading",
  FINISHED: "finished"
}
var imageUploads = []

function uploadPhotos() {
  imageUploads = []
  var photos = $("#add-photos-file-input")[0].files
  $.ajax({ url: "/upload_urls?count=" + photos.length }).done(function(data) {
    for (var index = 0; index < photos.length; index++) {
      imageUploads[index] = upload(photos[index], data[index])
      imageUploads[index].index = index
    }
    renderProgressBars()
    toggleAddPhotoSubmitButtonActivationState()
    imageUploads.forEach(function(upload) {
      startUpload(upload)
    })
  }).fail(function(request, status, error) {
    console.error("Unexpected error fetching upload urls")
    console.error(error)
    alert("An unexpected error has occured. No photos were uploaded.")
  })
}

function startUpload(upload) {
  $.ajax({
    url: upload.url,
    type: "PUT",
    contentType: "binary/octet-stream",
    processData: false,
    data: upload.file,
    xhr: function() {
      var xhr = new window.XMLHttpRequest()
      xhr.upload.addEventListener("progress", function(event) {
        updateUploadProgress(event, upload)
      })
      return xhr
    },
  })
  .success(function() {
    finishUpload(upload)
  })
  .error(function(request, status, error) {
    console.error("Unexpected error uploading photo")
    console.error(upload)
    console.error(error)
    alert("An unexpected error has occured. File named " + upload.original_name + " was not uploaded.")
  })
}

function updateUploadProgress(event, upload) {
  if (imageUploads[upload.index].status === UPLOAD_STATUS.FINISHED) {
    return
  } else {
    var progress = event.loaded / event.total
    progress = Math.floor(progress * 100)
    imageUploads[upload.index].progress = progress
    renderProgressBars()
  }
}

function finishUpload(upload) {
  imageUploads[upload.index].status = UPLOAD_STATUS.FINISHED
  renderProgressBars()
  toggleAddPhotoSubmitButtonActivationState()

  if (pendingImageUploadCount() == 0) {
    writeUploadDataToForm()
  }
}

function writeUploadDataToForm() {
  var data = imageUploads.map(function(datum) {
    return {
      name: datum.original_name,
      image_id: datum.uuid,
      extension: datum.extension,
    }
  })
  $("#photos-upload-data").val(JSON.stringify(data))
}

function upload(photo, presign_data) {
  return {
    original_name: photo.name,
    extension: getExtensionFromFile(photo),
    status: UPLOAD_STATUS.UPLOADING,
    uuid: presign_data.uuid,
    url: decodeURIComponent(presign_data.url),
    file: photo,
    progress: 0,
  }
}

function getExtensionFromFile(file) {
  if (file.name.split(".").length > 0) {
    return file.name.split(".")[file.name.split(".").length - 1]
  } else {
    return ""
  }
}

function pendingImageUploadCount() {
  return imageUploads.filter(uploadPending).length
}

function uploadPending(upload) {
  return upload && upload.status === UPLOAD_STATUS.UPLOADING
}

function renderProgressBars() {
  var html = ""
  for (var i in imageUploads) {
    var upload = imageUploads[i]
    html += progressBarHTMLForUpload(upload)
  }
  $("#upload-progress").html(html)
}

function progressBarHTMLForUpload(upload) {
  return uploadProgressPanelHTML.replace("{{ filename }}", upload.original_name)
                                .replace("{{ progress }}", imageUploadProgress(upload).toString())
                                .replace("{{ progress-description }}", imageUploadProgressDescription(upload))
}

function toggleAddPhotoSubmitButtonActivationState() {
  var submitButton = $("input#add-photos-submit-button")
  if (pendingImageUploadCount() == 0) {
    submitButton.prop("disabled", false)
    submitButton.val("Add Photos")
  } else {
    submitButton.prop("disabled", true)
    submitButton.val("Uploading")
  }
}

function imageUploadProgress(upload) {
  if (upload.status === UPLOAD_STATUS.UPLOADING) {
    return upload.progress
  } else {
    return 100
  }
}

function imageUploadProgressDescription(upload) {
  if (upload.status === UPLOAD_STATUS.UPLOADING) {
    return imageUploadProgress(upload) + "%"
  } else {
    return "Done"
  }
}

function addPhotosFileInputListener() {
  $("#add-photos-file-input").on("change", function(event) {
    event.preventDefault()
    uploadPhotos()
  })
}
$(document).ready(addPhotosFileInputListener)
$(document).on('page:load', addPhotosFileInputListener)
