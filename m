Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC42597F4
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgIAQU6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 12:20:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728316AbgIAQU5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Sep 2020 12:20:57 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1FE857F855BC42B7CBD9;
        Tue,  1 Sep 2020 17:20:55 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 1 Sep 2020 17:20:54 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Tue, 1 Sep 2020 17:20:54 +0100
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
Thread-Index: AQHWgG1JK3/pxs0Hy0WMoA7NPJGN4qlT2awA
Date:   Tue, 1 Sep 2020 16:20:54 +0000
Message-ID: <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
 <20200901143539.GC8392@zn.tnic>
In-Reply-To: <20200901143539.GC8392@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.85.84]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2
IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiAwMSBTZXB0ZW1iZXIgMjAyMCAx
NTozNg0KPlRvOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4
LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgdG9ueS5sdWNrQGludGVsLmNvbTsgcmp3QHJqd3lz
b2NraS5uZXQ7DQo+amFtZXMubW9yc2VAYXJtLmNvbTsgbGVuYkBrZXJuZWwub3JnOyBMaW51eGFy
bQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBSQVM6
IEFkZCBDUFUgQ29ycmVjdGFibGUgRXJyb3IgQ29sbGVjdG9yIHRvIGlzb2xhdGUNCj5hbiBlcnJv
bmVvdXMgQ1BVIGNvcmUNCj4NCj5PbiBUdWUsIFNlcCAwMSwgMjAyMCBhdCAwMzowMTo0MFBNICsw
MTAwLCBTaGlqdSBKb3NlIHdyb3RlOg0KPj4gV2hlbiB0aGUgQ1BVIGNvcnJlY3RhYmxlIGVycm9y
cyByZXBvcnRlZCBvbiBhbiBBUk02NCBDUFUgY29yZSB0b28NCj4+IG9mdGVuLCBpdCBzaG91bGQg
YmUgaXNvbGF0ZWQuIEFkZCB0aGUgQ1BVIGNvcnJlY3RhYmxlIGVycm9yIGNvbGxlY3Rvcg0KPj4g
dG8gc3RvcmUgdGhlIENQVSBjb3JyZWN0YWJsZSBlcnJvciBjb3VudC4NCj4+DQo+PiBXaGVuIHRo
ZSBjb3JyZWN0YWJsZSBlcnJvciBjb3VudCBmb3IgYSBDUFUgZXhjZWVkIHRoZSB0aHJlc2hvbGQg
dmFsdWUNCj4+IGluIGEgc2hvcnQgdGltZSBwZXJpb2QsIGl0IHdpbGwgdHJ5IHRvIGlzb2xhdGUg
dGhlIENQVSBjb3JlLg0KPj4gVGhlIHRocmVzaG9sZCB2YWx1ZSwgdGltZSBwZXJpb2QgZXRjIGFy
ZSBjb25maWd1cmFibGUuDQo+Pg0KPj4gSW1wbGVtZW50YXRpb24gZGV0YWlscyBpcyBhZGRlZCBp
biB0aGUgZmlsZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaGlqdSBKb3NlIDxzaGlqdS5qb3Nl
QGh1YXdlaS5jb20+DQo+PiAtLS0NCj4+ICBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL2RlYnVn
ZnMtY3B1LWNlYyB8ICAyMiArKw0KPj4gIGFyY2gvYXJtNjQvcmFzL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgIHwgICA4ICsNCj4+ICBkcml2ZXJzL2FjcGkvYXBlaS9naGVzLmMgICAgICAgICAg
ICAgICAgICB8ICAzMCArLQ0KPj4gIGRyaXZlcnMvcmFzL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxICsNCj4+ICBkcml2ZXJzL3Jhcy9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+PiAgZHJpdmVycy9yYXMvY3B1X2NlYy5jICAgICAgICAgICAgICAgICAg
ICAgfCAzOTMgKysrKysrKysrKysrKysrKysrKysrKw0KPg0KPlNvIGluc3RlYWQgb2YgYWRkaW5n
IHRoZSBhYmlsaXR5IHRvIGNvbGxlY3Qgb3RoZXIgZXJyb3IgdHlwZXMgdG8gdGhlIENFQywgeW91
J3JlDQo+ZHVwbGljYXRpbmcgdGhlIENFQyBpdHNlbGY/IQ0KPg0KPldoeT8NCkNQVSBDRUMgZGVy
aXZlZCB0aGUgaW5mcmFzdHJ1Y3R1cmUgb2YgdGhlIENFQyBvbmx5IGFuZCB0aGUgbG9naWMgdXNl
ZCBpbiB0aGUgQ0VDIGZvcg0KQ0UgY291bnQgc3RvcmFnZSwgQ0UgY291bnQgY2FsY3VsYXRpb24g
YW5kIHBhZ2UgaXNvbGF0aW9uIGlzIHZlcnkgdW5pcXVlIGZvciB0aGUNCm1lbW9yeSBwYWdlcywg
IHdoaWNoIHNlZW1zIGNhbm5vdCBiZSByZXVzYWJsZSBmb3IgdGhlIENQVSBDRXMuIA0KQWxzbyB0
aGUgdmFsdWVzIHNldCBmb3IgdGhlIHBhcmFtZXRlcnMgc3VjaCBhcyB0aHJlc2hvbGQsIHRpbWUg
cGVyaW9kIGZvciB0aGUgbWVtb3J5IGVycm9ycw0KYW5kICBDUFUgZXJyb3JzIHdvdWxkIGJlIGRp
ZmZlcmVudC4NClRodXMgZXh0ZW5kaW5nIGNlYy5jIHRvIHN1cHBvcnQgQ1BVIENFcyB3b3VsZCBp
bmNsdWRlIGFkZGluZyBDUFUgQ0VDIHNwZWNpZmljIGNvZGUNCmZvciBzdG9yaW5nIGVycm9yIGNv
dW50LCBpc29sYXRpb24gZXRjIHdoaWNoIEkgdGhvdWdodCB3b3VsZCByZXN1bHQgdGhlIGNvZGUg
bGVzcyB0aWR5IGFuZA0KbGVzcyByZWFkYWJsZSB1bmxlc3MgZmluZCBtb3JlIHJldXNhYmxlIGxv
Z2ljLg0KDQo+DQo+LS0NCj5SZWdhcmRzL0dydXNzLA0KPiAgICBCb3Jpcy4NCj4NCj5odHRwczov
L3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KDQpUaGFua3Ms
DQpTaGlqdQ0K
