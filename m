Return-Path: <linux-edac+bounces-2941-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA55A19578
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4661A1883D8E
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CAC2147E7;
	Wed, 22 Jan 2025 15:39:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516938DC0;
	Wed, 22 Jan 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560346; cv=none; b=OMMxWRA2o8ia93PUjeJGMCs2kB48xIXUrX491yG4SLbobdB2vvYeGdz6O+legruQnzGfVsK/bNX67qJcl7FFR9Jxi0iRXXO3xz4mXY7W4jCH1PCa5Yg7qn6kcikxToR8+Lm8wPmTf33nI74pQtGtmFGFQ3GyzzU8GawtvX6sof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560346; c=relaxed/simple;
	bh=MIKSQ7UxY98Sl2FHgEy9YxBdCbAVhRndPN3dLppqu5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fUd2hGfY3C/qYyndlYizxw7mcpFLf/XdPoz2gXHDOkiMLTapV5p/kG646yzs1hZBxj/syTO455HfCrxml2VYwSbz86P91OZT+VvN7xyGobO9JYjdAwq2Eb6LLn91wLG29yNKwNYDdSn2iWz29ExjAb3DkhUjgG5QBpRw8+H8gd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YdSqb5g1Wz67Ldy;
	Wed, 22 Jan 2025 23:36:59 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CE621408F9;
	Wed, 22 Jan 2025 23:38:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 16:38:55 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 22 Jan 2025 16:38:55 +0100
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
Subject: RE: [PATCH v18 05/19] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v18 05/19] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHbYDQiZumDs/5vrkCWy+AxWVuSd7Mh34mAgAESWmA=
Date: Wed, 22 Jan 2025 15:38:55 +0000
Message-ID: <97de84c2ad194b10ae4c9948d9bda2c6@huawei.com>
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-6-shiju.jose@huawei.com>
 <a562f557-0530-4e29-b0d0-78d4441e06e1@os.amperecomputing.com>
In-Reply-To: <a562f557-0530-4e29-b0d0-78d4441e06e1@os.amperecomputing.com>
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEYW5pZWwgRmVyZ3Vzb24gPGRh
bmllbGZAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj5TZW50OiAyMSBKYW51YXJ5IDIwMjUgMjM6
MDENCj5UbzogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPjsgbGludXgtZWRhY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj5DYzogYnBAYWxpZW44LmRlOyB0b255Lmx1Y2tAaW50ZWwuY29tOyByYWZh
ZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPm1jaGVoYWJAa2VybmVsLm9yZzsgZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tOyBkYXZlQHN0Z29sYWJzLm5ldDsgSm9uYXRoYW4NCj5DYW1l
cm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBkYXZlLmppYW5nQGludGVsLmNvbTsN
Cj5hbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsgdmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBp
cmEud2VpbnlAaW50ZWwuY29tOw0KPmRhdmlkQHJlZGhhdC5jb207IFZpbGFzLlNyaWRoYXJhbkBh
bWQuY29tOyBsZW8uZHVyYW5AYW1kLmNvbTsNCj5ZYXplbi5HaGFubmFtQGFtZC5jb207IHJpZW50
amVzQGdvb2dsZS5jb207IGppYXFpeWFuQGdvb2dsZS5jb207DQo+Sm9uLkdyaW1tQGFtZC5jb207
IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsg
amFtZXMubW9yc2VAYXJtLmNvbTsganRob3VnaHRvbkBnb29nbGUuY29tOw0KPnNvbWFzdW5kYXJh
bS5hQGhwZS5jb207IGVyZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207DQo+
ZHVlbndlbkBnb29nbGUuY29tOyBndGhlbGVuQGdvb2dsZS5jb207DQo+d3NjaHdhcnR6QGFtcGVy
ZWNvbXB1dGluZy5jb207IGRmZXJndXNvbkBhbXBlcmVjb21wdXRpbmcuY29tOw0KPndic0Bvcy5h
bXBlcmVjb21wdXRpbmcuY29tOyBuaWZhbi5jeGxAZ21haWwuY29tOyB0YW54aWFvZmVpDQo+PHRh
bnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5j
b20+OyBSb2JlcnRvDQo+U2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47IGthbmdrYW5n
LnNoZW5AZnV0dXJld2VpLmNvbTsNCj53YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWku
Y29tPjsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2VpLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYxOCAwNS8xOV0gQUNQSTpSQVMyOiBBZGQgQUNQSSBSQVMyIGRyaXZlcg0KPg0KPg0KPg0K
Pk9uIDEvNi8yMDI1IDQ6MTAgQU0sIHNoaWp1Lmpvc2VAaHVhd2VpLmNvbSB3cm90ZToNCj4+ICtz
dGF0aWMgaW50IHJhczJfcmVwb3J0X2NhcF9lcnJvcih1MzIgY2FwX3N0YXR1cykgew0KPj4gKwlz
d2l0Y2ggKGNhcF9zdGF0dXMpIHsNCj4+ICsJY2FzZSBBQ1BJX1JBUzJfTk9UX1ZBTElEOg0KPj4g
KwljYXNlIEFDUElfUkFTMl9OT1RfU1VQUE9SVEVEOg0KPj4gKwkJcmV0dXJuIC1FUEVSTTsNCj4+
ICsJY2FzZSBBQ1BJX1JBUzJfQlVTWToNCj4+ICsJCXJldHVybiAtRUJVU1k7DQo+PiArCWNhc2Ug
QUNQSV9SQVMyX0ZBSUxFRDoNCj4+ICsJY2FzZSBBQ1BJX1JBUzJfQUJPUlRFRDoNCj4+ICsJY2Fz
ZSBBQ1BJX1JBUzJfSU5WQUxJRF9EQVRBOg0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCWRl
ZmF1bHQ6IC8qIDAgb3Igb3RoZXIsIFN1Y2Nlc3MgKi8NCj4+ICsJCXJldHVybiAwOw0KPj4gKwl9
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgcmFzMl9jaGVja19wY2NfY2hhbihzdHJ1Y3Qg
cmFzMl9wY2Nfc3Vic3BhY2UNCj4+ICsqcGNjX3N1YnNwYWNlKSB7DQo+PiArCXN0cnVjdCBhY3Bp
X3JhczJfc2hhcmVkX21lbW9yeSBfX2lvbWVtICpnZW5lcmljX2NvbW1fYmFzZSA9DQo+cGNjX3N1
YnNwYWNlLT5wY2NfY29tbV9hZGRyOw0KPj4gKwlrdGltZV90IG5leHRfZGVhZGxpbmUgPSBrdGlt
ZV9hZGQoa3RpbWVfZ2V0KCksIHBjY19zdWJzcGFjZS0NCj4+ZGVhZGxpbmUpOw0KPj4gKwl1MzIg
Y2FwX3N0YXR1czsNCj4+ICsJdTE2IHN0YXR1czsNCj4+ICsJdTMyIHJldDsNCj4+ICsNCj4+ICsJ
d2hpbGUgKCFrdGltZV9hZnRlcihrdGltZV9nZXQoKSwgbmV4dF9kZWFkbGluZSkpIHsNCj4+ICsJ
CS8qDQo+PiArCQkgKiBBcyBwZXIgQUNQSSBzcGVjLCB0aGUgUENDIHNwYWNlIHdpbGwgYmUgaW5p
dGlhbGl6ZWQgYnkNCj4+ICsJCSAqIHBsYXRmb3JtIGFuZCBzaG91bGQgaGF2ZSBzZXQgdGhlIGNv
bW1hbmQgY29tcGxldGlvbiBiaXQNCj53aGVuDQo+PiArCQkgKiBQQ0MgY2FuIGJlIHVzZWQgYnkg
T1NQTQ0KPj4gKwkJICovDQo+PiArCQlzdGF0dXMgPSByZWFkd19yZWxheGVkKCZnZW5lcmljX2Nv
bW1fYmFzZS0+c3RhdHVzKTsNCj4+ICsJCWlmIChzdGF0dXMgJiBSQVMyX1BDQ19DTURfRVJST1Ip
IHsNCj4+ICsJCQljYXBfc3RhdHVzID0gcmVhZHdfcmVsYXhlZCgmZ2VuZXJpY19jb21tX2Jhc2Ut
DQo+PnNldF9jYXBhYmlsaXRpZXNfc3RhdHVzKTsNCj4+ICsJCQlyZXQgPSByYXMyX3JlcG9ydF9j
YXBfZXJyb3IoY2FwX3N0YXR1cyk7DQo+DQo+VGhlcmUgaXMgc29tZSBuZXcgaW5mb3JtYXRpb246
DQo+DQo+VGhlIFNjcnViIHBhcmFtZXRlciBibG9jayBpbnRlbmRzIHRvIGdldCBpdHMgb3duIFN0
YXR1cyBmaWVsZCwgYW5kIHRoZQ0KPnNldF9jYXBhYmlsaXRpZXNfc3RhdHVzIGZpZWxkIGlzIGJl
aW5nIGRlcHJlY2F0ZWQuIFRoaXMgYWxzbyBjYXVzZXMgYSByZXZpc2lvbg0KPmJ1bXAgaW4gdGhl
IHNwZWMuDQo+DQo+U2VlIFsxXQ0KPg0KPkFzc3VtaW5nIHRoaXMgY2hhbmdlIGlzIHJhdGlmaWVk
IChub3QgZ3VhcmFudGVlZCwgc3RpbGwgcGVuZGluZyk6DQo+VGhpcyBjaGFuZ2UgaW1wbGllcyB0
aGF0IHdlIGNhbm5vdCBjZW50cmFsbHkgZGVjb2RlIGVycm9ycywgYXMgaXMgZG9uZSBoZXJlIGFu
ZA0KPm5vdy4gSW5zdGVhZCBlcnJvciBkZWNvZGluZyBtdXN0IGJlIGRvbmUgYWZ0ZXIgc29tZSBm
ZWF0dXJlLXNwZWNpZmljIHJvdXRpbmUNCj5jYWxscyByYXMyX3NlbmRfcGNjX2NtZC4gSXQgc2hv
dWxkIGJlIHRoZSBjYXNlIHRoYXQgZWFjaCBuZXcgZmVhdHVyZSwgbW92aW5nDQo+Zm9yd2FyZCwg
d2lsbCBsaWtlbHkgaGF2ZSB0aGVpciBvd24gc3RhdHVzLg0KPg0KPlBsZWFzZSBzZWUgbXkgZm9s
bG93IHVwIGNvbW1lbnQgb24gW1BBVENIIHYxOCAwNi8xOV0NCj4NCj4tLS0NCj5bMV0gaHR0cHM6
Ly9naXRodWIuY29tL3RpYW5vY29yZS9lZGsyL2lzc3Vlcy8xMDU0MA0KDQpIaSBEYW5pZWwsDQoN
ClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uIGFuZCBzdWdnZXN0ZWQgbW9kaWZpY2F0aW9ucy4N
Cg0KV2Ugd2lsbCB0cmFjayB0aGUgY2hhbmdlIGFuZCBhc3N1bWluZyBpdCBsYW5kcyBhcyBhbiBF
Q04NCndpbGwgdHJ5IHRvIGFkZCBzdXBwb3J0IGluIGJhY2t3YXJkcyBjb21wYXRpYmxlIGZhc2hp
b24uDQoNCj4tLS0NCj4NCj4+ICsNClsuLi5dDQo+DQpUaGFua3MsDQpTaGlqdQ0K

