({
	numberClicked : function(component, event, helper) {
        
        // Reset strInput and strOperator
        if(component.get("v.strOperator") === '='){
            component.set("v.strInput", "");
            component.set("v.strOperator", "NA");
        }
        
        // Get the clicked number and store it in strCurrentNumber
        let numClicked = event.target.innerText;
        component.set("v.strInput", component.get("v.strInput") + numClicked);
        let strCurrentNumber = component.get("v.strCurrentNumber");
        if(strCurrentNumber){
            component.set("v.strCurrentNumber", strCurrentNumber + numClicked);
        }else{
            component.set("v.strCurrentNumber", numClicked);
        }
	},
    
    calculate : function(component, event, helper) {
        let lstNumbers = component.get("v.lstNumbers");
        let result = 0;
        lstNumbers.push(Number(component.get("v.strCurrentNumber")));
        component.set("v.lstNumbers", lstNumbers);
        
        switch(component.get("v.strOperator")){
            case '+':
                for(let num of lstNumbers){
                    result = result + num;
                }
                break;
            case '-':
                result = lstNumbers[0];
                for(let i in lstNumbers){
                    if(i==0){
                        continue;
                    }
                    result = result - lstNumbers[i];
                }
                break;
            case '/':
                result = lstNumbers[0];
                for(let i in lstNumbers){
                    if(i==0){
                        continue;
                    }
                    result = result / lstNumbers[i];
                }
                break;
            case 'x':
                result = lstNumbers[0];
                for(let i in lstNumbers){
                    if(i==0){
                        continue;
                    }
                    result = result * lstNumbers[i];
                }
                break;
            default:
                component.set("v.result", 0);
                console.log("Invalid Operator");
        }
        component.set("v.result", result);
        component.set("v.lstNumbers", []);
        component.set("v.strCurrentNumber", "");
        component.set("v.strOperator", '=');
	},
    
    operatorClicked : function(component, event, helper) {
        let op = event.target.innerText;
        component.set("v.strInput", component.get("v.strInput") +' ' +op +' ');
        component.set("v.strOperator", op);
        
        let lstNumbers = component.get("v.lstNumbers");
        lstNumbers.push(Number(component.get("v.strCurrentNumber")));
        component.set("v.lstNumbers", lstNumbers);
        component.set("v.strCurrentNumber", "");
        
	},
    
    clearClicked : function(component, event, helper) {
        component.set("v.lstNumbers", []);
        component.set("v.strCurrentNumber", "");
        component.set("v.strInput", "");
		component.set("v.strOperator", "NA");
        component.set("v.result", 0);
	},
})