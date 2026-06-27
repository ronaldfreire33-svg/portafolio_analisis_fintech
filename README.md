# Portafolio de Análisis de Datos en SQL - Sector Fintech

Este repositorio contiene el desarrollo de consultas SQL avanzadas para resolver problemas estratégicos de negocio en una plataforma Fintech. El objetivo es demostrar habilidades técnicas en la manipulación, agregación y optimización de datos estructurados para la toma de decisiones.

## Tecnologías Utilizadas
* **Lenguaje:** SQL (ANSI SQL / PostgreSQL compatible)
* **Conceptos Clave:** Agregaciones avanzadas, subconsultas (`NOT IN`), lógica condicional (`CASE WHEN`), filtrado de grupos (`HAVING`) y optimización de consultas (`LIMIT/OFFSET`).

## Preguntas de Negocio Resueltas

### 1. Análisis de Churn y Retención de Clientes
* **Problema:** Identificar usuarios activos en el mes previo (Abril) que no registraron actividad en el mes actual (Mayo) para medir el capital en riesgo.
* **Técnica:** Uso de `INNER JOIN` para asegurar actividad previa y una subconsulta con `NOT IN` para exclusión de usuarios reactivos.

### 2. Segmentación de Clientes por Ticket Promedio
* **Problema:** Clasificar usuarios según su ticket promedio de gasto en 2025, filtrando únicamente las cuentas de alto valor corporativo (>500 USD).
* **Técnica:** Uso de `GROUP BY` combinado con filtros agregados mediante `HAVING`.

### 3. Rendimiento de Depósitos y Retiros (Detección de Anomalías)
* **Problema:** Separar flujos de ingresos (positivos) y egresos (negativos) en columnas independientes por tipo de cuenta para auditoría de riesgo.
* **Técnica:** Implementación de agregación condicional con `SUM(CASE WHEN...)`.

### 4. Frecuencia de Transacciones y Clientes VIP
* **Problema:** Detectar usuarios con alta frecuencia operativa (>10 transacciones anuales) para campañas de fidelización.
* **Técnica:** Combinación de métricas de conteo (`COUNT`) y volumen monetario (`SUM`) bajo agrupaciones estrictas.

### 5. Paginación de Transacciones Críticas
* **Problema:** Extraer transacciones de alto riesgo (>10,000 USD) de forma paginada para optimizar el rendimiento de la interfaz web de auditoría.
* **Técnica:** Control de flujo mediante `ORDER BY`, `LIMIT` y cálculo dinámico de `OFFSET`.

---
*Este proyecto fue desarrollado bajo la simulación de requerimientos de negocio reales del sector financiero tecnológico.*
