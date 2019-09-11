Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0F2AFA18
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 12:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfIKKNq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 06:13:46 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:52564 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726724AbfIKKNq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Sep 2019 06:13:46 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:13:44 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:13:43 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Wed, 11 Sep 2019 18:13:43 +0800
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
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgNC80XSB4ODYvbWNlOiBBZGQgWmhhb3hpbiBM?=
 =?utf-8?Q?MCE_support?=
Thread-Topic: [PATCH v2 4/4] x86/mce: Add Zhaoxin LMCE support
Thread-Index: AdVnrQawETN/yUVcT86jBiMUKrTywv//yLSA//5cEqA=
Date:   Wed, 11 Sep 2019 10:13:43 +0000
Message-ID: <904ed0781be648fa8a8fdd8af70b6b94@zhaoxin.com>
References: <5f4f8dee1fb24d38aa0ee136c5e98c72@zhaoxin.com>
 <20190910123657.GE23931@zn.tnic>
In-Reply-To: <20190910123657.GE23931@zn.tnic>
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
cCAxMCwgMjAxOSBhdCAwODoyMDowN0FNICswMDAwLCBUb255IFcgV2FuZy1vYyB3cm90ZToNCj4+
IFpoYW94aW4gbmV3ZXIgQ1BVcyBzdXBwb3J0IExNQ0UgdGhhdCBjb21wYXRpYmxlIHdpdGggSW50
ZWwncw0KPj4gIk1hY2hpbmUtQ2hlY2sgQXJjaGl0ZWN0dXJlIiwgc28gYWRkIHN1cHBvcnQgZm9y
IFpoYW94aW4gTE1DRQ0KPj4gaW4gbWNlL2NvcmUuYy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBU
b255IFcgV2FuZy1vYyA8VG9ueVdXYW5nLW9jQHpoYW94aW4uY29tPg0KPj4gLS0tDQo+PiB2MS0+
djI6DQo+PiAgLSBGaXggcmVkZWZpbml0aW9uIG9mICJtY2Vfemhhb3hpbl9mZWF0dXJlX2NsZWFy
Ig0KPj4NCj4+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaCAgICAgfCAgMiArKw0KPj4gIGFy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysr
LS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21jZS5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vbWNlLmgNCj4+IGluZGV4IDA5ODZhMTEuLjAxODQwZWMgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tY2UuaA0KPj4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vbWNlLmgNCj4+IEBAIC0zNTIsOCArMzUyLDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCBtY2VfaHlnb25fZmVhdHVyZV9pbml0KHN0cnVjdA0KPmNwdWluZm9feDg2ICpjKQl7IHJldHVy
biBtY2VfYW0NCj4+DQo+PiAgI2lmZGVmIENPTkZJR19DUFVfU1VQX1pIQU9YSU4NCj4+ICB2b2lk
IG1jZV96aGFveGluX2ZlYXR1cmVfaW5pdChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpOw0KPj4gK3Zv
aWQgbWNlX3poYW94aW5fZmVhdHVyZV9jbGVhcihzdHJ1Y3QgY3B1aW5mb194ODYgKmMpOw0KPj4g
ICNlbHNlDQo+PiAgc3RhdGljIGlubGluZSB2b2lkIG1jZV96aGFveGluX2ZlYXR1cmVfaW5pdChz
dHJ1Y3QgY3B1aW5mb194ODYgKmMpIHsgfQ0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBtY2Vfemhh
b3hpbl9mZWF0dXJlX2NsZWFyKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykgeyB9DQo+PiAgI2VuZGlm
DQo+Pg0KPj4gICNlbmRpZiAvKiBfQVNNX1g4Nl9NQ0VfSCAqLw0KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2Nv
cmUuYw0KPj4gaW5kZXggOGEzNjgzMy4uNTk1ZDNhZjdhYyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvY29yZS5jDQo+PiBAQCAtMTEyOSw2ICsxMTI5LDE3IEBAIHN0YXRpYyBib29sIF9fbWNfY2hl
Y2tfY3Jhc2hpbmdfY3B1KGludCBjcHUpDQo+PiAgCQl1NjQgbWNnc3RhdHVzOw0KPj4NCj4+ICAJ
CW1jZ3N0YXR1cyA9IG1jZV9yZG1zcmwoTVNSX0lBMzJfTUNHX1NUQVRVUyk7DQo+PiArDQo+PiAr
CQlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfWkhBT1hJTikgew0K
Pj4gKwkJCWlmIChtY2dzdGF0dXMgJiBNQ0dfU1RBVFVTX0xNQ0VTKSB7DQo+PiArCQkJCXJldHVy
biBmYWxzZTsNCj4+ICsJCQl9IGVsc2Ugew0KPj4gKwkJCQlpZiAobWNnc3RhdHVzICYgTUNHX1NU
QVRVU19SSVBWKQ0KPj4gKwkJCQkJbWNlX3dybXNybChNU1JfSUEzMl9NQ0dfU1RBVFVTLCAwKTsN
Cj4+ICsJCQkJcmV0dXJuIHRydWU7DQo+PiArCQkJfQ0KPj4gKwkJfQ0KPg0KPlNpbXBsaWZ5Og0K
Pg0KPiAgICAgICAgICAgICAgICBpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9W
RU5ET1JfWkhBT1hJTikgew0KPiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChtY2dzdGF0dXMg
JiBNQ0dfU1RBVFVTX0xNQ0VTKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPgkJfQ0KPg0KPgkJPC0tLSBOb3cgaGVyZSwgb24geW91ciBDUFVzIHdoaWNo
IGRvbid0IHNldCBNQ0dfU1RBVFVTX0xNQ0VTLA0KPml0IHdpbGwgZmFsbGJhY2sgdG8gY2xlYXJp
bmcgdGhlIHN0YXR1cyByZWdpc3Rlci4gSS5lLiwgd2hhdCB5b3UgZG8gaW4gdGhlIGVsc2UNCj5j
bGF1c2UuDQo+DQoNCk9uIFpoYW94aW4gQ1BVcyBkb24ndCBzZXQgTUNHX1NUQVRVU19MTUNFUywg
dG8gYXZvaWQgcmVuZGV6dm91cyB0aW1lb3V0IGlmIA0KdGhpcyBDUFUgaXMgb2ZmbGluZSBvciBj
cmFzaGluZ19jcHUgd2FzIHNldCwgd2Ugd2FudCByZXR1cm4gdHJ1ZSByZWdhcmRsZXNzIG9mDQpN
Q0dfU1RBVFVTX1JJUFYncyBzZXR0aW5nLiANCg0KV2l0aG91dCBteSBlbHNlIGNsYXVzZSwgb3Jp
Z2luYWwgY29kZXMgcmV0dXJuIHRydWUgb25seSB3aGVuIE1DR19TVEFUVVNfUklQVg0KYmUgc2V0
dGVkLg0KDQpGb3IgYmV0dGVyIHJlYWRhYmlsaXR5LCB3aWxsIGFkZCBjb21tZW50IGFuZCBjaGFu
Z2UgY29kaW5nIHN0eWxlIGluIHYzLg0KDQpTaW5jZXJlbHkNClRvbnlXV2FuZy1vYw0K
