
-- PROYECTO PORTAFOLIO: ANÁLISIS DE NEGOCIO FINTECH
-- Autor: 'Ronald_Freire'
-- Herramienta: SQL (PostgreSQL / MySQL)
-- ----------------------------------------------------------------------------
-- PREGUNTA 1: Análisis de Churn y Retención de Clientes
-- Objetivo: Identificar usuarios activos en Abril 2026 que abandonaron en Mayo 2026
-- y medir el capital en riesgo.
-- ----------------------------------------------------------------------------

SELECT 
    u.tipo_cuenta,
    SUM(t.monto) AS saldo_en_riesgo
FROM usuarios u
INNER JOIN transacciones t 
    ON u.id_usuario = t.id_usuario
WHERE t.fecha_transaccion BETWEEN '2026-04-01' AND '2026-04-30'
  AND u.id_usuario NOT IN (
      SELECT DISTINCT id_usuario 
      FROM transacciones 
      WHERE fecha_transaccion BETWEEN '2026-05-01' AND '2026-05-31'
  )
GROUP BY u.tipo_cuenta;


-- ----------------------------------------------------------------------------
-- PREGUNTA 2: Segmentación por Volumen de Transacciones (Ticket Promedio)
-- Objetivo: Mostrar el promedio por operación en 2025 para tipos de cuenta 
-- con un ticket promedio general superior a 500 USD.
-- ----------------------------------------------------------------------------

SELECT 
    u.tipo_cuenta, 
    AVG(t.monto) AS promedio_transaccionado
FROM usuarios u
INNER JOIN transacciones t
    ON u.id_usuario = t.id_usuario
WHERE t.fecha_transaccion BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY u.tipo_cuenta
HAVING AVG(t.monto) > 500
ORDER BY promedio_transaccionado DESC;


-- ----------------------------------------------------------------------------
-- PREGUNTA 3: Rendimiento de Depósitos y Retiros (Detección de Anomalías)
-- Objetivo: Separar flujos de ingresos (positivos) y egresos (negativos) 
-- por tipo de cuenta durante el Q1 2026 utilizando agregación condicional.
-- ----------------------------------------------------------------------------

SELECT
    u.tipo_cuenta,
    SUM(CASE WHEN t.monto > 0 THEN t.monto ELSE 0 END) AS total_depositado,
    SUM(CASE WHEN t.monto < 0 THEN t.monto ELSE 0 END) AS total_retirado
FROM usuarios u
INNER JOIN transacciones t
    ON u.id_usuario = t.id_usuario
WHERE t.fecha_transaccion BETWEEN '2026-01-01' AND '2026-03-31'
GROUP BY u.tipo_cuenta;


-- ----------------------------------------------------------------------------
-- PREGUNTA 4: Frecuencia de Transacciones y Clientes VIP
-- Objetivo: Identificar usuarios con alta frecuencia operativa (>10 transacciones)
-- en 2025 para campañas de fidelización.
-- ----------------------------------------------------------------------------

SELECT 
    u.id_usuario,
    u.tipo_cuenta,
    COUNT(t.id_transaccion) AS cantidad_transacciones,
    SUM(t.monto) AS monto_acumulado
FROM usuarios u
INNER JOIN transacciones t
    ON u.id_usuario = t.id_usuario
WHERE t.fecha_transaccion BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY u.id_usuario, u.tipo_cuenta
HAVING COUNT(t.id_transaccion) > 10
ORDER BY cantidad_transacciones DESC;


-- ----------------------------------------------------------------------------
-- PREGUNTA 5: Análisis de Paginación y Transacciones Críticas
-- Objetivo: Listar transacciones de alto riesgo (>10k USD) en 2025, de forma
-- paginada para optimizar el consumo de la interfaz (Página 3, bloque de 20).
-- ----------------------------------------------------------------------------

SELECT 
    id_transaccion, 
    monto, 
    id_usuario, 
    fecha_transaccion
FROM transacciones
WHERE monto > 10000
  AND fecha_transaccion BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY monto DESC
LIMIT 20 OFFSET 40;
