import nmap
import re

port_min = 0
port_max = 65535


puertos_abiertos = []
ip = input("Introduce la ip a scanear: ")
port_range_pattern = re.compile("([0-9]+)-([0-9]+)")

while True:
     print("Introduce el rango de puertos que quieres escanear: <int>-<int> (ej. 60-120)")
     port_range = input("Introduce el rango: ")
     port_range_valid = port_range_pattern.search(port_range.replace(" ",""))
     if port_range_valid:
          port_min = int(port_range_valid.group(1))
          port_max = int(port_range_valid.group(2))
          break
    
nm = nmap.PortScanner()
for port in range(port_min, port_max + 1):
    try:
        result = nm.scan(ip, str(port))
        port_status = (result['scan'][ip]['tcp'][port]['state'])
        print(f"Port {port} is {port_status}")
    except:
        print(f"No se puede escanear {port}.")
