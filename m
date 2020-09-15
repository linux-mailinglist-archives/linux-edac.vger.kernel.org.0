Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6887A26A3AF
	for <lists+linux-edac@lfdr.de>; Tue, 15 Sep 2020 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIOKyi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Sep 2020 06:54:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgIOKyg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Sep 2020 06:54:36 -0400
Received: from lhreml717-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B7335D582F45CD1A2A66;
        Tue, 15 Sep 2020 11:54:33 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 15 Sep 2020 11:54:33 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Tue, 15 Sep 2020 11:54:33 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Robert Richter <rric@kernel.org>
Subject: RE: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Thread-Topic: [PATCH 1/1] EDAC/ghes: Fix for NULL pointer dereference in
 ghes_edac_register()
Thread-Index: AQHWeuBKuvdPb5JTBkWflf4agAVi66lKBfCAgAH3gwCAF7K6gIAF8WQw
Date:   Tue, 15 Sep 2020 10:54:33 +0000
Message-ID: <66270fbc43fc4bd686b638586710d9dd@huawei.com>
References: <20200825130108.2132-1-shiju.jose@huawei.com>
 <20200826085229.GB22390@zn.tnic>
 <cd947c4ec6044521a92e2cc39eae5406@huawei.com>
 <20200911164817.GA19320@zn.tnic>
In-Reply-To: <20200911164817.GA19320@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkuDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5T
ZW50OiAxMSBTZXB0ZW1iZXIgMjAyMCAxNzo0OA0KPlRvOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3Nl
QGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPm1jaGVoYWJAa2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVs
LmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsNCj5MaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNv
bT47IFJvYmVydCBSaWNodGVyIDxycmljQGtlcm5lbC5vcmc+DQo+U3ViamVjdDogUmU6IFtQQVRD
SCAxLzFdIEVEQUMvZ2hlczogRml4IGZvciBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4NCj5n
aGVzX2VkYWNfcmVnaXN0ZXIoKQ0KPg0KPk9uIFRodSwgQXVnIDI3LCAyMDIwIGF0IDAyOjAyOjI3
UE0gKzAwMDAsIFNoaWp1IEpvc2Ugd3JvdGU6DQo+PiBJIHRlc3RlZCB3aXRoIHlvdXIgY2hhbmdl
cyBhbmQgaXQgZml4ZXMgdGhlIGlzc3VlLiAgSSB3aWxsIHNlbmQgdjIuDQo+DQo+QnR3LCBJIGRv
bid0IGtub3cgaG93IGl0IG1hbmFnZWQgdG8gd29yayBvbiB5b3VyIG1hY2hpbmUgYmVjYXVzZSBl
dmVuDQo+d2l0aCB0aGlzIHBhdGNoLCBpdCBpc24ndCBhbGwgZml4ZWQgYmVjYXVzZSBudW1fZGlt
bXMgbmVlZHMgdG8gYmUgY2xlYXJlZCB0b28sDQo+c2VlIGhlcmU6DQoNCkkgZGVidWcgd2l0aCBh
ZGRpbmcgbW9yZSBsb2dzLiANCkkgZm91bmQgdGhhdCBpbiBvdXIgcGxhdGZvcm0gaHctPm51bV9k
aW1tcyB3YXMgMzIgd2hlbiBjYWxsZWQgZ2hlc19lZGFjX3JlZ2lzdGVyKCkgc2Vjb25kIHRpbWUN
CndoZW4gcHJvYmUgYSBuZXcgZ2hlcyBpbnN0YW5jZSwgIHRoZSBjaGVjayAhKGh3LT5udW1fZGlt
bXMgJSAxNikgaW4gdGhlIGVudW1lcmF0ZV9kaW1tcygpIHBhc3NlZCBhbmQgDQppdCBhbGxvY2F0
ZWQgbWVtb3J5IGZvciAgaHctPmRpbW1zLiBUaHVzIGl0IGRpZCBub3QgZmFpbCB3aXRoIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSBpbiBnaGVzX2VkYWNfcmVnaXN0ZXIoKS4NCldpdGggdGhlIHlv
dXIgbmV3IGZpeCBody0+bnVtX2RpbW1zIHJlc2V0IHRvIDAuDQoNCj4NCj4tLS0NCj5Gcm9tOiBC
b3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+RGF0ZTogRnJpLCAxMSBTZXAgMjAyMCAxMjo1
NTo1NSArMDIwMA0KPlN1YmplY3Q6IFtQQVRDSF0gRURBQy9naGVzOiBDbGVhciBzY2FubmVkIGRh
dGEgb24gdW5sb2FkDQo+DQo+Q29tbWl0DQo+DQo+ICBiOTcyZmRiYTg2NjUgKCJFREFDL2doZXM6
IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4NCj5naGVzX2VkYWNfcmVnaXN0ZXIoKSIp
DQo+DQo+ZGlkbid0IGNsZWFyIGFsbCB0aGUgaW5mb3JtYXRpb24gZnJvbSB0aGUgc2Nhbm5lZCBz
eXN0ZW0gYW5kLCBtb3JlDQo+c3BlY2lmaWNhbGx5LCBsZWZ0IGdoZXNfaHcubnVtX2RpbW1zIHRv
IGl0cyBwcmV2aW91cyB2YWx1ZS4gT24gYSBzZWNvbmQgbG9hZA0KPihDT05GSUdfREVCVUdfVEVT
VF9EUklWRVJfUkVNT1ZFPXkpLCB0aGUgZHJpdmVyIHdvdWxkIHVzZSB0aGUNCj5sZWZ0b3ZlciBu
dW1fZGltbXMgdmFsdWUgd2hpY2ggaXMgbm90IDAgYW5kIHRodXMgdGhlIDAgY2hlY2sgaW4NCj5l
bnVtZXJhdGVfZGltbXMoKSB3aWxsIGdldCBieXBhc3NlZCBhbmQgaXQgd291bGQgZ28gZGlyZWN0
bHkgdG8gdGhlIHBvaW50ZXINCj5kZXJlZjoNCj4NCj4gIGQgPSAmaHctPmRpbW1zW2h3LT5udW1f
ZGltbXNdOw0KPg0KPndoaWNoIGlzLCBvZiBjb3Vyc2UsIE5VTEw6DQo+DQo+ICAjUEY6IHN1cGVy
dmlzb3Igd3JpdGUgYWNjZXNzIGluIGtlcm5lbCBtb2RlDQo+ICAjUEY6IGVycm9yX2NvZGUoMHgw
MDAyKSAtIG5vdC1wcmVzZW50IHBhZ2UNCj4gIFBHRCAwIFA0RCAwDQo+ICBPb3BzOiAwMDAyIFsj
MV0gUFJFRU1QVCBTTVANCj4gIENQVTogNyBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWlu
dGVkIDUuOS4wLXJjNCsgIzcNCj4gIEhhcmR3YXJlIG5hbWU6IEdJR0FCWVRFIE1aMDEtQ0UxLTAw
L01aMDEtQ0UxLTAwLCBCSU9TIEYwMg0KPjA4LzI5LzIwMTgNCj4gIFJJUDogMDAxMDplbnVtZXJh
dGVfZGltbXMuY29sZCsweDdiLzB4Mzc1DQo+DQo+UmVzZXQgdGhlIHdob2xlIGdoZXNfaHcgb24g
ZHJpdmVyIHVucmVnaXN0ZXIgc28gdGhhdCBubyBzdGFsZSB2YWx1ZXMgYXJlDQo+dXNlZCBvbiBh
IHNlY29uZCBzeXN0ZW0gc2Nhbi4NCj4NCj5GaXhlczogYjk3MmZkYmE4NjY1ICgiRURBQy9naGVz
OiBGaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluDQo+Z2hlc19lZGFjX3JlZ2lzdGVyKCki
KQ0KPkNjOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+U2lnbmVkLW9mZi1i
eTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KPi0tLQ0KPiBkcml2ZXJzL2VkYWMvZ2hl
c19lZGFjLmMgfCAxICsNCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+ZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9naGVzX2Vk
YWMuYyBpbmRleA0KPmE2YjljMGIyYTE1Yy4uZWI2MDM0YTZmYmJiIDEwMDY0NA0KPi0tLSBhL2Ry
aXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KPisrKyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0K
PkBAIC02MzIsNiArNjMyLDcgQEAgdm9pZCBnaGVzX2VkYWNfdW5yZWdpc3RlcihzdHJ1Y3QgZ2hl
cyAqZ2hlcykNCj4gCW11dGV4X2xvY2soJmdoZXNfcmVnX211dGV4KTsNCj4NCj4gCXN5c3RlbV9z
Y2FubmVkID0gZmFsc2U7DQo+KwltZW1zZXQoJmdoZXNfaHcsIDAsIHNpemVvZihzdHJ1Y3QgZ2hl
c19od19kZXNjKSk7DQo+DQo+IAlpZiAoIXJlZmNvdW50X2RlY19hbmRfdGVzdCgmZ2hlc19yZWZj
b3VudCkpDQo+IAkJZ290byB1bmxvY2s7DQo+LS0NCj4yLjIxLjANCj4NCj4tLQ0KPlJlZ2FyZHMv
R3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9u
b3Rlcy1hYm91dC1uZXRpcXVldHRlDQoNClRoYW5rcywNClNoaWp1DQo=
