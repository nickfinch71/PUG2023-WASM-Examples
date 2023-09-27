namespace sports2000.Clients
{

  using Progress.Open4GL;
  using Progress.Open4GL.Proxy;
  using sports2000crud;
  using sports2000crud.StrongTypesNS;
  using System;

  public class OpenEdgeClient
  {
    private Connection connection;
    private sports2000proxy sports2000Proxy; 
    
    public string connectError;

    public bool Connect(string url, string userid, string password, string appServerInfo, bool sessionFree)
    {
      connectError = "";
      connection = new Connection(url, userid, password, appServerInfo);
      RunTimeProperties.SetIntProperty("PROGRESS.Session.HttpTimeout", 86400);
      RunTimeProperties.SSLProtocols = "TLSv1.2";
      connection.SessionModel = sessionFree ? 1 : 0;
      try
      {
        sports2000Proxy = new sports2000proxy(connection);
      } catch(Exception e)
      {
        connectError = e.Message;
      }
      return Connected;
    }

    public bool Connected
    {
      get
      {
        if (sports2000Proxy != null && sports2000Proxy.isConnected()) return true;
        return false;
      }
    }

    public dsCustomerDataSet GetCustomers()
    {
      if (!Connected) throw new Exception("Appserver must be connected before running GetCustomers");
      dsCustomerDataSet dsCust;
      sports2000Proxy.GetCustomers(out dsCust);
      return dsCust;
    }

  }
}
