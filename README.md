# shake_tune

This is a plugin that provides a randomizer while shaking the phone.

[![IMAGE ALT TEXT HERE](https://i.ytimg.com/vi/mCzh0kGeB7E/hqdefault.jpg)](https://www.youtube.com/watch?v=mCzh0kGeB7E)

### Features
- Shake Detection
- Customizable Actions
- Randomization
- Configuration Options


### How to use

To listen to shaking of phone (automatically calls [startListening]):

    shakeDetector = ShakeDetector.autoStart(onPhoneShake: handleShake);

To listen to shaking of phone (waits until [startListening] is called):

    shakeDetector = ShakeDetector.waitForStart(onPhoneShake: handleShake);

To stop listening:

    shakeDetector.stopListening();


ShakeTune widget contains:
- [children] array - all results that randomizer may give (must not be ```null```)
- [probabilities] array - probabilities for each element in [children] (the length shall be equal to length of the
[children] array, and the sum of all elements shall be equal to one)
- [callback] - call when phone shook
- [firstElementShownOnlyOnce] - property that defines if first element shows
only on first start (before shake)
- [alwaysChooseDifferentElement] - property that defines if we should choose
different element on every shake
