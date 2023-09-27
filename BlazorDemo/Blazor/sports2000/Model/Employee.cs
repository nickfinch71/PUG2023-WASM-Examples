using System;

namespace sports2000.Model
{
  public class Employee
  {
    public int EmpNum { get; set; }
    public string LastName { get; set; }
    public string FirstName { get; set; }
    public string Address { get; set; }
    public string Address2 { get; set; }
    public string City { get; set; }
    public string State { get; set; }
    public string PostalCode { get; set; }
    public string HomePhone { get; set; }
    public string WorkPhone { get; set; }
    public string DeptCode { get; set; }
    public string Position { get; set; }
    public DateTime Birthdate { get; set; }
    public DateTime StartDate { get; set; }
    public int VacationDaysLeft { get; set; }
    public int SickDaysLeft { get; set; }

    public string FullName
    {
      get
      {
        return FirstName + " " + LastName;
      }
    }

    public int TotalDaysLeft
    {
      get
      {
        return VacationDaysLeft + SickDaysLeft;
      }
    }

    public int Age { 
      get { 
        return (new DateTime(1, 1, 1) + (DateTime.Now - Birthdate)).Year;
      } 
    }
        
  }
}
