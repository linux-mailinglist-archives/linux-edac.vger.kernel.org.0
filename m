Return-Path: <linux-edac+bounces-5649-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB44D24F8F
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jan 2026 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FB593036C4F
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jan 2026 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2B3939DB;
	Thu, 15 Jan 2026 14:35:13 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C323EA94;
	Thu, 15 Jan 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487713; cv=none; b=ADERereSSWqNq0/bGt6NRTqCt/tVMVHrRIrB85WMGuP6/przkfekk/CgMGmJpdqsAjFLtJcSY6+JGtUZrSUz/QGnDf4G5Swye+X+NKJmg/Ctk0FSyUG5nnZYebY7S7sFb8FF1zXoGrRiTv4ih4CorbrbfwnBcfmkU862c8e5zQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487713; c=relaxed/simple;
	bh=GsnesY46C7txOMXSi1RG0Noxnsupye4L9XuEAcDVyC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FoUrC5CL5dbG2g561Lj9xXJTaKyehx8nSj951oSGrhvobTIC48V+62kQU4jLkV7qS6emeFWriWqm1PXvVV3vW8xQaqAmNcn37Nv7RwLv+lrzMql/ZiF5csm0fehqO7IT82ORh/YJLJH7kh4fQfuaiVWVJMSye4ljmRaT0eV3nNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsQVh2NPfzJ46C6;
	Thu, 15 Jan 2026 22:34:52 +0800 (CST)
Received: from dubpeml100006.china.huawei.com (unknown [7.214.145.132])
	by mail.maildlp.com (Postfix) with ESMTPS id B579340584;
	Thu, 15 Jan 2026 22:35:08 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (7.214.145.227) by
 dubpeml100006.china.huawei.com (7.214.145.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 15 Jan 2026 14:35:08 +0000
Received: from dubpeml100008.china.huawei.com ([7.214.145.227]) by
 dubpeml100008.china.huawei.com ([7.214.145.227]) with mapi id 15.02.1544.036;
 Thu, 15 Jan 2026 14:35:08 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>
CC: "rafael@kernel.org" <rafael@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, "rientjes@google.com" <rientjes@google.com>,
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
Subject: RE: [PATCH v14 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Thread-Topic: [PATCH v14 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Thread-Index: AQHcaRwzowtPaYFfVka45sLtxZNoVLVO16oAgAE3y4CAA3WoUA==
Date: Thu, 15 Jan 2026 14:35:08 +0000
Message-ID: <d310566a0d6544eeb57a43b110782118@huawei.com>
References: <20251209145742.297-1-shiju.jose@huawei.com>
 <20251209145742.297-2-shiju.jose@huawei.com>
 <20260112150552.GGaWUN0Ex8KgfqEEi5@fat_crate.local>
 <20260113094149.GAaWYTXf6qH4zleOOQ@fat_crate.local>
In-Reply-To: <20260113094149.GAaWYTXf6qH4zleOOQ@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMTMgSmFudWFyeSAyMDI2IDA5OjQyDQo+VG86IFNoaWp1IEpvc2Ug
PHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogcmFmYWVsQGtlcm5lbC5vcmc7IGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc7IHJwcHRAa2VybmVsLm9yZzsNCj5kZmVyZ3Vzb25AYW1wZXJlY29t
cHV0aW5nLmNvbTsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmFjcGlAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5v
cmc7DQo+dG9ueS5sdWNrQGludGVsLmNvbTsgbGVuYkBrZXJuZWwub3JnOyBsZW8uZHVyYW5AYW1k
LmNvbTsNCj5ZYXplbi5HaGFubmFtQGFtZC5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsgSm9uYXRo
YW4gQ2FtZXJvbg0KPjxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBMaW51eGFybSA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47DQo+cmllbnRqZXNAZ29vZ2xlLmNvbTsgamlhcWl5YW5AZ29vZ2xl
LmNvbTsgSm9uLkdyaW1tQGFtZC5jb207DQo+ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyBu
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsNCj5qYW1lcy5tb3JzZUBhcm0uY29tOyBqdGhvdWdodG9u
QGdvb2dsZS5jb207IHNvbWFzdW5kYXJhbS5hQGhwZS5jb207DQo+ZXJkZW1ha3Rhc0Bnb29nbGUu
Y29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsgZHVlbndlbkBnb29nbGUuY29tOw0KPmd0aGVsZW5AZ29v
Z2xlLmNvbTsgd3NjaHdhcnR6QGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNv
bXB1dGluZy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2Zl
aUBodWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJv
YmVydG8NCj5TYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hlbkBm
dXR1cmV3ZWkuY29tOw0KPndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+DQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMS8yXSBBQ1BJOlJBUzI6IEFkZCBkcml2ZXIgZm9yIHRo
ZSBBQ1BJIFJBUzIgZmVhdHVyZQ0KPnRhYmxlDQo+DQo+T24gTW9uLCBKYW4gMTIsIDIwMjYgYXQg
MDQ6MDU6NTJQTSArMDEwMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPj4gUGxlYXNlIGdvIG92
ZXIgYWxsIG15IHJldmlldyBjb21tZW50cyBmcm9tIGhlcmU6DQo+Pg0KPj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDI1MTEyNTA3MzYyNy5HTGFTVmNlN2hCcUdIMWEzbmlAZmF0X2NyYXRl
Lg0KPj4gbG9jYWwNCj4+DQo+PiBhbmQgZWl0aGVyIGluY29ycG9yYXRlIHRoZW0gb3Igc2F5IHdo
eSB5b3UgZG9uJ3QgYWdyZWUuDQo+Pg0KPj4gSWdub3JpbmcgdGhlbSBpcyBOT1Qgc29tZXRoaW5n
IHlvdSBzaG91bGQgZG8gYmVjYXVzZSB0aGlzIGdvZXMgYm90aCB3YXlzLg0KPj4NCj4+IElnbm9y
aW5nIHRoaXMgc3VibWlzc2lvbiBub3cuDQo+DQo+SSB0YWtlIHRoYXQgYmFjayAtIEkgZm9yZ290
IHRoYXQgdGhlcmUgd2FzIGFuIGluLWZsaWdodCByZXZpZXcgd2hlbiB5b3Ugc2VudCB5b3VyDQo+
djE0LiBTb3JyeS4NCj4NCj5TbyBwbGVhc2UgaW5jb3Jwb3JhdGUgKmFsbCogZmVlZGJhY2sgYW5k
IHNlbmQgYSBuZXcgdmVyc2lvbiBzbyB0aGF0IEkgY2FuIHRha2UgYQ0KPmxvb2suDQoNCkhpIEJv
cmlzbGF2LA0KDQpTdXJlLiBWMTUgc2VyaWVzIGhhcyBwb3N0ZWQgaW5jb3Jwb3JhdGluZyB5b3Vy
IGNvbW1lbnRzLiANCg0KVGhhbmtzLA0KU2hpanUNCg0KPg0KPlRoeC4NCj4NCj4tLQ0KPlJlZ2Fy
ZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGds
eC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=

