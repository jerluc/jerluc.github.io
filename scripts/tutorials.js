var revealAnswers = function(parentId) {
  var parent = document.getElementById(parentId);
  var answers = parent.querySelectorAll('.answer');
  for (var i = 0; i < answers.length; i++) {
    answers[i].classList.remove('answer');
    answers[i].classList.add('answered');
  }
};
