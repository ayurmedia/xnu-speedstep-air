rm -r ./IntelEnhancedSpeedStep.kext
cp -a /Users/dun/Library/Developer/Xcode/DerivedData/IntelEnhancedSpeedStep-cdumqibshldjfudtvorreqalosnf/Build/Products/Debug/IntelEnhancedSpeedStep.kext .
./kextpatch.sh IntelEnhancedSpeedStep.kext

