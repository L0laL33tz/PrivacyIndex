document.addEventListener("DOMContentLoaded", function() {
  const clickHandler = function( entryId ) {

    const header = document.querySelector(`.row.row-meta[data-entry-id="${entryId}"]`);
    const contentWrapper = document.querySelector(`.row.row-detail[data-entry-id="${entryId}"]`);

    header.classList.toggle("row-detail-visible");
    contentWrapper.classList.toggle("row-detail-hidden");

  }

  const dataRows = document.querySelectorAll(".row.row-meta");
  // add a click listener to each header
  dataRows.forEach(function(dataRow) {
    const entryId = dataRow.dataset.entryId;
    dataRow.addEventListener("click", function( event ) {
      clickHandler(entryId);
      event.stopPropagation();
    });
  });

});
