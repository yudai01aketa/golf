//レスポンシブデザイン、スマホサイズ時のheader//
$(function() {
   const hum = $('#hamburger, .close')
   const nav = $('.sp-nav')
   hum.on('click', function(){
      nav.toggleClass('toggle');
   });
});

//コース個別ページの<続きを読む>//
$(function() {
  var textHeight = $('.text').height(),
    lineHeight = parseFloat($('.text').css('line-height')),
    lineNum = 4,
    textNewHeight = lineHeight * lineNum;
  if (textHeight > textNewHeight) {
    $('.text').css('height', textNewHeight);
    $('.readmore-btn').show();
    $('.readmore-btn').click(function() {
      $(this).hide();
      $('.text').css('height', textHeight);
      return false
    });
  };
});
