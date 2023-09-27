 
/*------------------------------------------------------------------------
   File        : Form1
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : 
   Created     : 
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.
USING OpenEdge.Core.String.
USING OpenEdge.Net.HTTP.ClientBuilder.
USING OpenEdge.Net.HTTP.IHttpClient.
USING OpenEdge.Net.HTTP.IHttpRequest.
USING OpenEdge.Net.HTTP.RequestBuilder.
USING OpenEdge.Net.HTTP.IHttpResponse.
USING Progress.Json.ObjectModel.JsonObject.
USING Progress.Json.ObjectModel.*. 

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Form1 INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE btnGetLicenseUsage AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btnUpdate AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE txtLicenseCode AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE lblLicenseCode AS System.Windows.Forms.Label NO-UNDO.
		
    CONSTRUCTOR PUBLIC Form1 (  ):

        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:Add(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID btnGetLicenseUsage_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        DEFINE VARIABLE oRequest  AS IHttpRequest NO-UNDO.
        DEFINE VARIABLE oResponse AS IHttpResponse NO-UNDO.
        DEFINE VARIABLE jsonParser AS ObjectModelParser NO-UNDO. 
        DEFINE VARIABLE oJson AS JsonObject NO-UNDO.
        DEFINE VARIABLE dtLastAccess AS DATETIME NO-UNDO.
        DEFINE VARIABLE chUser AS CHARACTER NO-UNDO.

        oRequest = RequestBuilder:Get("http://localhost:3000/" + txtLicenseCode:Text):Request. 

        oResponse = ClientBuilder:Build():Client:Execute(oRequest).
        
        DEFINE VARIABLE str AS CHARACTER NO-UNDO.
        
        DEFINE VARIABLE oReturnMemptrEntity AS OpenEdge.Core.Memptr NO-UNDO.
        DEFINE VARIABLE cRawBytes AS CHARACTER NO-UNDO.
        oReturnMemptrEntity = CAST(oResponse:Entity, OpenEdge.Core.Memptr).
        cRawBytes = oReturnMemptrEntity:GetString(1).
        
        
        jsonParser = NEW ObjectModelParser(). 
        ojson = CAST(jsonParser:Parse(cRawBytes),JsonObject).
        
        dtLastAccess = oJson:GetDatetime('LastAccess').
        chUser = oJson:GetCharacter('Username').
        
        MESSAGE "Last access at " + STRING(dtLastAccess) + " by " + chUser VIEW-AS ALERT-BOX.
		
        RETURN.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID btnUpdate_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
        DEFINE VARIABLE oClient   AS IHttpClient   NO-UNDO.
        DEFINE VARIABLE oRequest  AS IHttpRequest  NO-UNDO.
        DEFINE VARIABLE oResponse AS IHttpResponse NO-UNDO.
        DEFINE VARIABLE oPayload  AS JsonObject    NO-UNDO.
		
		
        oClient = ClientBuilder:Build():Client.

        oPayload = NEW JsonObject().
        oPayload:Add('LastAccess',NOW).
        oPayload:Add('Username',OS-GETENV("username")).

        oRequest = RequestBuilder:Post("http://localhost:3000/" + txtLicenseCode:Text, oPayload)
                :Request.
        oResponse = oClient:Execute(oRequest).
		
        RETURN.

    END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:btnUpdate = NEW System.Windows.Forms.Button().
        THIS-OBJECT:txtLicenseCode = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lblLicenseCode = NEW System.Windows.Forms.Label().
        THIS-OBJECT:btnGetLicenseUsage = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* btnUpdate */
        /*  */
        THIS-OBJECT:btnUpdate:Location = NEW System.Drawing.Point(133, 112).
        THIS-OBJECT:btnUpdate:Name = "btnUpdate".
        THIS-OBJECT:btnUpdate:Size = NEW System.Drawing.Size(393, 23).
        THIS-OBJECT:btnUpdate:TabIndex = 0.
        THIS-OBJECT:btnUpdate:Text = "Update License Log".
        THIS-OBJECT:btnUpdate:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnUpdate:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnUpdate:Click:Subscribe(THIS-OBJECT:btnUpdate_Click).
        /*  */
        /* txtLicenseCode */
        /*  */
        THIS-OBJECT:txtLicenseCode:Location = NEW System.Drawing.Point(133, 86).
        THIS-OBJECT:txtLicenseCode:Name = "txtLicenseCode".
        THIS-OBJECT:txtLicenseCode:Size = NEW System.Drawing.Size(393, 20).
        THIS-OBJECT:txtLicenseCode:TabIndex = 1.
        THIS-OBJECT:txtLicenseCode:Text = "30C140B6-457E-4937-9EB6-A5D1FE6165C4".
        /*  */
        /* lblLicenseCode */
        /*  */
        THIS-OBJECT:lblLicenseCode:Location = NEW System.Drawing.Point(133, 63).
        THIS-OBJECT:lblLicenseCode:Name = "lblLicenseCode".
        THIS-OBJECT:lblLicenseCode:Size = NEW System.Drawing.Size(100, 17).
        THIS-OBJECT:lblLicenseCode:TabIndex = 2.
        THIS-OBJECT:lblLicenseCode:Text = "License Code".
        THIS-OBJECT:lblLicenseCode:UseCompatibleTextRendering = TRUE.
        /*  */
        /* btnGetLicenseUsage */
        /*  */
        THIS-OBJECT:btnGetLicenseUsage:Location = NEW System.Drawing.Point(133, 141).
        THIS-OBJECT:btnGetLicenseUsage:Name = "btnGetLicenseUsage".
        THIS-OBJECT:btnGetLicenseUsage:Size = NEW System.Drawing.Size(393, 23).
        THIS-OBJECT:btnGetLicenseUsage:TabIndex = 3.
        THIS-OBJECT:btnGetLicenseUsage:Text = "Get Last Usage".
        THIS-OBJECT:btnGetLicenseUsage:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btnGetLicenseUsage:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btnGetLicenseUsage:Click:Subscribe(THIS-OBJECT:btnGetLicenseUsage_Click).
        /*  */
        /* Form1 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(738, 420).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnGetLicenseUsage).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:lblLicenseCode).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txtLicenseCode).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnUpdate).
        THIS-OBJECT:Name = "Form1".
        THIS-OBJECT:Text = "Form1".
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC Form1 ( ):

    END DESTRUCTOR.

END CLASS.