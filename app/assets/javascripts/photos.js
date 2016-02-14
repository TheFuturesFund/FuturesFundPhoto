// MARK: Async uploads
$(function() {
  var uploadedImageFiles = 0
  var totalImageFiles = 0

  function updateUploadProgressLabel() {
    $("p#upload-progress-status").show()
    $("p#upload-progress-status").text("Uploaded " + uploadedImageFiles + "/" + totalImageFiles + " files.")
  }

  function toggleSubmitButtonActivationState() {
    var submitButton = $("input#add-photos-submit-button")
    if (uploadedImageFiles == totalImageFiles) {
      submitButton.prop("disabled", false)
      submitButton.val("Add Photos")
    } else {
      submitButton.prop("disabled", true)
      submitButton.val("Uploading")
    }
  }

  $(document).on("upload:start", "form#add-photos-form", function(e) {
    totalImageFiles++
    updateUploadProgressLabel()
    toggleSubmitButtonActivationState()
  });

  $(document).on("upload:success", "form#add-photos-form", function(e) {
    uploadedImageFiles++
    updateUploadProgressLabel()
    toggleSubmitButtonActivationState()
  });
});
