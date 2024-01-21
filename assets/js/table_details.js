document.addEventListener("DOMContentLoaded", function() {
  const clickHandler = function( entryId ) {

    const header = document.querySelector(`div.detail-box-header[data-entry-id="${entryId}"]`);
    const contentWrapper = document.querySelector(`div.detail-box-content-wrapper[data-entry-id="${entryId}"]`);

    header.classList.toggle("detail-box-element-detail-visible");
    contentWrapper.classList.toggle("detail-box-content-wrapper-hidden");

  }

  const dataRows = document.querySelectorAll("tr.data-row");
  // add a click listener to each header
  dataRows.forEach(function(dataRow) {
    const entryId = dataRow.dataset.entryId;
    dataRow.addEventListener("click", function( event ) {
      clickHandler(entryId);
    });
  });

  /*
  const headers = document.querySelectorAll("div.detail-box-header");
  // add a click listener to each header
  headers.forEach(function(header) {
    header.addEventListener("click", function() { clickHandler(header) });
  });
  */

  const contentWrappers = document.querySelectorAll("div.detail-box-content-wrapper");
  // add a click listener to each header
  contentWrappers.forEach(function(contentWrapper) {
    const entryId = contentWrapper.dataset.entryId;
    contentWrapper.addEventListener("click", function( event ) {
      clickHandler(entryId);
    });
  });

  const tagAnchors = document.querySelectorAll('tr a.tag');

  // Process each anchor tag
  tagAnchors.forEach(function(anchor) {
    anchor.addEventListener("click", function(event) {
      // do not bubble the click event up to the parent table row
      event.stopPropagation();
    });
  });



});
