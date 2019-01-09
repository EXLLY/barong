//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require dropify/src/js/dropify
//= require gt

window.dataLayer = window.dataLayer || [];
function gtag(){
  dataLayer.push(arguments)
}
function loadGtag(){
  var script = document.createElement('script');
  script.src = '//www.googletagmanager.com/gtag/js?id=UA-131801655-1';
  script.onload = function(){
    gtag('js', new Date());
    gtag('config', 'UA-131801655-1')
  };
  document.body.appendChild(script);
}

window.onload = function () {
  loadGtag();
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
/*
    var handler1 = function (captchaObj) {
        captchaObj.onReady(function () {
            $("#wait").hide();
        }).onSuccess(function (){
        var result = captchaObj.getValidate();
            if (!result) {
               return alert('Please conduct man-machine verification!')
            }
            $("#geetest_challenge").val(result.geetest_challenge);
            $("#geetest_validate").val(result.geetest_validate);
            $("#geetest_seccode").val(result.geetest_seccode);
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

function isaccepted(){
    if(document.getElementById("check_id").checked==true){
        document.getElementById("submit").disabled = false;
    }else{
        document.getElementById("submit").disabled = true;
    }*/
}