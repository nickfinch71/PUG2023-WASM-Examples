 
 /*------------------------------------------------------------------------
    File        : rwDepartmentHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : nick
    Created     : Thu Oct 28 17:04:32 UTC 2021
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Web.WebResponseWriter.
USING OpenEdge.Net.HTTP.StatusCodeEnum.
USING OpenEdge.Web.WebHandler.
USING Progress.Json.ObjectModel.JsonObject.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS rwDepartmentHandler INHERITS WebHandler: 

    METHOD OVERRIDE PROTECTED INTEGER HandleNotAllowedMethod( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
        
        UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").

    END METHOD.

    METHOD OVERRIDE PROTECTED INTEGER HandleNotImplemented( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
        
        UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").

    END METHOD.

    
    
    /*------------------------------------------------------------------------------
            Purpose: Default handler for the HTTP GET method. The request being 
                     serviced and an optional status code is returned. A zero or 
                     null value means this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    DEFINE TEMP-TABLE ttDepartment LIKE Department.  
    DEFINE DATASET dsDepartment FOR ttDepartment.  
 
    METHOD OVERRIDE PROTECTED INTEGER HandleGet( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
  
        DEFINE VARIABLE oBody          AS OpenEdge.Core.String            NO-UNDO.
        DEFINE VARIABLE oResponse      AS OpenEdge.Net.HTTP.IHttpResponse NO-UNDO.
        DEFINE VARIABLE oWriter        AS OpenEdge.Web.WebResponseWriter  NO-UNDO.
         
        DEFINE VARIABLE httDepartment    AS HANDLE                          NO-UNDO.
        DEFINE VARIABLE jsonoDepartment  AS JsonObject                      NO-UNDO.
         
        DEFINE VARIABLE lcjsonDepartment AS LONGCHAR                        NO-UNDO.
 
        EMPTY TEMP-TABLE ttDepartment.
        httDepartment = TEMP-TABLE ttDepartment:HANDLE.
 
        DEFINE DATA-SOURCE srcDepartment FOR Department.
 
        BUFFER ttDepartment:ATTACH-DATA-SOURCE(DATA-SOURCE srcDepartment:HANDLE).
 
        DATASET dsDepartment:FILL().
 
        jsonoDepartment = NEW JsonObject().
        jsonoDepartment:Read(DATASET dsDepartment:HANDLE).         
                
        ASSIGN 
            oResponse = NEW OpenEdge.Web.WebResponse().                                              
             
        ASSIGN 
            lcjsonDepartment = jsonoDepartment:GetJsonText()
            oBody          = NEW OpenEdge.Core.String(lcjsonDepartment).                 
             
        ASSIGN
            oResponse:Entity        = jsonoDepartment //Could have used oBody here...
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