Return-Path: <linux-edac+bounces-2779-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764EA00E5C
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 20:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DA13A0341
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2025 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B01BD4F1;
	Fri,  3 Jan 2025 19:17:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F5199938;
	Fri,  3 Jan 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931841; cv=none; b=SHRj+/IyxPBHZO2okPuZI+aO8BJQfN/6tw7qZ9bMFMPBySrc9i1frcFcLixlDEnDbg2K0xGJ99SvsRetvOogAtY3RYH1vVZ6cgX9MhcaXenq5Y79kl09nKlwhNLAh3WVzkpMA79iYC9q9jY4/m1n0A2KvLtVgBBqEpPR+yNFxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931841; c=relaxed/simple;
	bh=IirUrc6x72UmzdTtvx04pW9P8f2+AgcTSpW0az9y8RU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T/QIWNOJWW4S1Zh3Uv6IN7rXjkUI8OsMSbzgiSh1ESEq128mE1D1KIBNc+Qlzq9ODP7tYXEFeZgr9Rv3rSv+PmtgHhSAAqLHBmnx3yL+0fNic8IAt60WKi8jjt+TqXLboDSqkS+gaWKUs/2bU+HSWrrUyTWwG6q1B7Jp44/LWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPtWS0RY9z6K92y;
	Sat,  4 Jan 2025 03:12:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6024A1400D3;
	Sat,  4 Jan 2025 03:17:14 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 3 Jan 2025 20:17:13 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 3 Jan 2025 20:17:13 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Borislav Petkov
	<bp@alien8.de>
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
Thread-Index: AQHbPQj8CmvY1OUXTkq0gc1M8/aWtLMFHhiAgAAWfICAAC7NAIAAPHswgAAL0xA=
Date: Fri, 3 Jan 2025 19:17:13 +0000
Message-ID: <216de8e0176441e29a656865fc31d336@huawei.com>
References: <20241122180416.1932-1-shiju.jose@huawei.com>
 <20250103114109.GAZ3fM1dEsyBSn9lWA@fat_crate.local>
 <20250103130213.00006abd@huawei.com>
 <c89765ef-1243-445a-bc4a-db88fb5b9377@intel.com>
 <747cb4c966604aaf84f6b9f2d54df02c@huawei.com>
In-Reply-To: <747cb4c966604aaf84f6b9f2d54df02c@huawei.com>
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU2hpanUgSm9zZSA8c2hpanUuam9z
ZUBodWF3ZWkuY29tPg0KPlNlbnQ6IDAzIEphbnVhcnkgMjAyNSAxODozMw0KPlRvOiBEYXZlIEpp
YW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj48am9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+Q2M6
IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj5hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPnRvbnkubHVja0BpbnRlbC5jb207IHJhZmFlbEBrZXJu
ZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7DQo+bWNoZWhhYkBrZXJuZWwub3JnOyBkYW4uai53aWxs
aWFtc0BpbnRlbC5jb207IGRhdmVAc3Rnb2xhYnMubmV0Ow0KPmFsaXNvbi5zY2hvZmllbGRAaW50
ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBpbnRlbC5jb207DQo+
ZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IGxlby5kdXJhbkBhbWQu
Y29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgcmllbnRqZXNAZ29vZ2xlLmNvbTsgamlhcWl5
YW5AZ29vZ2xlLmNvbTsNCj5Kb24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBq
dGhvdWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRhcmFtLmFAaHBlLmNvbTsgZXJkZW1ha3Rh
c0Bnb29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsNCj5kdWVud2VuQGdvb2dsZS5jb207IGd0
aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNvbTsgZGZlcmd1
c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IG5p
ZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2ZlaUBodWF3ZWkuY29tPjsg
WmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVydG8NCj5TYXNzdSA8
cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hlbkBmdXR1cmV3ZWkuY29tOw0K
PndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBMaW51eGFybQ0KPjxsaW51
eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJFOiBbUEFUQ0ggdjE3IDAwLzE4XSBFREFDOiBT
Y3J1YjogaW50cm9kdWNlIGdlbmVyaWMgRURBQyBSQVMNCj5jb250cm9sIGZlYXR1cmUgZHJpdmVy
ICsgQ1hML0FDUEktUkFTMiBkcml2ZXJzDQo+DQpbLi4uXQ0KPj4NCj4+DQo+Pk9uIDEvMy8yNSA2
OjAyIEFNLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPj4+IE9uIEZyaSwgMyBKYW4gMjAyNSAx
Mjo0MTo0NSArMDEwMA0KPj4+IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToN
Cj4+Pg0KPj4+PiBPbiBGcmksIE5vdiAyMiwgMjAyNCBhdCAwNjowMzo1N1BNICswMDAwLCBzaGlq
dS5qb3NlQGh1YXdlaS5jb20gd3JvdGU6DQo+Pj4+PiAgZHJpdmVycy9lZGFjL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+Pj4+PiAgZHJpdmVycy9lZGFjL2Vjcy5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIwNyArKysNCj4+Pj4+ICBkcml2ZXJzL2Vk
YWMvZWRhY19kZXZpY2UuYyAgICAgICAgICAgICAgICAgICAgfCAgMTgzICsrDQo+Pj4+PiAgZHJp
dmVycy9lZGFjL21lbV9yZXBhaXIuYyAgICAgICAgICAgICAgICAgICAgIHwgIDQ5MiArKysrKw0K
Pj4+Pj4gIGRyaXZlcnMvZWRhYy9zY3J1Yi5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAy
MDkgKysrDQo+Pj4+PiAgZHJpdmVycy9yYXMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxMCArDQo+Pj4+PiAgZHJpdmVycy9yYXMvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAgMSArDQo+Pj4+PiAgZHJpdmVycy9yYXMvYWNwaV9yYXMyLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDM4NSArKysrDQo+Pj4+PiAgaW5jbHVkZS9hY3BpL3JhczJfYWNw
aS5oICAgICAgICAgICAgICAgICAgICAgIHwgICA0NSArDQo+Pj4+PiAgaW5jbHVkZS9jeGwvZmVh
dHVyZXMuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0OCArDQo+Pj4+PiAgaW5jbHVkZS9j
eGwvbWFpbGJveC5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0NSArLQ0KPj4+Pj4gIGlu
Y2x1ZGUvbGludXgvZWRhYy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMzggKysrDQo+
Pj4+PiAgaW5jbHVkZS91YXBpL2xpbnV4L2N4bF9tZW0uaCAgICAgICAgICAgICAgICAgIHwgICAg
MyArDQo+Pj4+DQo+Pj4+IFNvIHdoYXQncyB0aGUgcGxhbiBoZXJlPyBBbSBJIHN1cHBvc2VkIHRv
IG1lcmdlIHRoZSBFREFDL1JBUyBiaXRzDQo+Pj4+IHRocm91Z2ggdGhlIFJBUyB0cmVlIGFuZCB0
aGVuIGdpdmUgZm9sa3MgYW4gaW1tdXRhYmxlIGJyYW5jaCBvciBob3cNCj4+Pj4gZG8gd2Ugd2Fu
dCB0byBwcm9jZWVkIGhlcmU/DQo+Pj4+DQo+Pj4NCj4+PiBEYXZlIEppYW5nIC8gUmFmYWVsLCB3
aGF0IHdvdWxkIHdvcmsgYmVzdCBmb3IgdGhlIHR3byBvZiB5b3U/DQo+Pj4NCj4+PiBUbyBtZSBC
b3Jpcycgc3VnZ2VzdGlvbiBtYWtlcyBzZW5zZSwgcGFydGljdWxhcmx5IGFzIHRoYXQgYXZvaWRz
IHRoZQ0KPj4+IGNvbXBsZXhpdHkgb2YgQ1hMIGdldC9zZXQgZmVhdHVyZXMgYmVpbmcgaW4gbXVs
dGlwbGUgc2VyaWVzLg0KPj4+DQo+Pj4gSSB0aGluayB0aGUgc3BsaXQgdGhhdCB3b3VsZCBtYWtl
IHNlbnNlIGlzOg0KPj4+DQo+Pj4gRURBQyBpbW11dGFibGUgYnJhbmNoIGZvcjoNCj4+PiAgMTog
RURBQzogQWRkIHN1cHBvcnQgZm9yIEVEQUMgZGV2aWNlIGZlYXR1cmVzIGNvbnRyb2wNCj4+PiAg
MjogQWRkIHNjcnViIGNvbnRyb2wgZmVhdHVyZQ0KPj4+ICAzOiBFREFDOiBBZGQgRUNTIGNvbnRy
b2wgZmVhdHVyZQ0KPj4+ICAxNTogRURBQzogQWRkIG1lbW9yeSByZXBhaXIgY29udHJvbCBmZWF0
dXJlDQo+Pj4NCj4+PiBBQ1BJIG1lcmdlcyBFREFDIGltbXV0YWJsZSArDQo+Pj4gIDEzOiBBQ1BJ
OlJBUzI6IEFkZCBBQ1BJIFJBUzIgZHJpdmVyDQo+Pj4gIDE0OiByYXM6IG1lbTogQWRkIG1lbW9y
eSBBQ1BJIFJBUzIgZHJpdmVyDQo+Pj4NCj4+PiBDWEwgbWVyZ2VzIEVEQUMgaW1tdXRhYmxlICsN
Cj4+PiAgNDogY3hsOiBSZWZhY3RvciB1c2VyIGlvY3RsIGNvbW1hbmQgcGF0aCBmcm9tIG1kcyB0
byBtYWlsYm94DQo+Pj4gIDU6IGN4bDogQWRkIEdldCBTdXBwb3J0ZWQgRmVhdHVyZXMgY29tbWFu
ZCBmb3Iga2VybmVsIHVzYWdlDQo+Pj4gIDY6IGN4bC9tYm94OiBBZGQgR0VUX0ZFQVRVUkUgbWFp
bGJveCBjb21tYW5kDQo+Pj4gIDc6IGN4bDogQWRkIEdldCBGZWF0dXJlIGNvbW1hbmQgc3VwcG9y
dCBmb3IgdXNlciBzdWJtaXNzaW9uDQo+Pj4gIDg6IGN4bC9tYm94OiBBZGQgU0VUX0ZFQVRVUkUg
bWFpbGJveCBjb21tYW5kDQo+Pj4gIDk6IGN4bDogQWRkIFNldCBGZWF0dXJlIGNvbW1hbmQgc3Vw
cG9ydCBmb3IgdXNlciBzdWJtaXNzaW9uDQo+Pj4gIDEwOiBjeGw6IEFkZCBVVUlEcyBmb3IgdGhl
IENYTCBSQVMgZmVhdHVyZXMNCj4+PiAgMTE6IGN4bC9tZW1mZWF0dXJlOiBBZGQgQ1hMIG1lbW9y
eSBkZXZpY2UgcGF0cm9sIHNjcnViIGNvbnRyb2wNCj4+PiBmZWF0dXJlDQo+Pj4gIDEyOiBjeGwv
bWVtZmVhdHVyZTogQWRkIENYTCBtZW1vcnkgZGV2aWNlIEVDUyBjb250cm9sIGZlYXR1cmUNCj4+
PiAgMTY6IGN4bC9tYm94OiBBZGQgc3VwcG9ydCBmb3IgUEVSRk9STV9NQUlOVEVOQU5DRSBtYWls
Ym94IGNvbW1hbmQNCj4+PiAgMTc6IGN4bC9tZW1mZWF0dXJlOiBBZGQgQ1hMIG1lbW9yeSBkZXZp
Y2Ugc29mdCBQUFIgY29udHJvbCBmZWF0dXJlDQo+Pj4gIDE4OiBjeGwvbWVtZmVhdHVyZTogQWRk
IENYTCBtZW1vcnkgZGV2aWNlIG1lbW9yeSBzcGFyaW5nIGNvbnRyb2wNCj4+PiBmZWF0dXJlDQo+
Pg0KPj5UaGF0IHdvcmtzIGZvciBtZS4NCj4+DQo+PkRKDQo+Pg0KPj4+DQo+Pj4gVGhhdCBkb2Vz
IG1lYW4gdGhhdCB0aGUgYWN0dWFsIGRyaXZlcnMvZWRhYy8gc3BlY2lmaWMgZHJpdmVycyBsYW5k
DQo+Pj4gdmlhIHRoZSBBQ1BJIGFuZCBDWEwgdHJlZXMgb25seSwgYnV0IHdpdGhvdXQgYW5vdGhl
ciBsYXllciBvZg0KPj4+IGltbXV0YWJsZSBicmFuY2hlcyB3ZSBjYW4ndCBhdm9pZCB0aGF0LiBN
aWdodCBjYXVzZSBtZXJnZSBjb25mbGljdHMNCj4+PiBpbiBLY29uZmlnL01ha2VmaWxlcyBidXQg
b3RoZXJ3aXNlIHNob3VsZG4ndCBiZSB0b28gYmFkLg0KPj4+DQo+Pj4gVGhlcmUgaXMgZ29pbmcg
dG8gYmUgc29tZSBub2lzZSBpbiBkb2N1bWVudGF0aW9uIGFzIGV4YW1wbGVzIGFyZQ0KPj4+IGFk
ZGVkIHRvIHRoZSBkb2NzIHdpdGggdGhlIGFjdHVhbCBkcml2ZXJzICh3aGVyZWFzIGdlbmVyaWMg
ZG9jcyBhcmUNCj4+PiBpbnRyb2R1Y2VkIHdpdGggdGhlIGluZnJhc3RydWN0dXJlKS4gIEkgdGhp
bmsgdGhhdCB3aWxsIHdvcmsgb3V0IHRob3VnaC4NCj4+PiBTaGlqdSwgY291bGQgeW91IHNwaW4g
dGhpcyBvcmRlcmluZyB1cCBhbmQgY2hlY2sgaXQgYWxsIHdvcmtzDQo+Pj4gKGluY29ycG9yYXRp
bmcgRGF2ZSdzIHVwZGF0ZXMgdG8gdGhlIEdFVCAvIFNFVCBmZWF0dXJlKT8NCj4NCj5SZWJhc2Vk
LCByZW9yZGVyZWQgYW5kIHRlc3RlZCBmaW5lLiBXYWl0aW5nIGZvciBzb21lIGluZm9ybWF0aW9u
IGJlZm9yZQ0KPnNoYXJpbmcgdGhlIHVwZGF0ZWQgcGF0Y2hlcy4NCg0KUGxlYXNlIGZpbmQgdXBk
YXRlZCBhbmQgcmVvcmRlcmVkIHBhdGNoZXMgaW4NCmh0dHBzOi8vZ2l0aHViLmNvbS9zaGlqdWpv
c2U0L2xpbnV4L3RyZWUvZWRhYy1lbmhhbmNlbWVudC1yYXMtZmVhdHVyZXNfdjE4DQpQbGVhc2Ug
bm90ZSB0aGF0IEVEQUMgcGF0Y2hlcyBhcmUgdGhlIHNhbWUgYXMgaW4gdjE3IG90aGVyIHRoYW4g
dXBkYXRlZCwgdGhlIGtlcm5lbCB2ZXJzaW9uDQp0byA2LjE0IGluIHRoZSBkb2N1bWVudGF0aW9u
Lg0KDQo+DQo+Pj4gPiBUaGFua3MsDQo+Pj4NCj4+PiBKb25hdGhhbg0KPj4NCg0KVGhhbmtzLA0K
U2hpanUNCg==

