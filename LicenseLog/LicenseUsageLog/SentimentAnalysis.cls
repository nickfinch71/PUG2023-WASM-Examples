 
 /*------------------------------------------------------------------------
    File        : SentimentAnalysis
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : nickf
    Created     : Tue Sep 12 12:25:35 BST 2023
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

CLASS SentimentAnalysis INHERITS Form: 
    
    DEFINE PRIVATE VARIABLE button1 AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE textBox1 AS System.Windows.Forms.TextBox NO-UNDO.

    CONSTRUCTOR PUBLIC SentimentAnalysis (  ):
        
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
	METHOD PRIVATE VOID button1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		DEFINE VARIABLE oClient   AS IHttpClient   NO-UNDO.
        DEFINE VARIABLE oRequest  AS IHttpRequest  NO-UNDO.
        DEFINE VARIABLE oResponse AS IHttpResponse NO-UNDO.
        DEFINE VARIABLE oPayload  AS JsonObject    NO-UNDO.
        DEFINE VARIABLE jsonParser AS ObjectModelParser NO-UNDO. 
        DEFINE VARIABLE oJson AS JsonObject NO-UNDO.
        DEFINE VARIABLE chSentiment AS CHARACTER NO-UNDO.
        
        
        oClient = ClientBuilder:Build():Client.

        oPayload = NEW JsonObject().
        oPayload:Add('sentence',textBox1:Text).

        oRequest = RequestBuilder:Post("http://localhost:3000/api/sentiment-analysis", oPayload):Request.
    
        oResponse = oClient:Execute(oRequest).
        DEFINE VARIABLE str AS CHARACTER NO-UNDO.
        
        DEFINE VARIABLE oReturnMemptrEntity AS OpenEdge.Core.Memptr NO-UNDO.
        DEFINE VARIABLE cRawBytes AS CHARACTER NO-UNDO.
        oReturnMemptrEntity = CAST(oResponse:Entity, OpenEdge.Core.Memptr).
        cRawBytes = oReturnMemptrEntity:GetString(1).
        
        jsonParser = NEW ObjectModelParser(). 
        ojson = CAST(jsonParser:Parse(cRawBytes),JsonObject).
        
        chSentiment = oJson:GetCharacter('sentiment').
        
        MESSAGE "Sentiment is " + chSentiment VIEW-AS ALERT-BOX.
        
		RETURN.

	END METHOD.

    METHOD PRIVATE VOID InitializeComponent(  ):
        
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:textBox1 = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:button1 = NEW System.Windows.Forms.Button().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* textBox1 */
        /*  */
        THIS-OBJECT:textBox1:Location = NEW System.Drawing.Point(59, 61).
        THIS-OBJECT:textBox1:Name = "textBox1".
        THIS-OBJECT:textBox1:Size = NEW System.Drawing.Size(486, 20).
        THIS-OBJECT:textBox1:TabIndex = 0.
        THIS-OBJECT:textBox1:Text = "Well this is very nice indeed".
        /*  */
        /* button1 */
        /*  */
        THIS-OBJECT:button1:Location = NEW System.Drawing.Point(326, 88).
        THIS-OBJECT:button1:Name = "button1".
        THIS-OBJECT:button1:Size = NEW System.Drawing.Size(218, 23).
        THIS-OBJECT:button1:TabIndex = 1.
        THIS-OBJECT:button1:Text = "button1".
        THIS-OBJECT:button1:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:button1:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:button1:Click:Subscribe(THIS-OBJECT:button1_Click).
        /*  */
        /* SentimentAnalysis */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(619, 413).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:button1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:textBox1).
        THIS-OBJECT:Name = "SentimentAnalysis".
        THIS-OBJECT:Text = "SentimentAnalysis".
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    DESTRUCTOR PUBLIC SentimentAnalysis ( ):

    END DESTRUCTOR.

END CLASS.