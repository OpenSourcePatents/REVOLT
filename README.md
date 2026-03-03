# REVOLT
Fully 3D-printable modular wind turbine for emergency &amp; off-grid power. Savonius drag-rotor, snap-fit tier stacking, axial flux generator, hand-crank zero-wind backup. Build it anywhere for ~$30. CC0 — no patents, no royalties, free forever. #OpenSourceEnergy “Built on days off. Released for free.”
# REVOLT

## Remote Energy Via Optimized Load Turbine

**Disclosure Date: March 3, 2026 — This publication establishes prior art under 35 U.S.C. § 102 and international equivalents.**

**License: CC0 / Public Domain — Print it. Build it. Share it. No strings. Ever.**

-----

## The Mission

I am a regular guy who loves solving real-world problems. I run dual-spindle lathes on the night shift and earned my degree in 2024 while working full-time for six years, graduating Summa Cum Laude. I’ve spent years fighting a sleep deficit from a diagnosed shift work sleep disorder — but now I’m using that hard-won clarity to put the ideas that have been living in my head out into the world where they can actually help people.

Power goes out. In storms, in wildfires, in floods, in war zones, in remote villages the grid never reached. When it does, people lose communication, medical equipment fails, and in the worst cases people die because they couldn’t call for help.

REVOLT is my answer to that. A wind turbine anyone can print on a basic 3D printer and build in an afternoon from hardware store parts. No electrician. No permit. No supply chain. Just wind, a printer, and about $30 in hardware.

If an idea can solve a problem, it belongs to the world — not a corporate vault.

-----

## What Is REVOLT?

REVOLT is a modular **Vertical Axis Wind Turbine (VAWT)** based on a Savonius drag-rotor design. It is:

- **Fully 3D printable** — every structural component on a standard FDM printer
- **Scalable** — snap-fit tier stacking means you add tiers to increase power output without redesigning anything
- **Omnidirectional** — no weathervane or yaw mechanism required, works in any wind direction
- **Emergency-ready** — a hand crank overdrive attachment lets you generate power with zero wind
- **Globally buildable** — all hardware is commodity bin parts available worldwide

-----

## How It Works

Two semi-circular scoop blades face opposite directions on a central hub. Wind pushes into the open face of one scoop and spins the whole assembly. A precisely sized **venting gap** (18% of rotor diameter) between the two scoops allows air to bleed through the center and push the returning scoop forward, reducing drag and preventing stall.

At the base, an **axial flux permanent magnet generator** — also fully 3D printed — converts rotation into electricity. Output feeds through a bridge rectifier into either a 5V USB buck converter for direct device charging or a 12/24V charge controller for battery banks.

### Real-World Performance (200mm rotor, single tier)

|Wind Speed|Output per Tier|3 Tiers|What It Powers      |
|----------|---------------|-------|--------------------|
|10 mph    |~1W            |~3W    |Trickle charge      |
|15 mph    |~3W            |~10W   |Phone fast charge   |
|20 mph    |~8W            |~24W   |Phone + radio       |
|25 mph    |~15W           |~45W   |Battery bank        |
|30 mph    |~26W           |~78W   |LED lighting + comms|

**The honest answer:** stack at least 3 tiers for useful emergency output. Add more for your wind environment.

-----

## What You Need to Build It

### 3D Printed Parts (per tier)

- 2x Savonius scoop blades
- 1x Hub collar
- 1x Base mount (one total, not per tier)
- 1x Generator rotor disc (one total)
- 1x Generator stator disc (one total)
- 1x Hand crank attachment (optional but strongly recommended)

**Recommended material:** PETG or ASA. PLA+ for prototyping only — it will warp and fail outdoors.

**Print settings:** 0.28mm layer height, 4-6 walls, 15-20% Gyroid infill. No supports needed if scoops are printed vertically.

### Hardware (Bin Parts — Available Worldwide)

|Part             |Spec                                   |Qty|Approx Cost|
|-----------------|---------------------------------------|---|-----------|
|Central shaft    |12.7mm (1/2”) stainless or aluminum rod|1  |$3-8       |
|Bearings         |608-RS (standard skateboard bearing)   |2  |$2-4       |
|Neodymium magnets|N52, 22mm dia x 6mm thick              |8  |$8-15      |
|Magnet wire      |24 AWG, 1 spool                        |1  |$5-10      |
|Bridge rectifier |3-phase module                         |1  |~$2        |
|Buck converter   |5V/2A module                           |1  |~$2        |
|M5 bolts         |20mm                                   |4  |$1         |

**Total estimated build cost (3-tier): $30-60 USD** depending on location and existing filament.

-----

## Generator Winding Specification

To achieve **5V DC output at 300 RPM:**

|Parameter        |Value                                       |
|-----------------|--------------------------------------------|
|Magnets          |8x N52, 22mm dia, alternating N-S polarity  |
|Coils            |9 total (3-phase, 3 coils per phase)        |
|Turns per coil   |100 turns                                   |
|Wire             |24 AWG magnet wire                          |
|Winding direction|All coils same direction                    |
|Phase connection |Star (Y) configuration                      |
|Rectification    |3-phase bridge rectifier → 5V buck converter|

Full derivation and math in `revolt_simulation.py` and the Patent Disclosure document.

-----

## Mounting Options

All three modes use the **same base mount** — no separate parts needed:

|Mode                         |Interface                      |
|-----------------------------|-------------------------------|
|PVC pipe                     |33.4mm (1” nominal) socket bore|
|T-post / rebar / fence post  |Adjustable clamp collar        |
|Vehicle roof rack / truck bed|MOLLE/PALS bolt flange         |
|Camera tripod                |Standard 5/8” stud             |

-----

## The Hand Crank — Zero-Wind Power

The manual overdrive attachment engages the generator shaft using the same hub interface as the rotor tiers. When there is no wind at all, you can charge devices by hand.

**Estimated human output:** 10-20W continuous at moderate effort.
**Time to charge a dead phone:** approximately 25-35 minutes of steady cranking.

This is not an accessory. This is what makes REVOLT an unconditional emergency tool.

-----

## Validation Protocol — Truck-Bed Wind Tunnel

Before trusting REVOLT in a real emergency, test it:

1. Mount to vehicle roof rack or truck bed using the vehicle mount interface
1. Drive at steady speeds: 10, 20, 30, 40, 50 mph on a calm day
1. Record RPM (cheap optical tachometer or phone app) and output watts at each speed
1. Compare to simulation curves in `revolt_simulation.py`
1. Upload your results as a Fatigue Log — see below

-----

## Community Data Loop — Fatigue Logs

Every builder who runs the truck-bed test and tracks their build over time makes REVOLT better for everyone who builds it next.

Upload a completed `fatigue_log_template.csv` to help track:

- Power output curves by material and tier count
- Which components fail first and under what conditions
- Real-world wind environment performance
- Material durability (PETG vs ASA vs other)

This data drives V2.0 geometry improvements. You are the R&D team.

-----

## Repository Contents

```
/docs
    REVOLT_Plain_English.pdf        — Guide for any builder, no engineering background needed
    REVOLT_Patent_Disclosure.pdf    — Full prior art disclosure, public domain record
    REVOLT_Technical_Brief.pdf      — Detailed specs for makers, NGOs, and manufacturers

/cad
    revolt_scoop.scad               — Full OpenSCAD parametric source, all components

/simulation
    revolt_simulation.py            — Physics model, power/torque curves at any wind speed

/community
    fatigue_log_template.csv        — Standardized community data upload format

README.md                           — This file
DISCLOSURE_DATE.txt                 — Timestamped prior art record
LICENSE                             — CC0 1.0 Universal
```

-----

## License — Public Domain (CC0)

This disclosure is made with the explicit intent of placing all described inventive concepts into the public domain under the Creative Commons Zero (CC0) license.

The originator expressly waives all patent rights. Any person, company, or institution is free to manufacture, distribute, modify, sublicense, or build upon these designs without restriction, royalty, or attribution requirement.

No entity may obtain valid patent protection for the concepts described herein after the date of this publication.

**DISCLAIMER:** This is an open engineering design, not a certified product. Builders are responsible for their own safety validation, structural testing, and local electrical code compliance.

-----

## Part of the Open Source Patents Project

REVOLT is released alongside the **FCK-U System** (Frame Cab Kinetic Utilization) — an open-source vehicle safety architecture — as part of the same mission: if an idea can help people, it belongs to everyone.

**X (Twitter):** [@OpnSorcePatents](https://twitter.com/OpnSorcePatents)
**FCK-U Repository:** [github.com/OpenSourcePatents/FCK-U-System](https://github.com/OpenSourcePatents/FCK-U-System)

`#OpenSourceEnergy` `#REVOLT` `#OpenSourceSafety`

-----

*Built on nights off. Released for free. No exceptions.*