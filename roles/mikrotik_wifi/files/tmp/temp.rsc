# nov/13/2018 13:37:48 by RouterOS 6.43.4
/interface wireless
# managed by CAPsMAN
# channel: 2412/20/gn(20dBm), SSID: Saber, CAPsMAN forwarding
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-Ce \
    distance=indoors frequency=auto mode=ap-bridge ssid=MikroTik-106B93 \
    wireless-protocol=802.11
# managed by CAPsMAN
# channel: 5260/20/ac(20dBm), SSID: Saber, CAPsMAN forwarding
set [ find default-name=wlan2 ] band=5ghz-a/n/ac channel-width=\
    20/40/80mhz-Ceee distance=indoors frequency=auto mode=ap-bridge ssid=\
    MikroTik-106B92 wireless-protocol=802.11
/interface ethernet
set [ find default-name=ether1 ] speed=100Mbps
/interface list
add exclude=dynamic name=discover
add name=mactel
add name=mac-winbox
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-server
add disabled=no name=defconf
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0
/interface bridge port
add comment=defconf interface=wlan1
add comment=defconf interface=wlan2
/interface list member
add interface=wlan1 list=discover
add interface=wlan2 list=discover
add list=mactel
add list=mac-winbox
/interface wireless cap
# 
set caps-man-addresses=192.168.3.58 enabled=yes interfaces=wlan1,wlan2
/ip address
add address=192.168.6.11/16 interface=ether1 network=192.168.0.0
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,192.168.3.7
/ip dns static
add address=192.168.88.1 name=router
/ip firewall filter
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment="defconf: accept established,related" \
    connection-state=established,related
add action=accept chain=forward comment="defconf: accept established,related" \
    connection-state=established,related
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=input connection-state=invalid
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" disabled=yes \
    out-interface=ether1
/ip route
add distance=1 gateway=192.168.3.58
/snmp
set contact=Saber3D enabled=yes location=mikrotik6-11 trap-version=2
/system clock
set time-zone-name=Europe/Moscow
/system identity
set name=wi-fi_mikrotik6-11
/system ntp client
set enabled=yes primary-ntp=192.168.3.7
/system routerboard settings
set silent-boot=no
/tool mac-server
set allowed-interface-list=mactel
/tool mac-server mac-winbox
set allowed-interface-list=mac-winbox
