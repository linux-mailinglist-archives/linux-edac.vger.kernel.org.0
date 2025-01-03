Return-Path: <linux-edac+bounces-2778-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F71A00DA3
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 19:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F4F1642F5
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E511FBCBD;
	Fri,  3 Jan 2025 18:32:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2731FA84F;
	Fri,  3 Jan 2025 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929178; cv=none; b=FtMCYAMZpflqRHDZgDheh59BezbS06dKBGovMoQUAwcunZwXIv7bHHP4CV0+l1Oz9eWGaL1KtpU1mDLqqDJRE0/eJvFkUDmwjayp5seiVHJ+AwmTCa6BEvJDZ6eldornIin1ylWgm1vJPW4mMtPGCAzkPTV6nUX5wrTkK8JVErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929178; c=relaxed/simple;
	bh=/l5Oe64fYVXTFHsHtZ+AAqB9eUG6nB2EjFrrc2gc9qU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vE+Wu0/IX/ZZ0fttXdxpm6RpjmRDupO+CH7nmtyTBVaPDD0MB4mQBESgP2jqxGTBlRtVIeu8WZ4Q41Ubn3zZSa0m0VLRrVSADAysEvz0s/x/TUm34mD9eJIgp5gDpklEmL2eaBzavUFiSQqvKNN4Tvus5VF3RJfadMzXD4EeTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPscH0XLJz67L21;
	Sat,  4 Jan 2025 02:31:59 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id B38661400DD;
	Sat,  4 Jan 2025 02:32:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 Jan 2025 19:32:51 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 3 Jan 2025 19:32:51 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
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
Subject: RE: [PATCH v17 00/18] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
Thread-Topic: [PATCH v17 00/18] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Thread-Index: AQHbPQj8CmvY1OUXTkq0gc1M8/aWtLMFHhiAgAAWfICAAC7NAIAAPHsw
Date: Fri, 3 Jan 2025 18:32:51 +0000
Message-ID: <747cb4c966604aaf84f6b9f2d54df02c@huawei.com>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
 <20250103114109.GAZ3fM1dEsyBSn9lWA@fat_crate.local>
 <20250103130213.00006abd@huawei.com>
 <c89765ef-1243-445a-bc4a-db88fb5b9377@intel.com>
In-Reply-To: <c89765ef-1243-445a-bc4a-db88fb5b9377@intel.com>
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFu
Z0BpbnRlbC5jb20+DQo+U2VudDogMDMgSmFudWFyeSAyMDI1IDE1OjUwDQo+VG86IEpvbmF0aGFu
IENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IEJvcmlzbGF2IFBldGtvdg0K
PjxicEBhbGllbjguZGU+DQo+Q2M6IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT47
IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5jeGxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC0N
Cj5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOyByYWZhZWxAa2Vy
bmVsLm9yZzsNCj5sZW5iQGtlcm5lbC5vcmc7IG1jaGVoYWJAa2VybmVsLm9yZzsgZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tOw0KPmRhdmVAc3Rnb2xhYnMubmV0OyBhbGlzb24uc2Nob2ZpZWxkQGlu
dGVsLmNvbTsgdmlzaGFsLmwudmVybWFAaW50ZWwuY29tOw0KPmlyYS53ZWlueUBpbnRlbC5jb207
IGRhdmlkQHJlZGhhdC5jb207IFZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOw0KPmxlby5kdXJhbkBh
bWQuY29tOyBZYXplbi5HaGFubmFtQGFtZC5jb207IHJpZW50amVzQGdvb2dsZS5jb207DQo+amlh
cWl5YW5AZ29vZ2xlLmNvbTsgSm9uLkdyaW1tQGFtZC5jb207IGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbTsNCj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsg
anRob3VnaHRvbkBnb29nbGUuY29tOw0KPnNvbWFzdW5kYXJhbS5hQGhwZS5jb207IGVyZGVtYWt0
YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207DQo+ZHVlbndlbkBnb29nbGUuY29tOyBn
dGhlbGVuQGdvb2dsZS5jb207DQo+d3NjaHdhcnR6QGFtcGVyZWNvbXB1dGluZy5jb207IGRmZXJn
dXNvbkBhbXBlcmVjb21wdXRpbmcuY29tOw0KPndic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBu
aWZhbi5jeGxAZ21haWwuY29tOyB0YW54aWFvZmVpDQo+PHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47
IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvDQo+U2Fzc3Ug
PHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47IGthbmdrYW5nLnNoZW5AZnV0dXJld2VpLmNvbTsN
Cj53YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgTGludXhhcm0NCj48bGlu
dXhhcm1AaHVhd2VpLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxNyAwMC8xOF0gRURBQzog
U2NydWI6IGludHJvZHVjZSBnZW5lcmljIEVEQUMgUkFTDQo+Y29udHJvbCBmZWF0dXJlIGRyaXZl
ciArIENYTC9BQ1BJLVJBUzIgZHJpdmVycw0KPg0KPg0KPg0KPk9uIDEvMy8yNSA2OjAyIEFNLCBK
b25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPj4gT24gRnJpLCAzIEphbiAyMDI1IDEyOjQxOjQ1ICsw
MTAwDQo+PiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4gd3JvdGU6DQo+Pg0KPj4+IE9u
IEZyaSwgTm92IDIyLCAyMDI0IGF0IDA2OjAzOjU3UE0gKzAwMDAsIHNoaWp1Lmpvc2VAaHVhd2Vp
LmNvbSB3cm90ZToNCj4+Pj4gIGRyaXZlcnMvZWRhYy9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgKw0KPj4+PiAgZHJpdmVycy9lZGFjL2Vjcy5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDIwNyArKysNCj4+Pj4gIGRyaXZlcnMvZWRhYy9lZGFjX2RldmljZS5j
ICAgICAgICAgICAgICAgICAgICB8ICAxODMgKysNCj4+Pj4gIGRyaXZlcnMvZWRhYy9tZW1fcmVw
YWlyLmMgICAgICAgICAgICAgICAgICAgICB8ICA0OTIgKysrKysNCj4+Pj4gIGRyaXZlcnMvZWRh
Yy9zY3J1Yi5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMDkgKysrDQo+Pj4+ICBkcml2
ZXJzL3Jhcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEwICsNCj4+Pj4g
IGRyaXZlcnMvcmFzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0K
Pj4+PiAgZHJpdmVycy9yYXMvYWNwaV9yYXMyLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDM4
NSArKysrDQo+Pj4+ICBpbmNsdWRlL2FjcGkvcmFzMl9hY3BpLmggICAgICAgICAgICAgICAgICAg
ICAgfCAgIDQ1ICsNCj4+Pj4gIGluY2x1ZGUvY3hsL2ZlYXR1cmVzLmggICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNDggKw0KPj4+PiAgaW5jbHVkZS9jeGwvbWFpbGJveC5oICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA0NSArLQ0KPj4+PiAgaW5jbHVkZS9saW51eC9lZGFjLmggICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDIzOCArKysNCj4+Pj4gIGluY2x1ZGUvdWFwaS9saW51eC9j
eGxfbWVtLmggICAgICAgICAgICAgICAgICB8ICAgIDMgKw0KPj4+DQo+Pj4gU28gd2hhdCdzIHRo
ZSBwbGFuIGhlcmU/IEFtIEkgc3VwcG9zZWQgdG8gbWVyZ2UgdGhlIEVEQUMvUkFTIGJpdHMNCj4+
PiB0aHJvdWdoIHRoZSBSQVMgdHJlZSBhbmQgdGhlbiBnaXZlIGZvbGtzIGFuIGltbXV0YWJsZSBi
cmFuY2ggb3IgaG93DQo+Pj4gZG8gd2Ugd2FudCB0byBwcm9jZWVkIGhlcmU/DQo+Pj4NCj4+DQo+
PiBEYXZlIEppYW5nIC8gUmFmYWVsLCB3aGF0IHdvdWxkIHdvcmsgYmVzdCBmb3IgdGhlIHR3byBv
ZiB5b3U/DQo+Pg0KPj4gVG8gbWUgQm9yaXMnIHN1Z2dlc3Rpb24gbWFrZXMgc2Vuc2UsIHBhcnRp
Y3VsYXJseSBhcyB0aGF0IGF2b2lkcyB0aGUNCj4+IGNvbXBsZXhpdHkgb2YgQ1hMIGdldC9zZXQg
ZmVhdHVyZXMgYmVpbmcgaW4gbXVsdGlwbGUgc2VyaWVzLg0KPj4NCj4+IEkgdGhpbmsgdGhlIHNw
bGl0IHRoYXQgd291bGQgbWFrZSBzZW5zZSBpczoNCj4+DQo+PiBFREFDIGltbXV0YWJsZSBicmFu
Y2ggZm9yOg0KPj4gIDE6IEVEQUM6IEFkZCBzdXBwb3J0IGZvciBFREFDIGRldmljZSBmZWF0dXJl
cyBjb250cm9sDQo+PiAgMjogQWRkIHNjcnViIGNvbnRyb2wgZmVhdHVyZQ0KPj4gIDM6IEVEQUM6
IEFkZCBFQ1MgY29udHJvbCBmZWF0dXJlDQo+PiAgMTU6IEVEQUM6IEFkZCBtZW1vcnkgcmVwYWly
IGNvbnRyb2wgZmVhdHVyZQ0KPj4NCj4+IEFDUEkgbWVyZ2VzIEVEQUMgaW1tdXRhYmxlICsNCj4+
ICAxMzogQUNQSTpSQVMyOiBBZGQgQUNQSSBSQVMyIGRyaXZlcg0KPj4gIDE0OiByYXM6IG1lbTog
QWRkIG1lbW9yeSBBQ1BJIFJBUzIgZHJpdmVyDQo+Pg0KPj4gQ1hMIG1lcmdlcyBFREFDIGltbXV0
YWJsZSArDQo+PiAgNDogY3hsOiBSZWZhY3RvciB1c2VyIGlvY3RsIGNvbW1hbmQgcGF0aCBmcm9t
IG1kcyB0byBtYWlsYm94DQo+PiAgNTogY3hsOiBBZGQgR2V0IFN1cHBvcnRlZCBGZWF0dXJlcyBj
b21tYW5kIGZvciBrZXJuZWwgdXNhZ2UNCj4+ICA2OiBjeGwvbWJveDogQWRkIEdFVF9GRUFUVVJF
IG1haWxib3ggY29tbWFuZA0KPj4gIDc6IGN4bDogQWRkIEdldCBGZWF0dXJlIGNvbW1hbmQgc3Vw
cG9ydCBmb3IgdXNlciBzdWJtaXNzaW9uDQo+PiAgODogY3hsL21ib3g6IEFkZCBTRVRfRkVBVFVS
RSBtYWlsYm94IGNvbW1hbmQNCj4+ICA5OiBjeGw6IEFkZCBTZXQgRmVhdHVyZSBjb21tYW5kIHN1
cHBvcnQgZm9yIHVzZXIgc3VibWlzc2lvbg0KPj4gIDEwOiBjeGw6IEFkZCBVVUlEcyBmb3IgdGhl
IENYTCBSQVMgZmVhdHVyZXMNCj4+ICAxMTogY3hsL21lbWZlYXR1cmU6IEFkZCBDWEwgbWVtb3J5
IGRldmljZSBwYXRyb2wgc2NydWIgY29udHJvbA0KPj4gZmVhdHVyZQ0KPj4gIDEyOiBjeGwvbWVt
ZmVhdHVyZTogQWRkIENYTCBtZW1vcnkgZGV2aWNlIEVDUyBjb250cm9sIGZlYXR1cmUNCj4+ICAx
NjogY3hsL21ib3g6IEFkZCBzdXBwb3J0IGZvciBQRVJGT1JNX01BSU5URU5BTkNFIG1haWxib3gg
Y29tbWFuZA0KPj4gIDE3OiBjeGwvbWVtZmVhdHVyZTogQWRkIENYTCBtZW1vcnkgZGV2aWNlIHNv
ZnQgUFBSIGNvbnRyb2wgZmVhdHVyZQ0KPj4gIDE4OiBjeGwvbWVtZmVhdHVyZTogQWRkIENYTCBt
ZW1vcnkgZGV2aWNlIG1lbW9yeSBzcGFyaW5nIGNvbnRyb2wNCj4+IGZlYXR1cmUNCj4NCj5UaGF0
IHdvcmtzIGZvciBtZS4NCj4NCj5ESg0KPg0KPj4NCj4+IFRoYXQgZG9lcyBtZWFuIHRoYXQgdGhl
IGFjdHVhbCBkcml2ZXJzL2VkYWMvIHNwZWNpZmljIGRyaXZlcnMgbGFuZCB2aWENCj4+IHRoZSBB
Q1BJIGFuZCBDWEwgdHJlZXMgb25seSwgYnV0IHdpdGhvdXQgYW5vdGhlciBsYXllciBvZiBpbW11
dGFibGUNCj4+IGJyYW5jaGVzIHdlIGNhbid0IGF2b2lkIHRoYXQuIE1pZ2h0IGNhdXNlIG1lcmdl
IGNvbmZsaWN0cyBpbg0KPj4gS2NvbmZpZy9NYWtlZmlsZXMgYnV0IG90aGVyd2lzZSBzaG91bGRu
J3QgYmUgdG9vIGJhZC4NCj4+DQo+PiBUaGVyZSBpcyBnb2luZyB0byBiZSBzb21lIG5vaXNlIGlu
IGRvY3VtZW50YXRpb24gYXMgZXhhbXBsZXMgYXJlIGFkZGVkDQo+PiB0byB0aGUgZG9jcyB3aXRo
IHRoZSBhY3R1YWwgZHJpdmVycyAod2hlcmVhcyBnZW5lcmljIGRvY3MgYXJlDQo+PiBpbnRyb2R1
Y2VkIHdpdGggdGhlIGluZnJhc3RydWN0dXJlKS4gIEkgdGhpbmsgdGhhdCB3aWxsIHdvcmsgb3V0
IHRob3VnaC4NCj4+IFNoaWp1LCBjb3VsZCB5b3Ugc3BpbiB0aGlzIG9yZGVyaW5nIHVwIGFuZCBj
aGVjayBpdCBhbGwgd29ya3MNCj4+IChpbmNvcnBvcmF0aW5nIERhdmUncyB1cGRhdGVzIHRvIHRo
ZSBHRVQgLyBTRVQgZmVhdHVyZSk/DQoNClJlYmFzZWQsIHJlb3JkZXJlZCBhbmQgdGVzdGVkIGZp
bmUuIFdhaXRpbmcgZm9yIHNvbWUgaW5mb3JtYXRpb24gYmVmb3JlDQpzaGFyaW5nIHRoZSB1cGRh
dGVkIHBhdGNoZXMuIA0KDQpUaGFua3MsDQpTaGlqdQ0KDQo+PiA+IFRoYW5rcywNCj4+DQo+PiBK
b25hdGhhbg0KPg0KDQo=

