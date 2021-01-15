Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA72F7739
	for <lists+linux-edac@lfdr.de>; Fri, 15 Jan 2021 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbhAOLHP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jan 2021 06:07:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2355 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbhAOLHO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Jan 2021 06:07:14 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DHJDV0Qyhz67bNM;
        Fri, 15 Jan 2021 19:02:34 +0800 (CST)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 15 Jan 2021 12:06:31 +0100
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 15 Jan 2021 11:06:31 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.2106.002;
 Fri, 15 Jan 2021 11:06:30 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [RFC PATCH 1/2] EDAC/ghes: Add EDAC device for the CPU caches
Thread-Topic: [RFC PATCH 1/2] EDAC/ghes: Add EDAC device for the CPU caches
Thread-Index: AQHWzYfjlbqCwiJRuEue7sP+GeTJvaoRjUKAgBcV6jA=
Date:   Fri, 15 Jan 2021 11:06:30 +0000
Message-ID: <a5745b56831c461bbb2cde4afc7ee295@huawei.com>
References: <20201208172959.1249-1-shiju.jose@huawei.com>
 <20201208172959.1249-2-shiju.jose@huawei.com> <20201231164409.GC4504@zn.tnic>
In-Reply-To: <20201231164409.GC4504@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.87.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KQXBvbG9naWVzIGZvciB0aGUg
ZGVsYXkuDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2IFBl
dGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiAzMSBEZWNlbWJlciAyMDIwIDE2OjQ0
DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtZWRh
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBqYW1lcy5tb3JzZUBhcm0uY29tOw0KPm1jaGVoYWIraHVh
d2VpQGtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5jb207IHJqd0Byand5c29ja2kubmV0Ow0K
PmxlbmJAa2VybmVsLm9yZzsgcnJpY2h0ZXJAbWFydmVsbC5jb207IExpbnV4YXJtIDxsaW51eGFy
bUBodWF3ZWkuY29tPjsNCj54dXdlaSAoTykgPHh1d2VpNUBodWF3ZWkuY29tPjsgSm9uYXRoYW4g
Q2FtZXJvbg0KPjxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBKb2huIEdhcnJ5IDxqb2hu
LmdhcnJ5QGh1YXdlaS5jb20+Ow0KPnRhbnhpYW9mZWkgPHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47
IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj48c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBo
dWF3ZWkuY29tPjsgU2FsaWwgTWVodGENCj48c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj5TdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCAxLzJdIEVEQUMvZ2hlczogQWRkIEVEQUMgZGV2aWNlIGZvciB0
aGUgQ1BVDQo+Y2FjaGVzDQo+DQo+T24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDU6Mjk6NThQTSAr
MDAwMCwgU2hpanUgSm9zZSB3cm90ZToNCj4+IFRoZSBjb3JyZWN0ZWQgZXJyb3IgY291bnQgb24g
dGhlIENQVSBjYWNoZXMgcmVxdWlyZWQgcmVwb3J0aW5nIHRvIHRoZQ0KPj4gdXNlci1zcGFjZSBm
b3IgdGhlIHByZWRpY3RpdmUgZmFpbHVyZSBhbmFseXNpcy4gRm9yIHRoaXMgcHVycG9zZSwgYWRk
DQo+PiBhbiBFREFDIGRldmljZSBhbmQgZGV2aWNlIGJsb2NrcyBmb3IgdGhlIENQVSBjYWNoZXMg
Zm91bmQuDQo+PiBUaGUgY2FjaGUncyBjb3JyZWN0ZWQgZXJyb3IgY291bnQgd291bGQgYmUgc3Rv
cmVkIGluIHRoZQ0KPj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL2NwdS9jcHUqL2NhY2hlKi9j
ZV9jb3VudC4NCj4NCj5UaGlzIHN0aWxsIGRvZXNuJ3QgYmVnaW4gdG8gZXhwbGFpbiB3aHkgdGhl
IGtlcm5lbCBuZWVkcyB0aGlzLiBJIGhhZCBhbHJlYWR5DQo+YXNrZWQgd2hldGhlciBlcnJvcnMg
aW4gQ1BVIGNhY2hlcyBhcmUgc29tZXRoaW5nIHdoaWNoIGhhcHBlbiBvZnRlbg0KPmVub3VnaCBz
byB0aGF0IHNvZnR3YXJlIHNob3VsZCBjb3VudCB0aGVtIGJ1dCBub3RoaW5nIGNhbWUuIFNvIHBs
cyBqdXN0aWZ5DQo+Zmlyc3Qgd2h5IHRoaXMgd2FudHMgdG8gYmUgYWRkZWQgdG8gdGhlIGtlcm5l
bC4NCg0KTDIgY2FjaGUgY29ycmVjdGVkIGVycm9ycyBhcmUgZGV0ZWN0ZWQgb2NjYXNpb25hbGx5
IG9uIGZldyBvZg0Kb3VyIEFSTTY0IGhhcmR3YXJlIGJvYXJkcy4gVGhvdWdoIGl0IGlzIHJhcmUs
IHRoZSBwcm9iYWJpbGl0eSBvZg0KdGhlIENQVSBjYWNoZSBlcnJvcnMgZnJlcXVlbnRseSBvY2N1
cnJpbmcgY2FuJ3QgYmUgYXZvaWRlZC4NClRoZSBlYXJsaWVyIGZhaWx1cmUgZGV0ZWN0aW9uIGJ5
IG1vbml0b3JpbmcgdGhlIGNhY2hlIGNvcnJlY3RlZA0KZXJyb3JzIGZvciB0aGUgZnJlcXVlbnQg
b2NjdXJyZW5jZXMgYW5kIHRha2luZyBwcmV2ZW50aXZlDQphY3Rpb24gY291bGQgcHJldmVudCBt
b3JlIHNlcmlvdXMgaGFyZHdhcmUgZmF1bHRzLg0KDQpPbiBJbnRlbCBhcmNoaXRlY3R1cmVzLCBj
YWNoZSBjb3JyZWN0ZWQgZXJyb3JzIGFyZSByZXBvcnRlZCBhbmQNCnRoZSBhZmZlY3RlZCBjb3Jl
cyBhcmUgb2ZmbGluZSBpbiB0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIG1ldGhvZC4NCmh0dHA6
Ly93d3cubWNlbG9nLm9yZy9jYWNoZS5odG1sDQoNCkhvd2V2ZXIgZm9yIHRoZSBmaXJtd2FyZS1m
aXJzdCBlcnJvciByZXBvcnRpbmcsIHNwZWNpZmljYWxseSBvbg0KQVJNNjQgYXJjaGl0ZWN0dXJl
cywgdGhlcmUgaXMgbm8gcHJvdmlzaW9uIHByZXNlbnQgZm9yIHJlcG9ydGluZw0KdGhlIGNhY2hl
IGNvcnJlY3RlZCBlcnJvciBjb3VudCB0byB0aGUgdXNlci1zcGFjZSBhbmQgdGFraW5nDQpwcmV2
ZW50aXZlIGFjdGlvbiBzdWNoIGFzIG9mZmxpbmUgdGhlIGFmZmVjdGVkIGNvcmVzLg0KPg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9LY29uZmlnIGIvZHJpdmVycy9lZGFjL0tjb25maWcg
aW5kZXgNCj4+IDdhNDc2ODBkNmYwNy4uYzczZWVhYjI3YWM5IDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9lZGFjL0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+PiBAQCAt
NzQsNiArNzQsMTYgQEAgY29uZmlnIEVEQUNfR0hFUw0KPj4NCj4+ICAJICBJbiBkb3VidCwgc2F5
ICdZJy4NCj4+DQo+PiArY29uZmlnIEVEQUNfR0hFU19DUFVfRVJST1INCj4+ICsJYm9vbCAiRURB
QyBkZXZpY2UgZm9yIHJlcG9ydGluZyBmaXJtd2FyZS1maXJzdCBCSU9TIGRldGVjdGVkIENQVQ0K
PmVycm9yIGNvdW50Ig0KPg0KPldoeSBhIHNlcGFyYXRlIEtjb25maWcgaXRlbT8NCkNPTkZJR19F
REFDX0dIRVNfQ1BVX0NBQ0hFX0VSUk9SIGlzIGFkZGVkIHRvIG1ha2UgdGhpcw0KZmVhdHVyZSBv
cHRpb25hbCBvbmx5IGZvciB0aGUgcGxhdGZvcm1zIHdoaWNoIG5lZWQgdGhpcyBhbmQgc3VwcG9y
dGVkLg0KDQo+DQo+PiArCWRlcGVuZHMgb24gRURBQ19HSEVTDQo+PiArCWhlbHANCj4+ICsJICBF
REFDIGRldmljZSBmb3IgdGhlIGZpcm13YXJlLWZpcnN0IEJJT1MgZGV0ZWN0ZWQgQ1BVIGVycm9y
IGNvdW50DQo+PiArcmVwb3J0ZWQNCj4NCj5XZWxsIHRoaXMgaXMgbm90IHdoYXQgaXQgaXMgZG9p
bmcgLSB5b3UncmUgdGFsa2luZyBhYm91dCBjYWNoZSBlcnJvcnMuDQo+IkNQVSBlcnJvcnMiIGNh
biBiZSBhIGxvdCBtb3JlIHRoYW4ganVzdCBjYWNoZSBlcnJvcnMuDQpTdXJlLiBJIHdpbGwgY2hh
bmdlLg0KDQo+DQo+PiArc3RhdGljIHZvaWQgZ2hlc19lZGFjX2NyZWF0ZV9jcHVfZGV2aWNlKHN0
cnVjdCBkZXZpY2UgKmRldikgew0KPj4gKwlpbnQgY3B1Ow0KPj4gKwlzdHJ1Y3QgY3B1X2NhY2hl
aW5mbyAqdGhpc19jcHVfY2k7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIEZpbmQgdGhlIG1heGlt
dW0gbnVtYmVyIG9mIGNhY2hlcyBwcmVzZW50IGluIHRoZSBDUFUgaGVpcmFyY2h5DQo+PiArCSAq
IGFtb25nIHRoZSBvbmxpbmUgQ1BVcy4NCj4+ICsJICovDQo+PiArCWZvcl9lYWNoX29ubGluZV9j
cHUoY3B1KSB7DQo+PiArCQl0aGlzX2NwdV9jaSA9IGdldF9jcHVfY2FjaGVpbmZvKGNwdSk7DQo+
PiArCQlpZiAoIXRoaXNfY3B1X2NpKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKwkJaWYgKG1heF9u
dW1iZXJfb2ZfY2FjaGVzIDwgdGhpc19jcHVfY2ktPm51bV9sZWF2ZXMpDQo+PiArCQkJbWF4X251
bWJlcl9vZl9jYWNoZXMgPSB0aGlzX2NwdV9jaS0+bnVtX2xlYXZlczsNCj4NCj5TbyB0aGlzIGlz
IGNvdW50aW5nIHRoZSBudW1iZXIgb2YgY2FjaGUgbGV2ZWxzIG9uIHRoZSBzeXN0ZW0/IFNvIHlv
dSB3YW50IHRvDQo+Y291bnQgdGhlIGVycm9ycyBwZXIgY2FjaGUgbGV2ZWxzPw0KWWVzLiBUaGlz
IHdhcyB0aGUgc3VnZ2VzdGlvbiBmcm9tIEphbWVzIGFuZCB0byBvZmZsaW5lIHRoZSBhZmZlY3Rl
ZCBjb3JlcyBmb3IgdGhlIHNoYXJlZCBjYWNoZS4NCg0KPg0KPj4gKwl9DQo+PiArCWlmICghbWF4
X251bWJlcl9vZl9jYWNoZXMpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCS8qDQo+PiArCSAq
IEVEQUMgZGV2aWNlIGludGVyZmFjZSBvbmx5IHN1cHBvcnRzIGNyZWF0aW5nIHRoZSBDUFUgY2Fj
aGUNCj5oaWVyYXJjaHkgZm9yIGFsbHMNCj4+ICsJICogdGhlIENQVXMgdG9nZXRoZXIuIFRodXMg
bmVlZCB0byBhbGxvY2F0ZSBjcHVfZWRhY19ibG9ja19saXN0IGZvcg0KPnRoZQ0KPj4gKwkgKiBt
YXhfbnVtYmVyX29mX2NhY2hlcyBhbW9uZyBhbGwgdGhlIENQVXMgaXJyZXNwZWN0aXZlIG9mIHRo
ZQ0KPm51bWJlciBvZiBjYWNoZXMNCj4+ICsJICogcGVyIENQVSBtaWdodCB2YXJ5Lg0KPj4gKwkg
Ki8NCj4NCj5TbyB0aGlzIGlzIGx1bXBpbmcgYWxsIHRoZSBjYWNoZXMgdG9nZXRoZXIgaW50byBh
IHNpbmdsZSBsaXN0PyBXaGF0IGZvcj8NCj5UbyB1bnRhbmdsZSB0byB0aGUgcHJvcGVyIG9uZXMg
d2hlbiB0aGUgZXJyb3IgZ2V0cyByZXBvcnRlZD8NCj4NCj5IYXZlIHlvdSBoZWFyZCBvZiBwZXJj
cHUgdmFyaWFibGVzPw0KWWVzLiBDaGFuZ2VkIHRoZSBsaXN0IHRvIHRoZSBwZXJjcHUgdmFyaWFi
bGUuDQoNCj4NCj4+IEBAIC02MjQsNiArNzg3LDEwIEBAIGludCBnaGVzX2VkYWNfcmVnaXN0ZXIo
c3RydWN0IGdoZXMgKmdoZXMsIHN0cnVjdA0KPmRldmljZSAqZGV2KQ0KPj4gIAlnaGVzX3B2dCA9
IHB2dDsNCj4+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZ2hlc19sb2NrLCBmbGFncyk7DQo+
Pg0KPj4gKyNpZiBkZWZpbmVkKENPTkZJR19FREFDX0dIRVNfQ1BVX0VSUk9SKQ0KPj4gKwlnaGVz
X2VkYWNfY3JlYXRlX2NwdV9kZXZpY2UoZGV2KTsNCj4+ICsjZW5kaWYNCj4+ICsNCj4NCj5Jbml0
IHN0dWZmIGJlbG9uZ3MgaW50byBnaGVzX3NjYW5fc3lzdGVtKCkuDQo+DQpEaWQgeW91IG1lYW4g
Y2FsbGluZyAgZ2hlc19lZGFjX2NyZWF0ZV9jcHVfZGV2aWNlKCkgaW4gdGhlIGdoZXNfc2Nhbl9z
eXN0ZW0oKT8NCg0KPi4uLg0KPg0KPk9rLCBJJ3ZlIHNlZW4gZW5vdWdoLiAicmVxdWlyZWQgcmVw
b3J0aW5nIHRvIHRoZSB1c2VyLXNwYWNlIGZvciB0aGUgcHJlZGljdGl2ZQ0KPmZhaWx1cmUgYW5h
bHlzaXMuIiBpcyBub3QgZXZlbiB0cnlpbmcgdG8gZXhwbGFpbiAqd2h5KiB5b3UncmUgZG9pbmcg
dGhpcywgd2hhdA0KPiphY3R1YWwqIHByb2JsZW0gaXQgaXMgYWRkcmVzc2luZyBhbmQgd2h5IHNo
b3VsZCB0aGUga2VybmVsIGdldCBpdC4NCj4NCj5BbmQgd2l0aG91dCBhIHByb3BlciBwcm9ibGVt
IGRlZmluaXRpb24gb2Ygd2hhdCB5b3UncmUgdHJ5aW5nIHRvIHNvbHZlLCB0aGlzDQo+aXMgbm90
IGdvaW5nIGFueXdoZXJlLg0KPg0KPi0tDQo+UmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+
DQoNClRoYW5rcywNClNoaWp1DQo=
