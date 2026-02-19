using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Linq;
using System.Web;

namespace T02.Models
{
    public class VehiculoModel
    {
        public int IdVehiculo {  get; set; }
        public string Marca { get; set; }
        public string Modelo { get; set; }
        public string Color { get; set; }
        public decimal Precio { get; set; }
        public int IdVendedor { get; set; }

        public List<SelectListItem> ListaVendedores { get; set; }
    }
}