 using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using T02.EntityFramework;
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
        [ValidateAntiForgeryToken]
        public ActionResult RegistroVendedores(UsuarioModel model)
        {
            if (!ModelState.IsValid) return View(model);

            using (var context = new Practica2Entities())
            {
                bool existe = context.Vendedores.Any(v => v.Cedula == model.Cedula);

                if (existe)
                {
                    ModelState.AddModelError(nameof(model.Cedula), "La cédula ya está registrada.");
                    return View(model);
                }

                context.sp_RVendedor(model.Cedula, model.Nombre, model.Correo);
            }

            return RedirectToAction("RegistroVehiculos", "Home");

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
            using (var context = new Practica2Entities())
            {
                var vendedores = context.sp_LVendedores().ToList();

                return vendedores.Select(v => new SelectListItem
                {
                    Value = v.IdVendedor.ToString(),
                    Text = v.Nombre
                }).ToList();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RegistroVehiculos(VehiculoModel model)
        {
            using (var context = new Practica2Entities())
            {
                var marca = (model.Marca ?? "").Trim();

                int cantidad = context.Vehiculos.Count(v => v.Marca.Trim() == marca);

                if (cantidad >= 2)
                {
                    ModelState.AddModelError(nameof(model.Marca),
                        "No se pueden registrar más de 2 vehículos de la misma marca.");

                    model.ListaVendedores = ObtenerVendedores();
                    return View(model);
                }

                context.sp_RVehiculo(model.Marca, model.Modelo, model.Color, model.Precio, model.IdVendedor);
            }
            return RedirectToAction("ConsultaVehiculos", "Home");
        }
        #endregion

        #region Consultar Vehículos
        [HttpGet]
        public ActionResult ConsultaVehiculos()
        {
            using (var context = new Practica2Entities())
            {
                var lista = context.sp_ListarVehiculo()
                    .Select(x => new VehiculoConsultaModel
                    {
                        IdVehiculo = x.IdVehiculo,
                        Cedula = x.Cedula,
                        Marca = x.Marca,
                        Modelo = x.Modelo,
                        Precio = x.Precio,
                        Vendedor = x.Vendedor
                    }).ToList();

                return View(lista);
            }
        }
        #endregion
    }
}