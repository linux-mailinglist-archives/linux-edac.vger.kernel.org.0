Return-Path: <linux-edac+bounces-2555-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA39B9CDE2D
	for <lists+linux-edac@lfdr.de>; Fri, 15 Nov 2024 13:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA49283257
	for <lists+linux-edac@lfdr.de>; Fri, 15 Nov 2024 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A31BBBC4;
	Fri, 15 Nov 2024 12:21:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550415C140;
	Fri, 15 Nov 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673281; cv=none; b=m3TjmApj0yZFjISMYl7lB+fqgBN5ND4Tk5P7ATnMz+GZCcfJ2lKEaIiJjj0kFG0OjSlKLdSHFPs15V9Cn+9dWP6p97St+zhZQGgiJ7tc3/rDwfLcNQe9RbLEb7dfwhDjh+ugXPqDfWmfuvtIbEiRtKDzAd5FzhkyZV/BTPizlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673281; c=relaxed/simple;
	bh=/YnU3KdczjhJSPE6+xCxFockLpTzydoE6aOmdXrTJL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wt2Qc6o7IALaX69oVdW9XGm63uRShr1jVS647uoyVTkE/lQsi7XsFGnMj4EaCx7Ixlf11pfOJDYL0AHib1CUaLnwt05dnyqwv/8LBHH02tjUEA7VuCM/qS3VEHhhHrFuG2D2ADE42HM8yIqoagEhe3SatspbQQYEeEbKypJAe+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xqbhs0Btfz6LD47;
	Fri, 15 Nov 2024 20:21:01 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id B7725140B3C;
	Fri, 15 Nov 2024 20:21:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 13:21:16 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 15 Nov 2024 13:21:16 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
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
	"Roberto Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v15 11/15] EDAC: Add memory repair control feature
Thread-Topic: [PATCH v15 11/15] EDAC: Add memory repair control feature
Thread-Index: AQHbLD8AfemaRx1ca0GejEwzrXB007KmmMAAgABaU4CACv1JgIAAQsYAgASXAYCAAYpvYA==
Date: Fri, 15 Nov 2024 12:21:16 +0000
Message-ID: <fa5d6bdd08104cf1a09c4960a0f9bc46@huawei.com>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
 <20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
 <1ac30acc16ab42c98313c20c79988349@huawei.com>
 <20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
 <7fd81b442ba3477787f5342e69adbb96@huawei.com>
 <20241114133249.GEZzX8ATNyc_Xw1L52@fat_crate.local>
In-Reply-To: <20241114133249.GEZzX8ATNyc_Xw1L52@fat_crate.local>
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

SGkgQm9yaXMsDQoNClBsZWFzZSBmaW5kIHJlcGx5IGlubGluZS4NCj4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPlNlbnQ6
IDE0IE5vdmVtYmVyIDIwMjQgMTM6MzMNCj5UbzogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3
ZWkuY29tPg0KPkNjOiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgtY3hsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNr
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj50b255Lmx1Y2tAaW50ZWwuY29t
OyByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPm1jaGVoYWJAa2VybmVsLm9y
ZzsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBkYXZlQHN0Z29sYWJzLm5ldDsgSm9uYXRoYW4N
Cj5DYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsNCj5zdWRlZXAuaG9sbGFAYXJtLmNvbTsgamFzc2lzaW5naGJyYXJAZ21haWwu
Y29tOyBkYXZlLmppYW5nQGludGVsLmNvbTsNCj5hbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsg
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBpcmEud2VpbnlAaW50ZWwuY29tOw0KPmRhdmlkQHJl
ZGhhdC5jb207IFZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOyBsZW8uZHVyYW5AYW1kLmNvbTsNCj5Z
YXplbi5HaGFubmFtQGFtZC5jb207IHJpZW50amVzQGdvb2dsZS5jb207IGppYXFpeWFuQGdvb2ds
ZS5jb207DQo+Sm9uLkdyaW1tQGFtZC5jb207IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsN
Cj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsganRob3VnaHRv
bkBnb29nbGUuY29tOw0KPnNvbWFzdW5kYXJhbS5hQGhwZS5jb207IGVyZGVtYWt0YXNAZ29vZ2xl
LmNvbTsgcGdvbmRhQGdvb2dsZS5jb207DQo+ZHVlbndlbkBnb29nbGUuY29tOyBndGhlbGVuQGdv
b2dsZS5jb207DQo+d3NjaHdhcnR6QGFtcGVyZWNvbXB1dGluZy5jb207IGRmZXJndXNvbkBhbXBl
cmVjb21wdXRpbmcuY29tOw0KPndic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBuaWZhbi5jeGxA
Z21haWwuY29tOyB0YW54aWFvZmVpDQo+PHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8g
KEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvDQo+U2Fzc3UgPHJvYmVydG8u
c2Fzc3VAaHVhd2VpLmNvbT47IGthbmdrYW5nLnNoZW5AZnV0dXJld2VpLmNvbTsNCj53YW5naHVp
cWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgTGludXhhcm0NCj48bGludXhhcm1AaHVh
d2VpLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxNSAxMS8xNV0gRURBQzogQWRkIG1lbW9y
eSByZXBhaXIgY29udHJvbCBmZWF0dXJlDQo+DQo+T24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgMDQ6
NTQ6NDhQTSArMDAwMCwgU2hpanUgSm9zZSB3cm90ZToNCj4+IFByZXNlbnRseSwgMCAoc29mdCBt
ZW1vcnkgcmVwYWlyKSBhbmQgMSAoaGFyZCBtZW1vcnkgcmVwYWlyKSwgIGRlcGVuZHMNCj4+IG9u
IHdoaWNoIG1vZGUvcyBhIG1lbW9yeSBkZXZpY2UgaXMgc3VwcG9ydGVkLg0KPg0KPldoYXQgaWYg
dGhlIGRldmljZSBzdXBwb3J0cyBtb3JlIHRoYW4gb25lIG1vZGU/DQo+DQo+PiBIb3dldmVyIGZv
ciBDWEwgbWVtb3J5IHNwYXJpbmcgZmVhdHVyZSwgdGhlIHBlcnNpc3RlbnQgbW9kZSBpcw0KPj4g
Y29uZmlndXJhYmxlIGF0IHJ1bnRpbWUgZm9yIGEgbWVtb3J5IHNwYXJpbmcgaW5zdGFuY2UsIHRo
dXMgYm90aCBzb2Z0IGFuZA0KPmhhcmQgc3BhcmluZyBhcmUgc3VwcG9ydGVkLg0KPj4gRXhhbXBs
ZSBnaXZlbiBmb3IgQ1hMIG1lbW9yeSBzcGFyaW5nIGZlYXR1cmUgaW4NCj4+IERvY3VtZW50YXRp
b24vZWRhYy9tZW1vcnlfcmVwYWlyLnJzdCwNCj4+IHJvb3RAbG9jYWxob3N0On4jIGNhdA0KPj4g
L3N5cy9idXMvZWRhYy9kZXZpY2VzL2N4bF9tZW0wL21lbV9yZXBhaXIxL3BlcnNpc3RfbW9kZV9h
dmFpbA0KPj4gMCwxDQo+DQo+T2ssIGFuZCBob3cgaXMgdGhlIHVzZXIgc3VwcG9zZWQgdG8ga25v
dyB3aGF0IHRob3NlIG1lYW4/DQoNClByaW50IGluICBzdHJpbmcgZm9ybWF0PywgbWF5IGJlIGFz
ICdwZXJzaXN0Jy8ndm9sYXRpbGUnPyANCg0KPg0KPj4gS2VybmVsIHN5c2ZzIGRvYyBtZW50aW9u
ZWQgYWJvdXQgYXJyYXkgb2YgdmFsdWVzIGFzIGZvbGxvd3MsIHRob3VnaCBub3Qgc2Vlbg0KPm11
Y2ggZXhhbXBsZXMuDQo+PiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9maWxlc3lzdGVtcy9zeXNm
cy5odG1sDQo+PiAiQXR0cmlidXRlcyBzaG91bGQgYmUgQVNDSUkgdGV4dCBmaWxlcywgcHJlZmVy
YWJseSB3aXRoIG9ubHkgb25lIHZhbHVlDQo+PiBwZXIgZmlsZS4gSXQgaXMgbm90ZWQgdGhhdCBp
dCBtYXkgbm90IGJlIGVmZmljaWVudCB0byBjb250YWluIG9ubHkgb25lDQo+PiB2YWx1ZSBwZXIg
ZmlsZSwgc28gaXQgaXMgc29jaWFsbHkgYWNjZXB0YWJsZSB0byBleHByZXNzIGFuIGFycmF5IG9m
IHZhbHVlcyBvZiB0aGUNCj5zYW1lIHR5cGUuIg0KPg0KPlRydWUgc3RvcnkuIE9rLCBzbyB0aGVy
ZSdzIGFuIGV4Y2VwdGlvbiB0byB0aGF0IHJ1bGUuDQo+DQo+PiBUaGUgdmFsdWVzIG9mIHRoZXNl
IGF0dHJpYnV0ZXMgYXJlIHNwZWNpZmljIHRvIGRldmljZSBhbmQgcG9ydGlvbiBvZiB0aGUgbWVt
b3J5DQo+dG8gcmVwYWlyLg0KPj4gRm9yIGV4YW1wbGUsIEluIENYTCByZXBhaXIgZmVhdHVyZXMs
DQo+PiBDWEwgbWVtb3J5IGRldmljZSBpZGVudGlmaWVzIGEgZmFpbHVyZSBvbiBhIG1lbW9yeSBj
b21wb25lbnQsIGRldmljZQ0KPj4gcHJvdmlkZXMgdGhlIGNvcnJlc3BvbmRpbmcgdmFsdWVzIG9m
IHRoZSBhdHRyaWJ1dGVzIChEUEEsIGNoYW5uZWwsDQo+PiByYW5rLCBuaWJibGUgbWFzaywgYmFu
ayBncm91cCwgYmFuaywgcm93LCBjb2x1bW4gb3Igc3ViLWNoYW5uZWwgZXRjKSBpbiBhbg0KPmV2
ZW50IHJlY29yZCB0byB0aGUgaG9zdCBhbmQgdG8gdGhlIHVzZXJzcGFjZSBpbiB0aGUgY29ycmVz
cG9uZGluZyB0cmFjZSBldmVudC4NCj4+IFVzZXJzcGFjZSBzaGFsbCB1c2UgdGhlc2UgdmFsdWVz
IGZvciB0aGUgcXVlcnkgcmVzb3VyY2UgYXZhaWxhYmlsaXR5IGFuZCByZXBhaXINCj5vcGVyYXRp
b25zLg0KPg0KPkkgZG9uJ3QgdGhpbmsgeW91J3JlIGFuc3dlcmluZyBteSBxdWVzdGlvbi4gTGVt
bWUgdHJ5IGFnYWluOg0KPg0KPkkgYW0gb24gYSBtYWNoaW5lIHdpdGggc3VjaCBhbiBpbnRlcmZh
Y2UuIEkgZG8NCj4NCj5lY2hvIDB4ZGVhZGJlZWYgPiAvc3lzL2RldmljZXMuLi4NCj4tRUlOVkFM
DQo+DQo+ZWNobyAweGZhY2UgPiAuLi4NCj4tRUlOVkFMDQo+DQo+SG93IGRvIEkga25vdyB3aGF0
IHRoZSBhbGxvd2VkIHJhbmdlcyBhcmU/DQoNCkkgYW0gIGZpbmUgd2l0aCBhZGRpbmcgdGhlIHN1
cHBvcnQgZm9yIGV4cG9zZSB0aGUgcmFuZ2VzIG9mIHRoZXNlLA0KYnV0IG1ha2VzIG1vcmUgc2Vu
c2UgdG8gZG8gaXQgd2hlbiBhIGRyaXZlciBzdXJmYWNlcyB0aGF0IGNhbiBkbyBpdC4gDQpJIHdp
bGwgdXNlIHRoZSBEUEEgZm9yIENYTCBmZWF0dXJlcyBhcyBhbiBleGFtcGxlIG9mIGhvdyBpdCB3
b3VsZCBiZSBkb25lIGFuZCANCml0J3MgdGhlIG9uZSBpcyBzdXBwb3J0ZWQgbm93Lg0KDQo+PiBU
aGlzIHdpbGwgd29yayBmb3IgdGhlIENYTCBQUFIgZmVhdHVyZSB3aGVyZSB0aGUgcmVzdWx0IG9m
IHRoZSBxdWVyeQ0KWy4uLl0NCj4tLQ0KPlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0K
Pmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQoN
ClRoYW5rcywNClNoaWp1DQo=

