Return-Path: <linux-edac+bounces-5320-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB715C3117A
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65CE84E2600
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC32EC576;
	Tue,  4 Nov 2025 12:56:01 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6E2EC542;
	Tue,  4 Nov 2025 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260961; cv=none; b=tivBiUMSGeECCX62X555SSm1X81m60Qj991Y7J3gUV9xoHcxPLg896jPDtxm6zYBPyh87V2astxJc1wAzT3OWaQ0m/bbT3EbNKvkRH5CIKX8ukRudbr1GY2b+jm2cFMbo9cbXLiUIWUpScfnAcAHAUcWpgpB4NMIe2+0uW0y7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260961; c=relaxed/simple;
	bh=6Tz/dGTSyJPmBuJ8bKtv2nx0NsjdqmJRwSE1Z1vQg+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tx/JWEJO1SRqLXxbEBC16U2kNwfhvFZgM5G1OzGx/UQ17HXlcmS2nW7EesblqMSiprrVjx+Hwx1UsrlGzt2S6rfLK9afxJu3RsT0b5HikMQvNO/VXXg0+vybgBRQi6HqBdqMm2fUEcgdhabPCp6puwulpgKJOTShVHr/v8tE4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d17jF0n8nzJ46kC;
	Tue,  4 Nov 2025 20:55:29 +0800 (CST)
Received: from dubpeml100006.china.huawei.com (unknown [7.214.145.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B1121402F3;
	Tue,  4 Nov 2025 20:55:48 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (7.214.145.227) by
 dubpeml100006.china.huawei.com (7.214.145.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 12:55:48 +0000
Received: from dubpeml100008.china.huawei.com ([7.214.145.227]) by
 dubpeml100008.china.huawei.com ([7.214.145.227]) with mapi id 15.02.1544.011;
 Tue, 4 Nov 2025 12:55:48 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: Daniel Ferguson <danielf@os.amperecomputing.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHcHC9WuMPoKRXbY02Oy+WxUZ/jerSMt+SAgAK0t2CAABfigIAEdNLAgAOLbYCAABR4AIACsFkAgBrSt9CAD6pngIAAFX0QgBx0XwCAAX+KcA==
Date: Tue, 4 Nov 2025 12:55:48 +0000
Message-ID: <409217e466a9497697a82e2ac8a6a5f7@huawei.com>
References: <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
 <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
 <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>
 <20251015223242.GBaPAhCuS7YWqu-aH0@fat_crate.local>
 <75e9bae2d30748d5b66c288135915cc3@huawei.com>
 <20251103131914.GEaQir0sdz4Te_ea0l@fat_crate.local>
In-Reply-To: <20251103131914.GEaQir0sdz4Te_ea0l@fat_crate.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBh
bGllbjguZGU+DQo+U2VudDogMDMgTm92ZW1iZXIgMjAyNSAxMzoxOQ0KPlRvOiBTaGlqdSBKb3Nl
IDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IERhbmllbCBGZXJndXNvbiA8ZGFuaWVsZkBv
cy5hbXBlcmVjb21wdXRpbmcuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPjxqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb20+OyByYWZhZWxAa2VybmVsLm9yZzsgYWtwbUBsaW51eC0NCj5mb3VuZGF0
aW9uLm9yZzsgcnBwdEBrZXJuZWwub3JnOyBkZmVyZ3Vzb25AYW1wZXJlY29tcHV0aW5nLmNvbTsg
bGludXgtDQo+ZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LQ0KPmRvY0B2Z2VyLmtlcm5lbC5vcmc7IHRvbnku
bHVja0BpbnRlbC5jb207IGxlbmJAa2VybmVsLm9yZzsNCj5ZYXplbi5HaGFubmFtQGFtZC5jb207
IG1jaGVoYWJAa2VybmVsLm9yZzsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2VpLmNvbT47IHJp
ZW50amVzQGdvb2dsZS5jb207IGppYXFpeWFuQGdvb2dsZS5jb207DQo+Sm9uLkdyaW1tQGFtZC5j
b207IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNv
bTsgamFtZXMubW9yc2VAYXJtLmNvbTsganRob3VnaHRvbkBnb29nbGUuY29tOw0KPnNvbWFzdW5k
YXJhbS5hQGhwZS5jb207IGVyZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207
DQo+ZHVlbndlbkBnb29nbGUuY29tOyBndGhlbGVuQGdvb2dsZS5jb207DQo+d3NjaHdhcnR6QGFt
cGVyZWNvbXB1dGluZy5jb207IHdic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPm5pZmFuLmN4
bEBnbWFpbC5jb207IHRhbnhpYW9mZWkgPHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8g
KEIpDQo+PHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8u
c2Fzc3VAaHVhd2VpLmNvbT47DQo+a2FuZ2thbmcuc2hlbkBmdXR1cmV3ZWkuY29tOyB3YW5naHVp
cWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEy
IDEvMl0gQUNQSTpSQVMyOiBBZGQgQUNQSSBSQVMyIGRyaXZlcg0KPg0KPk9uIEZyaSwgT2N0IDE3
LCAyMDI1IGF0IDEyOjU0OjM2UE0gKzAwMDAsIFNoaWp1IEpvc2Ugd3JvdGU6DQpbLi4uXQ0KPg0K
Pj4gVGhpcyBpcyBmb3IgZGVtYW5kIHNjcnViYmluZyBmZWF0dXJlL3VzZSBjYXNlIHdoZXJlIGEg
c3BlY2lmaWMgYWRkcmVzcw0KPj4gcmFuZ2UgdG8gc2NydWIgYW5kIE9TIG11c3Qgc2V0IHRoZSBt
YW5kYXRvcnkgIHNwZWMgZGVmaW5lZCAgUkFTMiB0YWJsZQ0KPj4gZmllbGQgJ1JlcXVlc3RlZCBB
ZGRyZXNzIFJhbmdlKElOUFVUKScgd2hpbGUgcmVxdWVzdGluZyB0aGUgZGVtYW5kDQo+PiBzY3J1
YmJpbmcgaW4gYSBub2RlLiBIb3BlIHRoZSBmaXJtd2FyZSBjYW4gaWdub3JlIHRoZSByZXF1ZXN0
IGlmIHRoZQ0KPj4gcmVxdWVzdGVkIGFkZHJlc3MgcmFuZ2UgdG8gc2NydWIgaXMgaXJyZWxldmFu
dCBmb3IgYSBub2RlLCBiZWNhdXNlIGluDQo+PiB0aGlzIGFwcHJvYWNoIHdlIGhhdmUgY29tbW9u
IHN5c2ZzIHNjcnViIGNvbnRyb2wgYW5kIGtlcm5lbCBpcw0KPj4gcmVxdWVzdGluZyBkZW1hbmQg
c2NydWJiaW5nIHN5c3RlbS13aWRlIGFjcm9zcyBhbGwgbm9kZXMuDQo+Pg0KPj4gSWYgdGhpcyBh
cHByb2FjaCBpcyBub3QgY29ycmVjdCwgY2FuIHdlIHVzZSAoYikgYXMgYmVsb3c/IHByb3ZpZGlu
ZyB3ZQ0KPj4gbmVlZCB0byBnZXQgUEEgcmFuZ2UgZm9yIHRoZSBub2RlcyBpbiB0aGUgUkFTMiBk
cml2ZXIgIHVzaW5nIHRoZQ0KPj4gZnVuY3Rpb25zIChzdGFydF9wZm4gPSBub2RlX3N0YXJ0X3Bm
bihuaWQpIGFuZCBzaXplX3BmbiA9DQo+PiBub2RlX3NwYW5uZWRfcGFnZXMobmlkKTspIGFzIGlt
cGxlbWVudGVkIGluIHYxMiBhbmQgZGlzY3Vzc2VkIGVhcmxpZXIgaW4gdGhpcw0KPnRocmVhZC4N
Cj4+DQo+DQo+SSdtIHdvbmRlcmluZyBob3cgdXNlZnVsIHRoYXQgYWRkcmVzcyByYW5nZSBzY3J1
YmJpbmcgd291bGQgYmUgYW5kIHdoZXRoZXIgaXQNCj5pcyB3b3J0aCB0aGUgZWZmb3J0Li4uIEkg
Z3Vlc3MgdGhlIGdvYWwgaGVyZSBpcyBzb21ldGhpbmcgYWxvbmcgdGhvc2UgbGluZXM6DQo+Im9o
LCB5b3UganVzdCBoYWQgYW4gZXJyb3IgYXQgYWRkcmVzcyBYLCBzbyBsZXQncyBzY3J1YiBbIEEg
Li4uIFggLi4uIEIgXSB3aXRoIEEgYW5kIEINCj5oYXZpbmcsIGhtLCBkdW5ubywgc3VmZmljaWVu
dCB2YWx1ZXMgdG8gY29udGFpbiBYIGFuZCBwZXJoYXBzIGNvdmVyIHN1ZmZpY2llbnQNCj5yYW5n
ZSB0byBjYXRjaCBlcnJvciBsb2NhbGl0eSBvciB3aGF0bm90Lg0KPg0KPkJ1dCB5b3UnZCBuZWVk
IHRvIGRvIHRoaXMgb25seSB3aGVuIHlvdSBoYXZlIGEgZmF0IG1lbW9yeSBub2RlIGFuZCB3aGVy
ZSB5b3UNCj5zdGFydCBzY3J1YmJpbmcgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgbm9kZSByYW5n
ZSBhbmQgdGhlbiB5b3UnZCBoYXZlIHRvIHdhaXQNCj5mb3IgYSByZWxhdGl2ZWx5IGxvbmcgdGlt
ZSB0byByZWFjaCB0aGUgUEEgWCBhdCBmYXVsdC4uLg0KPg0KPkJ1dCBJIGhhdmUgYSBiZXR0ZXIg
aWRlYTogaG93IGFib3V0IHlvdSBzdGFydCBhdCBYIC0geSwgaS5lLiwgYXQgYW4gYWRkcmVzcyBh
IGJpdA0KPnNtYWxsZXIgdGhhbiB0aGUgbGFzdCByZXBvcnRlZCBvbmUgYW5kIHRoZW4gY29udGlu
dWUgZnJvbSB0aGVyZSBvbiwgcmVhY2ggdGhlDQo+KmVuZCogb2YgdGhlIG5vZGUgYW5kIHRoZW4g
d3JhcGFyb3VuZCB0byB0aGUgYmVnaW5uaW5nIHVudGlsIHlvdSByZWFjaCBYDQo+YWdhaW4/DQo+
DQo+VGhpcyB3YXkgeW91IGRvbid0IG5lZWQgdG8gc3VwcGx5IGFueSByYW5nZSBhbmQgeW91IGFy
ZSBzdGlsbCAib24gdGltZSIgd2hlbg0KPnJlYWN0aW5nIHRvIHRoZSBlcnJvciB3aXRoIHNjcnVi
YmluZy4uLg0KPg0KPkhtbW0/DQpUaGFua3MgQm9yaXNsYXYgZm9yIHRoZSB2YWx1YWJsZSBzdWdn
ZXN0aW9uIGFuZCBpdCBtYWtlIHNlbnNlLiBTaW5jZSBwcmVzZW50bHkgd2UgYXJlDQpub3Qgc3Vy
ZSBob3cgcmVhY2hpbmcgdGhlIGVuZCBvZiB0aGUgbm9kZSB3b3JrIG9uIGluZGl2aWR1YWwgcGxh
dGZvcm1zLCAgY2FuIHdlIGRvDQp0aGlzIGFzIGFuIG9wdGltaXphdGlvbiBpbiB0aGUgbmV4dCBz
dGFnZT8gYW5kIA0KQ2FuIHdlIHN0YXJ0IHdpdGggYmFzaWMgZGVtYW5kIHNjcnViYmluZyB3aXRo
b3V0IGFkZHJlc3MgcmFuZ2UgY29udHJvbCBpbiBzeXNmcywNCmJ1dCB3aXRoIHVzZXIgc3BhY2Ug
c2V0IG9ubHkgc2NydWIgcmF0ZSBhbmQgZW5hYmxlX2RlbWFuZCwga2VybmVsIHNldCB0aGUNCm5v
ZGUncyBhZGRyIHJhbmdlIGFzIFJlcXVlc3RlZCBBZGRyZXNzIFJhbmdlIHRvIHN0YXJ0IHRoZSBk
ZW1hbmQgc2NydWJiaW5nIG9uDQplbnRpcmUgbm9kZSwgYXMgeW91IHN1Z2dlc3RlZD8NCj4NCj4+
IFN1cmUuIFRoZW4gYmFja2dyb3VuZCBzY3J1YmJpbmcgd2lsbCBub3QgYmUgYWxsb3dlZCBpZiBk
ZW1hbmQNCj4+IHNjcnViYmluZyBpcyBpbiBwcm9ncmVzcyBpbiBhIG5vZGUsIGlmIHRoZSBzeXN0
ZW0td2lkZSBzY3J1YiBjb250cm9sIGluIHN5c2ZzIGlzDQo+Y2hvc2VuLg0KPg0KPlNvIGNhbiB0
aGUga2VybmVsIGludGVycnVwdCBiYWNrZ3JvdW5kIHNjcnViYmluZyBvbiBzb21lIG5vZGU/IEJl
Y2F1c2UgdGhlbiBpdA0KPmlzIGVhc3k6DQpSQVMyIFNUT1BfUEFUUk9MX1NDUlVCQkVSICBjb21t
YW5kIGFsbG93cyBpbnRlcnJ1cHRpbmcgYmFja2dyb3VuZCBzY3J1YmJpbmcuICANCj4NCj5Zb3Ug
aW50ZXJydXB0IGJhY2tncm91bmQgc2NydWJiaW5nIHdoZW5ldmVyIG5lZWRlZCB3aXRoIG9uLWRl
bWFuZA0KPnNjcnViYmluZyBvbiB0aGF0IHBhcnRpY3VsYXIgbm9kZS4uLg0KPg0KU3VyZS4gV2ls
bCBkby4NCj5JdCBsb29rcyBsaWtlIGl0IGlzIHN0YXJ0aW5nIHRvIGNyeXN0YWxsaXplLi4uDQo+
DQoNClRoYW5rcywNClNoaWp1DQo=

