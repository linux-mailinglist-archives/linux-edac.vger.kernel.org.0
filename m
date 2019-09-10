Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B63CAE53E
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 10:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405076AbfIJISI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Sep 2019 04:18:08 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:17570 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731302AbfIJISI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Sep 2019 04:18:08 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 10 Sep
 2019 16:17:59 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 10 Sep
 2019 16:17:58 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 10 Sep 2019 16:17:58 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
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
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYxIDMvNF0geDg2L21jZTogQWRkIFpoYW94aW4gQ01D?=
 =?gb2312?Q?I_support?=
Thread-Topic: [PATCH v1 3/4] x86/mce: Add Zhaoxin CMCI support
Thread-Index: AdVm9rhzHHwSHU0OR4CG5KfkCNKupP//x2QA//5YiOA=
Date:   Tue, 10 Sep 2019 08:17:58 +0000
Message-ID: <ba29d87f31f24f64b2e8c243ee4e539a@zhaoxin.com>
References: <29e895912c2f4989937fa33d59e55dd9@zhaoxin.com>
 <201909092236.d2tP91A8%lkp@intel.com>
In-Reply-To: <201909092236.d2tP91A8%lkp@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gTW9uLCA5IFNlcCAyMDE5LCBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4gd3Jv
dGU6DQo+SGkgVG9ueSwNCj4NCj5JIGxvdmUgeW91ciBwYXRjaCEgWWV0IHNvbWV0aGluZyB0byBp
bXByb3ZlOg0KDQpHbGFkIHRvIGhlYXIsIHRoYW5rcy4NCg0KPg0KPlthdXRvIGJ1aWxkIHRlc3Qg
RVJST1Igb24gbGludXMvbWFzdGVyXQ0KPltjYW5ub3QgYXBwbHkgdG8gdjUuMy1yYzggbmV4dC0y
MDE5MDkwNF0NCj5baWYgeW91ciBwYXRjaCBpcyBhcHBsaWVkIHRvIHRoZSB3cm9uZyBnaXQgdHJl
ZSwgcGxlYXNlIGRyb3AgdXMgYSBub3RlIHRvIGhlbHANCj5pbXByb3ZlIHRoZSBzeXN0ZW1dDQo+
DQo+dXJsOg0KPmh0dHBzOi8vZ2l0aHViLmNvbS8wZGF5LWNpL2xpbnV4L2NvbW1pdHMvVG9ueS1X
LVdhbmctb2MveDg2LW1jZS1BZGQtWmhhbw0KPnhpbi1NQ0Utc3VwcG9ydC8yMDE5MDkwOS0xOTA0
MzUNCj5jb25maWc6IGkzODYtcmFuZGNvbmZpZy1iMDAyLTIwMTkzNiAoYXR0YWNoZWQgYXMgLmNv
bmZpZykNCj5jb21waWxlcjogZ2NjLTcgKERlYmlhbiA3LjQuMC0xMSkgNy40LjANCj5yZXByb2R1
Y2U6DQo+ICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXggYnVpbGQg
dHJlZQ0KPiAgICAgICAgbWFrZSBBUkNIPWkzODYNCj4NCj5JZiB5b3UgZml4IHRoZSBpc3N1ZSwg
a2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnDQo+UmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90
IDxsa3BAaW50ZWwuY29tPg0KPg0KPkFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+
KToNCj4NCj4+PiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmM6MTc4MDo2OiBlcnJvcjog
cmVkZWZpbml0aW9uIG9mDQo+J21jZV96aGFveGluX2ZlYXR1cmVfaW5pdCcNCj4gICAgdm9pZCBt
Y2Vfemhhb3hpbl9mZWF0dXJlX2luaXQoc3RydWN0IGNwdWluZm9feDg2ICpjKQ0KPiAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNo
L3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmM6NTA6MDoNCj4gICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9tY2UuaDozNTY6MjA6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2YNCj4nbWNlX3poYW94
aW5fZmVhdHVyZV9pbml0JyB3YXMgaGVyZQ0KPiAgICBzdGF0aWMgaW5saW5lIHZvaWQgbWNlX3po
YW94aW5fZmVhdHVyZV9pbml0KHN0cnVjdCBjcHVpbmZvX3g4NiAqYykgeyB9DQo+ICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4NCj52aW0gKy9tY2Vfemhh
b3hpbl9mZWF0dXJlX2luaXQgKzE3ODAgYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+
DQo+ICAxNzc5DQo+PiAxNzgwCXZvaWQgbWNlX3poYW94aW5fZmVhdHVyZV9pbml0KHN0cnVjdCBj
cHVpbmZvX3g4NiAqYykNCj4gIDE3ODEJew0KPiAgMTc4MgkJc3RydWN0IG1jZV9iYW5rICptY2Vf
YmFua3MgPSB0aGlzX2NwdV9wdHIobWNlX2JhbmtzX2FycmF5KTsNCj4gIDE3ODMNCj4gIDE3ODQJ
CS8qDQo+ICAxNzg1CQkgKiBUaGVzZSBDUFVzIGJhbms4IFNWQUQgZXJyb3IgbWF5IGJlIHRyaWdn
ZXJlZCB1bmV4cGVjdGVkDQo+d2hlbg0KPiAgMTc4NgkJICogYnJpbmd1cCB2aXJ0dWFsIG1hY2hp
bmUuIGl0IGlzIG5vdCBoYXJkd2FyZSBidWcuIEFsd2F5cyBkaXNhYmxlDQo+ICAxNzg3CQkgKiBi
YW5rOCBTVkFEIGVycm9yIGJ5IGRlZmF1bHQuDQo+ICAxNzg4CQkgKi8NCj4gIDE3ODkJCWlmICgo
Yy0+eDg2ID09IDYgJiYgYy0+eDg2X21vZGVsID09IDB4MTkgJiYNCj4gIDE3OTAJCQkoYy0+eDg2
X3N0ZXBwaW5nID4gMyAmJiBjLT54ODZfc3RlcHBpbmcgPCA4KSkgfHwNCj4gIDE3OTEJCSAgICAo
Yy0+eDg2ID09IDYgJiYgYy0+eDg2X21vZGVsID09IDB4MWYpIHx8DQo+ICAxNzkyCQkgICAgKGMt
Png4NiA9PSA3ICYmIGMtPng4Nl9tb2RlbCA9PSAweDFiKSkgew0KPiAgMTc5MwkJCWlmICh0aGlz
X2NwdV9yZWFkKG1jZV9udW1fYmFua3MpID4gOCkNCj4gIDE3OTQJCQkJbWNlX2JhbmtzWzhdLmN0
bCA9IDA7DQo+ICAxNzk1CQl9DQo+ICAxNzk2DQo+ICAxNzk3CQlpbnRlbF9pbml0X2NtY2koKTsN
Cj4gIDE3OTgJCW1jZV9hZGp1c3RfdGltZXIgPSBjbWNpX2ludGVsX2FkanVzdF90aW1lcjsNCj4g
IDE3OTkJfQ0KPiAgMTgwMA0KPg0KDQpXaWxsIGZpeCB0aGlzIGlzc3VlIGluIFYyLg0KDQo+LS0t
DQo+MC1EQVkga2VybmVsIHRlc3QgaW5mcmFzdHJ1Y3R1cmUgICAgICAgICAgICAgICAgT3BlbiBT
b3VyY2UgVGVjaG5vbG9neQ0KPkNlbnRlcg0KPmh0dHBzOi8vbGlzdHMuMDEub3JnL3BpcGVybWFp
bC9rYnVpbGQtYWxsICAgICAgICAgICAgICAgICAgIEludGVsIENvcnBvcmF0aW9uDQo=
