using System;
using System.Data;
using sports2000.Clients;

namespace TestProxy
{
  internal class Program
  {
    static void Main(string[] args)
    {
      var openEdgeClient = new OpenEdgeClient();
      if (openEdgeClient.Connect("http://localhost:8080/apsv", "", "", "", true))
      {
        var custs = openEdgeClient.GetCustomers();
        foreach(DataRow cust in custs.Tables[0].Rows)
        {
          Console.WriteLine(cust["Name"].ToString());
        }
        Console.WriteLine("Connected");
      }
      else
      {
        Console.WriteLine(openEdgeClient.connectError);
      };

      Console.WriteLine("Hello World!");
    }
  }
}
