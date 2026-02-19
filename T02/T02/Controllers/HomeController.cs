using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using T02.Models;

namespace T02.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        #region Registro de Vendedores
        [HttpGet]
        public ActionResult RegistroVendedores()
        {
            return View();
        }

        [HttpPost]
        public ActionResult RegistroVendedores(UsuarioModel modelo)
        {
            return View();
        }
        #endregion

        #region Registro de Vehículos
        [HttpGet]
        public ActionResult RegistroVehiculos()
        {
            var model = new VehiculoModel();

            model.ListaVendedores = ObtenerVendedores();

            return View(model);
        }

        private List<SelectListItem> ObtenerVendedores()
        {
            // Esto normalmente viene de la base de datos
            return new List<SelectListItem>
            {
                new SelectListItem { Value = "1", Text = "Carlos Pérez" },
                new SelectListItem { Value = "2", Text = "Ana Rodríguez" },
                new SelectListItem { Value = "3", Text = "Luis Mora" }
            };
        }

        [HttpPost]
        public ActionResult RegistroVehiculos(VehiculoModel modelo)
        {
            return View();
        }
        #endregion

        #region Consultar Vehículos
        [HttpGet]
        public ActionResult ConsultaVehiculos()
        {
            return View();
        }

        #endregion
    }
}