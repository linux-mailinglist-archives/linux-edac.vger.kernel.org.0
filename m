Return-Path: <linux-edac+bounces-2328-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E49B4FFD
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 18:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5081F22F05
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B41CC8BD;
	Tue, 29 Oct 2024 17:00:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3D82876;
	Tue, 29 Oct 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221240; cv=none; b=ixYu/PjTyF/J/TPI5EaLx+4Z63AvvHT0lp8Mer94dZgNn/w0/IpDvJP66OUztx1sRr0ZmXybwqd3Ob1ysWLb3gO44nDbTz15yGxTv7qNm+nRIjrweq358ofcPiCPGTfA/c3zhne+bKPvg6JhC+dtKjIK75xZvk+abfoN4ubYXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221240; c=relaxed/simple;
	bh=YTlJbbrj6Jok3RfWhMxRSCWu4ilkic69q1ZaEUZ95kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXZrfNwgTTpERTpKlrNGNlaFdfv2yg9VQNrN/kr1AUyZK4m17mUPOZD/jvw8FbUwEvCxzRERGcip35qf4uPxHPZFX6B6fwnd8JbtClfsdbcA0zpdvp10Dk5ZPjzFfsT3FkGzj87c/E9Qh+BL1OqnXNFgmqfC/YiaQDmJIVEBKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdGbg3SnJz6L74s;
	Wed, 30 Oct 2024 00:55:43 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DAE6140C72;
	Wed, 30 Oct 2024 01:00:33 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 18:00:33 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 29 Oct 2024 18:00:33 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "leo.duran@amd.com"
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
Subject: RE: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Topic: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Index: AQHbJwFiEsGT6VLXSEWw7XeCpRer7rKd4VaAgAAVoeA=
Date: Tue, 29 Oct 2024 17:00:32 +0000
Message-ID: <e6aed765394b4822ad5a70018c87ef1f@huawei.com>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-8-shiju.jose@huawei.com>
 <3a007a70-136b-4a45-8dd2-d33725ea96bc@intel.com>
In-Reply-To: <3a007a70-136b-4a45-8dd2-d33725ea96bc@intel.com>
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhdmUgSmlhbmcgPGRhdmUu
amlhbmdAaW50ZWwuY29tPg0KPlNlbnQ6IDI5IE9jdG9iZXIgMjAyNCAxNjozMg0KPlRvOiBTaGlq
dSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+Y3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PkNjOiBicEBhbGllbjguZGU7IHRvbnkubHVja0BpbnRlbC5jb207IHJhZmFlbEBrZXJuZWwub3Jn
OyBsZW5iQGtlcm5lbC5vcmc7DQo+bWNoZWhhYkBrZXJuZWwub3JnOyBkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb207IGRhdmVAc3Rnb2xhYnMubmV0OyBKb25hdGhhbg0KPkNhbWVyb24gPGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPnN1ZGVl
cC5ob2xsYUBhcm0uY29tOyBqYXNzaXNpbmdoYnJhckBnbWFpbC5jb207IGFsaXNvbi5zY2hvZmll
bGRAaW50ZWwuY29tOw0KPnZpc2hhbC5sLnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVs
LmNvbTsgZGF2aWRAcmVkaGF0LmNvbTsNCj5WaWxhcy5TcmlkaGFyYW5AYW1kLmNvbTsgbGVvLmR1
cmFuQGFtZC5jb207IFlhemVuLkdoYW5uYW1AYW1kLmNvbTsNCj5yaWVudGplc0Bnb29nbGUuY29t
OyBqaWFxaXlhbkBnb29nbGUuY29tOyBKb24uR3JpbW1AYW1kLmNvbTsNCj5kYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb207IG5hb3lhLmhvcmlndWNoaUBuZWMuY29tOw0KPmphbWVzLm1vcnNlQGFy
bS5jb207IGp0aG91Z2h0b25AZ29vZ2xlLmNvbTsgc29tYXN1bmRhcmFtLmFAaHBlLmNvbTsNCj5l
cmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29nbGUuY29tOyBkdWVud2VuQGdvb2dsZS5j
b207DQo+Z3RoZWxlbkBnb29nbGUuY29tOyB3c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNvbTsN
Cj5kZmVyZ3Vzb25AYW1wZXJlY29tcHV0aW5nLmNvbTsgd2JzQG9zLmFtcGVyZWNvbXB1dGluZy5j
b207DQo+bmlmYW4uY3hsQGdtYWlsLmNvbTsgdGFueGlhb2ZlaSA8dGFueGlhb2ZlaUBodWF3ZWku
Y29tPjsgWmVuZ3RhbyAoQikNCj48cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0byBT
YXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsNCj5rYW5na2FuZy5zaGVuQGZ1dHVyZXdl
aS5jb207IHdhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+Ow0KPkxpbnV4YXJt
IDxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE0IDA3LzE0XSBj
eGwvbWVtZmVhdHVyZTogQWRkIENYTCBtZW1vcnkgZGV2aWNlIHBhdHJvbA0KPnNjcnViIGNvbnRy
b2wgZmVhdHVyZQ0KPg0KPg0KPg0KPk9uIDEwLzI1LzI0IDEwOjEzIEFNLCBzaGlqdS5qb3NlQGh1
YXdlaS5jb20gd3JvdGU6DQo+PiBGcm9tOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5j
b20+DQo+Pg0KPj4gQ1hMIHNwZWMgMy4xIHNlY3Rpb24gOC4yLjkuOS4xMS4xIGRlc2NyaWJlcyB0
aGUgZGV2aWNlIHBhdHJvbCBzY3J1Yg0KPj4gY29udHJvbCBmZWF0dXJlLiBUaGUgZGV2aWNlIHBh
dHJvbCBzY3J1YiBwcm9hY3RpdmVseSBsb2NhdGVzIGFuZCBtYWtlcw0KPj4gY29ycmVjdGlvbnMg
dG8gZXJyb3JzIGluIHJlZ3VsYXIgY3ljbGUuDQo+Pg0KPj4gQWxsb3cgc3BlY2lmeWluZyB0aGUg
bnVtYmVyIG9mIGhvdXJzIHdpdGhpbiB3aGljaCB0aGUgcGF0cm9sIHNjcnViDQo+PiBtdXN0IGJl
IGNvbXBsZXRlZCwgc3ViamVjdCB0byBtaW5pbXVtIGFuZCBtYXhpbXVtIGxpbWl0cyByZXBvcnRl
ZCBieSB0aGUNCj5kZXZpY2UuDQo+PiBBbHNvIGFsbG93IGRpc2FibGluZyBzY3J1YiBhbGxvd2lu
ZyB0cmFkZS1vZmYgZXJyb3IgcmF0ZXMgYWdhaW5zdA0KPj4gcGVyZm9ybWFuY2UuDQo+Pg0KPj4g
QWRkIHN1cHBvcnQgZm9yIHBhdHJvbCBzY3J1YiBjb250cm9sIG9uIENYTCBtZW1vcnkgZGV2aWNl
cy4NCj4+IFJlZ2lzdGVyIHdpdGggdGhlIEVEQUMgZGV2aWNlIGRyaXZlciwgd2hpY2ggcmV0cmll
dmVzIHRoZSBzY3J1Yg0KPj4gYXR0cmlidXRlIGRlc2NyaXB0b3JzIGZyb20gRURBQyBzY3J1YiBh
bmQgZXhwb3NlcyB0aGUgc3lzZnMgc2NydWINCj4+IGNvbnRyb2wgYXR0cmlidXRlcyB0byB1c2Vy
c3BhY2UuIEZvciBleGFtcGxlLCBzY3J1YiBjb250cm9sIGZvciB0aGUNCj4+IENYTCBtZW1vcnkg
ZGV2aWNlICJjeGxfbWVtMCIgaXMgZXhwb3NlZCBpbg0KPi9zeXMvYnVzL2VkYWMvZGV2aWNlcy9j
eGxfbWVtMC9zY3J1YlgvLg0KPj4NCj4+IEFkZGl0aW9uYWxseSwgYWRkIHN1cHBvcnQgZm9yIHJl
Z2lvbi1iYXNlZCBDWEwgbWVtb3J5IHBhdHJvbCBzY3J1YiBjb250cm9sLg0KPj4gQ1hMIG1lbW9y
eSByZWdpb25zIG1heSBiZSBpbnRlcmxlYXZlZCBhY3Jvc3Mgb25lIG9yIG1vcmUgQ1hMIG1lbW9y
eQ0KPj4gZGV2aWNlcy4gRm9yIGV4YW1wbGUsIHJlZ2lvbi1iYXNlZCBzY3J1YiBjb250cm9sIGZv
ciAiY3hsX3JlZ2lvbjEiIGlzDQo+PiBleHBvc2VkIGluIC9zeXMvYnVzL2VkYWMvZGV2aWNlcy9j
eGxfcmVnaW9uMS9zY3J1YlgvLg0KPj4NCj4+IENvLWRldmVsb3BlZC1ieTogSm9uYXRoYW4gQ2Ft
ZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9u
YXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPj4gU2lnbmVkLW9m
Zi1ieTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAgRG9j
dW1lbnRhdGlvbi9lZGFjL2VkYWMtc2NydWIucnN0IHwgIDc0ICsrKysrKw0KPj4gIGRyaXZlcnMv
Y3hsL0tjb25maWcgICAgICAgICAgICAgICB8ICAxOCArKw0KPj4gIGRyaXZlcnMvY3hsL2NvcmUv
TWFrZWZpbGUgICAgICAgICB8ICAgMSArDQo+PiAgZHJpdmVycy9jeGwvY29yZS9tZW1mZWF0dXJl
LmMgICAgIHwgMzgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGRyaXZlcnMv
Y3hsL2NvcmUvcmVnaW9uLmMgICAgICAgICB8ICAgNiArDQo+PiAgZHJpdmVycy9jeGwvY3hsbWVt
LmggICAgICAgICAgICAgIHwgICA3ICsNCj4+ICBkcml2ZXJzL2N4bC9tZW0uYyAgICAgICAgICAg
ICAgICAgfCAgIDQgKw0KPj4gIDcgZmlsZXMgY2hhbmdlZCwgNDkxIGluc2VydGlvbnMoKykNCj4+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9lZGFjL2VkYWMtc2NydWIucnN0ICBj
cmVhdGUgbW9kZQ0KPj4gMTAwNjQ0IGRyaXZlcnMvY3hsL2NvcmUvbWVtZmVhdHVyZS5jDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZWRhYy9lZGFjLXNjcnViLnJzdA0KPj4gYi9E
b2N1bWVudGF0aW9uL2VkYWMvZWRhYy1zY3J1Yi5yc3QNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjRhYWQ0OTc0YjIwOA0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9lZGFjL2VkYWMtc2NydWIucnN0DQo+PiBAQCAtMCwwICsx
LDc0IEBADQo+PiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsNClsu
Li5dDQoNCj4+ICtzdGF0aWMgaW50IGN4bF9tZW1fcHNfZ2V0X2F0dHJzKHN0cnVjdCBjeGxfbWVt
ZGV2X3N0YXRlICptZHMsDQo+PiArCQkJCXN0cnVjdCBjeGxfbWVtZGV2X3BzX3BhcmFtcyAqcGFy
YW1zKSB7DQo+PiArCXNpemVfdCByZF9kYXRhX3NpemUgPSBzaXplb2Yoc3RydWN0IGN4bF9tZW1k
ZXZfcHNfcmRfYXR0cnMpOw0KPj4gKwlzaXplX3QgZGF0YV9zaXplOw0KPj4gKwlzdHJ1Y3QgY3hs
X21lbWRldl9wc19yZF9hdHRycyAqcmRfYXR0cnMgX19mcmVlKGtmcmVlKSA9DQo+PiArCQkJCQkJ
a21hbGxvYyhyZF9kYXRhX3NpemUsDQo+R0ZQX0tFUk5FTCk7DQo+PiArCWlmICghcmRfYXR0cnMp
DQo+PiArCQlyZXR1cm4gLUVOT01FTTsNCj4+ICsNCj4+ICsJZGF0YV9zaXplID0gY3hsX2dldF9m
ZWF0dXJlKG1kcywgY3hsX3BhdHJvbF9zY3J1Yl91dWlkLA0KPj4gKwkJCQkgICAgQ1hMX0dFVF9G
RUFUX1NFTF9DVVJSRU5UX1ZBTFVFLA0KPj4gKwkJCQkgICAgcmRfYXR0cnMsIHJkX2RhdGFfc2l6
ZSk7DQo+PiArCWlmICghZGF0YV9zaXplKQ0KPj4gKwkJcmV0dXJuIC1FSU87DQo+PiArDQo+PiAr
CXBhcmFtcy0+c2NydWJfY3ljbGVfY2hhbmdlYWJsZSA9DQo+RklFTERfR0VUKENYTF9NRU1ERVZf
UFNfU0NSVUJfQ1lDTEVfQ0hBTkdFX0NBUF9NQVNLLA0KPj4gKwkJCQkJCSAgIHJkX2F0dHJzLT5z
Y3J1Yl9jeWNsZV9jYXApOw0KPj4gKwlwYXJhbXMtPmVuYWJsZSA9DQo+RklFTERfR0VUKENYTF9N
RU1ERVZfUFNfRkxBR19FTkFCTEVEX01BU0ssDQo+PiArCQkJCSAgIHJkX2F0dHJzLT5zY3J1Yl9m
bGFncyk7DQo+PiArCXBhcmFtcy0+c2NydWJfY3ljbGVfaHJzID0NCj5GSUVMRF9HRVQoQ1hMX01F
TURFVl9QU19DVVJfU0NSVUJfQ1lDTEVfTUFTSywNCj4+ICsJCQkJCSAgICByZF9hdHRycy0+c2Ny
dWJfY3ljbGVfaHJzKTsNCj4+ICsJcGFyYW1zLT5taW5fc2NydWJfY3ljbGVfaHJzID0NCj5GSUVM
RF9HRVQoQ1hMX01FTURFVl9QU19NSU5fU0NSVUJfQ1lDTEVfTUFTSywNCj4+ICsJCQkJCQlyZF9h
dHRycy0+c2NydWJfY3ljbGVfaHJzKTsNCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4g
Kw0KPj4gK3N0YXRpYyBpbnQgY3hsX3BzX2dldF9hdHRycyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHZv
aWQgKmRydl9kYXRhLA0KPg0KPldvdWxkIGEgdW5pb24gYmUgYmV0dGVyIHRoYW4gYSB2b2lkICpk
cnZfZGF0YSBmb3IgYWxsIHRoZSBwbGFjZXMgdGhpcyBpcyB1c2VkIGFzIGENCj5wYXJhbWV0ZXI/
IEhvdyBtYW55IHZhcmlhdGlvbnMgb2YgdGhpcyBhcmUgdGhlcmU/DQo+DQo+REoNCkhpIERhdmUs
DQoNCkNhbiB5b3UgZ2l2ZSBtb3JlIGluZm8gb24gdGhpcyBnaXZlbiB0aGlzIGlzIGEgZ2VuZXJp
YyBjYWxsYmFjayBmb3IgdGhlIHNjcnViIGNvbnRyb2wgYW5kIGVhY2gNCmltcGxlbWVudGF0aW9u
IHdpbGwgaGF2ZSBpdHMgb3duIGNvbnRleHQgc3RydWN0IChmb3IgZWcuIHN0cnVjdCBjeGxfcGF0
cm9sX3NjcnViX2NvbnRleHQgaGVyZQ0KZm9yIENYTCBzY3J1YiBjb250cm9sKSwgd2hpY2ggaW4g
dHVybiB3aWxsIGJlIHBhc3NlZCBpbiBhbmQgb3V0IGFzIG9wYXF1ZSBkYXRhLg0KDQpUaGFua3Ms
DQpTaGlqdQ0KPg0KPj4gKwkJCSAgICBzdHJ1Y3QgY3hsX21lbWRldl9wc19wYXJhbXMgKnBhcmFt
cykgew0KPj4gKwlzdHJ1Y3QgY3hsX3BhdHJvbF9zY3J1Yl9jb250ZXh0ICpjeGxfcHNfY3R4ID0g
ZHJ2X2RhdGE7DQo+PiArCXN0cnVjdCBjeGxfbWVtZGV2ICpjeGxtZDsNCj4+ICsJc3RydWN0IGN4
bF9kZXZfc3RhdGUgKmN4bGRzOw0KPj4gKwlzdHJ1Y3QgY3hsX21lbWRldl9zdGF0ZSAqbWRzOw0K
Pj4gKwl1MTYgbWluX3NjcnViX2N5Y2xlID0gMDsNCj4+ICsJaW50IGksIHJldDsNCj4+ICsNCj4+
ICsJaWYgKGN4bF9wc19jdHgtPmN4bHIpIHsNCj4+ICsJCXN0cnVjdCBjeGxfcmVnaW9uICpjeGxy
ID0gY3hsX3BzX2N0eC0+Y3hscjsNCj4+ICsJCXN0cnVjdCBjeGxfcmVnaW9uX3BhcmFtcyAqcCA9
ICZjeGxyLT5wYXJhbXM7DQo+PiArDQo+PiArCQlmb3IgKGkgPSBwLT5pbnRlcmxlYXZlX3dheXMg
LSAxOyBpID49IDA7IGktLSkgew0KPj4gKwkJCXN0cnVjdCBjeGxfZW5kcG9pbnRfZGVjb2RlciAq
Y3hsZWQgPSBwLT50YXJnZXRzW2ldOw0KPj4gKw0KPj4gKwkJCWN4bG1kID0gY3hsZWRfdG9fbWVt
ZGV2KGN4bGVkKTsNCj4+ICsJCQljeGxkcyA9IGN4bG1kLT5jeGxkczsNCj4+ICsJCQltZHMgPSB0
b19jeGxfbWVtZGV2X3N0YXRlKGN4bGRzKTsNCj4+ICsJCQlyZXQgPSBjeGxfbWVtX3BzX2dldF9h
dHRycyhtZHMsIHBhcmFtcyk7DQo+PiArCQkJaWYgKHJldCkNCj4+ICsJCQkJcmV0dXJuIHJldDsN
Cj4+ICsNCj4+ICsJCQlpZiAocGFyYW1zLT5taW5fc2NydWJfY3ljbGVfaHJzID4gbWluX3NjcnVi
X2N5Y2xlKQ0KPj4gKwkJCQltaW5fc2NydWJfY3ljbGUgPSBwYXJhbXMtDQo+Pm1pbl9zY3J1Yl9j
eWNsZV9ocnM7DQo+PiArCQl9DQo+PiArCQlwYXJhbXMtPm1pbl9zY3J1Yl9jeWNsZV9ocnMgPSBt
aW5fc2NydWJfY3ljbGU7DQo+PiArCQlyZXR1cm4gMDsNCj4+ICsJfQ0KPj4gKwljeGxtZCA9IGN4
bF9wc19jdHgtPmN4bG1kOw0KPj4gKwljeGxkcyA9IGN4bG1kLT5jeGxkczsNCj4+ICsJbWRzID0g
dG9fY3hsX21lbWRldl9zdGF0ZShjeGxkcyk7DQo+PiArDQo+PiArCXJldHVybiBjeGxfbWVtX3Bz
X2dldF9hdHRycyhtZHMsIHBhcmFtcyk7IH0NCj4+ICsNClsuLi5dDQo+DQoNCg==

