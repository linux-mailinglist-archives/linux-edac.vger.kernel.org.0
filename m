Return-Path: <linux-edac+bounces-5518-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DBC7FCA5
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 11:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED473A21F6
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B726B77B;
	Mon, 24 Nov 2025 10:00:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084A26B742;
	Mon, 24 Nov 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763978418; cv=none; b=tmcIaaTnylosKdEbrUF4lJqeb/GlKD8bZPa1k/Hfrje0GDkqbTFsZSsJBsH1qRdwILdDQACQIyJHrJDcRryZhBywNpAcJNYhZ5EUt1016Zw022tIAlDqXyck9cEIgHm9+KpDc0gYzJpd21HHEeXw6yNzjKKzav16CGY4+XBaXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763978418; c=relaxed/simple;
	bh=bwk8PA2yKVbF2g//UG4+ZcDnvf9i2Q2+xtDKUf5v46M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNN/EbLOLpKdQ/v43Lazk5dFLauNN0Nrt+/MUDIkZSJGujkZMK3mU3kaJ35sEbbnlDVktGDMJWV8c/ZSfSRJ0MOQxxCLg8fUmrfsm94a4AhLqcdVuuG8q/OIToQioWMsSvy8hWMrX+dw+qHP5gcLKfJ/cQZ7Iv9s3HFD+39ZgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dFLrl6KdFzJ46dd;
	Mon, 24 Nov 2025 17:59:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A89871400D3;
	Mon, 24 Nov 2025 18:00:11 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (7.214.145.227) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 10:00:11 +0000
Received: from dubpeml100008.china.huawei.com ([7.214.145.227]) by
 dubpeml100008.china.huawei.com ([7.214.145.227]) with mapi id 15.02.1544.036;
 Mon, 24 Nov 2025 10:00:11 +0000
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
Thread-Index: AQHcWxSpDw4Z/LYIh0qhRo3faUcQr7T+KfGAgANpz1A=
Date: Mon, 24 Nov 2025 10:00:11 +0000
Message-ID: <78ee1bf7cfe34909bf09b429e81e63a7@huawei.com>
References: <20251121182825.237-1-shiju.jose@huawei.com>
 <20251121182825.237-3-shiju.jose@huawei.com>
 <26083ba9-1979-4d14-8465-3f54f2f96d23@infradead.org>
In-Reply-To: <26083ba9-1979-4d14-8465-3f54f2f96d23@infradead.org>
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPlNlbnQ6IDIyIE5vdmVtYmVyIDIwMjUgMDU6MjMNCj5Ubzog
U2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPjsgcmFmYWVsQGtlcm5lbC5vcmc7IGJw
QGFsaWVuOC5kZTsNCj5ha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBycHB0QGtlcm5lbC5vcmc7
DQo+ZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC0NCj5hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBs
aW51eC1kb2NAdmdlci5rZXJuZWwub3JnOw0KPnRvbnkubHVja0BpbnRlbC5jb207IGxlbmJAa2Vy
bmVsLm9yZzsgbGVvLmR1cmFuQGFtZC5jb207DQo+WWF6ZW4uR2hhbm5hbUBhbWQuY29tOyBtY2hl
aGFiQGtlcm5lbC5vcmcNCj5DYzogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBo
dWF3ZWkuY29tPjsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2VpLmNvbT47IHJpZW50amVzQGdv
b2dsZS5jb207IGppYXFpeWFuQGdvb2dsZS5jb207DQo+Sm9uLkdyaW1tQGFtZC5jb207IGRhdmUu
aGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsgamFtZXMu
bW9yc2VAYXJtLmNvbTsganRob3VnaHRvbkBnb29nbGUuY29tOw0KPnNvbWFzdW5kYXJhbS5hQGhw
ZS5jb207IGVyZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207DQo+ZHVlbndl
bkBnb29nbGUuY29tOyBndGhlbGVuQGdvb2dsZS5jb207DQo+d3NjaHdhcnR6QGFtcGVyZWNvbXB1
dGluZy5jb207IHdic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPm5pZmFuLmN4bEBnbWFpbC5j
b207IHRhbnhpYW9mZWkgPHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpDQo+PHBy
aW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVh
d2VpLmNvbT47DQo+a2FuZ2thbmcuc2hlbkBmdXR1cmV3ZWkuY29tOyB3YW5naHVpcWlhbmcgPHdh
bmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEzIDIvMl0gcmFz
OiBtZW06IEFkZCBBQ1BJIFJBUzIgbWVtb3J5IGRyaXZlcg0KPg0KPg0KPg0KPk9uIDExLzIxLzI1
IDEwOjI4IEFNLCBzaGlqdS5qb3NlQGh1YXdlaS5jb20gd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9lZGFjL3NjcnViLnJzdA0KPj4gYi9Eb2N1bWVudGF0aW9uL2VkYWMvc2Ny
dWIucnN0IGluZGV4IDJjZmE3NGZhMWZmZC4uNzM3YTEwZGEyMjRmIDEwMDY0NA0KPj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9lZGFjL3NjcnViLnJzdA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9lZGFj
L3NjcnViLnJzdA0KPj4gQEAgLTM0MCwzICszNDAsNjEgQEAgY29udHJvbGxlciBvciBwbGF0Zm9y
bSB3aGVuIHVuZXhwZWN0ZWRseSBoaWdoIGVycm9yDQo+cmF0ZXMgYXJlIGRldGVjdGVkLg0KPj4N
Cj4+ICBTeXNmcyBmaWxlcyBmb3Igc2NydWJiaW5nIGFyZSBkb2N1bWVudGVkIGluDQo+PiBgRG9j
dW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1lZGFjLWVjc2ANCj4+ICsNCj4+ICszLiBBQ1BJ
IFJBUzIgSGFyZHdhcmUtYmFzZWQgTWVtb3J5IFNjcnViYmluZw0KPj4gKw0KPj4gKzMuMS4gT24g
ZGVtYW5kIHNjcnViYmluZyBmb3IgYSBzcGVjaWZpYyBtZW1vcnkgcmVnaW9uLg0KPj4gKw0KPj4g
KzMuMS4xLiBRdWVyeSB0aGUgc3RhdHVzIG9mIGRlbWFuZCBzY3J1YmJpbmcNCj4+ICsNCj4+ICsj
IGNhdCAvc3lzL2J1cy9lZGFjL2RldmljZXMvYWNwaV9yYXNfbWVtMC9zY3J1YjAvZW5hYmxlX2Rl
bWFuZA0KPj4gKw0KPj4gKzANCj4+ICsNCj4+ICszLjEuMi4gUXVlcnkgd2hhdCBpcyBkZXZpY2Ug
ZGVmYXVsdC9jdXJyZW50IHNjcnViIGN5Y2xlIHNldHRpbmcuDQo+PiArDQo+PiArQXBwbGljYWJs
ZSB0byBib3RoIGRlbWFuZCBhbmQgYmFja2dyb3VuZCBzY3J1YmJpbmcuDQo+PiArDQo+PiArIyBj
YXQNCj4+ICsvc3lzL2J1cy9lZGFjL2RldmljZXMvYWNwaV9yYXNfbWVtMC9zY3J1YjAvY3VycmVu
dF9jeWNsZV9kdXJhdGlvbg0KPj4gKw0KPj4gKzM2MDAwDQo+PiArDQo+DQo+V2hhdCB1bml0cyAo
YWJvdmUpPw0KSW4gc2Vjb25kcy4NCg0KPg0KPj4gKzMuMS4zLiBRdWVyeSB0aGUgcmFuZ2Ugb2Yg
ZGV2aWNlIHN1cHBvcnRlZCBzY3J1YiBjeWNsZSBmb3IgYSBtZW1vcnkgcmVnaW9uLg0KPj4gKw0K
Pj4gKyMgY2F0IC9zeXMvYnVzL2VkYWMvZGV2aWNlcy9hY3BpX3Jhc19tZW0wL3NjcnViMC9taW5f
Y3ljbGVfZHVyYXRpb24NCj4+ICsNCj4+ICszNjAwDQo+PiArDQo+PiArIyBjYXQgL3N5cy9idXMv
ZWRhYy9kZXZpY2VzL2FjcGlfcmFzX21lbTAvc2NydWIwL21heF9jeWNsZV9kdXJhdGlvbg0KPj4g
Kw0KPj4gKzg2NDAwDQo+PiArDQo+DQo+ZGl0dG8uDQpVbml0IC0gIFNlY29uZHMuDQo+DQo+PiAr
My4xLjQuIFByb2dyYW0gc2NydWJiaW5nIGZvciB0aGUgbWVtb3J5IHJlZ2lvbiBpbiBSQVMyIGRl
dmljZSB0bw0KPj4gK3JlcGVhdCBldmVyeQ0KPj4gKzQzMjAwIHNlY29uZHMgKGhhbGYgYSBkYXkp
Lg0KPj4gKw0KPj4gKyMgZWNobyA0MzIwMCA+DQo+PiArL3N5cy9idXMvZWRhYy9kZXZpY2VzL2Fj
cGlfcmFzX21lbTAvc2NydWIwL2N1cnJlbnRfY3ljbGVfZHVyYXRpb24NCj4+ICsNCj4+ICszLjEu
NS4gU3RhcnQgJ2RlbWFuZCBzY3J1YmJpbmcnLg0KPj4gKw0KPj4gK1doZW4gYSBkZW1hbmQgc2Ny
dWIgaXMgc3RhcnRlZCwgYW55IGJhY2tncm91bmQgc2NydWIgY3VycmVudGx5IGluDQo+PiArcHJv
Z3Jlc3Mgd2lsbCBiZSBzdG9wcGVkIGFuZCB0aGVuIGF1dG9tYXRpY2FsbHkgcmVzdGFydGVkIG9u
Y2UgdGhlDQo+PiArZGVtYW5kIHNjcnViIGhhcyBjb21wbGV0ZWQuDQo+DQo+V2lsbCBpdCByZXN0
YXJ0IHdoZXJlIGl0IGxlZnQgb2ZmIG9yIGF0IHRoZSBiZWdpbm5pbmc/DQpJbiB0aGlzIGNhc2Us
IHByZXNlbnRseSBrZXJuZWwgc2VuZCAnU1RBUlRfUEFUUk9MX1NDUlVCQkVSICcgY29tbWFuZCAg
dG8gcmVzdGFydA0KdGhlIGJhY2tncm91bmQgc2NydWJiaW5nIGFuZCB0aHVzIHJlc3RhcnRzIGF0
IHRoZSBiZWdpbm5pbmcgdW5sZXNzIEkgdGhpbmsgZmlybXdhcmUNCmhhcyBzb21lIGltcGxlbWVu
dGF0aW9uIHRvIGRldGVjdCB0aGlzIGNhc2UgYW5kICAncmVzdW1lJyBiYWNrZ3JvdW5kIHNjcnVi
YmluZw0Kd2hlcmUgaXQgaGFzIHN0b3BwZWQuIE90aGVyd2lzZSBJIHRoaW5rIFJBUzIgbWF5IGRl
ZmluZSBzb21lIG5ldyBjb21tYW5kcyB0bw0KJ3BhdXNlJyBhbmQgJ3Jlc3VtZScgc2NydWJiaW5n
IGlmIHRoYXQgbWFrZSBzZW5zZSBzbyB0aGF0IGtlcm5lbCBjb3VsZCBzZW5kIHRob3NlDQpjb21t
YW5kcyB0byB0aGUgZmlybXdhcmUgZm9yIHRoaXMgY2FzZS4NCj4NCj4+ICsNCj4+ICsjIGVjaG8g
MSA+IC9zeXMvYnVzL2VkYWMvZGV2aWNlcy9hY3BpX3Jhc19tZW0wL3NjcnViMC9lbmFibGVfZGVt
YW5kDQo+PiArDQo+PiArMy4yLiBCYWNrZ3JvdW5kIHNjcnViYmluZyB0aGUgZW50aXJlIG1lbW9y
eQ0KPj4gKw0KPj4gKzMuMi4xLiBRdWVyeSB0aGUgc3RhdHVzIG9mIGJhY2tncm91bmQgc2NydWJi
aW5nLg0KPj4gKw0KPj4gKyMgY2F0IC9zeXMvYnVzL2VkYWMvZGV2aWNlcy9hY3BpX3Jhc19tZW0w
L3NjcnViMC9lbmFibGVfYmFja2dyb3VuZA0KPj4gKw0KPj4gKzANCj4+ICsNCj4+ICszLjIuMi4g
UHJvZ3JhbSBiYWNrZ3JvdW5kIHNjcnViYmluZyBmb3IgUkFTMiBkZXZpY2UgdG8gcmVwZWF0IGlu
DQo+PiArZXZlcnkgMjE2MDAgc2Vjb25kcyAocXVhcnRlciBvZiBhIGRheSkuDQo+PiArDQo+PiAr
IyBlY2hvIDIxNjAwID4NCj4+ICsvc3lzL2J1cy9lZGFjL2RldmljZXMvYWNwaV9yYXNfbWVtMC9z
Y3J1YjAvY3VycmVudF9jeWNsZV9kdXJhdGlvbg0KPj4gKw0KPj4gKzMuMi4zLiBTdGFydCAnYmFj
a2dyb3VuZCBzY3J1YmJpbmcnLg0KPj4gKw0KPj4gKyMgZWNobyAxID4NCj4+ICsvc3lzL2J1cy9l
ZGFjL2RldmljZXMvYWNwaV9yYXNfbWVtMC9zY3J1YjAvZW5hYmxlX2JhY2tncm91bmQNCj4NCj4t
LQ0KPn5SYW5keQ0KDQpUaGFua3MsDQpTaGlqdQ0KDQo=

