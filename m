Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4C2648C1
	for <lists+linux-edac@lfdr.de>; Thu, 10 Sep 2020 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgIJPav (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Sep 2020 11:30:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731307AbgIJPaD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Sep 2020 11:30:03 -0400
Received: from lhreml720-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2BA129CB13D474964D18;
        Thu, 10 Sep 2020 16:29:57 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml720-chm.china.huawei.com (10.201.108.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 10 Sep 2020 16:29:56 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Thu, 10 Sep 2020 16:29:56 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
Thread-Topic: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
Thread-Index: AQHWgG1JK3/pxs0Hy0WMoA7NPJGN4qlT2awAgAxWxYCAAaMi4A==
Date:   Thu, 10 Sep 2020 15:29:56 +0000
Message-ID: <50714e083d55491a8ccf5ad847682d1e@huawei.com>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
 <20200901143539.GC8392@zn.tnic> <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
 <20200909120203.GB12237@zn.tnic>
In-Reply-To: <20200909120203.GB12237@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.89.170]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGVsbG8gQm9yaXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlz
bGF2IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiAwOSBTZXB0ZW1iZXIgMjAy
MCAxMzowMg0KPlRvOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxp
bnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsgcmp3QHJq
d3lzb2NraS5uZXQ7DQo+amFtZXMubW9yc2VAYXJtLmNvbTsgbGVuYkBrZXJuZWwub3JnOyBMaW51
eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBS
QVM6IEFkZCBDUFUgQ29ycmVjdGFibGUgRXJyb3IgQ29sbGVjdG9yIHRvIGlzb2xhdGUNCj5hbiBl
cnJvbmVvdXMgQ1BVIGNvcmUNCj4NCj5PbiBUdWUsIFNlcCAwMSwgMjAyMCBhdCAwNDoyMDo1NFBN
ICswMDAwLCBTaGlqdSBKb3NlIHdyb3RlOg0KPj4gQ1BVIENFQyBkZXJpdmVkIHRoZSBpbmZyYXN0
cnVjdHVyZSBvZiB0aGUgQ0VDIG9ubHkgYW5kIHRoZSBsb2dpYyB1c2VkDQo+PiBpbiB0aGUgQ0VD
IGZvciBDRSBjb3VudCBzdG9yYWdlLCBDRSBjb3VudCBjYWxjdWxhdGlvbiBhbmQgcGFnZQ0KPj4g
aXNvbGF0aW9uIGlzIHZlcnkgdW5pcXVlIGZvciB0aGUgbWVtb3J5IHBhZ2VzLCB3aGljaCBzZWVt
cyBjYW5ub3QgYmUNCj4+IHJldXNhYmxlIGZvciB0aGUgQ1BVIENFcy4NCj4NCj5PaCwgYmVjYXVz
ZSBpdCBzYXZlcyB0aGUgcmVwb3J0ZWQgZXJyb3IncyBQRk4gYW5kIHlvdSB3YW50IHRvIHNhdmUN
Cj4NCj5bQ1BVIG51bSB8IGVycm9yIGNvdW50XQ0KPg0KPj8NClllcy4gDQoNCj4NCj5XZWxsLCB5
b3UgY2FuIGVhc2lseSBjaGFuZ2UgdGhhdCBieSBleHRlbmRpbmcgdGhlIGV4aXN0aW5nIENFQyB0
byBoYXZlIGENCj5kaWZmZXJlbnQgc3RvcmFnZSBmb3JtYXQgZm9yIENQVSBlcnJvcnMsIGkuZS4s
IHVzZSBhIGRpZmZlcmVudCBjZV9hcnJheSB3aGljaA0KPmdldHMgcGFzc2VkIHRvIHRoZSBmdW5j
dGlvbnMgYW55d2F5Lg0KT2suIEhvd2V2ZXIgdGhlIGZ1bmN0aW9ucyBzdWNoIGFzIF9fZmluZF9l
bGVtKCkgdXNlDQptZW1vcnkgc3BlY2lmaWMgUEZOKCkgYW5kIFBBR0VfU0hJRlQuDQoNCj4NCj4+
IEFsc28gdGhlIHZhbHVlcyBzZXQgZm9yIHRoZSBwYXJhbWV0ZXJzIHN1Y2ggYXMgdGhyZXNob2xk
LCB0aW1lIHBlcmlvZA0KPj4gZm9yIHRoZSBtZW1vcnkgZXJyb3JzIGFuZCBDUFUgZXJyb3JzIHdv
dWxkIGJlIGRpZmZlcmVudC4NCj4NCj5BbmQgeW91ciBpbXBsZW1lbnRhdGlvbiB3aXRoIHNsaWRp
bmcgd2luZG93cyBpcyBzbyB0b3RhbGx5IGRpZmZlcmVudCB0aGF0IGl0DQo+d2FycmFudHMgdGhl
IGR1cGxpY2F0aW9uIG9mIHRoZSBjb2RlPyBJIGRvbid0IHRoaW5rIHNvLg0KPg0KPllvdSBjYW4g
dXNlIHRoZSBjdXJyZW50IENFQyB0byBkbyBleGFjdGx5IHdoYXQgeW91IHdhbm5hIGRvLCB3aXRo
IHRoZQ0KPmRlY2F5aW5nIGFuZCBzbyBvbi4NCkkgd2lsbCBjaGVjayB0aGlzLg0KRm9yIENQVSwg
dGhlIGNvcnJlY3RlZCBlcnJvcnMgY291bnQgZm9yIGEgc2hvcnQgdGltZSBwZXJpb2QgdG8gYmUg
Y2hlY2tlZC4NClRodXMgb2xkIGVycm9ycyBvdXRzaWRlIHRoaXMgcGVyaW9kIHdvdWxkIG5vdCBi
ZSBjb25zaWRlcmVkIGFuZCB3b3VsZCBiZSBjbGVhcmVkLiANCkl0IGlzIG5vdCBjbGVhciB0byBt
ZSB3aGV0aGVyIGluIHRoZSBjdXJyZW50IENFQywgdGhlIGNvdW50IGZvciB0aGUgb2xkIGVycm9y
cyBvdXRzaWRlDQphIHRpbWUgcGVyaW9kIHdvdWxkIGJlIGV4Y2x1ZGVkIGZvciB0aGUgdGhyZXNo
b2xkIGNoZWNrIG9yIHJlbW92ZWQ/DQoNCj4NCj5CZWNhdXNlIGFsbCB5b3Ugd2FubmEgZG8gaXMg
Y291bnQgdGhlIGVycm9ycyBhIENQVSB0cmlnZ2VyZWQuDQo+DQo+SG93ZXZlciwgYSBDUFUgY2Fu
IHRyaWdnZXIgYSAqbG90KiBvZiBkaWZmZXJlbnQgdHlwZXMgb2YgZXJyb3JzLg0KPllvdSdyZSBw
dXR0aW5nIHRoZW0gYWxsIGluIHRoZSBzYW1lIGJhc2tldCBieSBkb2luZzoNCj4NCj4gICAgICAg
ICAgICAgICAgZWxzZSBpZiAoZ3VpZF9lcXVhbChzZWNfdHlwZSwgJkNQRVJfU0VDX1BST0NfQVJN
KSkNCj4JCQkvKiBhZGQgdG8gQ0VDICovDQo+DQo+YW5kIG9ubHkgZm9yIGNvcnJlY3RhYmxlLg0K
Pg0KPldoYXQgdHlwZSBvZiBlcnJvcnMgZ2V0IHJlcG9ydGVkIGluIENQRVJfU0VDX1BST0NfQVJN
Pw0KQWNjb3JkaW5nIHRvIHRoZSBBUk0gUHJvY2Vzc29yIENQRVIgZGVmaW5pdGlvbiB0aGUgZXJy
b3IgdHlwZXMgcmVwb3J0ZWQgYXJlDQpDYWNoZSBFcnJvciwgVExCIEVycm9yLCBCdXMgRXJyb3Ig
YW5kIG1pY3JvLWFyY2hpdGVjdHVyYWwgRXJyb3IuDQoNCj4NCj5JZiB0aGV5J3JlIGFsbCBsdW1w
ZWQgdG9nZXRoZXIgYW5kIGlmIHNvbWUgZnVuY3Rpb25hbCB1bml0IGdlbmVyYXRlcyBhIGxvdCBv
Zg0KPmVycm9ycywgaW5zdGVhZCBvZiBkaXNhYmxpbmcgdGhhdCB1bml0IG9ubHksIHlvdSdsbCBn
byBhbmQgcmVtb3ZlIHRoZSB3aG9sZQ0KPkNQVT8NCj4NCkZldyB0aG91Z2h0cyBvbiB0aGlzLA0K
MS4gTm90IHN1cmUgd2lsbCBhIENQVSBjb3JlIHdvdWxkIHdvcmsvcGVyZm9ybSBhcyBub3JtYWwg
YWZ0ZXIgZGlzYWJsaW5nDQphIGZ1bmN0aW9uYWwgdW5pdD8NCjIuIFN1cHBvcnQgaW4gdGhlIEhX
IHRvIGRpc2FibGUgYSBmdW5jdGlvbiB1bml0IGFsb25lIG1heSBub3QgYXZhaWxhYmxlLg0KMy4g
SWYgaXQgaXMgcmVxdWlyZSB0byBzdG9yZSBhbmQgcmV0cmlldmUgdGhlIGVycm9yIGNvdW50IGJh
c2VkIG9uIGZ1bmN0aW9uYWwgdW5pdCwNCiAgICB0aGVuIENFQyB3aWxsIGJlY29tZSBtb3JlIGNv
bXBsZXg/DQoNCj5Eb2Vzbid0IG1ha2UgYSB3aG9sZSBsb3Qgb2Ygc2Vuc2UgdG8gbWUuDQo+DQo+
SG93IGFib3V0IHlvdSBkZWZpbmUgd2hhdCBleGFjdGx5IHlvdSdyZSB0cnlpbmcgdG8gc29sdmUs
IG1heWJlIGdpdmUgYW4NCj5leGFtcGxlIG9mIGEgcmVhbCBpc3N1ZSBzb21lb25lIGlzIGVuY291
bnRlcmluZyBhbmQgeW91J3JlIHRyeWluZyB0bw0KPmFkZHJlc3M/IEJlY2F1c2UgdGhlcmUgd2Fz
IG5ldmVyIGEgbmVjZXNzaXR5IHNvIGZhciB0byBkaXNhYmxlIENQVXMgb24NCj54ODYgZHVlIHRv
IGNvcnJlY3RhYmxlIGVycm9ycy4gV2h5IGlzIHRoYXQgbmVlZGVkIG9uIEFSTT8NCj4NClRoaXMg
cmVxdWlyZW1lbnQgaXMgdGhlIHBhcnQgb2YgdGhlIGVhcmx5IGZhdWx0IHByZWRpY3Rpb24gYnkg
dGFraW5nIGFjdGlvbg0Kd2hlbiBsYXJnZSBudW1iZXIgb2YgY29ycmVjdGVkIGVycm9ycyByZXBv
cnRlZCBvbiBhIENQVSBjb3JlDQpiZWZvcmUgaXQgY2F1c2luZyBzZXJpb3VzIGZhdWx0cy4gDQpX
ZSBhcmUgbWFpbmx5IGxvb2tpbmcgZm9yIGRpc2FibGUgQ1BVIGNvcmUgb24gbGFyZ2UgbnVtYmVy
IG9mIEwxL0wyIGNhY2hlDQpjb3JyZWN0ZWQgZXJyb3JzICByZXBvcnRlZCBvbiBhIENQVSBjb3Jl
LiBDYW4gd2UgYWRkIGF0bGVhc3QgcmVtb3ZpbmcgQ1BVIGNvcmUNCmZvciB0aGUgQ1BVIGNhY2hl
IGNvcnJlY3RlZCBlcnJvcnMgZmlsdGVyaW5nIG91dCBvdGhlciBlcnJvciB0eXBlcz8NCiANClsu
Li5dDQoNClRoYW5rcywNClNoaWp1DQoNCg==
