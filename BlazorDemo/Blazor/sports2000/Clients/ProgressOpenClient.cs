namespace sports2000.Clients
{

  using Progress.Open4GL;
  using Progress.Open4GL.Proxy;
  using sports2000crud;
  using sports2000crud.StrongTypesNS;
  using System;
  using System.Reflection;

  public class ProgressOpenClient
  {
    #region declarations
    // Define a connection object for the PAS, and a proxy object for my API
    private Connection connection;
    private sports2000proxy sports2000Proxy; 
    
    // We'll define a public string to hold any connect errors.
    public string connectError;
    #endregion

    #region Connect method
    // This is our connect method that will attempt to connect to the PAS
    public bool Connect(string url, string userid, string password, string appServerInfo, bool sessionFree)
    {
      // initailise the connection error
      connectError = "";
      // create the connection object using the details provided
      connection = new Connection(url, userid, password, appServerInfo);
      // set the session model on the connection object
      connection.SessionModel = sessionFree ? 1 : 0;
      
      try
      {
        // try and create a new proxy using the connection details
        // this will attempt the connection to the PAS and error if it fails
        sports2000Proxy = new sports2000proxy(connection);
      } catch(Exception e)
      {
        // the connection failed, stick the details in the errorMessage property
        connectError = GetFullErrorString(e);
      }
      return Connected;
    }
    #endregion

    #region Connected 
    public bool Connected
    {
      get
      {
        if (sports2000Proxy != null && sports2000Proxy.isConnected()) return true;
        return false;
      }
    }
    #endregion

    #region GetCustomers
    // This method will call the GetCustomers method on the proxy object
    public dsCustomerDataSet GetCustomers()
    {
      if (!Connected) throw new Exception("Appserver must be connected before running GetCustomers");
      dsCustomerDataSet dsCust;
      sports2000Proxy.GetCustomers(out dsCust);
      return dsCust;
    }
    #endregion

    #region GetFullErrorString
    public static string GetFullErrorString(Exception ex)
    {
      string errorString = "";

      errorString = errorString + "<p>";
      try
      {
        errorString = "Target = " + ex.TargetSite.Name + "</br>";
      }
      catch
      {
      }
      try
      {
        foreach (var ParameterInfo_loopVariable in ex.TargetSite.GetParameters())
        {
          ParameterInfo paraminfo = ParameterInfo_loopVariable;
          errorString = errorString + "Parameter: " + paraminfo.Name + " (" + paraminfo.ParameterType.FullName + ")" + @"</br>";
        }
      }
      catch
      {
      }
      errorString = errorString + "</p>";
      try
      {
        while (ex != null)
        {
          errorString = errorString + "<p><strong>Message: " + ex.Message + "</strong></br>" + "Stack Trace: " + ex.StackTrace + "</p>";
          ex = ex.InnerException;
        }
      }
      catch
      {
      }
      return errorString;
    }
    #endregion

  }
}
