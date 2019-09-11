Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF9AFA09
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfIKKLS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Sep 2019 06:11:18 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:56842 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726724AbfIKKLS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Sep 2019 06:11:18 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:11:15 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 18:11:14 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Wed, 11 Sep 2019 18:11:14 +0800
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
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMi80XSB4ODYvbWNlOiBNYWtlIDQgZnVuY3Rp?=
 =?utf-8?Q?ons_non-static?=
Thread-Topic: [PATCH v2 2/4] x86/mce: Make 4 functions non-static
Thread-Index: AdVnqQDOV1imTHrsT2SgiPNqZp0lI///0PUA//6MTLA=
Date:   Wed, 11 Sep 2019 10:11:14 +0000
Message-ID: <511656950c0342178cceb024ece0bf0b@zhaoxin.com>
References: <5b5bf41a26674a1c9d67cd7b3822a304@zhaoxin.com>
 <20190910123741.GG23931@zn.tnic>
In-Reply-To: <20190910123741.GG23931@zn.tnic>
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
cCAxMCwgMjAxOSBhdCAwODoxOToyMEFNICswMDAwLCBUb255IFcgV2FuZy1vYyB3cm90ZToNCj4+
IFRoZXNlIGZ1bmN0aW9ucyBhcmUgZGVjbGFyZWQgc3RhdGljIGFuZCBjYW5ub3QgYmUgdXNlZCBp
biBvdGhlcnMNCj4+IC5jIHNvdXJjZSBmaWxlLiB0aGlzIGNvbW1pdCByZW1vdmVzIHRoZSBzdGF0
aWMgYXR0cmlidXRlIGFuZCBhZGRzDQo+PiB0aGUgZGVjbGFyYXRpb24gdG8gdGhlIGhlYWRlciBm
b3IgdGhlc2UgZnVuY3Rpb25zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRvbnkgVyBXYW5nLW9j
IDxUb255V1dhbmctb2NAemhhb3hpbi5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9pbnRlbC5jICAgIHwgOCArKysrLS0tLQ0KPj4gIGFyY2gveDg2L2tlcm5lbC9jcHUv
bWNlL2ludGVybmFsLmggfCA4ICsrKysrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L21jZS9pbnRlbC5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50ZWwuYw0K
Pj4gaW5kZXggODhjZDk1OS4uZWVlNGIxMiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvbWNlL2ludGVsLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVs
LmMNCj4+IEBAIC00MjMsNyArNDIzLDcgQEAgdm9pZCBjbWNpX2Rpc2FibGVfYmFuayhpbnQgYmFu
aykNCj4+ICAJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNtY2lfZGlzY292ZXJfbG9jaywg
ZmxhZ3MpOw0KPj4gIH0NCj4+DQo+PiAtc3RhdGljIHZvaWQgaW50ZWxfaW5pdF9jbWNpKHZvaWQp
DQo+PiArdm9pZCBpbnRlbF9pbml0X2NtY2kodm9pZCkNCj4+ICB7DQo+PiAgCWludCBiYW5rczsN
Cj4+DQo+PiBAQCAtNDQyLDcgKzQ0Miw3IEBAIHN0YXRpYyB2b2lkIGludGVsX2luaXRfY21jaSh2
b2lkKQ0KPj4gIAljbWNpX3JlY2hlY2soKTsNCj4+ICB9DQo+Pg0KPj4gLXN0YXRpYyB2b2lkIGlu
dGVsX2luaXRfbG1jZSh2b2lkKQ0KPj4gK3ZvaWQgaW50ZWxfaW5pdF9sbWNlKHZvaWQpDQo+PiAg
ew0KPj4gIAl1NjQgdmFsOw0KPj4NCj4+IEBAIC00NTUsNyArNDU1LDcgQEAgc3RhdGljIHZvaWQg
aW50ZWxfaW5pdF9sbWNlKHZvaWQpDQo+PiAgCQl3cm1zcmwoTVNSX0lBMzJfTUNHX0VYVF9DVEws
IHZhbCB8IE1DR19FWFRfQ1RMX0xNQ0VfRU4pOw0KPj4gIH0NCj4+DQo+PiAtc3RhdGljIHZvaWQg
aW50ZWxfY2xlYXJfbG1jZSh2b2lkKQ0KPj4gK3ZvaWQgaW50ZWxfY2xlYXJfbG1jZSh2b2lkKQ0K
Pj4gIHsNCj4+ICAJdTY0IHZhbDsNCj4+DQo+PiBAQCAtNDY3LDcgKzQ2Nyw3IEBAIHN0YXRpYyB2
b2lkIGludGVsX2NsZWFyX2xtY2Uodm9pZCkNCj4+ICAJd3Jtc3JsKE1TUl9JQTMyX01DR19FWFRf
Q1RMLCB2YWwpOw0KPj4gIH0NCj4+DQo+PiAtc3RhdGljIHZvaWQgaW50ZWxfcHBpbl9pbml0KHN0
cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4+ICt2b2lkIGludGVsX3BwaW5faW5pdChzdHJ1Y3QgY3B1
aW5mb194ODYgKmMpDQo+DQo+VGhhdCBvbmUgZG9lc24ndCBuZWVkIHRvIGdldCBleHBvcnRlZC4N
Cj4NCj5UaGlzIGNhbiBlYXNpbHkgYmUgbWlzc2VkIGJlY2F1c2UgeW91J3JlIGV4cG9ydGluZyB0
aGVtIGluIG9uZSBwYXRjaCBhbmQNCj51c2luZyB0aGVtIGluIGFub3RoZXIuIERvIHRoZSBleHBv
cnRzIGluIHRoZSBzYW1lIHBhdGNoIHdoZXJlIHlvdSB1c2UNCj50aGVtIGZvciB0aGUgZmlyc3Qg
dGltZS4NCg0KR290IGl0LCB3aWxsIGZpeCB0aGlzIGluIHYzLg0KDQpTaW5jZXJlbHkNClRvbnlX
V2FuZy1vYw0KDQo=
