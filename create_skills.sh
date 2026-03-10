#!/bin/bash
# Loop para crear skills automáticamente

SKILLS_DIR="/root/galban-mecamorfo/skills"

# Nmap Ports
cat > "$SKILLS_DIR/scanner/nmap_ports/SKILL.md" << 'EOF'
# Escaneo de Puertos con Nmap

## Descripción
Realiza escaneos TCP/UDP para descubrir puertos abiertos en objetivos.

## Herramientas
- nmap

## Comandos
```bash
# Escaneo básico TCP
nmap -sT -p- objetivo.com

# Escaneo sigiloso SYN
nmap -sS -p- objetivo.com

# Con detección de servicios
nmap -sV -sC objetivo.com
```

## Parámetros
- `-sT`: TCP connect
- `-sS`: SYN (requiere root)
- `-sV`: Version detection
- `-p-`: Todos los puertos
EOF

cat > "$SKILLS_DIR/scanner/nmap_ports/ejemplo.md" << 'EOF'
## Ejemplo de Resultado

```
Starting Nmap 7.93
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
443/tcp  open  https
3306/tcp open  mysql
```

## Éxito
- Puertos descubiertos
- Servicios identificados
EOF

# Masscan
cat > "$SKILLS_DIR/scanner/masscan/SKILL.md" << 'EOF'
# Escaneo Masivo con Masscan

## Descripción
Escaneos ultrarrápidos de grandes rangos de IP.

## Herramientas
- masscan

## Comandos
```bash
masscan -p1-65535 10.0.0.0/24 --rate=10000
```
EOF

cat > "$SKILLS_DIR/scanner/masscan/ejemplo.md" << 'EOF'
## Ejemplo

```
Discovered open port 80/tcp on 10.0.0.5
Discovered open port 443/tcp on 10.0.0.5
```
EOF

echo "Skills de scanner creadas"
