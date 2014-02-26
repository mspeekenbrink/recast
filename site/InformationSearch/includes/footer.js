document.write('<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>\
<script>window.jQuery || document.write(\'<script src=\"../../js/vendor/jquery-1.9.1.min.js\"></script>\')</script>\
        <script src=\"../../bootstrap/js/bootstrap.min.js\"></script>\
        <script src=\"../../js/main.js\"></script>\
        <script src=\"../../js/vendor/jquery.shorten.1.0.js\"></script>\
        <script type=\"text/javascript\">\
<script type=\"text/javascript\">\
$(document).ready(function() {\
            var stickyNavTop = $(\'.navbar\').offset().top;\
            var stickyNav = function(){\
                var scrollTop = $(window).scrollTop();\
                if (scrollTop > stickyNavTop) {\
                    $(\'.navbar\').addClass(\'navbar-fixed-top\');\
                } else {\
                    $(\'.navbar\').removeClass(\'navbar-fixed-top\');\
                }\
            };\
            stickyNav();\
            $(window).scroll(function() {\
                stickyNav();\
            });\
});\
</script>');
