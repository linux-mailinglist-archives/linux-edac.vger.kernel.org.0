Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E049CAFA16
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfIKKMq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 06:12:46 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:57013 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726842AbfIKKMp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Sep 2019 06:12:45 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:12:43 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:12:42 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Wed, 11 Sep 2019 18:12:42 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMy80XSB4ODYvbWNlOiBBZGQgWmhhb3hpbiBD?=
 =?utf-8?Q?MCI_support?=
Thread-Topic: [PATCH v2 3/4] x86/mce: Add Zhaoxin CMCI support
Thread-Index: AdVnqRp9Tf3+t+7iRiGrtZWDTW0/Hf//0KgA//6IMIA=
Date:   Wed, 11 Sep 2019 10:12:42 +0000
Message-ID: <43b89bb6e86c4fc79c89990ca4d18170@zhaoxin.com>
References: <e8d11f3ce0f64a9f9a4cefcc8059747b@zhaoxin.com>
 <20190910123720.GF23931@zn.tnic>
In-Reply-To: <20190910123720.GF23931@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gVHVlLCBTZXAgMTAsIDIwMTksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj5PbiBUdWUsIFNl
cCAxMCwgMjAxOSBhdCAwODoxOTo0NEFNICswMDAwLCBUb255IFcgV2FuZy1vYyB3cm90ZToNCj4+
IEBAIC0xNzc3LDYgKzE3NzcsMjkgQEAgc3RhdGljIHZvaWQgbWNlX2NlbnRhdXJfZmVhdHVyZV9p
bml0KHN0cnVjdA0KPmNwdWluZm9feDg2ICpjKQ0KPj4gIAl9DQo+PiAgfQ0KPj4NCj4+ICsjaWZk
ZWYgQ09ORklHX0NQVV9TVVBfWkhBT1hJTg0KPg0KPldoYXQncyB0aGF0IGlmZGVmZmVyeSBmb3Ig
c2luY2UgeW91IGhhdmUgaXQgaW4gdGhlIGhlYWRlciBhbHJlYWR5Pw0KDQpTb3JyeSBmb3IgdGhh
dC4gDQpTaW5jZSB0aGlzIGZ1bmN0aW9uIGFjdHVhbGx5IGJlIGNhbGxlZCBvbmx5IGluIG1jZS9j
b3JlLmMsIHdpbGwgcmVtb3ZlIHRoZQ0KZGVjbGFyZSBpbiB0aGUgaGVhZGVyIGZpbGUgYW5kIG1h
a2UgdGhpcyBmdW5jdGlvbiBzdGF0aWMuDQoNCj4NCj4+ICt2b2lkIG1jZV96aGFveGluX2ZlYXR1
cmVfaW5pdChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+PiArew0KPj4gKwlzdHJ1Y3QgbWNlX2Jh
bmsgKm1jZV9iYW5rcyA9IHRoaXNfY3B1X3B0cihtY2VfYmFua3NfYXJyYXkpOw0KPj4gKw0KPj4g
KwkvKg0KPj4gKwkgKiBUaGVzZSBDUFVzIGJhbms4IFNWQUQgZXJyb3IgbWF5IGJlIHRyaWdnZXJl
ZCB1bmV4cGVjdGVkIHdoZW4NCj4NCj4iVGhlc2UgQ1BVcyBiYW5rOCBTVkFEIj8/DQoNClRoZXNl
IFpoYW94aW4gQ1BVcyBoYXZlIE1DQSBiYW5rIDgsIHRoYXQgb25seSBoYXZlIG9uZSBlcnJvciBj
YWxsZWQgU1ZBRCgNClN5c3RlbSBWaWV3IEFkZHJlc3MgRGVjb2Rlcikgd2hpY2ggYmUgY29udHJv
bGxlZCBieSBJQTMyX01DOF9DVEwuMA0KDQo+DQo+PiArCSAqIGJyaW5ndXAgdmlydHVhbCBtYWNo
aW5lLiBpdCBpcyBub3QgaGFyZHdhcmUgYnVnLiBBbHdheXMgZGlzYWJsZQ0KPj4gKwkgKiBiYW5r
OCBTVkFEIGVycm9yIGJ5IGRlZmF1bHQuDQo+PiArCSAqLw0KPg0KPlRoYXQgY29tbWVudCBpcyBp
bmNvbXByZWhlbnNpYmxlLiBQbGVhc2UgcmV3cml0ZS4NCg0KT2ssIHdpbGwgcmV3cml0ZSBjb21t
ZW50IGluIHYzLg0KDQo+DQo+PiArCWlmICgoYy0+eDg2ID09IDYgJiYgYy0+eDg2X21vZGVsID09
IDB4MTkgJiYNCj4+ICsJCShjLT54ODZfc3RlcHBpbmcgPiAzICYmIGMtPng4Nl9zdGVwcGluZyA8
IDgpKSB8fA0KPj4gKwkgICAgKGMtPng4NiA9PSA2ICYmIGMtPng4Nl9tb2RlbCA9PSAweDFmKSB8
fA0KPj4gKwkgICAgKGMtPng4NiA9PSA3ICYmIGMtPng4Nl9tb2RlbCA9PSAweDFiKSkgew0KPg0K
PkFzIGJlZm9yZTogcG90ZW50aWFsIHRvIHNpbXBsaWZ5IHRoZSB0ZXN0IGhlcmU/DQoNCk9rLCB3
aWxsIHNpbXBsaWZ5IGFzIGJlZm9yZS4NCg0KPg0KPj4gKwkJaWYgKHRoaXNfY3B1X3JlYWQobWNl
X251bV9iYW5rcykgPiA4KQ0KPj4gKwkJCW1jZV9iYW5rc1s4XS5jdGwgPSAwOw0KPj4gKwl9DQo+
PiArDQo+PiArCWludGVsX2luaXRfY21jaSgpOw0KPj4gKwltY2VfYWRqdXN0X3RpbWVyID0gY21j
aV9pbnRlbF9hZGp1c3RfdGltZXI7DQo+PiArfQ0KPj4gKyNlbmRpZg0KPj4gKw0KPj4gIHN0YXRp
YyB2b2lkIF9fbWNoZWNrX2NwdV9pbml0X3ZlbmRvcihzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+
PiAgew0KPj4gIAlzd2l0Y2ggKGMtPng4Nl92ZW5kb3IpIHsNCj4+IEBAIC0xNzk4LDYgKzE4MjEs
MTAgQEAgc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X2luaXRfdmVuZG9yKHN0cnVjdA0KPmNwdWlu
Zm9feDg2ICpjKQ0KPj4gIAkJbWNlX2NlbnRhdXJfZmVhdHVyZV9pbml0KGMpOw0KPj4gIAkJYnJl
YWs7DQo+Pg0KPj4gKwljYXNlIFg4Nl9WRU5ET1JfWkhBT1hJTjoNCj4+ICsJCW1jZV96aGFveGlu
X2ZlYXR1cmVfaW5pdChjKTsNCj4+ICsJCWJyZWFrOw0KPj4gKw0KPj4gIAlkZWZhdWx0Og0KPj4g
IAkJYnJlYWs7DQo+PiAgCX0NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21j
ZS9pbnRlbC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZWwuYw0KPj4gaW5kZXggZWVl
NGIxMi4uYjQ5Y2JhNyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2lu
dGVsLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVsLmMNCj4+IEBAIC04
NSw3ICs4NSw4IEBAIHN0YXRpYyBpbnQgY21jaV9zdXBwb3J0ZWQoaW50ICpiYW5rcykNCj4+ICAJ
ICogaW5pdGlhbGl6YXRpb24gaXMgdmVuZG9yIGtleWVkIGFuZCB0aGlzDQo+PiAgCSAqIG1ha2Vz
IHN1cmUgbm9uZSBvZiB0aGUgYmFja2Rvb3JzIGFyZSBlbnRlcmVkIG90aGVyd2lzZS4NCj4+ICAJ
ICovDQo+DQo+VGhhdCBjb21tZW50IGFib3ZlIG5lZWRzIGZpeGluZyB0b28uDQoNCk9rLiANCg0K
Pg0KPj4gLQlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSU5URUwp
DQo+PiArCWlmIChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgIT0gWDg2X1ZFTkRPUl9JTlRFTCAm
Jg0KPj4gKwkgICAgYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfWkhBT1hJ
TikNCj4+ICAJCXJldHVybiAwOw0KPg0KPjwtLS0tIG5ld2xpbmUgaGVyZS4NCg0KT2suDQoNClNp
bmNlcmVseQ0KVG9ueVdXYW5nLW9jDQoNCg==
