Return-Path: <linux-edac+bounces-5683-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD1UJgU8emlB4wEAu9opvQ
	(envelope-from <linux-edac+bounces-5683-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jan 2026 17:40:37 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35FA5FB1
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jan 2026 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ECEA3003802
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jan 2026 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85689313E20;
	Wed, 28 Jan 2026 16:40:34 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801E318B91;
	Wed, 28 Jan 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618434; cv=none; b=QJpQGKH5I6SXKpJYF45ZJRK2uTGupwYmhZV0EaL6x5qOfh8E20v/+ZgXG3Ufo3D8aDk38NOfyuLr5amnn/ybdZk72A17o3eZH49YZxk99PPfCPE/Ivoh643/S+j2ziyK4NdYPGoZYGDSAlvG/rcoFL6L3PB13n/x6C/99p23fW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618434; c=relaxed/simple;
	bh=KN0RWmM/E0PJw5+tacIVqLz8j2grF2gZqhBSbSiV+TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6mjnwNoPMkfN7dX/pu5a/aa+fdx/XvsKzoSuuV9ZDdEORcwe+c4VPhWESNv1vsSBDlB6Mibe5mA9OoNzNEHLZeCyHyMymBnqm8EJpMb4ox2ayYxAdtGh39rP1+crRfec/doSbsMSIPt1Z3xEkZ8GYx6OHiUJfYb276/af22N3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f1Sft4CpNzJ46ZP;
	Thu, 29 Jan 2026 00:39:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6628540086;
	Thu, 29 Jan 2026 00:40:28 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Jan 2026 16:40:27 +0000
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Wed, 28 Jan 2026 16:40:27 +0000
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
Subject: RE: [PATCH v16 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Thread-Topic: [PATCH v16 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Thread-Index: AQHcjJF8dezXiKYfZEmczjDGAWEGLrVktbUAgAMVYQA=
Date: Wed, 28 Jan 2026 16:40:27 +0000
Message-ID: <863e6f6f7d15466397948ce8e920a04c@huawei.com>
References: <20260123175512.2066-1-shiju.jose@huawei.com>
 <20260123175512.2066-2-shiju.jose@huawei.com>
 <20260126171552.GJaXehSJp33nFnpvVd@fat_crate.local>
In-Reply-To: <20260126171552.GJaXehSJp33nFnpvVd@fat_crate.local>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,amperecomputing.com,vger.kernel.org,kvack.org,intel.com,amd.com,huawei.com,google.com,linux.intel.com,nec.com,arm.com,hpe.com,os.amperecomputing.com,gmail.com,hisilicon.com,futurewei.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5683-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shiju.jose@huawei.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF35FA5FB1
X-Rspamd-Action: no action

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj5TZW50OiAyNiBKYW51YXJ5IDIwMjYgMTc6MTYNCj5UbzogU2hpanUgSm9z
ZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiByYWZhZWxAa2VybmVsLm9yZzsgYWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZzsgcnBwdEBrZXJuZWwub3JnOw0KPmRmZXJndXNvbkBhbXBlcmVj
b21wdXRpbmcuY29tOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVs
Lm9yZzsNCj50b255Lmx1Y2tAaW50ZWwuY29tOyBsZW5iQGtlcm5lbC5vcmc7IGxlby5kdXJhbkBh
bWQuY29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOyBKb25h
dGhhbiBDYW1lcm9uDQo+PGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IExpbnV4YXJtIDxs
aW51eGFybUBodWF3ZWkuY29tPjsNCj5yaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBnb29n
bGUuY29tOyBKb24uR3JpbW1AYW1kLmNvbTsNCj5kYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207
IG5hb3lhLmhvcmlndWNoaUBuZWMuY29tOw0KPmphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0
b25AZ29vZ2xlLmNvbTsgc29tYXN1bmRhcmFtLmFAaHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2ds
ZS5jb207IHBnb25kYUBnb29nbGUuY29tOyBkdWVud2VuQGdvb2dsZS5jb207DQo+Z3RoZWxlbkBn
b29nbGUuY29tOyB3c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJl
Y29tcHV0aW5nLmNvbTsgbmlmYW4uY3hsQGdtYWlsLmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFv
ZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsg
Um9iZXJ0bw0KPlNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+OyBrYW5na2FuZy5zaGVu
QGZ1dHVyZXdlaS5jb207DQo+d2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT4N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHYxNiAxLzJdIEFDUEk6UkFTMjogQWRkIGRyaXZlciBmb3Ig
dGhlIEFDUEkgUkFTMiBmZWF0dXJlDQo+dGFibGUNCj4NCj5PbiBGcmksIEphbiAyMywgMjAyNiBh
dCAwNTo1NTowN1BNICswMDAwLCBzaGlqdS5qb3NlQGh1YXdlaS5jb20gd3JvdGU6DQo+PiArc3Rh
dGljIGludCBwYXJzZV9yYXMyX3RhYmxlKHN0cnVjdCBhY3BpX3RhYmxlX3JhczIgKnJhczJfdGFi
KSB7DQo+PiArCXN0cnVjdCBhY3BpX3JhczJfcGNjX2Rlc2MgKnBjY19kZXNjX2xpc3Q7DQo+PiAr
CXN0cnVjdCByYXMyX21lbV9jdHggKipwY3R4X2xpc3Q7DQo+PiArCXN0cnVjdCByYXMyX21lbV9j
dHggKnJhczJfY3R4Ow0KPj4gKwl1MTYgaTsNCj4+ICsNCj4+ICsJaWYgKHJhczJfdGFiLT5oZWFk
ZXIubGVuZ3RoIDwgc2l6ZW9mKCpyYXMyX3RhYikpIHsNCj4+ICsJCXByX3dhcm4oRldfV0FSTiAi
QUNQSSBSQVMyIHRhYmxlIHByZXNlbnQgYnV0IGJyb2tlbiAodG9vDQo+c2hvcnQsIHNpemU9JXUp
XG4iLA0KPj4gKwkJCXJhczJfdGFiLT5oZWFkZXIubGVuZ3RoKTsNCj4+ICsJCXJldHVybiAtRUlO
VkFMOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmICghcmFzMl90YWItPm51bV9wY2NfZGVzY3MgfHwg
cmFzMl90YWItPm51bV9wY2NfZGVzY3MgPg0KPlJBUzJfTUFYX05VTV9QQ0NfREVTQ1MpIHsNCj4+
ICsJCXByX3dhcm4oRldfV0FSTiAiTm8vSW52YWxpZCBudW1iZXIgb2YgUENDIGRlc2NzKCVkKSBp
bg0KPkFDUEkgUkFTMiB0YWJsZVxuIiwNCj4+ICsJCQlyYXMyX3RhYi0+bnVtX3BjY19kZXNjcyk7
DQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlwY3R4X2xpc3QgPSBr
Y2FsbG9jKHJhczJfdGFiLT5udW1fcGNjX2Rlc2NzLCBzaXplb2YoKnBjdHhfbGlzdCksDQo+R0ZQ
X0tFUk5FTCk7DQo+PiArCWlmICghcGN0eF9saXN0KQ0KPj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+
PiArDQo+PiArCXBjY19kZXNjX2xpc3QgPSAoc3RydWN0IGFjcGlfcmFzMl9wY2NfZGVzYyAqKShy
YXMyX3RhYiArIDEpOw0KPj4gKwlmb3IgKGkgPSAwOyBpIDwgcmFzMl90YWItPm51bV9wY2NfZGVz
Y3M7IGkrKywgcGNjX2Rlc2NfbGlzdCsrKSB7DQo+PiArCQlpZiAocGNjX2Rlc2NfbGlzdC0+ZmVh
dHVyZV90eXBlICE9IFJBUzJfRkVBVF9UWVBFX01FTU9SWSkNCj4+ICsJCQljb250aW51ZTsNCj4+
ICsNCj4+ICsJCXJhczJfY3R4ID0gYWRkX2F1eF9kZXZpY2UoUkFTMl9NRU1fREVWX0lEX05BTUUs
DQo+cGNjX2Rlc2NfbGlzdC0+Y2hhbm5lbF9pZCwNCj4+ICsJCQkJCSAgcGNjX2Rlc2NfbGlzdC0+
aW5zdGFuY2UpOw0KPj4gKwkJaWYgKElTX0VSUihyYXMyX2N0eCkpIHsNCj4+ICsJCQlwcl93YXJu
KCJGYWlsZWQgdG8gYWRkIFJBUzIgYXV4aWxpYXJ5IGRldmljZSByYz0lbGRcbiIsDQo+UFRSX0VS
UihyYXMyX2N0eCkpOw0KPj4gKwkJCWZvciAoOyBpID4gMDsgaS0tKSB7DQo+PiArCQkJCWlmIChw
Y3R4X2xpc3RbaSAtIDFdKQ0KPj4gKwkJCQkJYXV4aWxpYXJ5X2RldmljZV91bmluaXQoJnBjdHhf
bGlzdFtpIC0gMV0tDQo+PmFkZXYpOw0KPg0KPlRoaXMgaXMgd3JvbmcgLSB0aGVyZSBzaG91bGQg
YmUgYSBmdW5jdGlvbiBjYWxsZWQgcmVtb3ZlX2F1eF9kZXZpY2UoKSB3aGljaA0KPnVud2luZHMg
ZXZlcnl0aGluZyBhZGRfYXV4X2RldmljZSgpIGRvZXMgZm9yIGFsbCB0aG9zZSBkZXZpY2VzLg0K
DQpIaSBCb3Jpc2xhdiwNCg0KVGhhbmtzIGZvciBjb21tZW50cyBhbmQgY2hhbmdlcy4NCg0KSSBh
ZGRlZCByZW1vdmVfYXV4X2RldmljZSgpICBhcyBiZWxvdywgd2hpY2ggd291bGQgY2FsbCByYXMy
X3JlbGVhc2UoKSBhbmQgZnJlZQ0KYWRkX2F1eF9kZXZpY2UoKSBkb2VzIGZvciB0aGF0IGF1eGls
aWFyeSBkZXZpY2UuIEhvcGUgaXQgaXMgYWNjZXB0YWJsZT8NCg0KK3N0YXRpYyB2b2lkIHJlbW92
ZV9hdXhfZGV2aWNlKHN0cnVjdCByYXMyX21lbV9jdHggKnJhczJfY3R4KSB7DQorICAgIGlmICgh
cmFzMl9jdHgpDQorICAgICAgICByZXR1cm47DQorDQorICAgIGF1eGlsaWFyeV9kZXZpY2VfZGVs
ZXRlKCZyYXMyX2N0eC0+YWRldik7DQorICAgIGF1eGlsaWFyeV9kZXZpY2VfdW5pbml0KCZyYXMy
X2N0eC0+YWRldik7DQorfQ0KKw0KPg0KPkluIGFkZGl0aW9uLCBJIGRpZCBhIGJ1bmNoIG9mIGNs
ZWFudXBzIG9udG9wLCBzZWUgYmVsb3cuIEkgY2FuJ3QgdGVzdCB0aGVtIHNvIHBscw0KPmhhdmUg
YSBsb29rIGFuZCBydW4gdGhlbSBvbiB5b3VyIGh3IGFuZCBpZiBhbGwgZ29vZCwgbWVyZ2UgdGhl
bSB3aXRoIHlvdXINCj5wYXRjaC4NCg0KSSB0ZXN0ZWQgeW91ciBjaGFuZ2VzIGFuZCBtZXJnZWQu
DQpJIGdvdCBhIGNoZWNrcGF0Y2ggd2FybmluZyBmb3IgYmVsb3cgY2hhbmdlLg0KDQpUaGFua3Ms
DQpTaGlqdQ0KDQo+DQo+VGh4Lg0KPg0KPi0tLQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL2Fj
cGkvS2NvbmZpZyBiL2RyaXZlcnMvYWNwaS9LY29uZmlnIGluZGV4DQo+N2Y4NDZjMjJmYzMwLi4w
MDEwYjM4ZThmODEgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9hY3BpL0tjb25maWcNCj4rKysgYi9k
cml2ZXJzL2FjcGkvS2NvbmZpZw0KPkBAIC0yOTksOSArMjk5LDEwIEBAIGNvbmZpZyBBQ1BJX1JB
UzINCj4gCWRlcGVuZHMgb24gTUFJTEJPWA0KPiAJZGVwZW5kcyBvbiBQQ0MNCj5AQCAtMTg3LDIy
ICsxOTcsMjQgQEAgaW50IHJhczJfc2VuZF9wY2NfY21kKHN0cnVjdCByYXMyX21lbV9jdHgNCj4q
cmFzMl9jdHgsIHUxNiBjbWQpDQo+DQo+IAkvKiBSaW5nIGRvb3JiZWxsICovDQo+IAlyYyA9IG1i
b3hfc2VuZF9tZXNzYWdlKHBjY19jaGFubmVsLCAmY21kKTsNCj4rDQo+IAkvKg0KPi0JICogbWJv
eF9zZW5kX21lc3NhZ2UoKSByZXR1cm4gbm9uLW5lZ2F0aXZlIGludGVnZXIgZm9yIHN1Y2Nlc3Nm
dWwNCj5zdWJtaXNzaW9uDQo+LQkgKiBhbmQgbmVnYXRpdmUgdmFsdWUgb24gZmFpbHVyZS4NCj4r
CSAqIG1ib3hfc2VuZF9tZXNzYWdlKCkgcmV0dXJucyBhIG5vbi1uZWdhdGl2ZSBpbnRlZ2VyIGZv
ciBzdWNjZXNzZnVsDQo+c3VibWlzc2lvbg0KPisJICogYW5kIGEgbmVnYXRpdmUgdmFsdWUgb24g
ZmFpbHVyZS4NCj4gCSAqLw0KPi0JcmMgPSByYyA8IDAgPyByYyA6IDA7DQo+IAlpZiAocmMgPCAw
KSB7DQo+IAkJZGV2X3dhcm4ocmFzMl9jdHgtPmRldiwNCj4gCQkJICJFcnJvciBzZW5kaW5nIFBD
QyBtYm94IG1lc3NhZ2UgY29tbWFuZDogMHgleCwNCj5yYzolZFxuIiwgY21kLCByYyk7DQo+IAkJ
cmV0dXJuIHJjOw0KPisJfSBlbHNlIHsNCj4rCQlyYyA9IDA7DQo+IAl9DQo+DQpDaGVja3BhdGNo
IHdhcm5pbmc6DQoNCldBUk5JTkc6IGVsc2UgaXMgbm90IGdlbmVyYWxseSB1c2VmdWwgYWZ0ZXIg
YSBicmVhayBvciByZXR1cm4NCiMyMDc6IEZJTEU6IGRyaXZlcnMvYWNwaS9yYXMyLmM6MjA3Og0K
KyAgICAgICAgcmV0dXJuIHJjOw0KKyAgICB9IGVsc2Ugew0KDQphbmQgbm8gd2FybmluZyB3aXRo
IGFzIGJlbG93LA0KDQoraWYgKHJjID49IDApIHsNCisJcmMgPSAwOw0KK30gZWxzZSB7DQorCWRl
dl93YXJuKHJhczJfY3R4LT5kZXYsDQorCQkgICAgICJFcnJvciBzZW5kaW5nIFBDQyBtYm94IG1l
c3NhZ2UgY29tbWFuZDogMHgleCwgcmM6JWRcbiIsIGNtZCwgcmMpOw0KKwlyZXR1cm4gcmM7DQor
fQ0KDQo=

