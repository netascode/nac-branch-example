
*** Settings ***
Library    String
Library    ../myutils.py

*** Test Cases ***
{% for domain in meraki.domains | default([], true) %}
{% for organization in domain.organizations | default([], true) %}
{% for network in organization.networks | default([], true) %}
{% for wireless_ssid in network.wireless.ssids | default([], true) %}

Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//number{% if wireless_ssid.ssid_number is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    Should Be Equal As Strings   ${wireless_ssid}[number]   {{ wireless_ssid.ssid_number }}

{% else %}
    Skip    wireless_ssid.ssid_number is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//name{% if wireless_ssid.name is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    Should Be Equal As Strings   ${wireless_ssid}[name]   {{ wireless_ssid.name }}

{% else %}
    Skip    wireless_ssid.name is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//enabled{% if wireless_ssid.enabled is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    Should Be Equal As Strings   ${wireless_ssid}[enabled]   {{ wireless_ssid.enabled }}

{% else %}
    Skip    wireless_ssid.enabled is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//splash_page{% if wireless_ssid.splash_page is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    Should Be Equal As Strings   ${wireless_ssid}[splashPage]   {{ wireless_ssid.splash_page }}

{% else %}
    Skip    wireless_ssid.auth_mode is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//encryption_mode{% if wireless_ssid.encryption_mode is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    Should Be Equal As Strings   ${wireless_ssid}[encryptionMode]   {{ wireless_ssid.encryption_mode }}

{% else %}
    Skip    wireless_ssid.encryption_mode is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//wpa_encryption_mode{% if wireless_ssid.wpa_encryption_mode is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    Should Be Equal As Strings   ${wireless_ssid}[wpaEncryptionMode]   {{ wireless_ssid.wpa_encryption_mode }}

{% else %}
    Skip    wireless_ssid.wpa_encryption_mode is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//radius.servers{% if wireless_ssid.radius.servers is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    ${evaluated}=    Evaluate    {{ wireless_ssid.radius.servers }}
    ${validated}=    Validate Subset     ${wireless_ssid}[radiusServers]    ${evaluated}
    Should Be True   ${validated}

{% else %}
    Skip    wireless_ssid.radius.servers is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//radius.accounting_servers{% if wireless_ssid.radius.accounting_servers is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    ${evaluated}=    Evaluate    {{ wireless_ssid.radius.accounting_servers }}
    ${validated}=    Validate Subset     ${wireless_ssid}[radiusAccountingServers]    ${evaluated}
    Should Be True   ${validated}

{% else %}
    Skip    wireless_ssid.radius.accounting_servers is not defined
{% endif %}
Verify {{ organization.name }}/networks/{{ network.name }}/wireless.ssids/{{ wireless_ssid.name }}//radius.accounting{% if wireless_ssid.radius.accounting is defined %}
    [Setup]   Get Meraki Data   /networks/{networkId}/wireless/ssids/{number}   ['{{ organization.name }}', '{{ network.name }}', '{{ wireless_ssid.name }}']   wireless_ssid
    Should Be Equal As Strings   ${wireless_ssid}[radiusAccountingEnabled]   {{ wireless_ssid.radius.accounting }}

{% else %}
    Skip    wireless_ssid.radius.accounting is not defined
{% endif %}

{% endfor %}

{% endfor %}
{% endfor %}
{% endfor %}
