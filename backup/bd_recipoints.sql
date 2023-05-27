
CREATE DATABASE IF NOT EXISTS `bd_recipoints`;
USE `bd_recipoints`;

CREATE TABLE IF NOT EXISTS `profile` (
  `idProfile` int NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL DEFAULT '',
  `segundo_nombre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT '',
  `apellido_paterno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL DEFAULT '',
  `apellido_materno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL DEFAULT '',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci NOT NULL DEFAULT '',
  `fecha_nacimiento` date NOT NULL,
  PRIMARY KEY (`idProfile`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Volcando datos para la tabla bd_recipoints.profile: ~2 rows (aproximadamente)
INSERT INTO `profile` (`idProfile`, `primer_nombre`, `segundo_nombre`, `apellido_paterno`, `apellido_materno`, `email`, `fecha_nacimiento`) VALUES
	(1, 'gayan', 'asdsad', 'asdasfasf', 'asdasda', 'asda@gasdas', '2023-05-27'),
	(2, 'cholin', 'asdasdasd', 'aweewq', '', 'asd@asdas', '2023-05-27');

-- Volcando estructura para tabla bd_recipoints.user
CREATE TABLE IF NOT EXISTS `user` (
  `iduser` int NOT NULL AUTO_INCREMENT,
  `codigo_uni` varchar(20) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `idProfile` int NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `codigo_uni` (`codigo_uni`),
  UNIQUE KEY `idProfile` (`idProfile`),
  CONSTRAINT `FK_user_profile` FOREIGN KEY (`idProfile`) REFERENCES `profile` (`idProfile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Volcando datos para la tabla bd_recipoints.user: ~0 rows (aproximadamente)


-- Volcando estructura para tabla bd_recipoints.characteristic
CREATE TABLE IF NOT EXISTS `characteristic` (
  `idCharacteristic` int NOT NULL AUTO_INCREMENT,
  `botellasAcumuladas` int NOT NULL,
  `botellasCanje` int NOT NULL,
  `valesAcumulados` int NOT NULL,
  `idUser` int NOT NULL,
  PRIMARY KEY (`idCharacteristic`),
  UNIQUE KEY `idUser` (`idUser`),
  CONSTRAINT `FK_characteristic_user` FOREIGN KEY (`idUser`) REFERENCES `user` (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;



-- Volcando estructura para tabla bd_recipoints.tienda
CREATE TABLE IF NOT EXISTS `tienda` (
  `idTienda` int NOT NULL AUTO_INCREMENT,
  `nombre_tienda` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `descripcion_tienda` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `ruc_tienda` int NOT NULL,
  `ubicacion` varchar(500) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `fanpage_tienda` varchar(500) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `email_tienda` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `state_tienda` tinyint(1) NOT NULL,
  PRIMARY KEY (`idTienda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Volcando datos para la tabla bd_recipoints.tienda: ~0 rows (aproximadamente)


-- Volcando estructura para tabla bd_recipoints.cupon
CREATE TABLE IF NOT EXISTS `cupon` (
  `idCupon` int NOT NULL AUTO_INCREMENT,
  `nombre_cupon` varchar(50) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `descripcion_cupon` varchar(200) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `nombre_producto_cupon` varchar(50) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `descuento` double(2,2) NOT NULL,
  `cantidad_total` int NOT NULL,
  `cantidad_disponible` int NOT NULL,
  `state_cupon` tinyint(1) NOT NULL,
  `tiempo_disponible` int NOT NULL,
  `idTienda` int NOT NULL,
  PRIMARY KEY (`idCupon`),
  KEY `FK_cupon_tienda` (`idTienda`),
  CONSTRAINT `FK_cupon_tienda` FOREIGN KEY (`idTienda`) REFERENCES `tienda` (`idTienda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Volcando estructura para tabla bd_recipoints.vale
CREATE TABLE IF NOT EXISTS `vale` (
  `idVale` int NOT NULL AUTO_INCREMENT,
  `enlace_qr` int NOT NULL,
  `idCupon` int NOT NULL,
  PRIMARY KEY (`idVale`),
  KEY `FK_vale_cupon` (`idCupon`),
  CONSTRAINT `FK_vale_cupon` FOREIGN KEY (`idCupon`) REFERENCES `cupon` (`idCupon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Volcando datos para la tabla bd_recipoints.vale: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bd_recipoints.change
CREATE TABLE IF NOT EXISTS `change` (
  `idChange` int NOT NULL AUTO_INCREMENT,
  `botella` int NOT NULL,
  `vale` int NOT NULL,
  `state_change` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idChange`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- Volcando datos para la tabla bd_recipoints.change: ~0 rows (aproximadamente)

-- Volcando datos para la tabla bd_recipoints.characteristic: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bd_recipoints.canje
CREATE TABLE IF NOT EXISTS `canje` (
  `idCanje` int NOT NULL AUTO_INCREMENT,
  `state_canje` tinyint(1) NOT NULL,
  `idVale` int NOT NULL,
  `idCharacteristic` int NOT NULL,
  PRIMARY KEY (`idCanje`),
  KEY `FK_canje_characteristic` (`idCharacteristic`),
  KEY `FK_canje_vale` (`idVale`),
  CONSTRAINT `FK_canje_characteristic` FOREIGN KEY (`idCharacteristic`) REFERENCES `characteristic` (`idCharacteristic`),
  CONSTRAINT `FK_canje_vale` FOREIGN KEY (`idVale`) REFERENCES `vale` (`idVale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;