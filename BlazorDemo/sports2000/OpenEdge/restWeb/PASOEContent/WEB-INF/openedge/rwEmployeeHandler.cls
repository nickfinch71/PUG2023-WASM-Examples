 
 /*------------------------------------------------------------------------
    File        : rwEmployeeHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : inmydata
    Created     : Wed Oct 12 10:04:46 BST 2022
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Web.WebResponseWriter.
USING OpenEdge.Net.HTTP.StatusCodeEnum.
USING OpenEdge.Web.WebHandler.
USING Progress.Json.ObjectModel.JsonObject.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS rwEmployeeHandler INHERITS WebHandler: 

    METHOD OVERRIDE PROTECTED INTEGER HandleNotAllowedMethod( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
        
        UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").

    END METHOD.

    METHOD OVERRIDE PROTECTED INTEGER HandleNotImplemented( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
        
        UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").

    END METHOD.

    
    DEFINE TEMP-TABLE ttEmployee LIKE Employee.
    DEFINE DATASET dsEmployee FOR ttEmployee.  
    
    /*------------------------------------------------------------------------------
            Purpose: Default handler for the HTTP GET method. The request being 
                     serviced and an optional status code is returned. A zero or 
                     null value means this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
     METHOD OVERRIDE PROTECTED INTEGER HandleGet( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
  
        DEFINE VARIABLE oBody          AS OpenEdge.Core.String            NO-UNDO.
        DEFINE VARIABLE oResponse      AS OpenEdge.Net.HTTP.IHttpResponse NO-UNDO.
        DEFINE VARIABLE oWriter        AS OpenEdge.Web.WebResponseWriter  NO-UNDO.
         
        DEFINE VARIABLE httEmployee    AS HANDLE                          NO-UNDO.
        DEFINE VARIABLE jsonoEmployee  AS JsonObject                      NO-UNDO.
         
        DEFINE VARIABLE lcjsonEmployee AS LONGCHAR                        NO-UNDO.
 
        EMPTY TEMP-TABLE ttEmployee.
        httEmployee = TEMP-TABLE ttEmployee:HANDLE.
 
        DEFINE DATA-SOURCE srcEmployee FOR Employee.
 
        BUFFER ttEmployee:ATTACH-DATA-SOURCE(DATA-SOURCE srcEmployee:HANDLE).
 
        DATASET dsEmployee:FILL().
 
        jsonoEmployee = NEW JsonObject().
        jsonoEmployee:Read(DATASET dsEmployee:HANDLE).         
                
        ASSIGN 
            oResponse = NEW OpenEdge.Web.WebResponse().                                              
             
        ASSIGN 
            lcjsonEmployee = jsonoEmployee:GetJsonText()
            oBody          = NEW OpenEdge.Core.String(lcjsonEmployee).                 
             
        ASSIGN
            oResponse:Entity        = jsonoEmployee //Could have used oBody here...
            oResponse:ContentType   = 'application/json':u
            oResponse:ContentLength = oBody:Size
            oResponse:StatusCode    = INTEGER(StatusCodeEnum:OK).            
             
        ASSIGN 
            oWriter = NEW WebResponseWriter(oResponse).
             
        oWriter:Open().
        oWriter:Close().     
 
        RETURN 0.
        
     END METHOD. 
     
     
       
    
END CLASS.