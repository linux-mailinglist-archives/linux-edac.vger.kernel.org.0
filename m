Return-Path: <linux-edac+bounces-1715-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1952C95A27C
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34B1282040
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7C14D428;
	Wed, 21 Aug 2024 16:11:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2865113AA2F;
	Wed, 21 Aug 2024 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256691; cv=none; b=nvnSKjS5BBFb3K8xubTOQHvxxmxSRMA9rsI9S0kXAghX+hLbla7o0FCnNfRV0fy/N2R/17ssmrllLhWFjkIxdQLvcHWAZ/T0womd6UlDh67/tydAY7uu1+fIZambmZ7C2aYjzCZCEc5SbIjzKA9ao+exkG+K7pakxVmav6InFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256691; c=relaxed/simple;
	bh=ZBZi7s9YHCsJoMmlbxbtRtJFRO0vnJ9ouF0XNdiT1jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pM45gfJsp80TDeYkZ0DoUr9QhwUD3mKCISGkbXVL9TOztvkISiiQCXciEV0yCZqO9ndRHVvO4mo4l5Z/zVl78oW407qRpxbroB93C6az/MHJVvcDUhvbTbdu2pRzwbnco9lpyb5BAsY0H2PoJBA5fI8XpM+Tq6nSXIKXlBxFoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WprpB0PBwz6FCry;
	Thu, 22 Aug 2024 00:07:46 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 2ED2714011D;
	Thu, 22 Aug 2024 00:11:25 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 17:11:24 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Wed, 21 Aug 2024 17:11:24 +0100
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
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "jgroves@micron.com"
	<jgroves@micron.com>, "vsalve@micron.com" <vsalve@micron.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v11 04/14] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Thread-Topic: [PATCH v11 04/14] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Thread-Index: AQHa7/tuozUcaDHi1UOzxt2Hy082pLIwtLoAgAEzZKA=
Date: Wed, 21 Aug 2024 16:11:24 +0000
Message-ID: <bef6c9774c93486184af38091cb6207e@huawei.com>
References: <20240816164238.1902-1-shiju.jose@huawei.com>
 <20240816164238.1902-5-shiju.jose@huawei.com>
 <8b78d617-26f6-45a2-87d7-d3b66f5e7277@intel.com>
In-Reply-To: <8b78d617-26f6-45a2-87d7-d3b66f5e7277@intel.com>
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

SGkgRGF2ZSwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGF2ZSBKaWFu
ZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+U2VudDogMjAgQXVndXN0IDIwMjQgMjM6NDYNCj5U
bzogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPjsgbGludXgtZWRhY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPmN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj5DYzogYnBAYWxpZW44LmRlOyB0b255Lmx1Y2tAaW50ZWwuY29tOyByYWZhZWxAa2Vy
bmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPm1jaGVoYWJAa2VybmVsLm9yZzsgZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tOyBkYXZlQHN0Z29sYWJzLm5ldDsgSm9uYXRoYW4NCj5DYW1lcm9uIDxq
b25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsN
Cj52aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBpbnRlbC5jb207IGRhdmlkQHJl
ZGhhdC5jb207DQo+VmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IGxlby5kdXJhbkBhbWQuY29tOyBZ
YXplbi5HaGFubmFtQGFtZC5jb207DQo+cmllbnRqZXNAZ29vZ2xlLmNvbTsgamlhcWl5YW5AZ29v
Z2xlLmNvbTsgSm9uLkdyaW1tQGFtZC5jb207DQo+ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29t
OyBuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsNCj5qYW1lcy5tb3JzZUBhcm0uY29tOyBqdGhvdWdo
dG9uQGdvb2dsZS5jb207IHNvbWFzdW5kYXJhbS5hQGhwZS5jb207DQo+ZXJkZW1ha3Rhc0Bnb29n
bGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsgZHVlbndlbkBnb29nbGUuY29tOw0KPm1pa2UubWFs
dmVzdHV0b0BpbnRlbC5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJl
Y29tcHV0aW5nLmNvbTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFt
cGVyZWNvbXB1dGluZy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IGpncm92ZXNAbWljcm9uLmNv
bTsNCj52c2FsdmVAbWljcm9uLmNvbTsgdGFueGlhb2ZlaSA8dGFueGlhb2ZlaUBodWF3ZWkuY29t
PjsgWmVuZ3RhbyAoQikNCj48cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0byBTYXNz
dSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsNCj5rYW5na2FuZy5zaGVuQGZ1dHVyZXdlaS5j
b207IHdhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+Ow0KPkxpbnV4YXJtIDxs
aW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDA0LzE0XSBjeGwv
bWJveDogQWRkIEdFVF9TVVBQT1JURURfRkVBVFVSRVMNCj5tYWlsYm94IGNvbW1hbmQNCj4NCj4N
Cj4NCj5PbiA4LzE2LzI0IDk6NDIgQU0sIHNoaWp1Lmpvc2VAaHVhd2VpLmNvbSB3cm90ZToNCj4+
IEZyb206IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj4+DQo+PiBBZGQgc3Vw
cG9ydCBmb3IgR0VUX1NVUFBPUlRFRF9GRUFUVVJFUyBtYWlsYm94IGNvbW1hbmQuDQo+Pg0KPj4g
Q1hMIHNwZWMgMy4xIHNlY3Rpb24gOC4yLjkuNiBkZXNjcmliZXMgb3B0aW9uYWwgZGV2aWNlIHNw
ZWNpZmljIGZlYXR1cmVzLg0KPj4gQ1hMIGRldmljZXMgc3VwcG9ydCBmZWF0dXJlcyB3aXRoIGNo
YW5nZWFibGUgYXR0cmlidXRlcy4NCj4+DQo+PiBDWEwgc3BlYyAzLjEgc2VjdGlvbiA4LjIuOS42
LjEgZGVzY3JpYmVzIEdldCBTdXBwb3J0ZWQgZmVhdHVyZXMgY29tbWFuZC4NCj4+IEdldCBTdXBw
b3J0ZWQgRmVhdHVyZXMgcmV0cmlldmVzIHRoZSBsaXN0IG9mIHN1cHBvcnRlZCBkZXZpY2Ugc3Bl
Y2lmaWMNCj4+IGZlYXR1cmVzLiBUaGUgc2V0dGluZ3Mgb2YgYSBmZWF0dXJlIGNhbiBiZSByZXRy
aWV2ZWQgdXNpbmcgR2V0IEZlYXR1cmUNCj4+IGFuZCBvcHRpb25hbGx5IG1vZGlmaWVkIHVzaW5n
IFNldCBGZWF0dXJlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaWp1IEpvc2UgPHNoaWp1Lmpv
c2VAaHVhd2VpLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvY3hsL2NvcmUvbWJveC5jIHwgNjgN
Cj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIGRyaXZlcnMv
Y3hsL2N4bG1lbS5oICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEzMSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jIGIvZHJpdmVycy9jeGwvY29yZS9tYm94LmMg
aW5kZXgNCj4+IDI2MjZmM2ZmZjIwMS4uNzYwZmEzZTEwNzVmIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9jeGwvY29yZS9tYm94LmMNCj4+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvbWJveC5jDQo+
PiBAQCAtMTMyNCw2ICsxMzI0LDc0IEBAIGludCBjeGxfc2V0X3RpbWVzdGFtcChzdHJ1Y3QgY3hs
X21lbWRldl9zdGF0ZQ0KPj4gKm1kcykgIH0gIEVYUE9SVF9TWU1CT0xfTlNfR1BMKGN4bF9zZXRf
dGltZXN0YW1wLCBDWEwpOw0KPj4NCj4+ICtpbnQgY3hsX2dldF9zdXBwb3J0ZWRfZmVhdHVyZXMo
c3RydWN0IGN4bF9tZW1kZXZfc3RhdGUgKm1kcywNCj4+ICsJCQkgICAgICAgdTMyIGNvdW50LCB1
MTYgc3RhcnRfaW5kZXgsDQo+PiArCQkJICAgICAgIHN0cnVjdCBjeGxfbWJveF9nZXRfc3VwcF9m
ZWF0c19vdXQgKmZlYXRzX291dCkgew0KPj4gKwlzdHJ1Y3QgY3hsX21ib3hfZ2V0X3N1cHBfZmVh
dHNfaW4gcGk7DQo+PiArCXN0cnVjdCBjeGxfbWJveF9jbWQgbWJveF9jbWQ7DQo+PiArCWludCBy
YzsNCj4+ICsNCj4+ICsJcGkuY291bnQgPSBjcHVfdG9fbGUzMihjb3VudCk7DQo+PiArCXBpLnN0
YXJ0X2luZGV4ID0gY3B1X3RvX2xlMTYoc3RhcnRfaW5kZXgpOw0KPj4gKw0KPj4gKwltYm94X2Nt
ZCA9IChzdHJ1Y3QgY3hsX21ib3hfY21kKSB7DQo+PiArCQkub3Bjb2RlID0gQ1hMX01CT1hfT1Bf
R0VUX1NVUFBPUlRFRF9GRUFUVVJFUywNCj4+ICsJCS5zaXplX2luID0gc2l6ZW9mKHBpKSwNCj4+
ICsJCS5wYXlsb2FkX2luID0gJnBpLA0KPj4gKwkJLnNpemVfb3V0ID0gY291bnQsDQo+PiArCQku
cGF5bG9hZF9vdXQgPSBmZWF0c19vdXQsDQo+PiArCQkubWluX291dCA9IHNpemVvZigqZmVhdHNf
b3V0KSwNCj4+ICsJfTsNCj4+ICsJcmMgPSBjeGxfaW50ZXJuYWxfc2VuZF9jbWQobWRzLCAmbWJv
eF9jbWQpOw0KPj4gKwlpZiAocmMgPCAwKQ0KPj4gKwkJcmV0dXJuIHJjOw0KPj4gKw0KPj4gKwly
ZXR1cm4gMDsNCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9OU19HUEwoY3hsX2dldF9zdXBwb3J0
ZWRfZmVhdHVyZXMsIENYTCk7DQo+PiArDQo+PiAraW50IGN4bF9nZXRfc3VwcG9ydGVkX2ZlYXR1
cmVfZW50cnkoc3RydWN0IGN4bF9tZW1kZXZfc3RhdGUgKm1kcywgY29uc3QNCj51dWlkX3QgKmZl
YXRfdXVpZCwNCj4+ICsJCQkJICAgIHN0cnVjdCBjeGxfbWJveF9zdXBwX2ZlYXRfZW50cnkNCj4q
ZmVhdF9lbnRyeV9vdXQpDQo+DQo+SGkgU2hpanUsDQo+dGhvdWdodHMgb24gc3RvcmluZyBhbGwg
dGhlIHN1cHBvcnRlZCBmZWF0dXJlcyBtZXRhIGluZm8gZnJvbQ0KPkdFVF9TVVBQT1JURURfRkVB
VFVSRVMgY29tbWFuZCBpbiB0aGUgY3hsIGNvcmUgZHJpdmVyIGR1cmluZyBkZXZpY2UNCj5lbnVt
ZXJhdGlvbiBhbmQgdGhlIENYTCBFREFDIGNvZGUgY2FuIGp1c3QgcXVlcnkgdGhlIGNvcmUgaW5z
dGVhZCBvZiByZWFkaW5nDQo+ZnJvbSB0aGUgZGV2aWNlPyBKdXN0IGxvb2tpbmcgZm9yd2FyZCB0
byBzdXBwb3J0aW5nIG90aGVyIHJlYWQvc2V0IGZlYXR1cmVzDQo+b3BlcmF0aW9ucyBpbiB0aGUg
ZnV0dXJlIGFuZCBhdm9pZGluZyBnb2luZyB0aHJvdWdoIHRoaXMgZW50aXJlIHJlYWQgYW5kIGZp
bmQNCj5yb3V0aW5lIGZvciBlYWNoIGZlYXR1cmUuDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9u
Lg0KSSBzYXcgeW91IGhhdmUgaW1wbGVtZW50YXRpb24gZm9yIHN0b3JpbmcgYWxsIHRoZSBzdXBw
b3J0ZWQgZmVhdHVyZXMgbWV0YSBpbmZvIGZyb20gR0VUX1NVUFBPUlRFRF9GRUFUVVJFUyBjb21t
YW5kICBoZXJlLiANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9jeGwvcGF0
Y2gvMjAyNDA3MTgyMTM0NDYuMTc1MDEzNS01LWRhdmUuamlhbmdAaW50ZWwuY29tLw0KSSBhbSBm
aW5lIGJhc2luZyBvbiBpdCBpZiB0aGlzIHBhdGNoIGlzIHJlYWR5IHRvIGdvPw0KPg0KPkRKDQoN
ClRoYW5rcywNClNoaWp1DQo+DQo+PiArew0KPj4gKwlzdHJ1Y3QgY3hsX21ib3hfc3VwcF9mZWF0
X2VudHJ5ICpmZWF0X2VudHJ5Ow0KPj4gKwlpbnQgZmVhdF9pbmRleCwgZmVhdHNfb3V0X3NpemU7
DQo+PiArCWludCBuZW50cmllcywgY291bnQ7DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiArCWZl
YXRfaW5kZXggPSAwOw0KPj4gKwlmZWF0c19vdXRfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgY3hsX21i
b3hfZ2V0X3N1cHBfZmVhdHNfb3V0KSArDQo+PiArCQkJCXNpemVvZihzdHJ1Y3QgY3hsX21ib3hf
c3VwcF9mZWF0X2VudHJ5KTsNCj4+ICsJc3RydWN0IGN4bF9tYm94X2dldF9zdXBwX2ZlYXRzX291
dCAqZmVhdHNfb3V0IF9fZnJlZShrZnJlZSkgPQ0KPj4gKwkJCQkJa21hbGxvYyhmZWF0c19vdXRf
c2l6ZSwgR0ZQX0tFUk5FTCk7DQo+PiArCWlmICghZmVhdHNfb3V0KQ0KPj4gKwkJcmV0dXJuIC1F
Tk9NRU07DQo+PiArDQo+PiArCXdoaWxlICh0cnVlKSB7DQo+PiArCQltZW1zZXQoZmVhdHNfb3V0
LCAwLCBmZWF0c19vdXRfc2l6ZSk7DQo+PiArCQlyZXQgPSBjeGxfZ2V0X3N1cHBvcnRlZF9mZWF0
dXJlcyhtZHMsIGZlYXRzX291dF9zaXplLA0KPj4gKwkJCQkJCSBmZWF0X2luZGV4LCBmZWF0c19v
dXQpOw0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwkJbmVu
dHJpZXMgPSBmZWF0c19vdXQtPm5yX2VudHJpZXM7DQo+PiArCQlpZiAoIW5lbnRyaWVzKQ0KPj4g
KwkJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4+ICsNCj4+ICsJCS8qIENoZWNrIENYTCBtZW1kZXYg
c3VwcG9ydHMgdGhlIGZlYXR1cmUgKi8NCj4+ICsJCWZlYXRfZW50cnkgPSBmZWF0c19vdXQtPmZl
YXRfZW50cmllczsNCj4+ICsJCWZvciAoY291bnQgPSAwOyBjb3VudCA8IG5lbnRyaWVzOyBjb3Vu
dCsrLCBmZWF0X2VudHJ5KyspIHsNCj4+ICsJCQlpZiAodXVpZF9lcXVhbCgmZmVhdF9lbnRyeS0+
dXVpZCwgZmVhdF91dWlkKSkgew0KPj4gKwkJCQltZW1jcHkoZmVhdF9lbnRyeV9vdXQsIGZlYXRf
ZW50cnksDQo+PiArCQkJCSAgICAgICBzaXplb2YoKmZlYXRfZW50cnlfb3V0KSk7DQo+PiArCQkJ
CXJldHVybiAwOw0KPj4gKwkJCX0NCj4+ICsJCX0NCj4+ICsJCWZlYXRfaW5kZXggKz0gbmVudHJp
ZXM7DQo+PiArCX0NCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9OU19HUEwoY3hsX2dldF9zdXBw
b3J0ZWRfZmVhdHVyZV9lbnRyeSwgQ1hMKTsNCj4+ICsNCj4+ICBpbnQgY3hsX21lbV9nZXRfcG9p
c29uKHN0cnVjdCBjeGxfbWVtZGV2ICpjeGxtZCwgdTY0IG9mZnNldCwgdTY0IGxlbiwNCj4+ICAJ
CSAgICAgICBzdHJ1Y3QgY3hsX3JlZ2lvbiAqY3hscikNCj4+ICB7DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jeGwvY3hsbWVtLmggYi9kcml2ZXJzL2N4bC9jeGxtZW0uaCBpbmRleA0KPj4gYWY4
MTY5Y2NkYmMwLi45OTM5Yzc3MWY2NDIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2N4bC9jeGxt
ZW0uaA0KPj4gKysrIGIvZHJpdmVycy9jeGwvY3hsbWVtLmgNCj4+IEBAIC01MzEsNiArNTMxLDcg
QEAgZW51bSBjeGxfb3Bjb2RlIHsNCj4+ICAJQ1hMX01CT1hfT1BfR0VUX0xPR19DQVBTCT0gMHgw
NDAyLA0KPj4gIAlDWExfTUJPWF9PUF9DTEVBUl9MT0cgICAgICAgICAgID0gMHgwNDAzLA0KPj4g
IAlDWExfTUJPWF9PUF9HRVRfU1VQX0xPR19TVUJMSVNUID0gMHgwNDA1LA0KPj4gKwlDWExfTUJP
WF9PUF9HRVRfU1VQUE9SVEVEX0ZFQVRVUkVTCT0gMHgwNTAwLA0KPj4gIAlDWExfTUJPWF9PUF9J
REVOVElGWQkJPSAweDQwMDAsDQo+PiAgCUNYTF9NQk9YX09QX0dFVF9QQVJUSVRJT05fSU5GTwk9
IDB4NDEwMCwNCj4+ICAJQ1hMX01CT1hfT1BfU0VUX1BBUlRJVElPTl9JTkZPCT0gMHg0MTAxLA0K
Pj4gQEAgLTcwMCw2ICs3MDEsNjMgQEAgc3RydWN0IGN4bF9tYm94X3NldF90aW1lc3RhbXBfaW4g
ew0KPj4NCj4+ICB9IF9fcGFja2VkOw0KPj4NCj4+ICsvKg0KPj4gKyAqIEdldCBTdXBwb3J0ZWQg
RmVhdHVyZXMgQ1hMIDMuMSBTcGVjIDguMi45LjYuMSAgKi8NCj4+ICsNCj4+ICsvKg0KPj4gKyAq
IEdldCBTdXBwb3J0ZWQgRmVhdHVyZXMgaW5wdXQgcGF5bG9hZA0KPj4gKyAqIENYTCByZXYgMy4x
IHNlY3Rpb24gOC4yLjkuNi4xIFRhYmxlIDgtOTUgICovIHN0cnVjdA0KPj4gK2N4bF9tYm94X2dl
dF9zdXBwX2ZlYXRzX2luIHsNCj4+ICsJX19sZTMyIGNvdW50Ow0KPj4gKwlfX2xlMTYgc3RhcnRf
aW5kZXg7DQo+PiArCXU4IHJzdmRbMl07DQo+PiArfSBfX3BhY2tlZDsNCj4+ICsNCj4+ICsvKg0K
Pj4gKyAqIEdldCBTdXBwb3J0ZWQgRmVhdHVyZXMgU3VwcG9ydGVkIEZlYXR1cmUgRW50cnkNCj4+
ICsgKiBDWEwgcmV2IDMuMSBzZWN0aW9uIDguMi45LjYuMSBUYWJsZSA4LTk3ICAqLw0KPj4gKy8q
IFN1cHBvcnRlZCBGZWF0dXJlIEVudHJ5IDogUGF5bG9hZCBvdXQgYXR0cmlidXRlIGZsYWdzICov
DQo+PiArI2RlZmluZSBDWExfRkVBVF9FTlRSWV9GTEFHX0NIQU5HQUJMRQlCSVQoMCkNCj4+ICsj
ZGVmaW5lIENYTF9GRUFUX0VOVFJZX0ZMQUdfREVFUEVTVF9SRVNFVF9QRVJTSVNURU5DRV9NQVNL
DQo+CUdFTk1BU0soMywgMSkNCj4+ICsjZGVmaW5lIENYTF9GRUFUX0VOVFJZX0ZMQUdfUEVSU0lT
VF9BQ1JPU1NfRklSTVdBUkVfVVBEQVRFDQo+CUJJVCg0KQ0KPj4gKyNkZWZpbmUgQ1hMX0ZFQVRf
RU5UUllfRkxBR19TVVBQT1JUX0RFRkFVTFRfU0VMRUNUSU9OCUJJVCg1KQ0KPj4gKyNkZWZpbmUg
Q1hMX0ZFQVRfRU5UUllfRkxBR19TVVBQT1JUX1NBVkVEX1NFTEVDVElPTglCSVQoNikNCj4+ICsN
Cj4+ICtlbnVtIGN4bF9mZWF0X2F0dHJfdmFsdWVfcGVyc2lzdGVuY2Ugew0KPj4gKwlDWExfRkVB
VF9BVFRSX1ZBTFVFX1BFUlNJU1RFTkNFX05PTkUsDQo+PiArCUNYTF9GRUFUX0FUVFJfVkFMVUVf
UEVSU0lTVEVOQ0VfQ1hMX1JFU0VULA0KPj4gKwlDWExfRkVBVF9BVFRSX1ZBTFVFX1BFUlNJU1RF
TkNFX0hPVF9SRVNFVCwNCj4+ICsJQ1hMX0ZFQVRfQVRUUl9WQUxVRV9QRVJTSVNURU5DRV9XQVJN
X1JFU0VULA0KPj4gKwlDWExfRkVBVF9BVFRSX1ZBTFVFX1BFUlNJU1RFTkNFX0NPTERfUkVTRVQs
DQo+PiArCUNYTF9GRUFUX0FUVFJfVkFMVUVfUEVSU0lTVEVOQ0VfTUFYDQo+PiArfTsNCj4+ICsN
Cj4+ICtzdHJ1Y3QgY3hsX21ib3hfc3VwcF9mZWF0X2VudHJ5IHsNCj4+ICsJdXVpZF90IHV1aWQ7
DQo+PiArCV9fbGUxNiBpbmRleDsNCj4+ICsJX19sZTE2IGdldF9zaXplOw0KPj4gKwlfX2xlMTYg
c2V0X3NpemU7DQo+PiArCV9fbGUzMiBhdHRyX2ZsYWdzOw0KPj4gKwl1OCBnZXRfdmVyc2lvbjsN
Cj4+ICsJdTggc2V0X3ZlcnNpb247DQo+PiArCV9fbGUxNiBzZXRfZWZmZWN0czsNCj4+ICsJdTgg
cnN2ZFsxOF07DQo+PiArfSAgX19wYWNrZWQ7DQo+PiArDQo+PiArLyoNCj4+ICsgKiBHZXQgU3Vw
cG9ydGVkIEZlYXR1cmVzIG91dHB1dCBwYXlsb2FkDQo+PiArICogQ1hMIHJldiAzLjEgc2VjdGlv
biA4LjIuOS42LjEgVGFibGUgOC05NiAgKi8gc3RydWN0DQo+PiArY3hsX21ib3hfZ2V0X3N1cHBf
ZmVhdHNfb3V0IHsNCj4+ICsJX19sZTE2IG5yX2VudHJpZXM7DQo+PiArCV9fbGUxNiBucl9zdXBw
b3J0ZWQ7DQo+PiArCXU4IHJzdmRbNF07DQo+PiArCXN0cnVjdCBjeGxfbWJveF9zdXBwX2ZlYXRf
ZW50cnkgZmVhdF9lbnRyaWVzW107IH0gX19wYWNrZWQ7DQo+PiArDQo+PiAgLyogR2V0IFBvaXNv
biBMaXN0ICBDWEwgMy4wIFNwZWMgOC4yLjkuOC40LjEgKi8gIHN0cnVjdA0KPj4gY3hsX21ib3hf
cG9pc29uX2luIHsNCj4+ICAJX19sZTY0IG9mZnNldDsNCj4+IEBAIC04MzEsNiArODg5LDExIEBA
IHZvaWQgY3hsX2V2ZW50X3RyYWNlX3JlY29yZChjb25zdCBzdHJ1Y3QNCj5jeGxfbWVtZGV2ICpj
eGxtZCwNCj4+ICAJCQkgICAgZW51bSBjeGxfZXZlbnRfdHlwZSBldmVudF90eXBlLA0KPj4gIAkJ
CSAgICBjb25zdCB1dWlkX3QgKnV1aWQsIHVuaW9uIGN4bF9ldmVudCAqZXZ0KTsgIGludA0KPj4g
Y3hsX3NldF90aW1lc3RhbXAoc3RydWN0IGN4bF9tZW1kZXZfc3RhdGUgKm1kcyk7DQo+PiAraW50
IGN4bF9nZXRfc3VwcG9ydGVkX2ZlYXR1cmVzKHN0cnVjdCBjeGxfbWVtZGV2X3N0YXRlICptZHMs
DQo+PiArCQkJICAgICAgIHUzMiBjb3VudCwgdTE2IHN0YXJ0X2luZGV4LA0KPj4gKwkJCSAgICAg
ICBzdHJ1Y3QgY3hsX21ib3hfZ2V0X3N1cHBfZmVhdHNfb3V0ICpmZWF0c19vdXQpOw0KPmludA0K
Pj4gK2N4bF9nZXRfc3VwcG9ydGVkX2ZlYXR1cmVfZW50cnkoc3RydWN0IGN4bF9tZW1kZXZfc3Rh
dGUgKm1kcywgY29uc3QNCj51dWlkX3QgKmZlYXRfdXVpZCwNCj4+ICsJCQkJICAgIHN0cnVjdCBj
eGxfbWJveF9zdXBwX2ZlYXRfZW50cnkNCj4qZmVhdF9lbnRyeV9vdXQpOw0KPj4gIGludCBjeGxf
cG9pc29uX3N0YXRlX2luaXQoc3RydWN0IGN4bF9tZW1kZXZfc3RhdGUgKm1kcyk7ICBpbnQNCj4+
IGN4bF9tZW1fZ2V0X3BvaXNvbihzdHJ1Y3QgY3hsX21lbWRldiAqY3hsbWQsIHU2NCBvZmZzZXQs
IHU2NCBsZW4sDQo+PiAgCQkgICAgICAgc3RydWN0IGN4bF9yZWdpb24gKmN4bHIpOw0KDQo=

