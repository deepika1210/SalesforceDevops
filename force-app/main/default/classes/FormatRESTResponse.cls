global class FormatRESTResponse {
   public static blob formatResponse(ResponseBase ResponseBaseObj,String contentType){
        String response;
        String strContectType = contentType.toUpperCase();
        if(strContectType.contains('XML')){
            response = serializeRespinseBaseXml(ResponseBaseObj);
        }    
        else {
            response = JSON.serialize(ResponseBaseObj);
        }
        return blob.valueOf(response);
    }
    public static string serializeRespinseBaseXml(ResponseBase ResponseBaseObj ){
        String responseXML = '';
        responseXML  += '<response>';
        XmlStreamWriter w = new XmlStreamWriter();
        w.writeStartElement(null , 'Message', null );
        w.writeCharacters(ResponseBaseObj.Message);
        w.writeEndElement();
        
        w.writeStartElement(null , 'Success', null );
        w.writeCharacters(String.valueOf(ResponseBaseObj.Success));
        w.writeEndElement();
        responseXML += '</response>';
        String xmlOutput = '<?xml version="1.0" encoding="UTF-8"?>' + '<Response>' + w.getXmlString() 
            + '</Response>';
        w.close();
        return xmlOutput ;
    }

    global class ResponseBase {
        global Boolean Success {get;set;}
        global String Message  {get;set;}
        global ResponseBase(){
                success = true;
                message = 'Records are updated';
        }
    }
}