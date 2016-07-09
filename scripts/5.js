var isDescendant = function(parent, child) {
  var node = child.parentNode;
  while (node) {
    if (node == parent) {
      return true;
    }
    node = node.parentNode;
  }
  return false;
};

var collapseSiblings = function(el) {
  var parent = el.parentNode.parentNode;
  var detailses = parent.querySelectorAll('details');
  for (var i = 0; i < detailses.length; i++) {
    var details = detailses[i];
    if (details != el && !isDescendant(details, el) && details.open !== false) {
      details.open = false;
    }
  }
};

var attachNavigation = function() {
  var detailses = document.querySelectorAll('details');
  for (var i = 0; i < detailses.length; i++) {
    var details = detailses[i];
    details.querySelector('summary').onclick = function(evt) {
      var dets = this.parentNode;
      // The toggle event happens after!
      var isOpen = !dets.open;
      if (isOpen) {
        collapseSiblings(dets);
        //setUrl(dets.dataset.path);
      } else {
        //setUrl(parentPath(dets.dataset.path));
      }
      event.stopPropagation();
    };
  }
};

window.onload = function() {
  attachNavigation();
};

