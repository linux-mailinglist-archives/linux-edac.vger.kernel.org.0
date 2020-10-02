Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282762816C7
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbgJBPiv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 11:38:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbgJBPiu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 11:38:50 -0400
Received: from lhreml717-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E1DE52450D7A0623FD4C;
        Fri,  2 Oct 2020 16:38:48 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 16:38:48 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Fri, 2 Oct 2020 16:38:48 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
Thread-Topic: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
Thread-Index: AQHWmLdPdbyjNlzT0kmpr3mH9sP7namEMSsAgAASuxA=
Date:   Fri, 2 Oct 2020 15:38:48 +0000
Message-ID: <19a8cc62b11c49e9b584857a6a6664e5@huawei.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
 <20201002124352.GC17436@zn.tnic>
In-Reply-To: <20201002124352.GC17436@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.84.119]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsIEhpIEphbWVzLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+U2VudDogMDIgT2N0b2Jl
ciAyMDIwIDEzOjQ0DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5D
YzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOyBy
andAcmp3eXNvY2tpLm5ldDsNCj5qYW1lcy5tb3JzZUBhcm0uY29tOyBsZW5iQGtlcm5lbC5vcmc7
IExpbnV4YXJtDQo+PGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtSRkMgUEFU
Q0ggMC83XSBSQVMvQ0VDOiBFeHRlbmQgQ0VDIGZvciBlcnJvcnMgY291bnQgY2hlY2sgb24NCj5z
aG9ydCB0aW1lIHBlcmlvZA0KPg0KPk9uIEZyaSwgT2N0IDAyLCAyMDIwIGF0IDAxOjIyOjI4UE0g
KzAxMDAsIFNoaWp1IEpvc2Ugd3JvdGU6DQo+PiBPcGVuIFF1ZXN0aW9ucyBiYXNlZCBvbiB0aGUg
ZmVlZGJhY2sgZnJvbSBCb3JpcywgMS4gQVJNIHByb2Nlc3Nvcg0KPj4gZXJyb3IgdHlwZXMgYXJl
IGNhY2hlL1RMQi9idXMgZXJyb3JzLg0KPj4gICAgW1JlZmVyZW5jZSBOMi40LjQuMSBBUk0gUHJv
Y2Vzc29yIEVycm9yIEluZm9ybWF0aW9uIFVFRkkgU3BlYyB2Mi44XQ0KPj4gQW55IG9mIHRoZSBh
Ym92ZSBlcnJvciB0eXBlcyBzaG91bGQgbm90IGJlIGNvbnNpZGVyIGZvciB0aGUgZXJyb3INCj4+
IGNvbGxlY3Rpb24gYW5kIENQVSBjb3JlIGlzb2xhdGlvbj8NCj4+DQo+PiAyLklmIGRpc2FibGlu
ZyBlbnRpcmUgQ1BVIGNvcmUgaXMgbm90IGFjY2VwdGFibGUsIHBsZWFzZSBzdWdnZXN0DQo+PiBt
ZXRob2QgdG8gZGlzYWJsZSBMMSBhbmQgTDIgY2FjaGUgb24gQVJNNjQgY29yZT8NCj4NCj5Nb3Jl
IG9wZW4gcXVlc3Rpb25zOg0KPg0KPj4gVGhpcyByZXF1aXJlbWVudCBpcyB0aGUgcGFydCBvZiB0
aGUgZWFybHkgZmF1bHQgcHJlZGljdGlvbiBieSB0YWtpbmcNCj4+IGFjdGlvbiB3aGVuIGxhcmdl
IG51bWJlciBvZiBjb3JyZWN0ZWQgZXJyb3JzIHJlcG9ydGVkIG9uIGEgQ1BVIGNvcmUNCj4+IGJl
Zm9yZSBpdCBjYXVzaW5nIHNlcmlvdXMgZmF1bHRzLg0KPg0KPkFuZCBkbyB5b3Uga25vdyBvZiBh
Y3R1YWwgcmVhbC1saWZlIGV4YW1wbGVzIHdoZXJlIHRoaXMgaXMgcmVhbGx5IHRoZSBjYXNlPyBE
bw0KPnlvdSBoYXZlIGFueSB1c2VycyB3aG8gcmVwb3J0IGEgbGFyZ2UgZXJyb3IgY291bnQgb24g
QVJNIENQVXMsIG9yaWdpbmF0aW5nDQo+ZnJvbSB0aGUgY2FjaGVzIGFuZCB0aGF0IHNvbWV0aGlu
ZyBsaWtlIHRoYXQgd291bGQgcmVhbGx5IGhlbHA/DQo+DQo+QmVjYXVzZSBmcm9tIG15IHg4NiBD
UFVzIGxpbWl0ZWQgZXhwZXJpZW5jZSwgdGhlIGNhY2hlIGFycmF5cyBhcmUgbW9zdGx5DQo+Zmlu
ZSBhbmQgZXJyb3JzIHJlcG9ydGVkIHRoZXJlIGFyZSBub3Qgc29tZXRoaW5nIHRoYXQgaGFwcGVu
cyB2ZXJ5DQo+ZnJlcXVlbnRseSBzbyB3ZSBkb24ndCBldmVuIG5lZWQgdG8gY29sbGVjdCBhbmQg
Y291bnQgdGhvc2UuDQo+DQo+U28gaXMgdGhpcyBzb21ldGhpbmcgd2hpY2ggeW91IG5lZWQgdG8g
aGF2ZSBpbiBvcmRlciB0byBjaGVjayBhIGJveA0KPnNvbWV3aGVyZSB0aGF0IHRoZXJlIGlzIHNv
bWUgZnVuY3Rpb25hbGl0eSBvciBpcyB0aGVyZSBhbiBhY3R1YWwgcmVhbC1saWZlIHVzZQ0KPmNh
c2UgYmVoaW5kIGl0IHdoaWNoIGEgY3VzdG9tZXIgaGFzIHJlcXVlc3RlZD8NCldlIGhhdmUgbm90
IGdvdCBhIHJlYWwtbGlmZSBleGFtcGxlIGZvciB0aGlzIGNhc2UuIEhvd2V2ZXIgcmFyZSBlcnJv
cnMNCmxpa2UgdGhpcyBjYW4gb2NjdXIgZnJlcXVlbnRseSBzb21ldGltZXMgYXQgc2NhbGUsIHdo
aWNoIHdvdWxkIGNhdXNlDQptb3JlIHNlcmlvdXMgaXNzdWVzIGlmIG5vdCBoYW5kbGVkLg0KPg0K
Pk9wZW4gcXVlc3Rpb24gZnJvbSBKYW1lcyB3aXRoIG15IHJlcGx5IHRvIGl0Og0KPg0KPk9uIFRo
dSwgT2N0IDAxLCAyMDIwIGF0IDA2OjE2OjAzUE0gKzAxMDAsIEphbWVzIE1vcnNlIHdyb3RlOg0K
Pj4gSWYgdGhlIGNvcnJlY3RlZC1jb3VudCBpcyBhdmFpbGFibGUgc29tZXdoZXJlLCBjYW4ndCB0
aGlzIHBvbGljeSBiZQ0KPj4gbWFkZSBpbiB1c2VyLXNwYWNlPw0KVGhlIGVycm9yIGNvdW50IGlz
IHByZXNlbnQgaW4gdGhlIHN0cnVjdCBjcGVyX2FybV9lcnJfaW5mbywgdGhlIGZpZWxkcyBvZg0K
dGhpcyBzdHJ1Y3R1cmUgIGFyZSBub3QgcmVwb3J0ZWQgdG8gdGhlIHVzZXItc3BhY2UgdGhyb3Vn
aCB0cmFjZSBldmVudHM/DQpQcmVzZW50bHkgdGhlIGZpZWxkcyBvZiB0YWJsZSBzdHJ1Y3QgY3Bl
cl9zZWNfcHJvY19hcm0gb25seSBhcmUgcmVwb3J0ZWQgDQp0byB0aGUgdXNlci1zcGFjZSB0aHJv
dWdoIHRyYWNlLWFybS1ldmVudC4NCkFsc28gdGhlcmUgY2FuIGJlIG11bHRpcGxlIGNwZXJfYXJt
X2Vycl9pbmZvIHBlciBjcGVyX3NlY19wcm9jX2FybS4NClRodXMgSSB0aGluayB0aGlzIG5lZWQg
cmVwb3J0aW5nIHRocm91Z2ggYSBuZXcgdHJhY2UgZXZlbnQ/DQoNCkFsc28gdGhlIGxvZ2ljYWwg
aW5kZXggb2YgYSBDUFUgd2hpY2ggSSB0aGluayBuZWVkIHRvIGV4dHJhY3QgZnJvbSB0aGUgJ21w
aWRyJyBmaWVsZCBvZg0Kc3RydWN0IGNwZXJfc2VjX3Byb2NfYXJtIHVzaW5nIHBsYXRmb3JtIGRl
cGVuZGVudCBrZXJuZWwgZnVuY3Rpb24gZ2V0X2xvZ2ljYWxfaW5kZXgoKS4gICAgDQpUaHVzIGNw
dSBpbmRleCBhbHNvIG5lZWQgdG8gcmVwb3J0IHRvIHRoZSB1c2VyIHNwYWNlLg0KPg0KPllvdSBt
ZWFuIHJhc2RhZW1vbiBnb2VzIGFuZCBvZmZsaW5lcyBDUFVzIHdoZW4gY2VydGFpbiB0aHJlc2hv
bGRzIGFyZQ0KPnJlYWNoZWQ/IFN1cmUuIEl0IHdvdWxkIGJlIG11Y2ggbW9yZSBmbGV4aWJsZSB0
b28uDQpJIHRoaW5rIGFkZGluZyB0aGUgQ1BVIGVycm9yIGNvbGxlY3Rpb24gdG8gdGhlIGtlcm5l
bA0KaGFzIHRoZSBmb2xsb3dpbmcgYWR2YW50YWdlcywNCiAgICAxLiBUaGUgQ1BVIGVycm9yIGNv
bGxlY3Rpb24gYW5kIGlzb2xhdGlvbiB3b3VsZCBub3QgYmUgYWN0aXZlIGlmIHRoZQ0KICAgICAg
ICAgcmFzZGFlbW9uIHN0b3BwZWQgcnVubmluZyBvciBub3QgcnVubmluZyBvbiBhIG1hY2hpbmUu
DQogICAgMi4gUmVjZWl2aW5nIGVycm9ycyBhbmQgaXNvbGF0aW5nIGEgQ1BVIGNvcmUgZnJvbSB0
aGUgdXNlci1zcGFjZSB3b3VsZA0KICAgICAgICBwcm9iYWJseSBkZWxheWVkIG1vcmUsICB3aGVu
IGxhcmdlIG51bWJlciBvZiBlcnJvcnMgYXJlIHJlcG9ydGVkLg0KICAgMy4gU3VwcG9ydGluZyB0
aGUgaW50ZXJmYWNlIGZvciBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMgYW5kICBlcnJvciBzdGF0
aXN0aWNzIGV0Yw0KICAgICAgICBwcm9iYWJseSBlYXN5IHRvIGltcGxlbWVudCBpbiB0aGUga2Vy
bmVsLg0KICAgNC4gVGhlIGludGVyZmFjZSBnaXZlbiBmb3IgZGlzYWJsaW5nIGEgQ1BVIGlzIGVh
c3kgdG8gdXNlIGZyb20gdGhlIGtlcm5lbCBsZXZlbC4NCg0KPg0KPkZpcnN0IHdlIGFuc3dlciBx
dWVzdGlvbnMgYW5kIGRpc2N1c3MsIHRoZW4gd2UgY29kZS4NCj4NCj4tLQ0KPlJlZ2FyZHMvR3J1
c3MsDQo+ICAgIEJvcmlzLg0KPg0KDQpUaGFua3MsDQpTaGlqdQ0KDQo+aHR0cHM6Ly9wZW9wbGUu
a2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg==
