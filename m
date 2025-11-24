Return-Path: <linux-edac+bounces-5517-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B989C7FA51
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 10:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDF2B4E4572
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6782F5A18;
	Mon, 24 Nov 2025 09:30:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD4263C8A;
	Mon, 24 Nov 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976601; cv=none; b=t123m9tjTjTpcN5jVFhxHl2JIDg0u/AbIW/eKV3C6AFTsplYeHpPgjWiZGbWbWpcc4r7dxUmaVvmyWKvwnyycwDsrtyakzzEtsG1VZE+myknfMtstE6vgs/aYu/FVYHrAPHS09jwTuA/+SxNDB07mdPZFCz96CB0NHpMZmym58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976601; c=relaxed/simple;
	bh=WIEzxFEC/PnkxmuAIhUbJI67YAunydQmi9QG1iFd0E4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rAWON3TdDk5QIL/E+3yFcIk25f17BL/afjXG2PQds5UPL9NpGDEjDQTK/N6gCWR2O1m0fJkziTCE9fcCdfRMBo96mOs+zYXPTCBal2sAtrlaHEXUafjJSe09Bo5bpHzPjlgSWanGh4IEQr4toTL9QeDMOyEJeRiY8VOEcF5yYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dFL9j2N5PzJ46lR;
	Mon, 24 Nov 2025 17:28:57 +0800 (CST)
Received: from dubpeml500006.china.huawei.com (unknown [7.214.146.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BE031400D3;
	Mon, 24 Nov 2025 17:29:49 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (7.214.145.227) by
 dubpeml500006.china.huawei.com (7.214.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 09:29:48 +0000
Received: from dubpeml100008.china.huawei.com ([7.214.145.227]) by
 dubpeml100008.china.huawei.com ([7.214.145.227]) with mapi id 15.02.1544.036;
 Mon, 24 Nov 2025 09:29:48 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Randy Dunlap <rdunlap@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm
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
Subject: RE: [PATCH v13 2/2] ras: mem: Add ACPI RAS2 memory driver
Thread-Topic: [PATCH v13 2/2] ras: mem: Add ACPI RAS2 memory driver
Thread-Index: AQHcWxSpDw4Z/LYIh0qhRo3faUcQr7T+KJmAgANquEA=
Date: Mon, 24 Nov 2025 09:29:48 +0000
Message-ID: <9165f50de6fa43edba7a3e6d99eebe8b@huawei.com>
References: <20251121182825.237-1-shiju.jose@huawei.com>
 <20251121182825.237-3-shiju.jose@huawei.com>
 <af7b6cdc-c0a7-4896-ba6b-6bb933898d37@infradead.org>
In-Reply-To: <af7b6cdc-c0a7-4896-ba6b-6bb933898d37@infradead.org>
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4NCj5TZW50OiAyMiBOb3ZlbWJlciAyMDI1IDA1OjE4DQo+VG86IFNo
aWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT47IHJhZmFlbEBrZXJuZWwub3JnOyBicEBh
bGllbjguZGU7DQo+YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgcnBwdEBrZXJuZWwub3JnOw0K
PmRmZXJndXNvbkBhbXBlcmVjb21wdXRpbmcuY29tOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGlu
dXgtZG9jQHZnZXIua2VybmVsLm9yZzsNCj50b255Lmx1Y2tAaW50ZWwuY29tOyBsZW5iQGtlcm5l
bC5vcmc7IGxlby5kdXJhbkBhbWQuY29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgbWNoZWhh
YkBrZXJuZWwub3JnDQo+Q2M6IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVh
d2VpLmNvbT47IExpbnV4YXJtDQo+PGxpbnV4YXJtQGh1YXdlaS5jb20+OyByaWVudGplc0Bnb29n
bGUuY29tOyBqaWFxaXlhbkBnb29nbGUuY29tOw0KPkpvbi5HcmltbUBhbWQuY29tOyBkYXZlLmhh
bnNlbkBsaW51eC5pbnRlbC5jb207DQo+bmFveWEuaG9yaWd1Y2hpQG5lYy5jb207IGphbWVzLm1v
cnNlQGFybS5jb207IGp0aG91Z2h0b25AZ29vZ2xlLmNvbTsNCj5zb21hc3VuZGFyYW0uYUBocGUu
Y29tOyBlcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29nbGUuY29tOw0KPmR1ZW53ZW5A
Z29vZ2xlLmNvbTsgZ3RoZWxlbkBnb29nbGUuY29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRp
bmcuY29tOyB3YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsNCj5uaWZhbi5jeGxAZ21haWwuY29t
OyB0YW54aWFvZmVpIDx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKQ0KPjxwcmlt
ZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdl
aS5jb20+Ow0KPmthbmdrYW5nLnNoZW5AZnV0dXJld2VpLmNvbTsgd2FuZ2h1aXFpYW5nIDx3YW5n
aHVpcWlhbmdAaHVhd2VpLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxMyAyLzJdIHJhczog
bWVtOiBBZGQgQUNQSSBSQVMyIG1lbW9yeSBkcml2ZXINCj4NCj4NCj4NCj5PbiAxMS8yMS8yNSAx
MDoyOCBBTSwgc2hpanUuam9zZUBodWF3ZWkuY29tIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcmFzL0tjb25maWcgYi9kcml2ZXJzL3Jhcy9LY29uZmlnDQo+PiBpbmRleCBmYzRmNGJi
OTRhNGMuLjdlN2FmZDJiMmJhNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvcmFzL0tjb25maWcN
Cj4+ICsrKyBiL2RyaXZlcnMvcmFzL0tjb25maWcNCj4+IEBAIC00Niw0ICs0NiwxNiBAQCBjb25m
aWcgUkFTX0ZNUE0NCj4+ICAJICBNZW1vcnkgd2lsbCBiZSByZXRpcmVkIGR1cmluZyBib290IHRp
bWUgYW5kIHJ1biB0aW1lIGRlcGVuZGluZyBvbg0KPj4gIAkgIHBsYXRmb3JtLXNwZWNpZmljIHBv
bGljaWVzLg0KPj4NCj4+ICtjb25maWcgTUVNX0FDUElfUkFTMg0KPj4gKwl0cmlzdGF0ZSAiTWVt
b3J5IEFDUEkgUkFTMiBkcml2ZXIiDQo+PiArCWRlcGVuZHMgb24gQUNQSV9SQVMyDQo+PiArCWRl
cGVuZHMgb24gRURBQw0KPj4gKwlkZXBlbmRzIG9uIEVEQUNfU0NSVUINCj4+ICsJaGVscA0KPj4g
KwkgIFRoZSBkcml2ZXIgYmluZHMgdG8gdGhlIGF1eGlsaWFyeSBkZXZpY2UgYWRkZWQgYnkgdGhl
IEFDUEkgUkFTMg0KPj4gKwkgIGZlYXR1cmUgdGFibGUgcGFyc2VyLiBUaGUgZHJpdmVyIHVzZXMg
YSBQQ0MgY2hhbm5lbCBzdWJzcGFjZSB0bw0KPj4gKwkgIGNvbW11bmljYXRpbmcgd2l0aCB0aGUg
QUNQSS1jb21wbGlhbnQgcGxhdGZvcm0gYW5kIHByb3ZpZGVzDQo+DQo+CSAgY29tbXVuaWNhdGUg
d2l0aA0KVGhhbmtzIFJhbmR5IGZvciByZXZpZXdpbmcuIEkgd2lsbCBmaXguDQoNCj4NCj4+ICsJ
ICBjb250cm9sIG9mIHRoZSBIVy1iYXNlZCBtZW1vcnkgc2NydWJiZXIgcGFyYW1ldGVycyB0byB0
aGUgdXNlcg0KPj4gKwkgIHRocm91Z2ggdGhlIEVEQUMgc2NydWIgaW50ZXJmYWNlLg0KPg0KPi0t
DQo+flJhbmR5DQo+DQoNClRoYW5rcywNClNoaWp1DQo=

