Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64A22FC3AF
	for <lists+linux-edac@lfdr.de>; Tue, 19 Jan 2021 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbhASOhb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jan 2021 09:37:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2368 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389495AbhASKFY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Jan 2021 05:05:24 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKkgx048mz67bwc;
        Tue, 19 Jan 2021 18:01:17 +0800 (CST)
Received: from lhreml717-chm.china.huawei.com (10.201.108.68) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 19 Jan 2021 11:04:24 +0100
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 10:04:24 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.2106.006;
 Tue, 19 Jan 2021 10:04:23 +0000
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
Thread-Index: AQHWzYfjlbqCwiJRuEue7sP+GeTJvaoRjUKAgBcV6jCABVN5gIAA+W4Q
Date:   Tue, 19 Jan 2021 10:04:23 +0000
Message-ID: <51d4ecaf997043718d3066e0a45518d2@huawei.com>
References: <20201208172959.1249-1-shiju.jose@huawei.com>
 <20201208172959.1249-2-shiju.jose@huawei.com> <20201231164409.GC4504@zn.tnic>
 <a5745b56831c461bbb2cde4afc7ee295@huawei.com>
 <20210118183637.GD30090@zn.tnic>
In-Reply-To: <20210118183637.GD30090@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.92.19]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2
IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiAxOCBKYW51YXJ5IDIwMjEgMTg6
MzcNCj5UbzogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiBsaW51eC1l
ZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
Pmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGphbWVzLm1vcnNlQGFybS5jb207DQo+bWNoZWhhYito
dWF3ZWlAa2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsgcmp3QHJqd3lzb2NraS5uZXQ7
DQo+bGVuYkBrZXJuZWwub3JnOyBycmljaHRlckBtYXJ2ZWxsLmNvbTsgSm9uYXRoYW4gQ2FtZXJv
bg0KPjxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB0YW54aWFvZmVpIDx0YW54aWFvZmVp
QGh1YXdlaS5jb20+Ow0KPmxpbnV4YXJtQG9wZW5ldWxlci5vcmcNCj5TdWJqZWN0OiBSZTogW1JG
QyBQQVRDSCAxLzJdIEVEQUMvZ2hlczogQWRkIEVEQUMgZGV2aWNlIGZvciB0aGUgQ1BVDQo+Y2Fj
aGVzDQo+DQo+T24gRnJpLCBKYW4gMTUsIDIwMjEgYXQgMTE6MDY6MzBBTSArMDAwMCwgU2hpanUg
Sm9zZSB3cm90ZToNCj4+IEwyIGNhY2hlIGNvcnJlY3RlZCBlcnJvcnMgYXJlIGRldGVjdGVkIG9j
Y2FzaW9uYWxseSBvbiBmZXcgb2Ygb3VyDQo+PiBBUk02NCBoYXJkd2FyZSBib2FyZHMuIFRob3Vn
aCBpdCBpcyByYXJlLCB0aGUgcHJvYmFiaWxpdHkgb2YgdGhlIENQVQ0KPj4gY2FjaGUgZXJyb3Jz
IGZyZXF1ZW50bHkgb2NjdXJyaW5nIGNhbid0IGJlIGF2b2lkZWQuDQo+PiBUaGUgZWFybGllciBm
YWlsdXJlIGRldGVjdGlvbiBieSBtb25pdG9yaW5nIHRoZSBjYWNoZSBjb3JyZWN0ZWQgZXJyb3Jz
DQo+PiBmb3IgdGhlIGZyZXF1ZW50IG9jY3VycmVuY2VzIGFuZCB0YWtpbmcgcHJldmVudGl2ZSBh
Y3Rpb24gY291bGQNCj4+IHByZXZlbnQgbW9yZSBzZXJpb3VzIGhhcmR3YXJlIGZhdWx0cy4NCj4+
DQo+PiBPbiBJbnRlbCBhcmNoaXRlY3R1cmVzLCBjYWNoZSBjb3JyZWN0ZWQgZXJyb3JzIGFyZSBy
ZXBvcnRlZCBhbmQgdGhlDQo+PiBhZmZlY3RlZCBjb3JlcyBhcmUgb2ZmbGluZSBpbiB0aGUgYXJj
aGl0ZWN0dXJlIHNwZWNpZmljIG1ldGhvZC4NCj4+IGh0dHA6Ly93d3cubWNlbG9nLm9yZy9jYWNo
ZS5odG1sDQo+Pg0KPj4gSG93ZXZlciBmb3IgdGhlIGZpcm13YXJlLWZpcnN0IGVycm9yIHJlcG9y
dGluZywgc3BlY2lmaWNhbGx5IG9uDQo+PiBBUk02NCBhcmNoaXRlY3R1cmVzLCB0aGVyZSBpcyBu
byBwcm92aXNpb24gcHJlc2VudCBmb3IgcmVwb3J0aW5nIHRoZQ0KPj4gY2FjaGUgY29ycmVjdGVk
IGVycm9yIGNvdW50IHRvIHRoZSB1c2VyLXNwYWNlIGFuZCB0YWtpbmcgcHJldmVudGl2ZQ0KPj4g
YWN0aW9uIHN1Y2ggYXMgb2ZmbGluZSB0aGUgYWZmZWN0ZWQgY29yZXMuDQo+DQo+SG93IGhhcmQg
d2FzIGl0IHRvIHdyaXRlIHRoYXQgaW4geW91ciBmaXJzdCBzdWJtaXNzaW9uPyBXaGF0IGRvIHlv
dSB0aGluaw0KPndvdWxkIGJlIHRoZSBiZXN0IHdheSB0byBwZXJzdWFkZSBhIHBhdGNoIHJldmll
d2VyL21haW50YWluZXIgdG8gdGFrZSBhDQo+bG9vayBhdCB5b3VyIHN1Ym1pc3Npb24/DQo+DQo+
PiA+V2h5IGEgc2VwYXJhdGUgS2NvbmZpZyBpdGVtPw0KPj4gQ09ORklHX0VEQUNfR0hFU19DUFVf
Q0FDSEVfRVJST1IgaXMgYWRkZWQgdG8gbWFrZSB0aGlzIGZlYXR1cmUNCj4+IG9wdGlvbmFsIG9u
bHkgZm9yIHRoZSBwbGF0Zm9ybXMgd2hpY2ggbmVlZCB0aGlzIGFuZCBzdXBwb3J0ZWQuDQo+Pg0K
Pj4gPg0KPj4gPj4gKwlkZXBlbmRzIG9uIEVEQUNfR0hFUw0KPg0KPmRlcGVuZHMgb24gRURBQ19H
SEVTIGhhcmRseSBleHByZXNzZXMgd2hpY2ggcGxhdGZvcm1zIG5lZWQgaXQvc3VwcG9ydCBpdC4N
Cj4NCj5JZiBhbnl0aGluZywgZGVwZW5kcyBvbiBBUk02NC4NClN1cmUuIEkgd2lsbCBhZGQgZGVw
ZW5kZW5jeSBvbiBBUk02NC4NClRoaXMgRURBQyBjb2RlIGZvciB0aGUgY2FjaGUgZXJyb3JzIGlz
ICBhcmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQgZm9yIHRoZQ0KZmlybXdhcmUtZmlyc3QgZXJyb3Ig
cmVwb3J0aW5nIGFuZCAgY291bGQgYmUgdXNlZCBmb3Igb3RoZXIgYXJjaGl0ZWN0dXJlcywNCnRo
b3VnaCBub3cgd2UgbmVlZCBpdCBmb3IgdGhlIEFSTTY0LiANCg0KPg0KPj4gPkluaXQgc3R1ZmYg
YmVsb25ncyBpbnRvIGdoZXNfc2Nhbl9zeXN0ZW0oKS4NCj4+ID4NCj4+IERpZCB5b3UgbWVhbiBj
YWxsaW5nICBnaGVzX2VkYWNfY3JlYXRlX2NwdV9kZXZpY2UoKSBpbiB0aGUNCj5naGVzX3NjYW5f
c3lzdGVtKCk/DQo+DQo+SSBtZWFuLCBhbGwgaGFyZHdhcmUgZGlzY292ZXJ5IG5lZWRzIHRvIGhh
cHBlbiBpbiBnaGVzX3NjYW5fc3lzdGVtDQo+LSB5b3UgZG9uJ3QgbmVlZCB0byBjYWxsIHRob3Nl
IGZyb20gb3V0c2lkZSB0aGUgZHJpdmVyLCBpbg0KPmdoZXNfZWRhY19yZWdpc3RlcigpLg0KDQpz
dXJlLiBXaWxsIG1vZGlmeS4NCj4NCj4tLQ0KPlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0K
DQpUaGFua3MsDQpTaGlqdQ0K
