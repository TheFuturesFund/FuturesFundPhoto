var uploadProgressPanelHTML = "<div class=\"panel panel-default\"><div class=\"panel-heading\">Uploading \"{{ filename }}\"</div><div class=\"panel-body\"><div class=\"progress\"><div class=\"progress-bar progress-bar-striped active\" role=\"progressbar\" style=\"width: {{ progress }}%;\">{{ progress-description }}</div></div></div></div>"
var UPLOAD_STATUS = {
  UPLOADING: "uploading",
  FINISHED: "finished"
}
var imageUploads = []

function uploadFromEvent(event, status) {
  var detail = event.originalEvent.detail
  var uploadedBytes = 0
  var totalBytes = detail.file.size
  if (detail.progress) {
    uploadedBytes = detail.progress.loaded
    totalBytes = detail.progress.total
  } else if (status === UPLOAD_STATUS.FINISHED) {
    uploadedBytes = totalBytes
  }
  return {
    filename: detail.file.name,
    uploadedBytes: uploadedBytes,
    totalBytes: totalBytes,
    index: detail.index,
    status: status
  }
}

function updateImageUploadForEvent(event) {
  var upload = uploadFromEvent(event, UPLOAD_STATUS.UPLOADING)
  imageUploads[upload.index] = upload
  toggleAddPhotoSubmitButtonActivationState()
  renderProgressBars()
}

function finishImageUploadForEvent(event) {
  var upload = uploadFromEvent(event, UPLOAD_STATUS.FINISHED)
  imageUploads[upload.index] = upload
  toggleAddPhotoSubmitButtonActivationState()
  renderProgressBars()
}

function pendingImageUploadCount() {
  return imageUploads.filter(uploadPending).length
}

function uploadFinished(upload) {
  return upload && upload.status === UPLOAD_STATUS.FINISHED
}

function uploadPending(upload) {
  return upload && upload.status === UPLOAD_STATUS.UPLOADING
}

function totalImageUploadCount() {
  return imageUploads.length
}

function imageUploadProgress(upload) {
  return Math.ceil(100 * upload.uploadedBytes / upload.totalBytes)
}

function imageUploadProgressDescription(upload) {
  if (upload.status === UPLOAD_STATUS.UPLOADING) {
    return imageUploadProgress(upload).toString() + "%"
  } else {
    return "Done"
  }
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

function renderProgressBars() {
  var html = ""
  for (var i in imageUploads) {
    var upload = imageUploads[i]
    html += progressBarHTMLForUpload(upload)
  }
  $("#upload-progress").html(html)
}

function progressBarHTMLForUpload(upload) {
  return uploadProgressPanelHTML.replace("{{ filename }}", upload.filename)
                                .replace("{{ progress }}", imageUploadProgress(upload).toString())
                                .replace("{{ progress-description }}", imageUploadProgressDescription(upload))
}

$(function() {
  $(document).on("upload:start",    "form#add-photos-form", updateImageUploadForEvent);
  $(document).on("upload:progress", "form#add-photos-form", updateImageUploadForEvent);
  $(document).on("upload:success",  "form#add-photos-form", finishImageUploadForEvent);
});
