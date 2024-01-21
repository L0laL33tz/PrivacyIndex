---
---
document.addEventListener("DOMContentLoaded", function() {

  const linkerFunction = function(type) {
    // Select all anchor tags with data-type="type"
    const typeAnchors = document.querySelectorAll(`a[data-type="${type}"]`);

    // Process each anchor tag
    typeAnchors.forEach(function(anchor) {
      const typeText = anchor.textContent;
      // double encode cause the path actually contains the url encoded text
      const escapedTypeText = encodeURIComponent(encodeURIComponent(typeText).toLowerCase());

      // Construct the href attribute based on the escaped type
      anchor.href = `{{ site.baseurl }}/${type}/` + escapedTypeText;

      // Add the 'typeText' class to the anchor
      anchor.className = type;
      anchor.addEventListener("click", function(event) {
        // do not bubble the click event up to the parent table row
        event.stopPropagation();
      });
    });
  };

  linkerFunction("tag");
  linkerFunction("glossary");
});
