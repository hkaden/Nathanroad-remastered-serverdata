# https://modit.store
# ModFreakz
# Drug FX

## Information
Drug FX is a highly configurable drug consumption and effect framework, aiming to provide the ultimate experience for drug users (and abusers) in your server. 

In this script, there are drug "types", responsible the majority of the drug effect, that are triggered with varying intensity by defined drug items. The ability to configure your own drug effects and items is extensive, while also having a large number of drug types and items pre-defined for those who don't want to dig too deep into the config files.

No "drug addiction" or "drug resistance" has been tied to this mod, but there are several events that have been provided to allow external mods to control this process entirely through the creation and consumption of drug items with customised values.

NOTE: Integrating this with any of your other mods is entirely up to you. This script serves entirely as an effect handler with some pre-configured items for simple ESX (es_extended) users, with extensive configuration available to be used by developers.

## Installation
Drop resource in resources directory.
Add `start mf-drugfx` to server.cfg.
Ensure all dependencies below are inside your resources directory.
Import the sql file to your database.
Read the credentials.lua file provided for information on authorizing your script.

## Dependencies
(OPTIONAL) es_extended (Supported, not required).

## Usage
With ESX, using ESX inventory items:
  - Add one of the items from config.lua to your inventory (E.G: /additem 1 acid 1).
  - Use the item from your inventory panel.

From server script:
  To trigger with custom drug options, use options:

    local opts = {
      type    = 'amp',         
      quality = 1.0,
      instant = true,
      sober   = false,
      effects = {      
        move_speed    = 2.0, 
        add_armor     = false,
        add_health    = 100,
        take_armor    = 100,
        take_health   = false, 
        health_regen  = 2.0, 
      },
      animation = {  
        type      = "animation",        
        dict      = 'switch@trevor@trev_smoking_meth', 
        anim      = 'trev_smoking_meth_loop',
        blend_in  = 1.0,
        blend_out = 1.0,
        flag      = 49,
        start     = 0.0,
        prop      = 'prop_cs_meth_pipe',
        bone      = 28422,
        wait      = true,
        timeout   = 10000,
      },
    }
    TriggerEvent("Drugs:Create",function(drug)
      TriggerEvent("Drugs:ConsumeItem",source,drug)
    end,opts)

  To trigger with predefined item options, use item name:
    TriggerEvent("Drugs:Consume",source,"acid")




