Return-Path: <linux-edac+bounces-4987-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B4BBDB5A
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 589C64E983F
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D9242D9F;
	Mon,  6 Oct 2025 10:37:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DC188000;
	Mon,  6 Oct 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747067; cv=none; b=LbsJR0uIvh6R1qpBU41rFTMbGCLV0ljM5dQ8cJw3aZM0abuGASmUr0NJpGT9AYqyoiSghXMEQHb4bv4dFkBG448TV1ynfjsJsT2rWV6uurAW3xyb/7L/zFOqEkU4ClWFRk2RdAYJXOdzU3JbifcVF4KvQ2gIHpspJ5/nSOT4Ulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747067; c=relaxed/simple;
	bh=5a0V+ktkM0zmP/i/KvTfiBf3YEBIe7ryg6F09ELHLbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mANQUkQ86/3n22/wDhxqVXUj4/CAezMGCvZV3InPEOf/kOrIVI4JPacmrn/+M80gkEVpXxYlSIoEm09HYxCTPlBelj+IsNpE9Jt5xqMbdZ37kqaPd2ej/4prB7OgIVT+RBHIwaaxZ0PHBp/gTcdn7IRyX4tlcLPo3HiJA4wHhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgG0z0LfWz6L4xs;
	Mon,  6 Oct 2025 18:37:07 +0800 (CST)
Received: from dubpeml500006.china.huawei.com (unknown [7.214.146.138])
	by mail.maildlp.com (Postfix) with ESMTPS id BC60F1402CB;
	Mon,  6 Oct 2025 18:37:39 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (7.214.145.227) by
 dubpeml500006.china.huawei.com (7.214.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Oct 2025 11:37:39 +0100
Received: from dubpeml100008.china.huawei.com ([7.214.145.227]) by
 dubpeml100008.china.huawei.com ([7.214.145.227]) with mapi id 15.02.1544.011;
 Mon, 6 Oct 2025 11:37:39 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "mchehab@kernel.org" <mchehab@kernel.org>, Linuxarm
	<linuxarm@huawei.com>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHcHC9WuMPoKRXbY02Oy+WxUZ/jerSMt+SAgAK0t2CAABfigIAEdNLAgAOLbYCAABR4AIACsFkAgBrSt9A=
Date: Mon, 6 Oct 2025 10:37:39 +0000
Message-ID: <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
 <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
In-Reply-To: <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMTkgU2VwdGVtYmVyIDIwMjUgMTE6NDANCj5UbzogSm9uYXRoYW4g
Q2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPkNjOiBTaGlqdSBKb3NlIDxz
aGlqdS5qb3NlQGh1YXdlaS5jb20+OyByYWZhZWxAa2VybmVsLm9yZzsgYWtwbUBsaW51eC0NCj5m
b3VuZGF0aW9uLm9yZzsgcnBwdEBrZXJuZWwub3JnOyBkZmVyZ3Vzb25AYW1wZXJlY29tcHV0aW5n
LmNvbTsgbGludXgtDQo+ZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LQ0KPmRvY0B2Z2VyLmtlcm5lbC5vcmc7
IHRvbnkubHVja0BpbnRlbC5jb207IGxlbmJAa2VybmVsLm9yZzsNCj5ZYXplbi5HaGFubmFtQGFt
ZC5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2VpLmNv
bT47IHJpZW50amVzQGdvb2dsZS5jb207IGppYXFpeWFuQGdvb2dsZS5jb207DQo+Sm9uLkdyaW1t
QGFtZC5jb207IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj5uYW95YS5ob3JpZ3VjaGlA
bmVjLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsganRob3VnaHRvbkBnb29nbGUuY29tOw0KPnNv
bWFzdW5kYXJhbS5hQGhwZS5jb207IGVyZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2ds
ZS5jb207DQo+ZHVlbndlbkBnb29nbGUuY29tOyBndGhlbGVuQGdvb2dsZS5jb207DQo+d3NjaHdh
cnR6QGFtcGVyZWNvbXB1dGluZy5jb207IHdic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPm5p
ZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkgPHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFpl
bmd0YW8gKEIpDQo+PHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVydG8gU2Fzc3UgPHJv
YmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47DQo+a2FuZ2thbmcuc2hlbkBmdXR1cmV3ZWkuY29tOyB3
YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjEyIDEvMl0gQUNQSTpSQVMyOiBBZGQgQUNQSSBSQVMyIGRyaXZlcg0KPg0KPk9uIFdlZCwg
U2VwIDE3LCAyMDI1IGF0IDA2OjM2OjA4UE0gKzAxMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6
DQo+PiBUaGlzICdmaXJzdCBjb250aWd1b3VzIHJhbmdlJyBpcyBhbiBhdHRlbXB0IHRvIERUUlQg
aW4gYSBjb3JuZXIgY2FzZQ0KPj4gdGhhdCBpcyByZWFsIGJ1dCB3aGVyZSB0aGVyZSBpcyBub3Qg
YW4gb2J2aW91cyByaWdodCB0aGluZyBkdWUgdG8gc3BlYw0KPmxpbWl0YXRpb25zLg0KPg0KPlRo
YW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGV4cGFuZC4gVGhlIGdpc3Qgb2YgdGhpcyBuZWVk
cyB0byBiZSBpbiBhIGNvbW1pdA0KPm1lc3NhZ2UgZm9yIGZ1dHVyZSByZWZlcmVuY2UuDQo+DQo+
SE9XRVZFUiwgSSdtIHN0aWxsIG5vdCBjbGVhciAqd2h5KiB3ZSdyZSBqdW1waW5nIHRocm91Z2gg
aG9vcHMgd2hpY2ggd2UNCj5wcm9iYWJseSBzZXQgdXAgb3Vyc2VsdmVzIHdpdGhvdXQgZXZlbiBr
bm93aW5nIHdoeS4uLiBhdCBsZWFzdCBpdCBsb29rcyBsaWtlIHRoaXMNCj5mcm9tIHdoZXJlIEkn
bSBzdGFuZGluZy4NCj4NCj5TbyB3aHkgbm90IHN0YXJ0IGEgc2NydWIgb24gdGhlIHdob2xlIHN5
c3RlbT8gV2h5IGRvIHdlIGNhcmU/DQo+DQo+U2NydWIgaXMgImNoZWFwIiBpbiB0aGUgc2Vuc2Ug
dGhhdCBpdCBydW5zIGluIHRoZSBiYWNrZ3JvdW5kIGFuZCBpcyB0aGUgbG93ZXN0DQo+cHJpb3Jp
dHkgYW5kIGV2ZXJ5dGhpbmcgZWxzZSBvdmVycmlkZXMgaXQuDQo+DQo+U28gd2h5IGRlc2lnbiBh
biBpbnRlcmZhY2Ugb25seSB3aGVuIHRoZXJlJ3MgYSBuZWVkIHRvIGRlc2lnbiBvbmUgYW5kIGRv
IHRoZQ0KPnNpbXBsZXN0IHRoaW5nIG5vdywgZm9yIHN0YXJ0ZXJzPyBHYXRoZXIgc29tZSBleHBl
cmllbmNlIGFuZCB0aGVuIGltcnBvdmUgaXQgYnkNCj5hY3R1YWxseSBkZXNpZ25pbmcgYW4gaW50
ZXJmYWNlLi4uDQoNCkhpIEJvcmlzLA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5IGluIHJlcGxheWlu
Zy4NCg0KV2UgaGF2ZSBhIHByb3RvdHlwZSBsb29raW5nIHRvIHNpbXBsaWZ5IHRoaW5ncyBhcyBm
b2xsb3dzIChsZWF2aW5nIHBlciBub2RlIGFuZA0KcmFuZ2UgY29udHJvbCBmb3IgZnV0dXJlIHdv
cmspLCBidXQgYmVmb3JlIEkgcG9zdCBpdCAod2FpdGluZyBmb3IgcmMxKSBJJ2QgbGlrZSB0byBk
aXNjdXNzDQp0aGUgYXBwcm9hY2ggYW5kIGEgZmV3IG9wZW4gcXVlc3Rpb25zIg0KDQoxLlNjcnVi
IHJhdGUNCjEuMS4gU2NydWIgcmF0ZSBpcyBjb21tb24gYWNyb3NzIHRoZSBOVU1BIG5vZGUgZG9t
YWlucy4NCjEuMi4gQ29tbW9uIG1pbiBzY3J1YiByYXRlIGlzIG1heCBvZiBtaW4gc2NydWIgcmF0
ZXMgYWNyb3NzIG5vZGVzLg0KMS4zLiBDb21tb24gbWF4IHNjcnViIHJhdGUgaXMgbWluIG9mIG1h
eCBzY3J1YiByYXRlcyBhY3Jvc3Mgbm9kZXMuDQoxLjQuIFNjcnViIHJhdGUgYWxsb3dlZCB0byBj
aGFuZ2Ugb25seSBpZiBOTyBkZW1hbmQgYW5kIHBhdHJvbA0KICAgc2NydWJiaW5nIGlzIGluIHBy
b2dyZXNzIGFuZCBzaG91bGQgYmUgd2l0aGluIG1pbiBhbmQgbWF4DQogICByYW5nZSBvZiBzY3J1
YiByYXRlcy4NCg0KMi4gRGVtYW5kIHNjcnViYmluZyBhbmQgQmFja2dyb3VuZCAocGF0cm9sKSBz
Y3J1YmJpbmcNCjIuMS4gQmFja2dyb3VuZCBzY3J1YmJpbmcgcmVxdWVzdCBlbmFibGVzIEJHIHNj
cnViYmluZw0KICAgICBvbiBhbGwgTlVNQSBub2Rlcy4NCg0KMi4yLiBGb3IsIGRlbWFuZCBzY3J1
YmJpbmcgcmVxdWVzdCAyIG9wdGlvbnMgYXJlIGlkZW50aWZpZWQsDQogICAgIHdpdGggKGIpIHRy
aWVkLiBQbGVhc2Ugc3VnZ2VzdCB0aGUgcmlnaHQgYXBwcm9hY2g/DQphKSBFbmFibGUgZGVtYW5k
IHNjcnViYmluZyBvbiBhbGwgTlVNQSBub2RlcywgaG9wZSBmb3INCiAgICAgdGhlICdSZXF1ZXN0
ZWQgQWRkcmVzcyBSYW5nZShJTlBVVCknIGZpZWxkLCBjYW4gdXNlDQogICAgIGFkZHJlc3Mgc2V0
IHRvIHNjcnViIGFuZCBQQUdFX1NJWkUob3Igc2ltaWxhcikgZm9yIGFsbCB0aGUNCiAgICAgbm9k
ZXMuIEZvciBSQVMyLCBvbmx5ICdhZGRyJyBzeXNmcyBhdHRyaWJ1dGUgaXMgYWRkZWQgbm93DQog
ICAgIGFuZCAnc2l6ZScgc3lzZnMgYXR0cmlidXRlIGlzIHJlbW92ZWQuDQpiKSBFbmFibGUgZGVt
YW5kIHNjcnViYmluZyBvbiBhIE5VTUEgbm9kZSBmb3Igd2hpY2gNCiAgICAgdGhlIHJlcXVlc3Rl
ZCBhZGRyZXNzIHRvIHNjcnViIGlzIHdpdGhpbiB0aGUgUEEgcmFuZ2Ugb2YNCiAgICAgdGhhdCBu
b2RlLg0KDQoyLjMuIERlbWFuZCBzY3J1YmJpbmcgaXMgbm90IGFsbG93ZWQgd2hlbiBiYWNrZ3Jv
dW5kIHNjcnViYmluZw0KICAgICBpcyBpbiBwcm9ncmVzcy4NCg0KMi40LiBJZiAyLjIuIChiKSBp
cyBjaG9zZW4sIHNob3VsZCBrZXJuZWwgYWxsb3cgQkcNCiAgICAgIHNjcnViYmluZyBvbiByZXN0
IG9mIHRoZSBub2Rlcywgd2hlbiBkZW1hbmQgc2NydWJiaW5nIG9uDQogICAgICBzb21lIG5vZGUv
cyBpcyBpbiBwcm9ncmVzcz8NCg0KMi41IFRoZSBzdGF0dXMgb2YgdGhlIEJHIHNjcnViYmluZyBl
eHBvc2VkIHRvIHRoZSB1c2VyIHNwYWNlDQogICAgaW4gJ2VuYWJsZV9iYWNrZ3JvdW5kJyBzeXNm
cyBhdHRyaWJ1dGUuDQoNCjIuNiBUaGUgc3RhdHVzIG9mIHRoZSBkZW1hbmQgc2NydWJiaW5nIGV4
cG9zZWQgdG8gdGhlDQogICAgICAgdXNlciBzcGFjZSBpbiAnYWRkcicgc3lzZnMgYXR0cmlidXRl
LiBIb3dldmVyIHdoZW4gdGhlDQogICAgICAgZGVtYW5kIHNjcnViYmluZyBpcyBvbiBtdWx0aXBs
ZS9hbGwgbm9kZXMgYXJlIGluIHByb2dyZXNzLA0KICAgICAgIHdoaWNoIGRlbWFuZCBzY3J1YmJp
bmcgc3RhdHVzIGFuZCBhZGRyZXNzIGluICdhZGRyJyBzeXNmcyBhdHRyaWJ1dGUNCiAgICAgICBh
cyBzdGF0dXMgc2hvdWxkIGJlIGV4cG9zZWQgdG8gdGhlIHVzZXIgc3BhY2U/DQphKSBNYXkgYmUg
dGhlIHN0YXR1cyBvZiB0aGUgZmlyc3QgZGV0ZWN0ZWQgbm9kZSB3aXRoIGRlbWFuZCBzY3J1YmJp
bmcNCiAgICAgaXMgaW4gcHJvZ3Jlc3M/DQpiKSBEb2VzIG5vdCBzaG93IHRoZSBzdGF0dXMgYXQg
YWxsLCBqdXN0IGZhaWwgdGhlIHJlcXVlc3QgaWYgdGhlDQogICAgZGVtYW5kIHNjcnViYmluZyBp
cyBhbHJlYWR5IGluIHByb2dyZXNzIG9uIGEgbm9kZS9hbGwgbm9kZXM/DQpjKSAgQW55IG90aGVy
IHN1Z2dlc3Rpb24/DQoNClRoYW5rcywNClNoaWp1DQoNCj4NCj5UaHguDQo+DQo+LS0NCj5SZWdh
cmRzL0dydXNzLA0KPiAgICBCb3Jpcy4NCj4NCj5odHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3Rn
bHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KDQo=

