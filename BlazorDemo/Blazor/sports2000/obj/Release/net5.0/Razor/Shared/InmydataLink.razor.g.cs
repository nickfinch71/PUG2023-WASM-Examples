#pragma checksum "D:\Workdir\BlazorDemo\Blazor\sports2000\Shared\InmydataLink.razor" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "6941bf2d30cfabe19f4ab35c638e1bb6bed51715"
// <auto-generated/>
#pragma warning disable 1591
namespace sports2000.Shared
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Components;
#nullable restore
#line 1 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using System.Net.Http;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using System.Net.Http.Json;

#line default
#line hidden
#nullable disable
#nullable restore
#line 3 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Microsoft.AspNetCore.Components.Forms;

#line default
#line hidden
#nullable disable
#nullable restore
#line 4 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Microsoft.AspNetCore.Components.Routing;

#line default
#line hidden
#nullable disable
#nullable restore
#line 5 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Microsoft.AspNetCore.Components.Web;

#line default
#line hidden
#nullable disable
#nullable restore
#line 6 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Microsoft.AspNetCore.Components.Web.Virtualization;

#line default
#line hidden
#nullable disable
#nullable restore
#line 7 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Microsoft.AspNetCore.Components.WebAssembly.Http;

#line default
#line hidden
#nullable disable
#nullable restore
#line 8 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Microsoft.JSInterop;

#line default
#line hidden
#nullable disable
#nullable restore
#line 9 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using sports2000;

#line default
#line hidden
#nullable disable
#nullable restore
#line 10 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using sports2000.Shared;

#line default
#line hidden
#nullable disable
#nullable restore
#line 11 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Radzen;

#line default
#line hidden
#nullable disable
#nullable restore
#line 12 "D:\Workdir\BlazorDemo\Blazor\sports2000\_Imports.razor"
using Radzen.Blazor;

#line default
#line hidden
#nullable disable
    public partial class InmydataLink : global::Microsoft.AspNetCore.Components.ComponentBase
    {
        #pragma warning disable 1998
        protected override void BuildRenderTree(global::Microsoft.AspNetCore.Components.Rendering.RenderTreeBuilder __builder)
        {
            __builder.OpenElement(0, "div");
            __builder.AddAttribute(1, "class", "alert alert-secondary mt-4");
            __builder.AddAttribute(2, "role", "alert");
            __builder.AddMarkupContent(3, "<span class=\"oi oi-pencil mr-2\" aria-hidden=\"true\"></span>\r\n    ");
            __builder.OpenElement(4, "strong");
#nullable restore
#line 3 "D:\Workdir\BlazorDemo\Blazor\sports2000\Shared\InmydataLink.razor"
__builder.AddContent(5, Title);

#line default
#line hidden
#nullable disable
            __builder.CloseElement();
            __builder.AddMarkupContent(6, "\r\n\r\n    ");
            __builder.AddMarkupContent(7, "<span class=\"text-nowrap\">\r\n        Check out this  \r\n        <a target=\"_blank\" class=\"font-weight-bold\" href=\"https://demo.inmydata.com\">cool app built with blazor</a></span>\r\n    and tell us what you think.\r\n");
            __builder.CloseElement();
        }
        #pragma warning restore 1998
#nullable restore
#line 12 "D:\Workdir\BlazorDemo\Blazor\sports2000\Shared\InmydataLink.razor"
       
    // Demonstrates how a parent component can supply parameters
    [Parameter]
    public string Title { get; set; }

#line default
#line hidden
#nullable disable
    }
}
#pragma warning restore 1591