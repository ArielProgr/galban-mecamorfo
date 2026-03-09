# AGENT.md - Arquitectura del Orquestador Galban Mecamorfo

_Especificación técnica de la estructura, comunicación y ciclo de vida del agente principal._

---

## Visión General

Galban Mecamorfo opera como un **orquestador principal** que coordina múltiples subagentes especializados. El orquestador toma decisiones estratégicas, mientras que los subagentes ejecutan tareas tácticas específicas.

```
┌─────────────────────────────────────────────────────────────┐
│                    GALBAN MECAMORFO                         │
│                   (Orquestador Principal)                   │
│                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │ Planner     │  │ Memory      │  │ Controller  │         │
│  │ (Estrategia)│  │ (Shared)   │  │ (Ejecución) │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
└──────────────────────────┬──────────────────────────────────┘
                           │
           ┌───────────────┼───────────────┐
           ▼               ▼               ▼
    ┌───────────┐    ┌───────────┐    ┌───────────┐
    │ Subagente │    │ Subagente │    │ Subagente │
    │ OSINT     │    │ Scanner   │    │ Exploit   │
    └───────────┘    └───────────┘    └───────────┘
           │               │               │
           └───────────────┴───────────────┘
                           │
                    Memoria Compartida
                    (memory-lancedb-pro)
```

---

## Estructura Interna

### 1. Planner (Planificador)

**Responsabilidad:** Generar y adaptar el plan de ataque.

- Analiza el objetivo y alcance recibido
- Genera un plan de fases basado en Cyber Kill Chain
- Asigna prioridades a cada tarea
- Re-planifica dinámicamente según resultados

**Configuración:**
- `max_phases`: 7 (Cyber Kill Chain completo)
- `retry_on_failure`: true
- `adaptation_threshold`: 3 intentos fallidos por vector

### 2. Memory Manager (Gestor de Memoria)

**Responsabilidad:** Administrar la memoria compartida entre subagentes.

- Almacena hallazgos de cada fase
- Recupera información relevante para decisiones
- Coordina contexto entre subagentes
- Persiste conocimiento entre campañas

**Configuración:**
- `backend`: memory-lancedb-pro
- `scopes`: global, agent:<id>, campaign:<id>
- `retrieval`: hybrid (vector + BM25)
- `auto_recall`: true

### 3. Controller (Controlador)

**Responsabilidad:** Orquestar la ejecución de subagentes.

- Spawn subagentes según el plan
- Gestiona comunicación entre ellos
- Monitorea estado y progreso
- Maneja errores y reintentos
- Controla paralelización de tareas

**Configuración:**
- `max_concurrent_agents`: 5
- `agent_timeout`: 300s
- `spawn_strategy`: on-demand

---

## Parámetros de Configuración

### Alcance y Restricciones

```yaml
scope:
  allowed_targets: []        # IP/rangos permitidos
  denied_targets: []        # Excluidos explícitamente
  allowed_ports: [1-65535]   # Puertos permitidos
  allowed_techniques: all    # Técnicas permitidas
  max_concurrent: 5          # Máx. operaciones paralelas

risk:
  stealth_level: high        # high | medium | low
  detection_threshold: low   # Cuándo abortar por riesgo
  allowed_damage: minimal    # minimal | moderate | full
  can_escalate_privileges: true
  can_exfiltrate: true       # Solo si es objetivo
  can_persist: true
```

### Preferencias de Técnicas

```yaml
preferences:
  windows:
    - T1003 (LSASS dumping)
    - T1059 (PowerShell)
    - T1556 (Kerberoasting)
    - T1021 (RDP lateral)
  
  linux:
    - T1059 (Bash/Shell)
    - T1068 (Kernel exploits)
    - T1168 (Cron jobs)
    - T1021 (SSH lateral)
  
  web:
    - T1190 (SQLi)
    - T1189 (XSS)
    - T1056 (Command Injection)
    - T1005 (File Inclusion)
```

---

## Interfaces con OpenClaw

### Spawn de Subagentes

El orquestador utiliza la herramienta `sessions_spawn` de OpenClaw para crear subagentes:

```python
# Ejemplo de spawn
sessions_spawn(
    agentId="osint_agent",
    runtime="subagent",
    task="Recopilar información sobre objetivo: {target}",
    workspace="/workspace/galban/agents/osint"
)
```

### Herramientas Disponibles

El orquestador tiene acceso a:
- `web_search` - Búsqueda OSINT
- `browser` - Scraping activo
- `exec` - Ejecución de herramientas
- `sessions_spawn` - Crear subagentes
- `sessions_send` - Comunicar con subagentes
- `memory_search` / `memory_get` - Consultar memoria
- `write` - Guardar hallazgos

### Comunicación entre Subagentes

- **Directa:** sessions_send entre agentes
- **Indirecta:** Memoria compartida (findigs, contexto)
- **Eventos:** Notificaciones de hallazgos importantes

---

## Ciclo de Vida

### 1. Inicialización

```
Recibir objetivo → Verificar alcance → 
Cargar memoria previa → Inicializar planner →
Preparar entorno → Iniciar fase de reconocimiento
```

### 2. Ejecución de Fase

```
Obtener tareas de fase →
Para cada tarea:
  ├─ Spawn subagente apropiado
  ├─ Ejecutar tarea
  ├─ Almacenar resultados en memoria
  └─ Reportar al planner
Evaluar resultados →
Decidir: continuar | pivotar | завершить
```

### 3. Transición entre Fases

```
Verificar completitud de fase →
Si completas: siguiente fase
Si incompleto: reintentar o pivotar
Si todas las opciones agotadas: documentar y finalizar
```

### 4. Finalización

```
Ejecutar fase de limpieza →
Generar informe ejecutivo →
Generar informe técnico →
Almacenar en memoria →
Notificar al usuario
```

---

## Manejo de Errores

| Error | Acción |
|-------|--------|
| Subagente falla | Reintentar con otro agente o técnica |
| Vector bloqueado | Pivotar a siguiente vector |
| Detección (IDS) | Reducir sigilo, esperar, reintentar |
| Timeout | Abortar, documentar, continuar con siguiente |
| Sin acceso a memoria | Usar fallback a archivos locales |

---

## Métricas de Operación

- **Tiempo total de campaña**
- **Tiempo por fase**
- **Tasa de éxito por vector**
- **Veces detectado**
- **Accesos obtenidos**
- **Credenciales robadas**
- **Sistemas comprometidos**

---

_Este archivo define la arquitectura técnica de Galban Mecamorfo. La implementación específica de cada componente depende de las capacidades de OpenClaw y los subagentes disponibles._
