Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868ED2546EA
	for <lists+linux-edac@lfdr.de>; Thu, 27 Aug 2020 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgH0OVb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Aug 2020 10:21:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727981AbgH0OVI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Aug 2020 10:21:08 -0400
Received: from lhreml717-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1A92147605A1880C8E57;
        Thu, 27 Aug 2020 15:02:28 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 27 Aug 2020 15:02:27 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Thu, 27 Aug 2020 15:02:27 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Thread-Topic: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Thread-Index: AQHWeuBKuvdPb5JTBkWflf4agAVi66lKBfCAgAH3gwA=
Date:   Thu, 27 Aug 2020 14:02:27 +0000
Message-ID: <cd947c4ec6044521a92e2cc39eae5406@huawei.com>
References: <20200825130108.2132-1-shiju.jose@huawei.com>
 <20200826085229.GB22390@zn.tnic>
In-Reply-To: <20200826085229.GB22390@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.87.119]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGVsbG8gQm9yaXMsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQo+LS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj5Gcm9tOiBsaW51eC1lZGFjLW93bmVyQHZnZXIua2VybmVsLm9yZyBbbWFp
bHRvOmxpbnV4LWVkYWMtDQo+b3duZXJAdmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgQm9y
aXNsYXYgUGV0a292DQo+U2VudDogMjYgQXVndXN0IDIwMjAgMDk6NTINCj5UbzogU2hpanUgSm9z
ZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7IHRv
bnkubHVja0BpbnRlbC5jb207IGphbWVzLm1vcnNlQGFybS5jb207DQo+cnJpY2h0ZXJAbWFydmVs
bC5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggMS8xXSBFREFDL2doZXM6IEZpeCBmb3IgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluDQo+
Z2hlc19lZGFjX3JlZ2lzdGVyKCkNCj4NCj5PbiBUdWUsIEF1ZyAyNSwgMjAyMCBhdCAwMjowMTow
OFBNICswMTAwLCBTaGlqdSBKb3NlIHdyb3RlOg0KPj4gQWZ0ZXIgdGhlICdjb21taXQgYjljYWUy
NzcyOGQxICgiRURBQy9naGVzOiBTY2FuIHRoZSBzeXN0ZW0gb25jZSBvbg0KPmRyaXZlciBpbml0
IiknDQo+PiBhcHBsaWVkLCBmb2xsb3dpbmcgZXJyb3IgaGFzIG9jY3VycmVkIGluIGdoZXNfZWRh
Y19yZWdpc3RlcigpIHdoZW4NCj4+IENPTkZJR19ERUJVR19URVNUX0RSSVZFUl9SRU1PVkUgaXMg
ZW5hYmxlZC4gVGhlIG51bGwNCj5naGVzX2h3LmRpbW1zDQo+PiBwb2ludGVyIGluIHRoZSBtY2lf
Zm9yX2VhY2hfZGltbSgpIG9mIGdoZXNfZWRhY19yZWdpc3RlcigpIGNhdXNlZCB0aGUNCj5lcnJv
ci4NCj4+DQo+PiBUaGUgZXJyb3Igb2NjdXJzIHdoZW4gYWxsIHRoZSBwcmV2aW91c2x5IGluaXRp
YWxpemVkIGdoZXMgaW5zdGFuY2VzDQo+PiBhcmUgcmVtb3ZlZCBhbmQgdGhlbiBwcm9iZSBhIG5l
dyBnaGVzIGluc3RhbmNlLiBJbiB0aGlzIGNhc2UsIHRoZQ0KPj4gZ2hlc19yZWZjb3VudCB3b3Vs
ZCBiZSAwLCBnaGVzX2h3LmRpbW1zIGFuZCBtY2kgYWxyZWFkeSBmcmVlZC4gVGhlDQo+PiBnaGVz
X2h3LmRpbW1zIHdvdWxkIGJlIG51bGwgYmVjYXVzZSBnaGVzX3NjYW5fc3lzdGVtKCkgd291bGQg
bm90IGNhbGwNCj5lbnVtZXJhdGVfZGltbXMoKSBhZ2Fpbi4NCj4NCj5UcnkgdGhlIGJlbG93IGlu
c3RlYWQgYW5kIHNlZSBpZiBpdCBmaXhlcyB0aGUgaXNzdWUgZm9yIHlvdSB0b28uDQo+DQo+SWYg
aXQgZG9lcywgcGxzIHNlbmQgaXQgYXMgdjIgYnV0IGRvIG5vdCBhZGQgdGhlIHNwbGF0IHRvIHRo
ZSBjb21taXQgbWVzc2FnZSAtDQo+dGhhdCdzIGEgbG90IG9mIG5vaXNlIGZvciBzb21ldGhpbmcg
d2hpY2ggaXMgY2xlYXIgd2h5IGl0IGhhcHBlbnMgYW5kIHlvdQ0KPmV4cGxhaW4gaXQgcHJvcGVy
bHkgaW4gdGV4dCBhbnl3YXkuDQoNCkkgdGVzdGVkIHdpdGggeW91ciBjaGFuZ2VzIGFuZCBpdCBm
aXhlcyB0aGUgaXNzdWUuICBJIHdpbGwgc2VuZCB2Mi4NCiANCj4NCj5UaHguDQo+DQo+LS0tDQo+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9naGVz
X2VkYWMuYyBpbmRleA0KPmRhNjBjMjk0NjhhNy4uNTRlYmM4YWZjNmIxIDEwMDY0NA0KPi0tLSBh
L2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KPisrKyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMu
Yw0KPkBAIC01NSw2ICs1NSw4IEBAIHN0YXRpYyBERUZJTkVfU1BJTkxPQ0soZ2hlc19sb2NrKTsg
IHN0YXRpYyBib29sDQo+X19yZWFkX21vc3RseSBmb3JjZV9sb2FkOyAgbW9kdWxlX3BhcmFtKGZv
cmNlX2xvYWQsIGJvb2wsIDApOw0KPg0KPitzdGF0aWMgYm9vbCBzeXN0ZW1fc2Nhbm5lZDsNCj4r
DQo+IC8qIE1lbW9yeSBEZXZpY2UgLSBUeXBlIDE3IG9mIFNNQklPUyBzcGVjICovICBzdHJ1Y3Qg
bWVtZGV2X2RtaV9lbnRyeSB7DQo+IAl1OCB0eXBlOw0KPkBAIC0yMjUsMTQgKzIyNywxMiBAQCBz
dGF0aWMgdm9pZCBlbnVtZXJhdGVfZGltbXMoY29uc3Qgc3RydWN0DQo+ZG1pX2hlYWRlciAqZGgs
IHZvaWQgKmFyZykNCj4NCj4gc3RhdGljIHZvaWQgZ2hlc19zY2FuX3N5c3RlbSh2b2lkKQ0KPiB7
DQo+LQlzdGF0aWMgYm9vbCBzY2FubmVkOw0KPi0NCj4tCWlmIChzY2FubmVkKQ0KPisJaWYgKHN5
c3RlbV9zY2FubmVkKQ0KPiAJCXJldHVybjsNCj4NCj4gCWRtaV93YWxrKGVudW1lcmF0ZV9kaW1t
cywgJmdoZXNfaHcpOw0KPg0KPi0Jc2Nhbm5lZCA9IHRydWU7DQo+KwlzeXN0ZW1fc2Nhbm5lZCA9
IHRydWU7DQo+IH0NCj4NCj4gdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2
LCBzdHJ1Y3QgY3Blcl9zZWNfbWVtX2Vycg0KPiptZW1fZXJyKSBAQCAtNjMxLDYgKzYzMSw4IEBA
IHZvaWQgZ2hlc19lZGFjX3VucmVnaXN0ZXIoc3RydWN0IGdoZXMNCj4qZ2hlcykNCj4NCj4gCW11
dGV4X2xvY2soJmdoZXNfcmVnX211dGV4KTsNCj4NCj4rCXN5c3RlbV9zY2FubmVkID0gZmFsc2U7
DQo+Kw0KPiAJaWYgKCFyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJmdoZXNfcmVmY291bnQpKQ0KPiAJ
CWdvdG8gdW5sb2NrOw0KPg0KPg0KPi0tDQo+UmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+
DQo+aHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUN
Cg0KVGhhbmtzLA0KU2hpanUNCg==
