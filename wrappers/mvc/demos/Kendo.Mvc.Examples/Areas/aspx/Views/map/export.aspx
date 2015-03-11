<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/aspx/Views/Shared/Web.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
<div class="box">
    <h4>Export options</h4>
    <div class="box-col">
        <button class='export-pdf k-button'>Export as PDF</button>
    </div>
    <div class="box-col">
        <button class='export-img k-button'>Export as Image</button>
    </div>
    <div class="box-col">
        <button class='export-svg k-button'>Export as SVG</button>
    </div>
</div>
<div class="demo-section k-header" style="padding: 1em;">
<%: Html.Kendo().Map()
      .Name("map")
      .Center(30.2681, -97.7448)
      .Zoom(3)
      .Layers(layers =>
       {
           layers.Add()
              .Style(style => style.Fill(fill => fill.Opacity(0.7)))
              .Type(MapLayerType.Shape)
              .DataSource(dataSource => dataSource
                  .GeoJson()
                  .Read(read => read.Url(Url.Content("~/Content/dataviz/map/countries-users.geo.json")))
              );
       })
       .Events(events => events
           .ShapeCreated("onShapeCreated")
           .ShapeMouseEnter("onShapeMouseEnter")
           .ShapeMouseLeave("onShapeMouseLeave")
        )
%>
</div>

<!-- Load Pako ZLIB library to enable PDF compression -->
<script src="<%= Url.Content("~/Scripts/pako.min.js") %>"></script>

<!-- Chroma.js used to colorize the map in the demo -->
<script src="<%= Url.Content("~/Content/dataviz/map/js/chroma.min.js") %>"></script>

<script>
    $(".export-pdf").click(function () {
        // Convert the DOM element to a drawing using kendo.drawing.drawDOM
        kendo.drawing.drawDOM($(".demo-section"))
        .then(function (group) {
            // Render the result as a PDF file
            return kendo.drawing.exportPDF(group, {
                paperSize: "auto",
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
            });
        })
        .done(function (data) {
            // Save the PDF file
            kendo.saveAs({
                dataURI: data,
                fileName: "Map.pdf",
                proxyURL: "<%= Url.Action("Export_Save", "Map") %>"
            });
    });
    });

    $(".export-img").click(function () {
        // Convert the DOM element to a drawing using kendo.drawing.drawDOM
        kendo.drawing.drawDOM($(".demo-section"))
        .then(function (group) {
            // Render the result as a PNG image
            return kendo.drawing.exportImage(group);
        })
        .done(function (data) {
            // Save the image file
            kendo.saveAs({
                dataURI: data,
                fileName: "Map.png",
                proxyURL: "<%= Url.Action("Export_Save", "Map") %>"
            });
    });
    });

    $(".export-svg").click(function () {
        // Convert the DOM element to a drawing using kendo.drawing.drawDOM
        kendo.drawing.drawDOM($(".demo-section"))
        .then(function (group) {
            // Render the result as a SVG document
            return kendo.drawing.exportSVG(group);
        })
        .done(function (data) {
            // Save the SVG document
            kendo.saveAs({
                dataURI: data,
                fileName: "Map.svg",
                proxyURL: "<%= Url.Action("Export_Save", "Map") %>"
            });
    });
    });

    var scale = chroma
           .scale(["white", "green"])
           .domain([1, 1000]);

    function onShapeCreated(e) {
        var shape = e.shape;
        var users = shape.dataItem.properties.users;
        if (users) {
            var color = scale(users).hex();
            shape.options.fill.set("color", color);
        }
    }

    function onShapeMouseEnter(e) {
        e.shape.options.set("fill.opacity", 1);
    }

    function onShapeMouseLeave(e) {
        e.shape.options.set("fill.opacity", 0.7);
    }
</script>
</asp:Content>
