document.addEventListener("DOMContentLoaded",function(){
    const aggressive = document.querySelector("input[name='aggressive']#aggressive");
    const export_aggressive = document.querySelector("input[type=submit]#export_aggressive");
    const export_detail = document.querySelector("input[type=submit]#export_detail");
    if (aggressive && export_aggressive && export_detail) {
        export_aggressive.addEventListener("click",function(e){
            aggressive.value = true;
        });
        export_detail.addEventListener("click",function(e){
            aggressive.value = false;
        });
    }
})