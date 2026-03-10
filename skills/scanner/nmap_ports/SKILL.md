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
