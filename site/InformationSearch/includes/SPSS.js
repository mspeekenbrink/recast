// adapted from http://viralpatel.net/blogs/dynamically-shortened-text-show-more-link-jquery/
// $(document).ready(function() { var showChar = 100; var ellipsestext = "..."; var moretext = "more"; var lesstext = "less"; $('.more').each(function() { var content = $(this).html(); if(content.length > showChar) { var c = content.substr(0, showChar); var h = content.substr(showChar-1, content.length - showChar); var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>'; $(this).html(html); } }); $(".morelink").click(function(){ if($(this).hasClass("less")) { $(this).removeClass("less"); $(this).html(moretext); } else { $(this).addClass("less"); $(this).html(lesstext); } $(this).parent().prev().toggle(); $(this).prev().toggle(); return false; }); });
$(document).ready(
function() { 
    var showInstructions = "<p><a class=\"SPSSinstructionsButton\" href=\"#\">SPSS</a></p>"; 
    var closeInstructions = "<p><a class=\"SPSSinstructionsButton\" href=\"#\">Close SPSS</a></p>";
    $('.SPSSinstructions').each(function() {
        var instr = $(this).html();
        html = "<span class=\"SPSSinstructionsHidden"> + instr + "<\span>";
        $(this).html(html); 
    });
    $(".SPSSinstructionsButton").click(function(){ 
        if($(this).hasClass("SPSSinstructionsShown")) { 
            $(this).removeClass("SPSSinstructionsShown"); 
            $(this).html(showInstructions);
        } else { 
            $(this).addClass("SPSSinstructionsShown");
            $(this).html(closeInstructions); 
        } 
        $(this).parent().prev().toggle(); 
        $(this).prev().toggle(); 
        return false; 
    }); 
});
