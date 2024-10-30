Return-Path: <linux-edac+bounces-2344-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C39B6367
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 13:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD08B21912
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843D1E3772;
	Wed, 30 Oct 2024 12:52:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DA4D8A7;
	Wed, 30 Oct 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292767; cv=none; b=Y3JV3jAPWtCR8ugTt7w9m627t+6PLnEAI+43oIB4KcXEOzZYpneMBHuZfKNiGOMUyJKj8b9yiyNAJ6CTYgEDHNKTIWBbHB9hb2tTbj66DSPPkTWk82nJoLi8LxqCcW8NG3bz+fYUzmeyDoBrf8CVsUgvIYmhGz2G78srvMtrvF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292767; c=relaxed/simple;
	bh=6FmvHYArbP9A5eMkduasERmZjhT6W53BfofWfnRc/y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOAQDTQASnYMmEUnWpzmJMmn212gNR00Q7FT9F0B0CIk7IoTm9HcoNN/4gx8il/szkcXsdzY3HrqD0bBU0yQh//SkHLeBAas9ICC9gBiwQo1Tx7EsfeP7h7XtJ3j9KTQMj9V/aQtTKLEedXUDaEtIfIyvsiVM4zWjHaU33o9IAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdn604437z6K6YJ;
	Wed, 30 Oct 2024 20:50:16 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 969AB140429;
	Wed, 30 Oct 2024 20:52:41 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 13:52:41 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 30 Oct 2024 13:52:41 +0100
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
Subject: RE: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Topic: [PATCH v14 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Thread-Index: AQHbJwFiEsGT6VLXSEWw7XeCpRer7rKeH9CAgAEnCgA=
Date: Wed, 30 Oct 2024 12:52:41 +0000
Message-ID: <35c697489f2b486482ddc42d435861e4@huawei.com>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-8-shiju.jose@huawei.com>
 <20241029201527.GTZyFCX_foMR_GouGN@fat_crate.local>
In-Reply-To: <20241029201527.GTZyFCX_foMR_GouGN@fat_crate.local>
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPg0KPlNlbnQ6IDI5IE9jdG9iZXIgMjAyNCAyMDoxNQ0KPlRvOiBTaGlqdSBK
b3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5hY3BpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PnRvbnkubHVja0BpbnRlbC5jb207IHJhZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7
DQo+bWNoZWhhYkBrZXJuZWwub3JnOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IGRhdmVAc3Rn
b2xhYnMubmV0OyBKb25hdGhhbg0KPkNhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPnN1ZGVlcC5ob2xsYUBhcm0uY29tOyBq
YXNzaXNpbmdoYnJhckBnbWFpbC5jb207IGRhdmUuamlhbmdAaW50ZWwuY29tOw0KPmFsaXNvbi5z
Y2hvZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBp
bnRlbC5jb207DQo+ZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IGxl
by5kdXJhbkBhbWQuY29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgcmllbnRqZXNAZ29vZ2xl
LmNvbTsgamlhcWl5YW5AZ29vZ2xlLmNvbTsNCj5Kb24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5oYW5z
ZW5AbGludXguaW50ZWwuY29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1lcy5tb3Jz
ZUBhcm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRhcmFtLmFAaHBlLmNv
bTsgZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsNCj5kdWVud2VuQGdv
b2dsZS5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29tcHV0aW5n
LmNvbTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNvbXB1
dGluZy5jb207IG5pZmFuLmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2ZlaUBo
dWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVy
dG8NCj5TYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hlbkBmdXR1
cmV3ZWkuY29tOw0KPndhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBMaW51
eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE0IDA3
LzE0XSBjeGwvbWVtZmVhdHVyZTogQWRkIENYTCBtZW1vcnkgZGV2aWNlIHBhdHJvbA0KPnNjcnVi
IGNvbnRyb2wgZmVhdHVyZQ0KPg0KPk9uIEZyaSwgT2N0IDI1LCAyMDI0IGF0IDA2OjEzOjQ4UE0g
KzAxMDAsIHNoaWp1Lmpvc2VAaHVhd2VpLmNvbSB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2VkYWMvZWRhYy1zY3J1Yi5yc3QNCj4+IGIvRG9jdW1lbnRhdGlvbi9lZGFjL2Vk
YWMtc2NydWIucnN0DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAw
MDAwLi40YWFkNDk3NGIyMDgNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZWRhYy9lZGFjLXNjcnViLnJzdA0KPj4gQEAgLTAsMCArMSw3NCBAQA0KPj4gKy4uIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArDQpbLi4uXQ0KPj4gKzENCj4+ICtyb290
QGxvY2FsaG9zdDp+IyBlY2hvIDAgPg0KPj4gKy9zeXMvYnVzL2VkYWMvZGV2aWNlcy9jeGxfcmVn
aW9uMC9zY3J1YjAvZW5hYmxlX2JhY2tncm91bmQNCj4+ICtyb290QGxvY2FsaG9zdDp+IyBjYXQN
Cj4+ICsvc3lzL2J1cy9lZGFjL2RldmljZXMvY3hsX3JlZ2lvbjAvc2NydWIwL2VuYWJsZV9iYWNr
Z3JvdW5kDQo+PiArMA0KPg0KPlRoaXMgZmlsZSdzIGFkZGl0aW9uIGJlbG9uZ3MgdG8gc29tZSBF
REFDIHBhdGNoIGluIHRoZSBzZXJpZXMsIG5vdCBoZXJlLg0KSSB3aWxsIGRvLg0KPg0KPkl0IGNv
dWxkIGJlIGEgc2VwYXJhdGUsIGxhc3QgcGF0Y2ggaW4gdGhlIHNlcmllcyB0b28sIG9uY2UgZXZl
cnl0aGluZyBpcyBzZXR0bGVkLg0KPg0KPlRoeC4NCj4NCj4tLQ0KPlJlZ2FyZHMvR3J1c3MsDQo+
ICAgIEJvcmlzLg0KDQpUaGFua3MsDQpTaGlqdQ0K

