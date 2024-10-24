<?php
require_once '../src/Habitacion.php';
require_once '../src/db.php';

$habitacion = new Habitacion($conn);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['crear'])) {
        $habitacion->crear($_POST['numero'], $_POST['tipo'], $_POST['precio']);
    } elseif (isset($_POST['actualizar'])) {
        $habitacion->actualizar($_POST['id'], $_POST['numero'], $_POST['tipo'], $_POST['precio']);
    } elseif (isset($_POST['eliminar'])) {
        $habitacion->eliminar($_POST['id']);
    }
}

$habitaciones = $habitacion->obtenerTodas();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Habitaciones</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Habitaciones</h1>
    <nav>
        <a href="index.php">Volver al Index</a>
    </nav>
    <form method="POST" action="habitaciones.php">
        <input type="hidden" name="id" id="habitacion-id">
        <input type="text" name="numero" placeholder="Número" required>
        <input type="text" name="tipo" placeholder="Tipo" required>
        <input type="number" step="0.01" name="precio" placeholder="Precio" required>
        <button type="submit" name="crear">Crear</button>
        <button type="submit" name="actualizar">Actualizar</button>
    </form>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Número</th>
                    <th>Tipo</th>
                    <th>Precio</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($habitaciones as $habitacion): ?>
                    <tr>
                        <td><?php echo $habitacion['id']; ?></td>
                        <td><?php echo $habitacion['numero']; ?></td>
                        <td><?php echo $habitacion['tipo']; ?></td>
                        <td><?php echo $habitacion['precio']; ?></td>
                        <td>
                            <form method="POST" action="habitaciones.php" style="display:inline;">
                                <input type="hidden" name="id" value="<?php echo $habitacion['id']; ?>">
                                <button type="submit" name="eliminar">Eliminar</button>
                            </form>
                            <button onclick="editarHabitacion(<?php echo $habitacion['id']; ?>, '<?php echo $habitacion['numero']; ?>', '<?php echo $habitacion['tipo']; ?>', '<?php echo $habitacion['precio']; ?>')">Editar</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <script src="js/scripts.js"></script>
    <script>
        function editarHabitacion(id, numero, tipo, precio) {
            document.getElementById('habitacion-id').value = id;
            document.getElementsByName('numero')[0].value = numero;
            document.getElementsByName('tipo')[0].value = tipo;
            document.getElementsByName('precio')[0].value = precio;
        }
    </script>
</body>
</html>