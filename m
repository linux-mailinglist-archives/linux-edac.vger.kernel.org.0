Return-Path: <linux-edac+bounces-3413-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D3A74A49
	for <lists+linux-edac@lfdr.de>; Fri, 28 Mar 2025 14:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE417A4E64
	for <lists+linux-edac@lfdr.de>; Fri, 28 Mar 2025 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873DF35942;
	Fri, 28 Mar 2025 13:05:27 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F92F37;
	Fri, 28 Mar 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167127; cv=none; b=BNVVhonGVrdypxjwetRGUsGf05LRqZM9MLCiZDoxgistuI4vtuwBBNuPQ6/O69Dok9EHbjTdLKCl/e1tpXMxJgaBDcC1AbMFHkUJmkVQcJ/1NqPoBFLxvK4+LrSHkK50yDx2FeglamtQNYrfTMz3OILMsVyUvLkLhRifvzumzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167127; c=relaxed/simple;
	bh=ShT2PenzU5S5NzCDUYFCGLCJD2T3cC+Uz/7PyWeV60k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dbQgrjHfXz9iSf7jqCHvixtI2PShqM19HNmOv1O9dOdn4J5tJv64voNDim+lxfFG2i7EQE/YIzR4kxIfJnCurZozhNZT/sLAFlfrwNRHPUB/b6oNsXHoxnvJ3uxAbshtICgs9NG0OQj/sT3R5BJkwjyR7T9vVLTLJv/VxWe9hsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZPLND6rMQz689QQ;
	Fri, 28 Mar 2025 21:05:00 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 076131404F5;
	Fri, 28 Mar 2025 21:05:21 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Mar 2025 14:05:20 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 28 Mar 2025 14:05:20 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 7/8] cxl/memfeature: Add CXL memory device soft PPR
 control feature
Thread-Topic: [PATCH v2 7/8] cxl/memfeature: Add CXL memory device soft PPR
 control feature
Thread-Index: AQHbmcK1iSI3dcXpwk+yz+WC3qTrybOHL5sAgAAB6wCAAVqhsA==
Date: Fri, 28 Mar 2025 13:05:20 +0000
Message-ID: <481fb71e2867469d963e74d89a0228be@huawei.com>
References: <20250320180450.539-1-shiju.jose@huawei.com>
 <20250320180450.539-8-shiju.jose@huawei.com>
 <20250327170156.GCZ-WEhNREaxQaH_ya@fat_crate.local>
 <20250327170848.GDZ-WGIM553HJ61xj6@fat_crate.local>
In-Reply-To: <20250327170848.GDZ-WGIM553HJ61xj6@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMjcgTWFyY2ggMjAyNSAxNzowOQ0KPlRvOiBTaGlqdSBKb3NlIDxz
aGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGRh
bi5qLndpbGxpYW1zQGludGVsLmNvbTsgZGF2ZUBzdGdvbGFicy5uZXQ7DQo+Sm9uYXRoYW4gQ2Ft
ZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207
DQo+YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbTsg
aXJhLndlaW55QGludGVsLmNvbTsNCj5kYXZpZEByZWRoYXQuY29tOyBWaWxhcy5TcmlkaGFyYW5A
YW1kLmNvbTsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj50b255Lmx1Y2tAaW50ZWwuY29tOyByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwu
b3JnOw0KPm1jaGVoYWJAa2VybmVsLm9yZzsgbGVvLmR1cmFuQGFtZC5jb207IFlhemVuLkdoYW5u
YW1AYW1kLmNvbTsNCj5yaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBnb29nbGUuY29tOyBK
b24uR3JpbW1AYW1kLmNvbTsNCj5kYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IG5hb3lhLmhv
cmlndWNoaUBuZWMuY29tOw0KPmphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0b25AZ29vZ2xl
LmNvbTsgc29tYXN1bmRhcmFtLmFAaHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2dsZS5jb207IHBn
b25kYUBnb29nbGUuY29tOyBkdWVud2VuQGdvb2dsZS5jb207DQo+Z3RoZWxlbkBnb29nbGUuY29t
OyB3c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNvbTsNCj5kZmVyZ3Vzb25AYW1wZXJlY29tcHV0
aW5nLmNvbTsgd2JzQG9zLmFtcGVyZWNvbXB1dGluZy5jb207DQo+bmlmYW4uY3hsQGdtYWlsLmNv
bTsgdGFueGlhb2ZlaSA8dGFueGlhb2ZlaUBodWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikNCj48cHJp
bWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3
ZWkuY29tPjsNCj5rYW5na2FuZy5zaGVuQGZ1dHVyZXdlaS5jb207IHdhbmdodWlxaWFuZyA8d2Fu
Z2h1aXFpYW5nQGh1YXdlaS5jb20+Ow0KPkxpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNy84XSBjeGwvbWVtZmVhdHVyZTogQWRkIENYTCBtZW1v
cnkgZGV2aWNlIHNvZnQgUFBSDQo+Y29udHJvbCBmZWF0dXJlDQo+DQo+T24gVGh1LCBNYXIgMjcs
IDIwMjUgYXQgMDY6MDE6NTZQTSArMDEwMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPj4gT24g
VGh1LCBNYXIgMjAsIDIwMjUgYXQgMDY6MDQ6NDRQTSArMDAwMCwgc2hpanUuam9zZUBodWF3ZWku
Y29tIHdyb3RlOg0KPj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL21lbV9yZXBhaXIuYyBi
L2RyaXZlcnMvZWRhYy9tZW1fcmVwYWlyLmMNCj4+ID4gaW5kZXggM2IxYTg0NTQ1N2IwLi5iZjdl
MDFhOGI0ZGQgMTAwNzU1DQo+PiA+IC0tLSBhL2RyaXZlcnMvZWRhYy9tZW1fcmVwYWlyLmMNCj4+
ID4gKysrIGIvZHJpdmVycy9lZGFjL21lbV9yZXBhaXIuYw0KPj4gPiBAQCAtNDUsNiArNDUsMTEg
QEAgc3RydWN0IGVkYWNfbWVtX3JlcGFpcl9jb250ZXh0IHsNCj4+ID4gIAlzdHJ1Y3QgYXR0cmli
dXRlX2dyb3VwIGdyb3VwOw0KPj4gPiAgfTsNCj4+ID4NCj4+ID4gK2NvbnN0IGNoYXIgKiBjb25z
dCBlZGFjX3JlcGFpcl90eXBlW10gPSB7DQo+PiA+ICsJW0VEQUNfUFBSXSA9ICJwcHIiLA0KPj4g
PiArfTsNCj4+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGVkYWNfcmVwYWlyX3R5cGUpOw0KPj4NCj4+
IFdoeSBpcyB0aGlzIHRoaW5nIGV4cG9ydGVkIGluc3RlYWQgb2YgYWRkaW5nIGEgZ2V0dGVyIGZ1
bmN0aW9uIGFuZA0KPj4gaGF2aW5nIGFsbCBpdHMgdXNlcnMgcGFzcyBpbiBwcm9wZXIgZGVmaW5l
cyBhcyBhcmd1bWVudHM/DQo+Pg0KPj4gQW5kICJFREFDX1BQUiIgaXMgbm90IGEgcHJvcGVyIGRl
ZmluZSAtIGl0IGRvZXNuJ3QgdGVsbCBtZSB3aGF0IGl0IGlzLg0KPj4NCj4+IEl0IHNob3VsZCBi
ZSBtb3JlIGxpa2VseSBhDQo+Pg0KPj4gRURBQ19SRVBBSVJfUFBSLA0KPj4gRURBQ19SRVBBSVJf
Uk9XX1NQQVJJTkcsDQo+PiBFREFDX1JFUEFJUl9CQU5LX1NQQVJJTkcsDQo+Pg0KPj4gYW5kIHNv
IG9uLg0KDQpIaSBCb3Jpc2xhdiwNCg0KV2lsbCBjaGFuZ2UuDQoNCj4NCj5Mb29raW5nIGF0IHRo
aXMgbW9yZToNCj4NCj4rc3RhdGljIGludCBjeGxfcHByX2dldF9yZXBhaXJfdHlwZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHZvaWQgKmRydl9kYXRhLA0KPisJCQkJICAgY29uc3QgY2hhciAqKnJlcGFp
cl90eXBlKQ0KPit7DQo+KwkqcmVwYWlyX3R5cGUgPSBlZGFjX3JlcGFpcl90eXBlW0VEQUNfUFBS
XTsNCj4rDQo+KwlyZXR1cm4gMDsNCj4rfQ0KPg0KPkNhbiB0aGlzIGJlIGFueSBtb3JlIHNpbGx5
Pw0KPg0KPkFuIG9wcyBtZW1iZXIgd2hpY2ggY29waWVzIGEgc3RyaW5nIHBvaW50ZXIgaW50byBz
b21lIGFyZ3VtZW50LiBXaGF0IGZvcj8NCj4NCj5JZiB0aG9zZSBzdHJpbmdzIGFyZSBmb3IgdXNl
cnNwYWNlLCB3aHkgZG9uJ3QgeW91IHNpbXBseSByZXR1cm4gKm51bWJlcnMqIGFuZA0KPmxldCB1
c2Vyc3BhY2UgY29udmVydCB0aGVtIGludG8gc3RyaW5ncz8NClllcy4gVGhlIEVEQUMgbWVtb3J5
IHJlcGFpciBpbnRlcmZhY2UgZGVmaW5lZCBhcyByZXR1cm4gJ251bWJlcnMnIGZvciB1c2Vyc3Bh
Y2UgdW50aWwgDQp2MTggb2YgdGhlIEVEQUMgc2VyaWVzLiAgQ2hhbmdlZCB0byByZXR1cm4gJ3N0
cmluZycgYXMgTWF1cm8gd2FudGVkLg0KUGxlYXNlIHNlZSBkaXNjdXNzaW9uIGhlcmUuDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAxMTQxNTI2MTcuMTRlYjQxYjVAZm96Lmxhbi8N
Cg0KPg0KVGhhbmtzLA0KU2hpanUNCg==

