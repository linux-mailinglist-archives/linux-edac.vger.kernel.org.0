Return-Path: <linux-edac+bounces-5113-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E268ABE8ACE
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44FD04F1E48
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315F330319;
	Fri, 17 Oct 2025 12:54:49 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2233032B;
	Fri, 17 Oct 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705689; cv=none; b=PxNgw6dLdRs+xgu0r5/C0VhjdG1bxkOo3wZ9AlU/r91ltzdkEdmqlIkunujKtyu9ti9TJDMXm3prmfcb6Dg1O5XSUzVZ2Wzt1t/Xz73+9x48JR0zphDbSLRhZ4/40jE48zkc/U45MQYFbfkvSVAVwGYmnTrRPsN3/Rpe0towM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705689; c=relaxed/simple;
	bh=U+hS3i9CLjz1yKZlHXDos9dbra49iebTwFEFZpdtAW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UE2U1iprB/mRon0G49Z8zvywNmU4oi6Mk89JODP63+6Ys+uiApcV6dbvyLQk+CPiztz1zNAdswqqBIaqv7YSrwTvs3xJNC/3Jix3WutmuxB0eDBDcqn1Mot4qY6r1pW7EN/3jnSBLD0/+u9BkKkzXcHiv+ggh6sXyxKXToYFGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp4T64dVfz6L58j;
	Fri, 17 Oct 2025 20:51:38 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E316314033C;
	Fri, 17 Oct 2025 20:54:36 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (7.214.145.227) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 13:54:36 +0100
Received: from dubpeml100008.china.huawei.com ([7.214.145.227]) by
 dubpeml100008.china.huawei.com ([7.214.145.227]) with mapi id 15.02.1544.011;
 Fri, 17 Oct 2025 13:54:36 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>, Daniel Ferguson
	<danielf@os.amperecomputing.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>, "erdemaktas@google.com"
	<erdemaktas@google.com>, "pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>, "gthelen@google.com"
	<gthelen@google.com>, "wschwartz@amperecomputing.com"
	<wschwartz@amperecomputing.com>, "wbs@os.amperecomputing.com"
	<wbs@os.amperecomputing.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHcHC9WuMPoKRXbY02Oy+WxUZ/jerSMt+SAgAK0t2CAABfigIAEdNLAgAOLbYCAABR4AIACsFkAgBrSt9CAD6pngIAAFX0Q
Date: Fri, 17 Oct 2025 12:54:36 +0000
Message-ID: <75e9bae2d30748d5b66c288135915cc3@huawei.com>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
 <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
 <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>
 <20251015223242.GBaPAhCuS7YWqu-aH0@fat_crate.local>
In-Reply-To: <20251015223242.GBaPAhCuS7YWqu-aH0@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMTYgT2N0b2JlciAyMDI1IDExOjMxDQo+VG86IFNoaWp1IEpvc2Ug
PHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tPjsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+YWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZzsgcnBwdEBrZXJuZWwub3JnOw0KPmRmZXJndXNvbkBhbXBlcmVjb21wdXRpbmcu
Y29tOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsNCj50
b255Lmx1Y2tAaW50ZWwuY29tOyBsZW5iQGtlcm5lbC5vcmc7IFlhemVuLkdoYW5uYW1AYW1kLmNv
bTsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsN
Cj5yaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBnb29nbGUuY29tOyBKb24uR3JpbW1AYW1k
LmNvbTsNCj5kYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IG5hb3lhLmhvcmlndWNoaUBuZWMu
Y29tOw0KPmphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0b25AZ29vZ2xlLmNvbTsgc29tYXN1
bmRhcmFtLmFAaHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29nbGUu
Y29tOyBkdWVud2VuQGdvb2dsZS5jb207DQo+Z3RoZWxlbkBnb29nbGUuY29tOyB3c2Nod2FydHpA
YW1wZXJlY29tcHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgbmlmYW4u
Y3hsQGdtYWlsLmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5n
dGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0bw0KPlNhc3N1IDxyb2Jl
cnRvLnNhc3N1QGh1YXdlaS5jb20+OyBrYW5na2FuZy5zaGVuQGZ1dHVyZXdlaS5jb207DQo+d2Fu
Z2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENI
IHYxMiAxLzJdIEFDUEk6UkFTMjogQWRkIEFDUEkgUkFTMiBkcml2ZXINCj4NCj5PbiBNb24sIE9j
dCAwNiwgMjAyNSBhdCAxMDozNzozOUFNICswMDAwLCBTaGlqdSBKb3NlIHdyb3RlOg0KPj4gMS5T
Y3J1YiByYXRlDQo+PiAxLjEuIFNjcnViIHJhdGUgaXMgY29tbW9uIGFjcm9zcyB0aGUgTlVNQSBu
b2RlIGRvbWFpbnMuDQo+PiAxLjIuIENvbW1vbiBtaW4gc2NydWIgcmF0ZSBpcyBtYXggb2YgbWlu
IHNjcnViIHJhdGVzIGFjcm9zcyBub2Rlcy4NCj4+IDEuMy4gQ29tbW9uIG1heCBzY3J1YiByYXRl
IGlzIG1pbiBvZiBtYXggc2NydWIgcmF0ZXMgYWNyb3NzIG5vZGVzLg0KPg0KPkFuZCB5b3UgbmVl
ZCBzY3J1YiByYXRlIHRvIGJlIHBlciBub2RlIGJlY2F1c2UuLi4/DQo+DQo+V2h5IGNhbid0IGl0
IGJlIGEgc3lzdGVtLXdpZGUgc2NydWIgcmF0ZT8NCg0KQUNQSSBzcGVjIGRlZmluZWQgUkFTMiBp
bnRlcmZhY2UgZm9yIHNjcnViIGFuZCBzY3J1YiBwYXJhbWV0ZXJzIHBlciBub2RlIC4NClRodXMg
dG8gbWFrZSBjb21wYXRpYmxlIHRvIHRoZSBzcGVjLCAga2VybmVsIGFuZCBmaXJtd2FyZSBpbXBs
ZW1lbnRhdGlvbnMgZm9yDQpSQVMyIHNjcnViYmluZyBhcmUgcGVyIG5vZGUuIA0KRm9yIHRoZSBk
ZXNpZ24gYW5kIHByb3RvdHlwaW5nIHlvdXIgcmVxdWVzdCBmb3IgInN0YXJ0IGEgc2NydWIgb24g
dGhlIHdob2xlIHN5c3RlbSIsIA0Kd2UgYXJlIHRyeWluZyBtYWtlIHN5c2ZzIHNjcnViIGNvbnRy
b2wgc3lzdGVtLXdpZGUgd2hpbGUga2VlcGluZyB1bmRlcmx5aW5nIFJBUzINCnNjcnViYmluZyBw
ZXIgbm9kZS4gVGhlbiB0aGVzZSBvcGVuIHF1ZXN0aW9ucyBhcmlzZSwgc3VjaCBhcyBuZWVkIGZv
ciB0aGUgDQpzeXN0ZW0td2lkZSBjb21tb24gc2NydWIgcmF0ZSBhY3Jvc3MgYWxsIG5vZGVzLCAg
Zm9yIHRoZSBkZW1hbmQgc2NydWJiaW5nIHNob3VsZA0KdGhlIGtlcm5lbCBzZW5kIHNjcnViIHJl
cXVlc3QgdG8gb25seSBvbiB0aGUgY29ycmVzcG9uZGluZyBub2RlIG9yIHRvIGFsbCB0aGUgbm9k
ZXMgZXRjLg0KPg0KPklmIHRoZSB1c2UgY2FzZSBhcHBlYXJzIHdoaWNoIG5lZWRzIHBlci1ub2Rl
IHNjcnViIHJhdGUsIHRoZW4geW91IGRlc2lnbiBpdCB0aGlzDQo+d2F5Lg0KDQpGcm9tIHRoZSBB
Q1BJIHNwZWMgUkFTMiBzY3J1YiBpbnRlcmZhY2UgcGVyc3BlY3RpdmUsICBuZWVkcyBwZXItbm9k
ZSBzY3J1YiByYXRlIGFuZCBvdGhlcg0Kc2NydWIgcGFyYW1ldGVycy4gT25lIG9mIHRoZSB1c2Ug
Y2FzZSBmb3IgZGVtYW5kL2JhY2tncm91bmQgc2NydWJiaW5nIGluIGEgc3BlY2lmaWMgbm9kZQ0K
aW4gd2hpY2ggZnJlcXVlbnQgY29ycmVjdGVkIG1lbW9yeSBlcnJvcnMgcmVwb3J0ZWQgdG8gdGhl
IHVzZXIgc3BhY2UgYW5kIENFIGNvdW50IGV4Y2VlZHMgdGhlDQp0aHJlc2hvbGQuDQoNCk1heSBi
ZSBEYW5pZWwgY2FuIHByb3ZpZGUgbW9yZSBpbnB1dHMgZm9yIHRoaXMgcXVlc3Rpb24gYWJvdXQg
dXNlIGNhc2VzPw0KIA0KSWYgeW91IGFncmVlIHRvIGtlZXAgcGVyLW5vZGUgc2NydWIgcmF0ZSBh
bmQgdGh1cyBwZXItbm9kZSBzY3J1YiBjb250cm9sIGluIHRoZSBzeXNmcywNCnRoZW4gSSB3aWxs
IGNvbnRpbnVlIHRvIHVzZSB0aGUgb3JpZ2luYWwgZGVzaWduIGluIHYxMj8gT3RoZXJ3aXNlIHdp
bGwgdHJ5IHRvIHVzZSB0aGUgbmV3IGRlc2lnbg0Kd2l0aCBjb21tb24gc3lzdGVtLXdpZGUgc2Ny
dWIgY29udHJvbCBpbiB0aGUgc3lzZnMgYW5kIHVuZGVybHlpbmcgUkFTMiBzY3J1YmJpbmcgDQpp
bXBsZW1lbnRhdGlvbiBwZXIgbm9kZS4NCg0KPg0KPk9yIHlvdSBhbHJlYWR5IGhhdmUgYSB2YWxp
ZCB1c2UgY2FzZSBmb3IgaXQgd2hpY2ggZGljdGF0ZXMgdGhpcyBkZXNpZ24/DQo+DQo+PiAxLjQu
IFNjcnViIHJhdGUgYWxsb3dlZCB0byBjaGFuZ2Ugb25seSBpZiBOTyBkZW1hbmQgYW5kIHBhdHJv
bA0KPj4gICAgc2NydWJiaW5nIGlzIGluIHByb2dyZXNzDQo+DQo+UmlnaHQuDQo+DQo+PiAyLiBE
ZW1hbmQgc2NydWJiaW5nIGFuZCBCYWNrZ3JvdW5kIChwYXRyb2wpIHNjcnViYmluZyAyLjEuIEJh
Y2tncm91bmQNCj4+IHNjcnViYmluZyByZXF1ZXN0IGVuYWJsZXMgQkcgc2NydWJiaW5nDQo+PiAg
ICAgIG9uIGFsbCBOVU1BIG5vZGVzLg0KPg0KPlJpZ2h0Lg0KPg0KPj4gMi4yLiBGb3IsIGRlbWFu
ZCBzY3J1YmJpbmcgcmVxdWVzdCAyIG9wdGlvbnMgYXJlIGlkZW50aWZpZWQsDQo+PiAgICAgIHdp
dGggKGIpIHRyaWVkLiBQbGVhc2Ugc3VnZ2VzdCB0aGUgcmlnaHQgYXBwcm9hY2g/DQo+PiBhKSBF
bmFibGUgZGVtYW5kIHNjcnViYmluZyBvbiBhbGwgTlVNQSBub2RlcywgaG9wZSBmb3INCj4+ICAg
ICAgdGhlICdSZXF1ZXN0ZWQgQWRkcmVzcyBSYW5nZShJTlBVVCknIGZpZWxkLCBjYW4gdXNlDQo+
PiAgICAgIGFkZHJlc3Mgc2V0IHRvIHNjcnViIGFuZCBQQUdFX1NJWkUob3Igc2ltaWxhcikgZm9y
IGFsbCB0aGUNCj4+ICAgICAgbm9kZXMuDQo+DQo+V2h5IGRvIHlvdSBuZWVkIGFuIGFkZHJlc3Mg
cmFuZ2U/IFdoeSBub3Qgc3RhcnQgc2NydWJiaW5nIGFuZCBoYXZlIGl0IGJlIGZpcmUtDQo+YW5k
LWZvcmdldD8NClRoaXMgaXMgZm9yIGRlbWFuZCBzY3J1YmJpbmcgZmVhdHVyZS91c2UgY2FzZSB3
aGVyZSBhIHNwZWNpZmljIGFkZHJlc3MgcmFuZ2UgdG8gc2NydWIgYW5kDQpPUyBtdXN0IHNldCB0
aGUgbWFuZGF0b3J5ICBzcGVjIGRlZmluZWQgIFJBUzIgdGFibGUgZmllbGQgJ1JlcXVlc3RlZCBB
ZGRyZXNzIFJhbmdlKElOUFVUKScgDQp3aGlsZSByZXF1ZXN0aW5nIHRoZSBkZW1hbmQgc2NydWJi
aW5nIGluIGEgbm9kZS4gSG9wZSB0aGUgZmlybXdhcmUgY2FuIGlnbm9yZSB0aGUgcmVxdWVzdA0K
aWYgdGhlIHJlcXVlc3RlZCBhZGRyZXNzIHJhbmdlIHRvIHNjcnViIGlzIGlycmVsZXZhbnQgZm9y
IGEgbm9kZSwgYmVjYXVzZSBpbiB0aGlzIGFwcHJvYWNoIHdlIGhhdmUNCmNvbW1vbiBzeXNmcyBz
Y3J1YiBjb250cm9sIGFuZCBrZXJuZWwgaXMgcmVxdWVzdGluZyBkZW1hbmQgc2NydWJiaW5nIHN5
c3RlbS13aWRlIGFjcm9zcw0KYWxsIG5vZGVzLg0KDQpJZiB0aGlzIGFwcHJvYWNoIGlzIG5vdCBj
b3JyZWN0LCBjYW4gd2UgdXNlIChiKSBhcyBiZWxvdz8gcHJvdmlkaW5nIHdlIG5lZWQgdG8gZ2V0
IFBBIHJhbmdlDQpmb3IgdGhlIG5vZGVzIGluIHRoZSBSQVMyIGRyaXZlciAgdXNpbmcgdGhlIGZ1
bmN0aW9ucyAoc3RhcnRfcGZuID0gbm9kZV9zdGFydF9wZm4obmlkKSBhbmQgDQpzaXplX3BmbiA9
IG5vZGVfc3Bhbm5lZF9wYWdlcyhuaWQpOykgIGFzIGltcGxlbWVudGVkIGluIHYxMiBhbmQgZGlz
Y3Vzc2VkIGVhcmxpZXIgaW4gdGhpcyB0aHJlYWQuDQoNCj4NCj4+IGIpIEVuYWJsZSBkZW1hbmQg
c2NydWJiaW5nIG9uIGEgTlVNQSBub2RlIGZvciB3aGljaA0KPj4gICAgICB0aGUgcmVxdWVzdGVk
IGFkZHJlc3MgdG8gc2NydWIgaXMgd2l0aGluIHRoZSBQQSByYW5nZSBvZg0KPj4gICAgICB0aGF0
IG5vZGUuDQo+Pg0KPj4gMi4zLiBEZW1hbmQgc2NydWJiaW5nIGlzIG5vdCBhbGxvd2VkIHdoZW4g
YmFja2dyb3VuZCBzY3J1YmJpbmcNCj4+ICAgICAgaXMgaW4gcHJvZ3Jlc3MuDQo+Pg0KPj4gMi40
LiBJZiAyLjIuIChiKSBpcyBjaG9zZW4sIHNob3VsZCBrZXJuZWwgYWxsb3cgQkcNCj4+ICAgICAg
IHNjcnViYmluZyBvbiByZXN0IG9mIHRoZSBub2Rlcywgd2hlbiBkZW1hbmQgc2NydWJiaW5nIG9u
DQo+PiAgICAgICBzb21lIG5vZGUvcyBpcyBpbiBwcm9ncmVzcz8NCj4NCj5JdCBzZWVtcyBsaWtl
IGFsbCBzY3J1YmJpbmcgc2hvdWxkIGJlIG11dHVhbGx5LWV4Y2x1c2l2ZS4uLiBvciBpcyB0aGVy
ZSBhIHBvaW50IGluDQo+c2NydWJiaW5nIGluIHBhcmFsbGVsLi4uPw0KDQpTdXJlLiBUaGVuIGJh
Y2tncm91bmQgc2NydWJiaW5nIHdpbGwgbm90IGJlIGFsbG93ZWQgaWYgZGVtYW5kIHNjcnViYmlu
ZyBpcyBpbiBwcm9ncmVzcw0KaW4gYSBub2RlLCBpZiB0aGUgc3lzdGVtLXdpZGUgc2NydWIgY29u
dHJvbCBpbiBzeXNmcyBpcyBjaG9zZW4uIA0KPg0KPj4gMi41IFRoZSBzdGF0dXMgb2YgdGhlIEJH
IHNjcnViYmluZyBleHBvc2VkIHRvIHRoZSB1c2VyIHNwYWNlDQo+PiAgICAgaW4gJ2VuYWJsZV9i
YWNrZ3JvdW5kJyBzeXNmcyBhdHRyaWJ1dGUuDQo+Pg0KPj4gMi42IFRoZSBzdGF0dXMgb2YgdGhl
IGRlbWFuZCBzY3J1YmJpbmcgZXhwb3NlZCB0byB0aGUNCj4+ICAgICAgICB1c2VyIHNwYWNlIGlu
ICdhZGRyJyBzeXNmcyBhdHRyaWJ1dGUuIEhvd2V2ZXIgd2hlbiB0aGUNCj4+ICAgICAgICBkZW1h
bmQgc2NydWJiaW5nIGlzIG9uIG11bHRpcGxlL2FsbCBub2RlcyBhcmUgaW4gcHJvZ3Jlc3MsDQo+
PiAgICAgICAgd2hpY2ggZGVtYW5kIHNjcnViYmluZyBzdGF0dXMgYW5kIGFkZHJlc3MgaW4gJ2Fk
ZHInIHN5c2ZzIGF0dHJpYnV0ZQ0KPj4gICAgICAgIGFzIHN0YXR1cyBzaG91bGQgYmUgZXhwb3Nl
ZCB0byB0aGUgdXNlciBzcGFjZT8NCj4+IGEpIE1heSBiZSB0aGUgc3RhdHVzIG9mIHRoZSBmaXJz
dCBkZXRlY3RlZCBub2RlIHdpdGggZGVtYW5kIHNjcnViYmluZw0KPj4gICAgICBpcyBpbiBwcm9n
cmVzcz8NCj4+IGIpIERvZXMgbm90IHNob3cgdGhlIHN0YXR1cyBhdCBhbGwsIGp1c3QgZmFpbCB0
aGUgcmVxdWVzdCBpZiB0aGUNCj4+ICAgICBkZW1hbmQgc2NydWJiaW5nIGlzIGFscmVhZHkgaW4g
cHJvZ3Jlc3Mgb24gYSBub2RlL2FsbCBub2Rlcz8NCj4+IGMpICBBbnkgb3RoZXIgc3VnZ2VzdGlv
bj8NCj4NCj5GaXJzdCB3ZSBuZWVkIGEgcHJvcGVyIGdyYW51bGFyaXR5IGRlZmluZWQgYW5kIHRo
ZW4gZXZlcnl0aGluZyB3aWxsIHJldm9sdmUNCj5hcm91bmQgaXQ6IHNob3VsZCBpdCBiZSBzeXN0
ZW0td2lkZSwgcGVyLW5vZGUsIGRvZXMgaXQgbmVlZCB0byBoYXZlIGFuIGFkZHJlc3MNCj5yYW5n
ZSBvciBjYW4gaXQgYmUgc3RhcnRlZCBhbmQgbm8gbmVlZCBmb3IgYW55IGZ1cnRoZXIgdXNlciBp
bnRlcmFjdGlvbiBhbmQgc28gb24NCj5hbmQgc28gb24uLi4NClN1cmUuDQo+DQoNClRoYW5rcywN
ClNoaWp1DQoNCj4tLQ0KPlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8v
cGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQoNCg==

