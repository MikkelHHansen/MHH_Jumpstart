# MHH Jumpstart

Skip the early-game grind. Gives you powerful armor, equipment, construction and logistics robots, and spare items in your inventory as soon as you join a game (new or existing). Perfect for getting straight to the late-game or testing.

**Requires [MHH_Prototype_Equipment](https://mods.factorio.com/mod/MHH_Prototype_Equipment)** — all items come from that mod.

## Presets

| Preset | Armor | Equipment Grid | Quality |
|---|---|---|---|
| Balanced | Vanilla power armor | Filled with vanilla equipment at the selected quality | All qualities |
| Advanced | Vanilla power armor MK2 | Filled with vanilla equipment MK2 at the selected quality | All qualities |
| Overpowered | Prototype power armor | Filled with prototype equipment; includes robots, roboports, spare gear | All qualities |
| Cheaty (*default*) | Prototype power armor | Same as Overpowered, doubled — extra reactors, shields, lasers, exoskeletons, robots, roboports, spare gear | All qualities |

### What You Get

All presets give:
- A full suit of armor with a complete equipment grid (batteries, reactors, shields, exoskeletons, personal lasers, roboports, night vision, solar panels, belt immunity equipment)
- Construction and logistic robots in your inventory
- A stationary roboport in your inventory

Overpowered and Cheaty also give spare equipment, extra robots, and additional roboports in your inventory.

## Quality

The `mhh-jumpstart-quality` startup setting controls the quality level of all starting gear:

| Setting | Quality |
|---|---|
| `normal` (*default*) | Normal |
| `uncommon` | Uncommon |
| `rare` | Rare |
| `epic` | Epic |
| `legendary` | Legendary |

Quality only applies when **Space Age** is active (quality is a Space Age feature in Factorio 2.0). Without Space Age, all items are normal quality regardless of this setting.

## Settings

| Setting | Type | Default | Values | Description |
|---|---|---|---|---|
| mhh-jumpstart-preset | string | cheaty | balanced / advanced / overpowered / cheaty | Starting gear preset |
| mhh-jumpstart-quality | string | normal | normal / uncommon / rare / epic / legendary | Quality level of starting gear |

Both settings are **startup** type (require a game restart).

## How It Works

- **On new game** — items are granted when the player is created
- **On existing saves** — items are granted on join (but only once; the mod detects re-entry and skips already-equipped players)
- **Multiplayer** — works for all players, applies to each player on their first join

## Compatibility

| Mod | Support |
|---|---|
| **Space Age** | Detected — quality system used when available |
| **Space Exploration** | Detected — armor gets SE-specific resistances and equipment |
| **Krastorio 2** | Detected — armor and equipment adapt to K2 stats |

## Requirements

- **Factorio 2.0**
- **[MHH_Prototype_Equipment](https://mods.factorio.com/mod/MHH_Prototype_Equipment)** (auto-installed)
- Optional: Space Age, Space Exploration, Krastorio 2
