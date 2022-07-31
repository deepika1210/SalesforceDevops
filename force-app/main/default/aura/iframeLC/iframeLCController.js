({
    myAction : function(component, event, helper) {
        var inp = component.find("input");
        var val = inp.get("v.value");
        //alert(val);
        var action = component.get("c.assignValue");
        action.setParams({
           "svr" : val
        });
        action.setCallback(this,function(response){
            var state = action.getState();
            if(state === "SUCCESS"){
                component.set("v.inptText",response.getReturnValue());  
               
            }
        });
        $A.enqueueAction(action);
        console.log( '$A.enqueueAction(action)' );
        // reload iframe on button click 

                 var d = new Date();
                 var n = d.getTime();   
				component.set("v.ifmsrc", 'https://mytrailhead1210-dev-ed.my.salesforce.com//apex/iframeLCVF?t='+ n );   
           
    }
})