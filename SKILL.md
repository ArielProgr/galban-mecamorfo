# SKILL.md - Catálogo de Habilidades

_Repositorio de técnicas, vectores y procedimientos que Galban Mecamorfo puede ejecutar._

---

## Índice

1. [Fase 1: Reconocimiento](#fase-1-reconocimiento)
2. [Fase 2: Escaneo y Enumeración](#fase-2-escaneo-y-enumeración)
3. [Fase 3: Obtención de Acceso Inicial](#fase-3-obtención-de-acceso-inicial)
4. [Fase 4: Mantenimiento del Acceso](#fase-4-mantenimiento-del-acceso)
5. [Fase 5: Movimiento Lateral](#fase-5-movimiento-lateral)
6. [Fase 6: Post-Explotación](#fase-6-post-explotación)
7. [Fase 7: Generación de Informe](#fase-7-generación-de-informe)

---

## Fase 1: Reconocimiento

### OSINT Pasivo

#### 1.1 Búsqueda de Información Pública

| Habilidad | Descripción |
|-----------|-------------|
| `osint_whois` | Consulta WHOIS para obtener registrant, fechas, DNS |
| `osint_dns` | Enumeración de registros DNS (A, AAAA, MX, TXT, CNAME) |
| `osint_social` | Búsqueda en redes sociales por empleados, tecnologias |
| `osint_leaked` | Busca credenciales filtradas en breach databases |
| `osint_google` | Google Dorks para encontrar documentos sensibles |
| `osint_shibe` | Búsqueda en Shodan, Censys por infraestructura expuesta |
| `osint_github` | Busca repositorios públicos con código sensible |

**Herramientas:** theHarvester, Holehe, Sherlock, Amass, sublist3r

**Requisitos previos:** Solo acceso a internet pública, sin interacción con objetivo

#### 1.2 fingerprinting pasivo

| Habilidad | Descripción |
|-----------|-------------|
| `PassiveHttpFingerprint` | Identificar tecnologías via headers, certificados |
| `PassiveSslFingerprint` | Análisis de certificados SSL/TLS |

**Herramientas:** Wappalyzer (API), WhatWeb

---

## Fase 2: Escaneo y Enumeración

### 2.1 Descubrimiento de Activos

| Habilidad | Descripción |
|-----------|-------------|
| `scan_network_discovery` | Descubrir hosts vivos en red (ARP, ICMP, TCP) |
| `scan_port_scan` | Enumerar puertos abiertos en objetivo |
| `scan_service_enum` | Identificar servicios y versiones |
| `scan_os_detection` | Detectar sistema operativo (fingerprinting) |
| `scan_topology` | Mapear red interna |

**Herramientas:** Nmap, Masscan, Netdiscover

**Parámetros:** 
- `timing`: T0-T5 (T3 para sigilo)
- `port_range`: según alcance

### 2.2 Enumeración Específica

| Habilidad | Descripción |
|-----------|-------------|
| `enum_smb` | Enumerar SMB (shares, users, policies) |
| `enum_ldap` | Enumerar LDAP/Active Directory |
| `enum_dns` | Transferencias de zona, fuzzing de subdominios |
| `enum_http` | Enumerar directorios, parámetros, tecnologías web |
| `enum_smtp` | Enumerar usuarios via SMTP |
| `enum_snmp` | Extraer info via SNMP |

**Herramientas:** enum4linux, ldapsearch, DNSenum, Gobuster, Ffuf

---

## Fase 3: Obtención de Acceso Inicial

### 3.1 Explotación Web

| Habilidad | Descripción |
|-----------|-------------|
| `exploit_sqli` | SQL Injection (blind, time-based, union-based) |
| `exploit_xss` | Cross-Site Scripting (reflected, stored, DOM) |
| `exploit_csrf` | Cross-Site Request Forgery |
| `exploit_lfi` | Local File Inclusion / Directory Traversal |
| `exploit_rfi` | Remote File Inclusion |
| `exploit_ssrf` | Server-Side Request Forgery |
| `exploit_cmdi` | Command Injection |
| `exploit_xxe` | XML External Entity |
| `exploit_auth` | Bypass de autenticación, fuerza bruta |
| `exploit_api` | Hacking de APIs REST/GraphQL |

**Herramientas:** sqlmap, XSSer, Commix, SSRFmap, GF patterns

**Variantes:**
- `exploit_sqli_boolean` - Blind SQLi
- `exploit_sqli_time` - Time-based SQLi
- `exploit_sqli_union` - Union-based SQLi

### 3.2 Explotación de Servicios

| Habilidad | Descripción |
|-----------|-------------|
| `exploit_smb` | EternalBlue, SMB exploits |
| `exploit_ssh` | Fuerza bruta, claves privadas |
| `exploit_ftp` | Anon access, fuerza bruta |
| `exploit_rdp` | BlueKeep, fuerza bruta |
| `exploit_vnc` | Conexiones VNC sin auth |
| `exploit_mysql` | RCE en MySQL |
| `exploit_postgres` | RCE en PostgreSQL |

**Herramientas:** Metasploit, searchsploit, payloads personalizados

### 3.3 Ingeniería Social

| Habilidad | Descripción |
|-----------|-------------|
| `phishing_email` | Crear y enviar emails de phishing |
| `phishing_clone` | Clonar páginas legítimas |
| `phishing_sms` | Smishing |
| `social_linkedin` | Perfiles falsos en LinkedIn |

**Nota:** Requiere autorización específica en alcance

---

## Fase 4: Mantenimiento del Acceso

### 4.1 Persistencia en Windows

| Habilidad | Descripción |
|-----------|-------------|
| `persist_registry` | Claves en Run/RunOnce |
| `persist_service` | Crear servicio malicioso |
| `persist_scheduled` | Tareas programadas |
| `persist_wmi` | Suscripciones WMI persistentes |
| `persist_autorun` | Keys de ejecución automática |
| `persist_lsass` | Persistencia via LSASS |
| `persist_golden_ticket` | Golden Ticket Kerberos |

**Herramientas:** Metasploit, Cobalt Strike, scripts personalizados

### 4.2 Persistencia en Linux/Unix

| Habilidad | Descripción |
|-----------|-------------|
| `persist_cron` | Tareas cron |
| `persist_systemd` | Servicio systemd |
| `persist_ssh_key` | Clave SSH autorizada |
| `persist_bashrc` | Comandos en .bashrc |
| `persist_web_shell` | Web shell |
| `persist_backdoor` | Backdoor en servicio existente |

### 4.3 Evasión de Detección

| Habilidad | Descripción |
|-----------|-------------|
| `evasion_encrypt` | Cifrar payloads |
| `evasion_obfuscate` | Ofuscar código |
| `evasion_morph` | Metamorphic payloads |
| `evasion_av_bypass` | Técnicas anti-antivirus |
| `evasion_edr_bypass` | Evasión de EDR |
| `evasion_network` | Técnicas de分割 tráfico |

---

## Fase 5: Movimiento Lateral

### 5.1 Windows Lateral

| Habilidad | Descripción |
|-----------|-------------|
| `lateral_pth` | Pass-the-Hash |
| `lateral_ptt` | Pass-the-Ticket (Kerberos) |
| `lateral_rdp` | RDP a otro sistema |
| `lateral_wmi` | WMI exec |
| `lateral_winrm` | WinRM |
| `lateral_smb` | PsExec, smbexec |
| `lateral_kerberoast` | Kerberoasting |
| `lateral_golden` | Golden/Silver Ticket |

### 5.2 Linux Lateral

| Habilidad | Descripción |
|-----------|-------------|
| `lateral_ssh` | SSH con credenciales/keys |
| `lateral_scp` | SCP para transferir archivos |
| `lateral_ansible` | Abuse de Ansible |
| `lateral_docker` | Escape de Docker |

---

## Fase 6: Post-Explotación

### 6.1 Escalada de Privilegios

| Habilidad | Descripción |
|-----------|-------------|
| `privesc_linux_kernel` | Exploits de kernel Linux |
| `privesc_linux_sudo` | Abuso de sudo |
| `privesc_linux_suid` | SUID misconfigurations |
| `privesc_linux_capabilities` | Capabilities abusables |
| `privesc_windows_kernel` | Exploits de kernel Windows |
| `privesc_windows_service` | Service misconfigurations |
| `privesc_windows_dll` | DLL hijacking |
| `privesc_always_install` | Always Install Elevated |
| `privesc_uac` | Bypass UAC |

**Herramientas:** LinPEAS, WinPEAS, linux-exploit-suggester

### 6.2 Robo de Credenciales

| Habilidad | Descripción |
|-----------|-------------|
| `creds_lsass` | Dump LSASS |
| `creds_sam` | Dump SAM database |
| `creds_lsa` | Credential LSA Secrets |
| `creds_browser` | Chrome, Firefox, Edge |
| `creds_ssh` | Claves SSH |
| `creds_putty` | Sesiones PuTTY |
| `creds_wifi` | Contraseñas WiFi |
| `creds_ntlm` | Hashes NTLM |
| `creds_kerberos` | TGT/Tickets Kerberos |

**Herramientas:** Mimikatz, LaZagne, Sally

### 6.3 Exfiltración

| Habilidad | Descripción |
|-----------|-------------|
| `exfil_http` | Exfiltrar via HTTP |
| `exfil_dns` | Exfiltrar via DNS |
| `exfil_icmp` | Exfiltrar via ICMP |
| `exfil_ftp` | FTP |
| `exfil_cloud` | Dropbox, Google Drive |

**Nota:** Solo si está en el alcance

---

## Fase 7: Generación de Informe

### 7.1 Documentación Automática

| Habilidad | Descripción |
|-----------|-------------|
| `report_findings` | Documentar hallazgos por fase |
| `report_evidence` | Recopilar evidencias |
| `report_screenshot` | Capturas de pantalla |
| `report_executive` | Generar informe ejecutivo |
| `report_technical` | Generar informe técnico |
| `report_recommendations` | Recomendaciones de remediación |

### 7.2 Formatos de Salida

- **Markdown** - Documentación editable
- **HTML** - Reporte visual
- **JSON** - Datos estructurados para integración
- **PDF** - Reporte formal

---

## Métricas de Éxito por Habilidad

| Categoría | Indicador de Éxito |
|-----------|-------------------|
| OSINT | Información recopilada sin detección |
| Escaneo | Puertos/servicios identificados |
| Explotación | Shell obtenidot shell |
| Persistencia | Acceso survive reinicio |
| Lateral | Nuevo sistema comprometido |
| Privesc | Elevación a SYSTEM/root |
| Creds | Credenciales válidas obtenidas |
| Exfil | Datos extraídos exitosamente |

---

## Dependencias y Requisitos

### Herramientas Requeridas en Entorno

```bash
# Escaneo y enumeración
nmap, masscan, netdiscover, enum4linux, ldapsearch

# Explotación
metasploit-framework, sqlmap, commix, xssser
searchsploit, nikto, gobuster, ffuf

# Post-explotación
mimikatz, linpeas, winpeas, laZagne

# Utilidades
curl, wget, nc, socat, proxychains
```

### Habilidades que Requieren Credenciales

- `exploit_ssh` - Credenciales o ключ
- `lateral_*` - Credenciales válidas
- `creds_*` - Acceso privilegiado
- `privesc_*` - Acceso inicial

---

## Selección Dinámica de Técnicas

El orquestador debe seleccionar técnicas basándose en:

1. **Información recopilada** - Qué sabemos del objetivo
2. **Vector con mayor probabilidad** - Qué ha funcionado antes
3. **Sigilo requerido** - Nivel de detección aceptable
4. **Recursos disponibles** - Herramientas, tiempo
5. **Alcance definido** - Qué está permitido

**Flujo de decisión:**
```
Evaluar información disponible
    ↓
Listar vectores aplicables
    ↓
Ordenar por: probabilidad × sigilo
    ↓
Ejecutir primer vector
    ↓
Éxito? → Siguiente fase
    ↓
No → Siguiente vector en lista
```

---

_Este catálogo es la base de conocimientos de Galban Mecamorfo. Debe actualizarse regularmente con nuevas técnicas y herramientas._
