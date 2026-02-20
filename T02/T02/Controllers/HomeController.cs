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
        public ActionResult RegistroVendedores(UsuarioModel model)
        {
            using (var context = new Practica2Entities())
            {
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
            //Si el binder no armó el modelo
            if (model == null)
            {
                model = new VehiculoModel();
                model.ListaVendedores = ObtenerVendedores();
                ModelState.AddModelError("", "No se recibieron datos del formulario.");
                return View(model);
            }

            //Validación (y recargar dropdown si se devuelve la vista)
            if (!ModelState.IsValid)
            {
                model.ListaVendedores = ObtenerVendedores();
                return View(model);
            }

            //Guarda
            using (var context = new Practica2Entities())
            {
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
                var lista = context.sp_ListarVehiculos()
                    .Select(x => new VehiculoConsultaModel
                    {
                        IdVehiculo = x.IdVehiculo,
                        Marca = x.Marca,
                        Modelo = x.Modelo,
                        Color = x.Color,
                        Precio = x.Precio,
                        Vendedor = x.Vendedor
                    }).ToList();

                return View(lista);
            }
        }
        #endregion
    }
}