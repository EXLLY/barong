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
        captchaObj.onReady(function () {
            $("#wait").hide();
        }).onSuccess(function (){
        var result = captchaObj.getValidate();
            console.log("== result geetest_challenge: " + result.geetest_challenge);
            if (!result) {
               return alert('Please conduct man-machine verification!')
                // e.preventDefault();
            }
            $("#geetest_challenge").val(result.geetest_challenge);
            $("#geetest_validate").val(result.geetest_validate);
            $("#geetest_seccode").val(result.geetest_seccode);
            console.log("== geetest_challenge: " + $("#geetest_challenge").val());
            $("#new_account").submit();
        });

        $('#log-in').click(function () {
            captchaObj.verify();
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
                product: "bind", // product：float，popup
                lang: 'en',
                width: "100%"
                // more configuration ：http://www.geetest.com/install/sections/idx-client-sdk.html#config
            }, handler1);
        }
    });
};
