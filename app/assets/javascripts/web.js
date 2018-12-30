//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require dropify/src/js/dropify
//= require gt

window.onload = function () {
  $('.datepicker-toggle').datepicker();

  $('#send-code-btn').on('click', function () {
    $('.loader').css("display", "block");
    $('#send-code-btn').hide();
    number = $("#country_code").val() + $("#number").val();
    $.ajax({
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
      method:  'POST',
      data:    { number: number },
      url:     '/phones/verification',
      success: function(result){
         if (result.success){
           $('.loader').css("display", "none");
           $('#send-code-btn').show();
           $("#error").text('');
           $("#create-phone").prop('disabled', false);
           $("#send-code-btn").text('Resend');
         } else {
           $('.loader').css("display", "none");
           $('#send-code-btn').show();
           $("#error").text(result.error);
         }
      }
    });
  });

  $('.dropify').dropify({
      tpl: {
          message:  '<div class="dropify-message"> <p>{{ default }}</p> </div>',
      }
  });
    var handler1 = function (captchaObj) {
        $('#log-in').click(function (e) {
            var result = captchaObj.getValidate();
            console.log("== result: " + result);
            if (!result) {
                alert('Please conduct man-machine verification!')
                e.preventDefault();
            }
        });
        // Add the captcha to the element with the id captcha, and there are three input values for the form submission
        captchaObj.appendTo("#captcha1");
        captchaObj.onReady(function () {
            $("#wait1").hide();
        });
        // more configuration：http://www.geetest.com/install/sections/idx-client-sdk.html
    };
    $.ajax({
        url: "/gee_test_register?t=" + (new Date()).getTime(), // add random numbers to prevent caching
        type: "get",
        dataType: "json",
        success: function (data) {
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                new_captcha: data.new_captcha, // an outage of a new captcha is indicated when used for an outage
                offline: !data.success,
                product: "popup", // product：float，popup
                lang: 'en',
                width: "100%"
                // more configuration ：http://www.geetest.com/install/sections/idx-client-sdk.html#config
            }, handler1);
        }
    });
};
