Return-Path: <linux-edac+bounces-3193-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7133A42B5A
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7153A5B9C
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 18:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB216254873;
	Mon, 24 Feb 2025 18:30:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154438DEC;
	Mon, 24 Feb 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421855; cv=none; b=uTkJdB1gAO8M86LdUFh/9D9pmFYn8ca9oLVDoQjs+CjNmhaOf39L6pE+bfF0hD2vja11BFYVFpIqqvSVLNp5OwkaWxDSSunodIAAbTc7c49SozuoDU+OYPX1f07ljW/0Fvo3zySohjNDLykh/EK6qHpYpHDER9VAt/8au4itslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421855; c=relaxed/simple;
	bh=tEtVvuwWHlDXcAj0n/08mNkgMs0+lM9v7CgaWRalZ9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BW7tsmmZCEThH5zzrt79gRAOTvQLZJ5pp9j9LxXrCsMSI/qXVGZvLeu0AUndHLr0ofTxwx/g0CopyUvfdPENVJYNlV6L2FAgW+mQlmMCYn6gLu/Zb2wgKwSddOuV+QHu7xMt6N5cH8JnfuecZn/++G5DFdRPLP1VRjVyB8CZUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z1q3m4wqkz6M4ny;
	Tue, 25 Feb 2025 02:28:04 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id B6424140B63;
	Tue, 25 Feb 2025 02:30:48 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Feb 2025 19:30:48 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 24 Feb 2025 19:30:48 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
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
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
Thread-Topic: [PATCH v20 00/15] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Thread-Index: AQHbfVuaekLsP7SN9UOZsd1dS/TdhbNWWP4AgAB+X0A=
Date: Mon, 24 Feb 2025 18:30:48 +0000
Message-ID: <71ad0c8c6a304b2d9a62f49983c3d787@huawei.com>
References: <20250212143654.1893-1-shiju.jose@huawei.com>
 <20250224115002.GCZ7xc6o3yA1Q2j85i@fat_crate.local>
In-Reply-To: <20250224115002.GCZ7xc6o3yA1Q2j85i@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMjQgRmVicnVhcnkgMjAyNSAxMTo1MA0KPlRvOiBTaGlqdSBKb3Nl
IDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5hY3BpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5jb207IHJhZmFlbEBrZXJu
ZWwub3JnOw0KPmxlbmJAa2VybmVsLm9yZzsgbWNoZWhhYkBrZXJuZWwub3JnOyBkYW4uai53aWxs
aWFtc0BpbnRlbC5jb207DQo+ZGF2ZUBzdGdvbGFicy5uZXQ7IEpvbmF0aGFuIENhbWVyb24gPGpv
bmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+ZGF2ZS5qaWFuZ0BpbnRlbC5jb207IGFsaXNv
bi5zY2hvZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207DQo+aXJhLndl
aW55QGludGVsLmNvbTsgZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFuQGFtZC5jb207
DQo+bGVvLmR1cmFuQGFtZC5jb207IFlhemVuLkdoYW5uYW1AYW1kLmNvbTsgcmllbnRqZXNAZ29v
Z2xlLmNvbTsNCj5qaWFxaXlhbkBnb29nbGUuY29tOyBKb24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5o
YW5zZW5AbGludXguaW50ZWwuY29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1lcy5t
b3JzZUBhcm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRhcmFtLmFAaHBl
LmNvbTsgZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsNCj5kdWVud2Vu
QGdvb2dsZS5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29tcHV0
aW5nLmNvbTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNv
bXB1dGluZy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2Zl
aUBodWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJv
YmVydG8NCj5TYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hlbkBm
dXR1cmV3ZWkuY29tOw0KPndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBM
aW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIw
IDAwLzE1XSBFREFDOiBTY3J1YjogaW50cm9kdWNlIGdlbmVyaWMgRURBQyBSQVMNCj5jb250cm9s
IGZlYXR1cmUgZHJpdmVyICsgQ1hML0FDUEktUkFTMiBkcml2ZXJzDQo+DQo+T24gV2VkLCBGZWIg
MTIsIDIwMjUgYXQgMDI6MzY6MzhQTSArMDAwMCwgc2hpanUuam9zZUBodWF3ZWkuY29tIHdyb3Rl
Og0KPj4gRnJvbTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4NCj4+IFRo
ZSBDWEwgcGF0Y2hlcyBvZiB0aGlzIHNlcmllcyBoYXMgZGVwZW5kZW5jeSBvbiBEYXZlJ3MgQ1hM
IGZ3Y3RsDQo+PiBzZXJpZXMgWzFdLg0KPg0KPkZpcnN0IDUgcGF0Y2hlcyBtYXNzYWdlZCBhbmQg
cXVldWVkIGhlcmU6DQo+DQo+aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvYnAvYnAuZ2l0L2xvZy8/aD1lZGFjLWN4bA0KPg0KPlBsZWFzZSBydW4gdGhlbSB3
aXRoIHRoZSByZXN0IG9mIHlvdXIgdGVzdCBjYXNlcyB0byBtYWtlIHN1cmUgSSBoYXZlbid0IGZh
dC0NCj5maW5nZXJlZCBhbnl0aGluZy4NCg0KSGkgQm9yaXMsDQoNClRoYW5rcyBmb3Igc2hhcmlu
ZyB0aGUgdXBkYXRlZCBicmFuY2guDQoNClRlc3RpbmcgcmVzdCBvZiB0aGUgcGF0Y2hlcyBmb3Ig
Q1hMIFJBUyBmZWF0dXJlcyBhbmQgQUNQSSBSQVMyIHNjcnViIGZlYXR1cmUNCmluIHRoaXMgYnJh
bmNoIGFyZSB3b3JrZWQgZmluZS4NCg0KVGhhbmtzLA0KU2hpanUNCg0KPg0KPlRoeC4NCj4NCj4t
LQ0KPlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVvcGxlLmtlcm5l
bC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=

