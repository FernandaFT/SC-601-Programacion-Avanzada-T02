using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace T02.Models
{
    public class UsuarioModel
    {
        public long IdVendedor { get; set; }
        public string Cedula { get; set; }
        public string Nombre { get; set; }
        public string Correo { get; set; }
          
    }
}