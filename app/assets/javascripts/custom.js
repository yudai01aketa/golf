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

$(function() {
  $('.landnng-page').hide().fadeIn(1500);
});

$(function () {
    $(window).scroll(function () {
        const wHeight = $(window).height();
        const scrollAmount = $(window).scrollTop();
        $('#fadein').each(function () {
            const targetPosition = $(this).offset().top;
            if(scrollAmount > targetPosition - wHeight + 60) {
                $(this).addClass("fadeInDown");
            }
        });
    });
});
