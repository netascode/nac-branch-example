*** Settings ***
Library    String
Library    ../myutils.py

*** Test Cases ***
{% for domain in meraki.domains | default([], true) %}
{% for organization in domain.organizations | default([], true) %}
{% for network in organization.networks | default([], true) %}

# ---------- name ----------
Verify {{ organization.name }}/networks/{{ network.name }}//name
{% if network.name is defined %}
    [Setup]    Get Meraki Data    /networks/{networkId}    ['{{ organization.name }}', '{{ network.name }}']    network
    Should Be Equal As Strings    ${network}[name]    {{ network.name }}
{% else %}
    Skip    network.name is not defined
{% endif %}

# ---------- product_types ----------
Verify {{ organization.name }}/networks/{{ network.name }}//product_types
{% if network.product_types is defined %}
    [Setup]    Get Meraki Data    /networks/{networkId}    ['{{ organization.name }}', '{{ network.name }}']    network
    ${evaluated}=    Evaluate    {{ network.product_types }}
    ${validated}=    Validate Subset    ${network}[productTypes]    ${evaluated}
    Should Be True    ${validated}
{% else %}
    Skip    network.product_types is not defined
{% endif %}

# ---------- time_zone ----------
Verify {{ organization.name }}/networks/{{ network.name }}//time_zone
{% if network.time_zone is defined %}
    [Setup]    Get Meraki Data    /networks/{networkId}    ['{{ organization.name }}', '{{ network.name }}']    network
    Should Be Equal As Strings    ${network}[timeZone]    {{ network.time_zone }}
{% else %}
    Skip    network.time_zone is not defined
{% endif %}

# ---------- tags ----------
Verify {{ organization.name }}/networks/{{ network.name }}//tags
{% if network.tags is defined %}
    [Setup]    Get Meraki Data    /networks/{networkId}    ['{{ organization.name }}', '{{ network.name }}']    network
    ${evaluated}=    Evaluate    {{ network.tags }}
    ${validated}=    Validate Subset    ${network}[tags]    ${evaluated}
    Should Be True    ${validated}
{% else %}
    Skip    network.tags is not defined
{% endif %}

{% endfor %}
{% endfor %}
{% endfor %}
