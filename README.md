# Hogwarts Legacy Ultra Plus and Lighting Pak Source

I'm uploading this so that people can see how it works, and hopefully what changes I've made to the vanilla game and why.

While Hogwarts has a lot of plugins that are non-standard, a lot of the principles I've used in these mods also apply to other Unreal Engine 4 and 5 games — especially streamer changes, engine configuration and timing, LODs, and volumetric fog.

I would recommend using a tool like Meld or Diffinity to compare to the original game files (many of which are also included here).

## Contributing

Please feel free! I am busy and need help 😂

## Concepts

### Streaming

One of the least understood parts of Unreal (and other game engines) is the streamer (often called the texture streamer, but it also streams assets such as meshes, animations, and in other engines, sounds, etc.) A streamer is _not_ intended to hold assets indefinitely. Its job is to transform assets on the way to the GPU scene buffer. Ideally it should keep assets long enough to be uploaded to the GPU scene, and no longer, otherwise on low and mid-range PCs there is not enough room for new assets as the player moves around.

This was what happened in Hogwarts. On release, the streamer was modified, and configured to hold assets until it was 95% full (and to hold onto them), so when a player moved to a new area, the streamer has to emergency release a lot of assets, before it can load new ones. This is what initially caused stutters. A streamer should _always_ have enough room for new assets and avoid memory contention.

On the other hand some games release assets too fast, causing assets to be re-acquired unnecessarily. So there is a balance.

### Drum-Buffer-Rope

The other problem I commonly see in Unreal games and other engines is the problem of multiple parts of the streamer pipeline stopping and starting. By default, UE (even 5.x) is configured to stop streaming at the CPU after 100 requests or 130MB. In today's compute terms these thresholds are tiny. However, the methodology of trying to manage each stage of the pipeline this way is actually not ideal.

Specifically this is the field of the Theory of Constraints, and is a Drum-Buffer-Rope problem (Eliyahu Goldratt, [Beyond the Goal](https://www.amazon.com/Beyond-Goal-Eliyahu-Goldratt-Constraints/dp/1596590238)).

In the ideal streamer pipeline, all prior parts of the pipleine are ready to feed the next. In this methodology the _last_ part of the pipeline (the GPU scene) "pulls" from the prior, _and the prior part is already ready and waiting_. There is no reason to artificially stall components of of an asset streamer; this architecture will lead to stop-start within the streamer pipeline and an unstable flow of assets. 


## License

Please see the license. You are welcome to fork and make your own versions based on this mod, however please be clear that it's a fork, credit me, and include the same MIT license.

## Original License

I credit the original authors at Avalanche and Warner Brothers Games Montreal. These files and comparisons are provided here as a reference and to contribute to the UE and game community as a whole.
