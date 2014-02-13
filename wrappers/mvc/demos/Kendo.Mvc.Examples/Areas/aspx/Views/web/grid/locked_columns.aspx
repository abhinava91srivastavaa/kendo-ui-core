<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
<%: Html.Kendo().Grid<Kendo.Mvc.Examples.Models.Order>()
    .Name("Grid")
    .Columns(columns =>
    {
        columns.Bound(o => o.OrderID).Width(120).Locked(true);
        columns.Bound(o => o.ShipCountry).Width(200);
        columns.Bound(o => o.ShipCity).Width(160);
        columns.Bound(o => o.ShipName).Width(200).Locked(true);
        columns.Bound(o => o.ShipAddress).Width(300);
    })
    .DataSource(dataSource => dataSource
        .Ajax()
        .PageSize(30)
        .Read(read => read.Action("LockedColumns_Read", "Grid"))
     )
    .Scrollable(scrollable => scrollable.Height(430))
    .Reorderable(reorderable => reorderable.Columns(true))
    .Resizable(resizable => resizable.Columns(true))
    .Pageable()
    .Filterable()
    .Sortable()
    .Groupable()
    .ColumnMenu()
%>
</asp:Content>
