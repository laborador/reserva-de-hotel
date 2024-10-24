function editarCliente(id, nombre, apellido, email, telefono) {
    document.getElementById('cliente-id').value = id;
    document.getElementsByName('nombre')[0].value = nombre;
    document.getElementsByName('apellido')[0].value = apellido;
    document.getElementsByName('email')[0].value = email;
    document.getElementsByName('telefono')[0].value = telefono;
}