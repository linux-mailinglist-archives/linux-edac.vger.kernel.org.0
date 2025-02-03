Return-Path: <linux-edac+bounces-2964-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0788A2562C
	for <lists+linux-edac@lfdr.de>; Mon,  3 Feb 2025 10:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA127A38AB
	for <lists+linux-edac@lfdr.de>; Mon,  3 Feb 2025 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B21FFC71;
	Mon,  3 Feb 2025 09:43:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A271FFC4A;
	Mon,  3 Feb 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575835; cv=none; b=Y1/+efV9UQyi78HnwC/nOLS1IeFuRdnnN6efd57CyO58q8INGFR8ylHQlx30sBcw55m2ufi2CqpgKaMOlRNhMc0NWe/sgXGWUFCTKFyb/6g+1JdI6BHNSMo7EOp03I3e/jwZCQnySNheLWQ2MaQJDelFhI5hK3BcRDjSVu0+LEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575835; c=relaxed/simple;
	bh=u/TiDheBGQMUcfKMENR1ti8/63pZ28MNQGX44NFvsT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqZsM8Q+/QRDlrg7khNsmqav68ti2DM/LXUqaBYHe852N9mIP8hwpekWXTDEh7d6cayxwFxcajpzwXQObDnRWS34TAPjEp6dFoUJCdS103WWKDGo/OGvbQBHBjWJd4cpFEApb1YLDF7WlGHSODqttIDHY0D9w3ro4ZUzWcxQjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymgy16hQ4z6L4xM;
	Mon,  3 Feb 2025 17:22:33 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 7160B14011B;
	Mon,  3 Feb 2025 17:25:05 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Feb 2025 10:25:05 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 3 Feb 2025 10:25:05 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
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
Subject: RE: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS control
 feature driver + CXL/ACPI-RAS2 drivers
Thread-Topic: [PATCH v18 00/19] EDAC: Scrub: introduce generic EDAC RAS
 control feature driver + CXL/ACPI-RAS2 drivers
Thread-Index: AQHbYDQZq6uipUr1qkCeE+MAaYkJNbMvxkMAgAWzXZA=
Date: Mon, 3 Feb 2025 09:25:05 +0000
Message-ID: <a00264d506064598b81c31a369408e74@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <a6af63e2-227a-4909-9b87-8eff96be088b@os.amperecomputing.com>
In-Reply-To: <a6af63e2-227a-4909-9b87-8eff96be088b@os.amperecomputing.com>
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBGZXJndXNvbiA8
ZGFuaWVsZkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPlNlbnQ6IDMwIEphbnVhcnkgMjAyNSAx
OToxOA0KPlRvOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+OyBsaW51eC1lZGFj
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+Y3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYWNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtDQo+a2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPkNjOiBicEBhbGllbjguZGU7IHRvbnkubHVja0BpbnRlbC5jb207IHJh
ZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7DQo+bWNoZWhhYkBrZXJuZWwub3JnOyBk
YW4uai53aWxsaWFtc0BpbnRlbC5jb207IGRhdmVAc3Rnb2xhYnMubmV0OyBKb25hdGhhbg0KPkNh
bWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IGRhdmUuamlhbmdAaW50ZWwuY29t
Ow0KPmFsaXNvbi5zY2hvZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207
IGlyYS53ZWlueUBpbnRlbC5jb207DQo+ZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFu
QGFtZC5jb207IGxlby5kdXJhbkBhbWQuY29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgcmll
bnRqZXNAZ29vZ2xlLmNvbTsgamlhcWl5YW5AZ29vZ2xlLmNvbTsNCj5Kb24uR3JpbW1AYW1kLmNv
bTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29t
OyBqYW1lcy5tb3JzZUBhcm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRh
cmFtLmFAaHBlLmNvbTsgZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsN
Cj5kdWVud2VuQGdvb2dsZS5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1w
ZXJlY29tcHV0aW5nLmNvbTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9z
LmFtcGVyZWNvbXB1dGluZy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48
dGFueGlhb2ZlaUBodWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29u
LmNvbT47IFJvYmVydG8NCj5TYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2th
bmcuc2hlbkBmdXR1cmV3ZWkuY29tOw0KPndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdl
aS5jb20+OyBMaW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjE4IDAwLzE5XSBFREFDOiBTY3J1YjogaW50cm9kdWNlIGdlbmVyaWMgRURBQyBSQVMN
Cj5jb250cm9sIGZlYXR1cmUgZHJpdmVyICsgQ1hML0FDUEktUkFTMiBkcml2ZXJzDQo+DQo+SGkg
U2hpanUsDQo+DQo+SSd2ZSB0ZXN0ZWQgdGhlIFNjcnViIHNwZWNpZmljIHBpZWNlcyBhbmQgdGhl
IEVEQUMgaW5mcmFzdHJ1Y3R1cmUgcGllY2VzKGFzIGZhciBhcw0KPmhvdyBpdCByZWxhdGVzIHRv
IHRoZSBTY3J1YiBwaWVjZXMpLiBJIGFtIHVzaW5nIGFuIEFSTTY0IHBsYXRmb3JtIGZvciB0aGlz
DQo+dGVzdGluZy4gSSB3b3VsZCBsaWtlIHRvIG9mZmVyIG15IHRlc3RlZC1ieSB0byB0aG9zZSBw
aWVjZXMgSSBoYXZlIHBlcnNvbmFsDQo+ZXhwZXJpZW5jZSB3aXRoLiBJIHdpbGwgc2VuZCB0aGVt
IGFzIHJlcGxpZXMgdG8gdGhlaXIgcmVzcGVjdGl2ZSBwYXRjaGVzLg0KDQpIaSBEYW5pZWwsDQoN
ClRoYW5rcyBmb3IgdGVzdGluZyB0aGUgRURBQyBpbmZyYXN0cnVjdHVyZSBmb3Igc2NydWJiaW5n
IGZlYXR1cmUuDQpJIHdpbGwgYWRkICB0ZXN0ZWQtYnkgZm9yIHlvdS4gDQoNClRoYW5rcywNClNo
aWp1DQo+DQo+VGhhbmsgeW91LA0KPn5EYW5pZWwNCg==

