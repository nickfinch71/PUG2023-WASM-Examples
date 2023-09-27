
/*
**
**    Created by PROGRESS ProxyGen (Progress Version 12.4) Fri Oct 15 16:40:08 UTC 2021
**
*/

//
// sports2000proxy
//


namespace sports2000crud
{
    using System;
    using Progress.Open4GL;
    using Progress.Open4GL.Exceptions;
    using Progress.Open4GL.Proxy;
    using Progress.Open4GL.DynamicAPI;
    using Progress.Common.EhnLog;
    using System.Collections.Specialized;
    using System.Configuration;

    /// <summary>
    /// 
    /// 
    /// 
    /// </summary>
    public class sports2000proxy : AppObject
    {
        private static int proxyGenVersion = 1;
        private const  int PROXY_VER = 5;

    // Create a MetaData object for each temp-table parm used in any and all methods.
    // Create a Schema object for each method call that has temp-table parms which
    // points to one or more temp-tables used in that method call.


	static DataSetMetaData GetCustomers_DSMetaData1;

	static DataTableMetaData GetCustomers_MetaData11;




        static sports2000proxy()
        {
		GetCustomers_DSMetaData1 = new DataSetMetaData(0, "dsCustomer", 1, ParameterSet.OUTPUT, "sports2000crud.StrongTypesNS.dsCustomerDataSet");
		GetCustomers_MetaData11 = new DataTableMetaData(0, "ttCustomer", 18, false, 1, "1,CustNum:CustNum", null, null, "sports2000crud.StrongTypesNS.dsCustomerDataSet+ttCustomerDataTable");
		GetCustomers_MetaData11.setFieldDesc(1, "CustNum", 0, Parameter.PRO_INTEGER, 0, 0, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(2, "Name", 0, Parameter.PRO_CHARACTER, 0, 2, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(3, "Address", 0, Parameter.PRO_CHARACTER, 0, 3, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(4, "Address2", 0, Parameter.PRO_CHARACTER, 0, 4, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(5, "City", 0, Parameter.PRO_CHARACTER, 0, 5, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(6, "State", 0, Parameter.PRO_CHARACTER, 0, 6, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(7, "Country", 0, Parameter.PRO_CHARACTER, 0, 1, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(8, "Phone", 0, Parameter.PRO_CHARACTER, 0, 9, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(9, "Contact", 0, Parameter.PRO_CHARACTER, 0, 8, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(10, "SalesRep", 0, Parameter.PRO_CHARACTER, 0, 10, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(11, "Comments", 0, Parameter.PRO_CHARACTER, 0, 15, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(12, "CreditLimit", 0, Parameter.PRO_DECIMAL, 0, 11, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(13, "Balance", 0, Parameter.PRO_DECIMAL, 0, 12, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(14, "Terms", 0, Parameter.PRO_CHARACTER, 0, 13, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(15, "Discount", 0, Parameter.PRO_INTEGER, 0, 14, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(16, "PostalCode", 0, Parameter.PRO_CHARACTER, 0, 7, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(17, "Fax", 0, Parameter.PRO_CHARACTER, 0, 16, 0, "", "", 0, null, "");
		GetCustomers_MetaData11.setFieldDesc(18, "EmailAddress", 0, Parameter.PRO_CHARACTER, 0, 17, 0, "", "", 0, null, "");
		GetCustomers_DSMetaData1.addDataTable(GetCustomers_MetaData11);


        }


    //---- Constructors
    public sports2000proxy(Connection connectObj) : this(connectObj, false)
    {       
    }
    
    // If useWebConfigFile = true, we are creating AppObject to use with Silverlight proxy
    public sports2000proxy(Connection connectObj, bool useWebConfigFile)
    {
        if (RunTimeProperties.DynamicApiVersion != PROXY_VER)
            throw new Open4GLException(WrongProxyVer);

        if ((connectObj.Url == null) || (connectObj.Url.Equals("")))
            connectObj.Url = "sports2000crud";

        if (useWebConfigFile == true)
            connectObj.GetWebConfigFileInfo("sports2000proxy");

        initAppObject("sports2000crud",
                        connectObj,
                        RunTimeProperties.tracer,
                        null, // requestID
                        proxyGenVersion);
    }
   
    public sports2000proxy(string urlString,
                        string userId,
                        string password,
                        string appServerInfo)
    {
        Connection connectObj;

        if (RunTimeProperties.DynamicApiVersion != PROXY_VER)
            throw new Open4GLException(WrongProxyVer);

        connectObj = new Connection(urlString,
                                    userId,
                                    password,
                                    appServerInfo);

        initAppObject("sports2000crud",
                        connectObj,
                        RunTimeProperties.tracer,
                        null, // requestID
                        proxyGenVersion);

        /* release the connection since the connection object */
        /* is being destroyed.  the user can't do this        */
        connectObj.ReleaseConnection();
    }


    public sports2000proxy(string userId,
                        string password,
                        string appServerInfo)
    {
        Connection connectObj;

        if (RunTimeProperties.DynamicApiVersion != PROXY_VER)
            throw new Open4GLException(WrongProxyVer);

        connectObj = new Connection("sports2000crud",
                                    userId,
                                    password,
                                    appServerInfo);

        initAppObject("sports2000crud",
                        connectObj,
                        RunTimeProperties.tracer,
                        null, // requestID
                        proxyGenVersion);

        /* release the connection since the connection object */
        /* is being destroyed.  the user can't do this        */
        connectObj.ReleaseConnection();
    }

    public sports2000proxy()
    {
        Connection connectObj;

        if (RunTimeProperties.DynamicApiVersion != PROXY_VER)
            throw new Open4GLException(WrongProxyVer);

        connectObj = new Connection("sports2000crud",
                                    null,
                                    null,
                                    null);

        initAppObject("sports2000crud",
                        connectObj,
                        RunTimeProperties.tracer,
                        null, // requestID
                        proxyGenVersion);

        /* release the connection since the connection object */
        /* is being destroyed.  the user can't do this        */
        connectObj.ReleaseConnection();

    }

        /// <summary>
	/// 
	/// </summary> 
	public string GetCustomers(out sports2000crud.StrongTypesNS.dsCustomerDataSet dsCustomer)
	{
		RqContext rqCtx = null;
		if (isSessionAvailable() == false)
			throw new Open4GLException(NotAvailable);

		Object outValue;
		ParameterSet parms = new ParameterSet(1);

		// Set up input parameters


		// Set up input/output parameters


		// Set up Out parameters
		parms.setDataSetParameter(1, null, ParameterSet.OUTPUT, "sports2000crud.StrongTypesNS.dsCustomerDataSet");


		// Setup local MetaSchema if any params are tables
		MetaSchema GetCustomers_MetaSchema = new MetaSchema();
		GetCustomers_MetaSchema.addDataSetSchema(GetCustomers_DSMetaData1, 1, ParameterSet.OUTPUT);


		// Set up return type
		

		// Run procedure
		rqCtx = runProcedure("GetCustomers.p", parms, GetCustomers_MetaSchema);


		// Get output parameters
		outValue = parms.getOutputParameter(1);
		dsCustomer = (sports2000crud.StrongTypesNS.dsCustomerDataSet)outValue;


		if (rqCtx != null) rqCtx.Release();

		if (parms.DataSetFillErrors > 0)
			throw new Open4GLException(38, new System.Object[]{parms.DataSetFillErrorString});


		// Return output value
		return (string)(parms.ProcedureReturnValue);

	}



    }
}

