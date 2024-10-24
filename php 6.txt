<?php
require_once '../src/Reserva.php';
require_once '../src/db.php';

$reserva = new Reserva($conn);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['crear'])) {
        $reserva->crear($_POST['cliente_id'], $_POST['habitacion_id'], $_POST['fecha_inicio'], $_POST['fecha_fin'], $_POST['estado']);
    } elseif (isset($_POST['actualizar'])) {
        $reserva->actualizar($_POST['id'], $_POST['cliente_id'], $_POST['habitacion_id'], $_POST['fecha_inicio'], $_POST['fecha_fin'], $_POST['estado']);
    } elseif (isset($_POST['eliminar'])) {
        $reserva->eliminar($_POST['id']);
    }
}

$reservas = $reserva->obtenerTodas();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reservas</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Reservas</h1>
    <nav>
        <a href="index.php">Volver al Index</a>
    </nav>
    <form method="POST" action="reservas.php">
        <input type="hidden" name="id" id="reserva-id">
        <input type="number" name="cliente_id" placeholder="ID del Cliente" required>
        <input type="number" name="habitacion_id" placeholder="ID de la Habitación" required>
        <input type="date" name="fecha_inicio" placeholder="Fecha de Inicio" required>
        <input type="date" name="fecha_fin" placeholder="Fecha de Fin" required>
        <select name="estado" required>
            <option value="confirmada">Confirmada</option>
            <option value="pendiente">Pendiente</option>
            <option value="cancelada">Cancelada</option>
        </select>
        <button type="submit" name="crear">Crear</button>
        <button type="submit" name="actualizar">Actualizar</button>
    </form>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>ID Cliente</th>
                    <th>ID Habitación</th>
                    <th>Fecha de Inicio</th>
                    <th>Fecha de Fin</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($reservas as $reserva): ?>
                    <tr>
                        <td><?php echo $reserva['id']; ?></td>
                        <td><?php echo $reserva['cliente_id']; ?></td>
                        <td><?php echo $reserva['habitacion_id']; ?></td>
                        <td><?php echo $reserva['fecha_inicio']; ?></td>
                        <td><?php echo $reserva['fecha_fin']; ?></td>
                        <td><?php echo $reserva['estado']; ?></td>
                        <td>
                            <form method="POST" action="reservas.php" style="display:inline;">
                                <input type="hidden" name="id" value="<?php echo $reserva['id']; ?>">
                                <button type="submit" name="eliminar">Eliminar</button>
                            </form>
                            <button onclick="editarReserva(<?php echo $reserva['id']; ?>, <?php echo $reserva['cliente_id']; ?>, <?php echo $reserva['habitacion_id']; ?>, '<?php echo $reserva['fecha_inicio']; ?>', '<?php echo $reserva['fecha_fin']; ?>', '<?php echo $reserva['estado']; ?>')">Editar</button>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <script src="js/scripts.js"></script>
    <script>
        function editarReserva(id, cliente_id, habitacion_id, fecha_inicio, fecha_fin, estado) {
            document.getElementById('reserva-id').value = id;
            document.getElementsByName('cliente_id')[0].value = cliente_id;
            document.getElementsByName('habitacion_id')[0].value = habitacion_id;
            document.getElementsByName('fecha_inicio')[0].value = fecha_inicio;
            document.getElementsByName('fecha_fin')[0].value = fecha_fin;
            document.getElementsByName('estado')[0].value = estado;
        }
    </script>
</body>
</html>