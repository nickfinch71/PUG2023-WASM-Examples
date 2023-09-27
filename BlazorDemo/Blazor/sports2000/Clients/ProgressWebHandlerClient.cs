using sports2000.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;

namespace sports2000.Clients
{
  public class ProgressWebHandlerClient
  {
    private readonly HttpClient _httpClient;

    // This is our constructor, we'll require a base address that tells us where the server is
    public ProgressWebHandlerClient(string baseAddress)
    {
      _httpClient = new HttpClient();
      _httpClient.BaseAddress = new Uri(baseAddress);
    }

    // call the GetEmployees and return a list of employee objects
    public async Task<List<Employee>> GetEmployees()
    {
      var data = await _httpClient.GetFromJsonAsync<Dictionary<string, Dictionary<string, List<Employee>>>>("employee");
      return data["dsEmployee"]["ttEmployee"];
    }

    // call the GetDepartments and return a list of department objects
    public async Task<List<Department>> GetDepartments()
    {
      var data = await _httpClient.GetFromJsonAsync<Dictionary<string, Dictionary<string, List<Department>>>>("department");
      return data["dsDepartment"]["ttDepartment"];
    }
  }
}
