using Microsoft.AspNetCore.Components;
using sports2000.Clients;
using sports2000.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace sports2000.Pages
{
  public partial class ListEmployees
  {
    private ProgressWebHandlerClient ProgressWebHandlerClient;
    private string errorMessage = null;
    private List<Employee> employees;
    private List<Department> departments;
    public string department = "[All]";

    protected async override Task OnInitializedAsync()
    {
      ProgressWebHandlerClient = new ProgressWebHandlerClient("http://localhost:8080/restWeb/web/");
      try
      {
        departments = await ProgressWebHandlerClient.GetDepartments();
        employees = await ProgressWebHandlerClient.GetEmployees();
      }
      catch (Exception ex)
      {
        errorMessage = ex.Message;
      }
    }
  }
}
