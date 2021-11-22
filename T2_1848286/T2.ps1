# Tarea 2
#
# Elaborado por: Julio Adrian Sanchez Leal
# Matricula: 1848286
# Fecha: 15/10/2021
#
#

Write-host Menu
Write-host ===
Write-Host "1) Escaneo de toda la subred"
Write-Host "2) Escaneo de puertos para un equipo o direcccion ip"
Write-Host "3) Escaneo de puertos para todos los equipos que esten activos"

$opcion = Read-Host

switch ($opcion) {

3 {

$subred = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "Determinando tu gatway ..."
Write-Host "Tu gateway es: "$subred
$rango = $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.') + 1).IndexOf('.') + 3)

Write-Host "Determinando tu rango de subred..."
echo $rango
$respuesta = Test-Connection 192.168.1.254 -Quiet -Count 1
Write-Host $respuesta
$rango_ip = @(1..254)

Write-Output ""
Write-Host "Subred actual: "
Write-Host "Escaneando : " -NoNewLine ; Write-Host $rango -NoNewline; Write-Host "0/24" -ForegroundColor Red
Write-Output ""

foreach ( $r in $rango_ip ) {
    $actual = $rango + $r 
    $responde = Test-Connection $actual -Quiet -Count 1
    if ( $responde -eq "True" ) {
        Write-Output ""
        Write-Host " Host responde: " -NoNewline; Write-Host $actual -ForegroundColor Green
        }
    }

break
}

2 {

$porttoscan = @(20,21,22,23,25,50,51,53,80,110,119,135,136,137,138,139,143,161,162,389,443,445,636,1025,1443,3389,5985,5986,8080,10000)
$waittime = 100

Write-Host "Direccion ip a escanear: " -NoNewline
$direccion = Read-Host

foreach ( $p in $porttoscan) {


}

}







