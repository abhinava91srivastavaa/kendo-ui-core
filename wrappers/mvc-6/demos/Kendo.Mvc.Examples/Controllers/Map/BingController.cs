﻿using Microsoft.AspNetCore.Mvc;

namespace Kendo.Mvc.Examples.Controllers
{
    public partial class MapController : Controller
    {
        [Demo]
        public IActionResult Bing()
        {
            return View();
        }
    }
}