window.addEventListener('message', event => {
  if (event.data.type == 'enableui') {
    if (event.data.enable) {
      document.documentElement.style.display = 'block'
      $('#name').val(event.data.playerName)
      $('.passport__field--signature').html(event.data.playerName)
    } else {
      document.documentElement.style.display = 'none'
      document.querySelector('form').reset()
      document.querySelector('.passport__field--signature').innerText = ''
      document.querySelector('.passport').classList.remove('passport--open')
    }
  }
})

$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
      $.post('https://NR_identity/close', JSON.stringify({

      }));
		}
	};
});