# AppLovin MAX Setup - Banner Ads Only

## 🎯 Current Status

✅ **SETUP COMPLETE - BUT DISABLED**
- SDK initialized with feature flag
- Banner ads ready to use
- **Currently OFF** (using AdMob only)

---

## 🔧 Files Created/Modified

### New Files:
1. `lib/services/applovin_max.service.dart` - AppLovin service (banners only)
2. `lib/components/applovin_banner.dart` - Banner widget component
3. `lib/config/applovin_config.dart` - All IDs and configuration

### Modified Files:
1. `lib/main.dart` - Added SDK initialization (feature flag controlled)
2. `lib/services/index.dart` - Added service instance
3. `android/app/src/main/AndroidManifest.xml` - Added SDK key
4. `ios/Runner/Info.plist` - Added SDK key

---

## 🚦 How to Enable AppLovin Banners

### Step 1: Enable Feature Flag

In `lib/config/applovin_config.dart`:

```dart
// Change this from false to true
static const bool enableAppLovin = true;  // ← Enable AppLovin

// Keep test mode ON initially
static const bool testMode = true;  // ← Test ads only
```

### Step 2: Use Banner Widget

Replace existing AdMob banner with:

```dart
import 'package:new_trip_start/components/applovin_banner.dart';

// In your widget:
AppLovinBanner()  // Shows AppLovin banner
```

**OR** keep both for A/B testing:

```dart
AppLovinConfig.enableAppLovin
  ? AppLovinBanner()        // AppLovin (mediation)
  : YourAdMobBanner()       // Current AdMob
```

---

## ⚠️ IMPORTANT Safety Features

### Feature Flag System:
- **OFF by default** (`enableAppLovin = false`)
- No code runs when disabled
- Instant rollback: just set flag to `false`
- Zero impact on existing AdMob setup

### Test Mode:
- Test ads show initially (`testMode = true`)
- No revenue, but safe testing
- Switch to production after testing

---

## 📊 Ad Unit IDs (Already Configured)

### Banner:
- Android: `377609a017143797`
- iOS: `f6e396a963d97745`

### Interstitial (Created but not implemented):
- Android: `d2afb8ae471f12ab`
- iOS: `9447cf03c84a0e29`

### Rewarded (Created but not implemented):
- Android: `d65dd81556d43c03`
- iOS: `d009a6e1d669cddf`

---

## 🎯 Dashboard Setup TODO

**Still need to do in AppLovin Dashboard:**

1. ✅ SDK Key added
2. ✅ Ad Units created (Banner, Interstitial, Rewarded)
3. ⏳ **Enable AdMob mediation** ← CRITICAL!
4. ⏳ **Map AdMob IDs to AppLovin ad units** ← CRITICAL!
5. ⏳ Enable bidding for AdMob
6. ⏳ Configure waterfall/eCPM floors
7. ⏳ Enable test mode initially

**Without steps 3-4, AdMob won't compete and revenue will drop!**

---

## 🧪 Testing Plan

### Phase 1: Local Testing (Now)
```dart
enableAppLovin = true
testMode = true

Result: Test ads only, no real revenue
```

### Phase 2: Production Testing (After dashboard setup)
```dart
enableAppLovin = true
testMode = false

Test with your device first!
```

### Phase 3: Gradual Rollout
```dart
Week 1: 5% users
Week 2: 10% users
Week 3: 25% users
Week 4: 50% users
Month 2: 100% users (if successful)
```

---

## 🔄 Rollback Plan

**If anything goes wrong:**

1. Immediate rollback:
```dart
static const bool enableAppLovin = false;
```

2. Hot restart app - back to AdMob only
3. No app update needed!

---

## 📈 Expected Results (After Mediation Setup)

### Current (AdMob Only):
- Revenue: 100% from AdMob
- Fill rate: ~90-95%
- eCPM: $3-4

### After AppLovin MAX (With Mediation):
- Revenue: 30-40% increase expected
- Fill rate: ~98%+
- eCPM: $4-6
- Revenue sources:
  - 30-40% AppLovin
  - 30-35% AdMob (still earning!)
  - 20-25% Facebook
  - 10-15% Others

---

## ⚡ Quick Commands

### Enable AppLovin:
File: `lib/config/applovin_config.dart`
Change: `enableAppLovin = false` → `enableAppLovin = true`

### Disable AppLovin:
File: `lib/config/applovin_config.dart`
Change: `enableAppLovin = true` → `enableAppLovin = false`

### View Mediation Debugger (iOS only):
Automatically shows when `testMode = true`

---

## 🐛 Troubleshooting

### Banner not showing?
1. Check: `enableAppLovin = true`?
2. Check: Dashboard mediation setup done?
3. Check logs: `flutter run` and look for "AppLovin" messages

### AdMob revenue dropped?
1. **VERIFY**: AdMob mediation configured in dashboard
2. **CHECK**: AdMob IDs mapped to AppLovin ad units
3. **ENABLE**: Bidding for AdMob network

### App crashes?
1. Set `enableAppLovin = false` immediately
2. Check AndroidManifest/Info.plist for correct SDK key
3. Verify ad unit IDs are correct

---

## 📞 Support

**AppLovin Support:**
- They approached you - use dedicated support
- Account manager contact info
- Dashboard → Help → Contact Support

**Dashboard Setup Help:**
If confused about mediation setup, ask AppLovin team for:
- Screen share session
- Step-by-step guide
- Mediation best practices

---

## ✅ Checklist Before Enabling

- [ ] Dashboard mediation setup complete
- [ ] AdMob network added and active
- [ ] All ad units mapped to AdMob IDs
- [ ] Bidding enabled for AdMob
- [ ] Test mode ON initially
- [ ] Tested locally first
- [ ] Rollback plan ready
- [ ] Monitoring setup (revenue tracking)

---

**Current Status: READY TO TEST (Dashboard setup pending)**

**Next Step: Complete dashboard mediation setup, then set `enableAppLovin = true`**
