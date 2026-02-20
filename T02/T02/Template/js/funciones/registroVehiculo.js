$(function () {
    $("#FormRegistroVe").validate({
        rules: {
            Marca: {
                required: true
            },
            Modelo: {
                required: true
            },
            Color: {
                required: true
            },
            Precio: {
                required: true,
                number: true, min: 0.01
            },
            IdVendedor: {
                required: true
            }
        },
        messages: {
            Marca: {
                required: "Campo requerido"
            },
            Modelo: {
                required: "Campo requerido"
            },
            Color: {
                required: "Campo requerido"
            },
            Precio: {
                required: "Campo requerido",
                number: "Debe ser numérico",
                min: "Debe ser mayor a 0"
            },
            IdVendedor: {
                required: "Campo requerido"
            }
        },

        errorElement: "span",
        errorClass: "text-light",
        errorPlacement: function (error, element) {
            error.insertAfter(element);
        },
        highlight: function (element) {
            $(element).addClass("is-invalid");
        },
        unhighlight: function (element) {
            $(element).removeClass("is-invalid");
        }
    });
});