$(function(){
     $("#apploader").on('mouseover',".android",function(){
        $(this).find(".androidCode").stop();
        $(this).find(".androidCode").css("display","block");
    }).on('mouseout','.android',function(){
        $(this).find(".androidCode").stop();
        $(this).find(".androidCode").css("display","none");
    })
    $("#apploader").on('mouseover',".ios",function(){
        $(this).find(".iosCode").stop();
        $(this).find(".iosCode").css("display","block");
    }).on('mouseout','.ios',function(){
        $(this).find(".iosCode").stop();
        $(this).find(".iosCode").css("display","none");
    })

        $(".apploader2").on("click",function(){
            $(".appzhezhao").slideDown();
        })
})