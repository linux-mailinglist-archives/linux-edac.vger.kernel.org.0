Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C49AFA07
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfIKKKy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 06:10:54 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:52181 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726696AbfIKKKx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Sep 2019 06:10:53 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:10:49 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:10:48 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Wed, 11 Sep 2019 18:10:48 +0800
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
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMS80XSB4ODYvbWNlOiBBZGQgWmhhb3hpbiBN?=
 =?utf-8?Q?CE_support?=
Thread-Topic: [PATCH v2 1/4] x86/mce: Add Zhaoxin MCE support
Thread-Index: AdVnqN8gcs/qr4n4QmGIov91NLhkWP//xD8A//6NK/A=
Date:   Wed, 11 Sep 2019 10:10:48 +0000
Message-ID: <3ebc05282ec948288af9e6060e5a474e@zhaoxin.com>
References: <d2660f92baf04d1f9aef5fedc39d7360@zhaoxin.com>
 <20190910115116.GD23931@zn.tnic>
In-Reply-To: <20190910115116.GD23931@zn.tnic>
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
cCAxMCwgMjAxOSBhdCAwODoxOTowOEFNICswMDAwLCBUb255IFcgV2FuZy1vYyB3cm90ZToNCj4+
IEFsbCBaaGFveGluIG5ld2VyIENQVXMgc3VwcG9ydCBNQ0UgdGhhdCBjb21wYXRpYmxlIHdpdGgg
SW50ZWwncw0KPj4gIk1hY2hpbmUtQ2hlY2sgQXJjaGl0ZWN0dXJlIiwgc28gYWRkIHN1cHBvcnQg
Zm9yIFpoYW94aW4gTUNFIGluDQo+PiBtY2UvY29yZS5jLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFRvbnkgVyBXYW5nLW9jIDxUb255V1dhbmctb2NAemhhb3hpbi5jb20+DQo+PiAtLS0NCj4+ICBh
cmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgfCAzMCArKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5j
IGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+PiBpbmRleCA3NDMzNzBlLi4zZjg3
OGY2IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+PiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4+IEBAIC00ODgsOCArNDg4LDkg
QEAgaW50IG1jZV91c2FibGVfYWRkcmVzcyhzdHJ1Y3QgbWNlICptKQ0KPj4gIAlpZiAoIShtLT5z
dGF0dXMgJiBNQ0lfU1RBVFVTX0FERFJWKSkNCj4+ICAJCXJldHVybiAwOw0KPj4NCj4+IC0JLyog
Q2hlY2tzIGFmdGVyIHRoaXMgb25lIGFyZSBJbnRlbC1zcGVjaWZpYzogKi8NCj4+IC0JaWYgKGJv
b3RfY3B1X2RhdGEueDg2X3ZlbmRvciAhPSBYODZfVkVORE9SX0lOVEVMKQ0KPj4gKwkvKiBDaGVj
a3MgYWZ0ZXIgdGhpcyBvbmUgYXJlIEludGVsL1poYW94aW4tc3BlY2lmaWM6ICovDQo+PiArCWlm
IChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgIT0gWDg2X1ZFTkRPUl9JTlRFTCAmJg0KPj4gKwkg
ICAgYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfWkhBT1hJTikNCj4+ICAJ
CXJldHVybiAxOw0KPj4NCj4+ICAJaWYgKCEobS0+c3RhdHVzICYgTUNJX1NUQVRVU19NSVNDVikp
DQo+PiBAQCAtNTEwLDcgKzUxMSw4IEBAIGJvb2wgbWNlX2lzX21lbW9yeV9lcnJvcihzdHJ1Y3Qg
bWNlICptKQ0KPj4gIAlpZiAobS0+Y3B1dmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EIHx8DQo+PiAg
CSAgICBtLT5jcHV2ZW5kb3IgPT0gWDg2X1ZFTkRPUl9IWUdPTikgew0KPj4gIAkJcmV0dXJuIGFt
ZF9tY2VfaXNfbWVtb3J5X2Vycm9yKG0pOw0KPj4gLQl9IGVsc2UgaWYgKG0tPmNwdXZlbmRvciA9
PSBYODZfVkVORE9SX0lOVEVMKSB7DQo+PiArCX0gZWxzZSBpZiAobS0+Y3B1dmVuZG9yID09IFg4
Nl9WRU5ET1JfSU5URUwgfHwNCj4+ICsJCSAgIG0tPmNwdXZlbmRvciA9PSBYODZfVkVORE9SX1pI
QU9YSU4pIHsNCj4+ICAJCS8qDQo+PiAgCQkgKiBJbnRlbCBTRE0gVm9sdW1lIDNCIC0gMTUuOS4y
IENvbXBvdW5kIEVycm9yIENvZGVzDQo+PiAgCQkgKg0KPg0KPk1ha2UgdGhhdCBhIHN3aXRjaC1j
YXNlIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkgcGxzLg0KDQpPay4NCg0KPg0KPj4gQEAgLTE2OTcs
NiArMTY5OSwyMSBAQCBzdGF0aWMgaW50IF9fbWNoZWNrX2NwdV9hcHBseV9xdWlya3Moc3RydWN0
DQo+Y3B1aW5mb194ODYgKmMpDQo+PiAgCQlpZiAoYy0+eDg2ID09IDYgJiYgYy0+eDg2X21vZGVs
ID09IDQ1KQ0KPj4gIAkJCXF1aXJrX25vX3dheV9vdXQgPSBxdWlya19zYW5keWJyaWRnZV9pZnU7
DQo+PiAgCX0NCj4+ICsNCj4+ICsJaWYgKGMtPng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9aSEFP
WElOKSB7DQo+PiArCQkvKg0KPj4gKwkJICogQWxsIG5ld2VyIFpoYW94aW4gQ1BVcyBzdXBwb3J0
IE1DRSBicm9hZGNhc3RpbmcuIEVuYWJsZQ0KPj4gKwkJICogc3luY2hyb25pemF0aW9uIHdpdGgg
YSBvbmUgc2Vjb25kIHRpbWVvdXQuDQo+PiArCQkgKi8NCj4+ICsJCWlmICgoYy0+eDg2ID09IDYg
JiYgYy0+eDg2X21vZGVsID09IDB4MTkgJiYNCj4+ICsJCQkoYy0+eDg2X3N0ZXBwaW5nID4gMyAm
JiBjLT54ODZfc3RlcHBpbmcgPCA4KSkgfHwNCj4+ICsJCSAgICAoYy0+eDg2ID09IDYgJiYgYy0+
eDg2X21vZGVsID09IDB4MWYpIHx8DQo+PiArCQkgICAgIGMtPng4NiA+IDYpIHsNCj4NCj5DYW4g
dGhpcyBiZSBzaW1wbGlmaWVkIGludG8gbWF5YmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4NCj4J
aWYgKGMtPng4NiA+IDYgfHwgKGMtPng4Nl9tb2RlbCA9PSAweDE5IHx8IGMtPng4Nl9tb2RlbCA9
PSAweDFmKSkNCj4NCj50aGlzIGlzLCBvZiBjb3Vyc2UsIGFzc3VtaW5nIHRoYXQgWmhhb3hpbiBk
b2Vzbid0IGRvIGZhbWlseSA8IDYgYW5kIHRoYXQNCj50aGUgb3RoZXIgc3RlcHBpbmdzIGZvciBt
b2RlbCAweDE5IGRvbid0IG1hdHRlciBiZWNhdXNlIHRoZXkgZG9uJ3QgZXhpc3QNCj5vciBzby4u
Lg0KPg0KDQpZZXMsIFpoYW94aW4gZG9lc24ndCBkbyBmYW1pbHk8NiwgYW5kIHRoZSBvdGhlciBz
dGVwcGluZ3MgZm9yIG1vZGVsIDB4MTkNCmRvZXNuJ3QgaGF2ZSBNQ0EuIFNvIHdpbGwgc2ltcGxp
ZmllZCBsaWtlIHRoaXM6DQppZiAoYy0+eDg2ID4gNiB8fCAoYy0+eDg2X21vZGVsID09IDB4MTkg
fHwgYy0+eDg2X21vZGVsID09IDB4MWYpKQ0KDQpTaW5jZXJlbHkNClRvbnlXV2FuZy1vYw0KDQo=
