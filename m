Return-Path: <linux-edac+bounces-3265-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B30A4EBBC
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 19:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E9F16203B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Mar 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691727D767;
	Tue,  4 Mar 2025 18:20:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C827CB25;
	Tue,  4 Mar 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112404; cv=none; b=I/T+Z4j2KDM+wbxS22lP1ZA9VxXqdFOgdKoKzZESgRhEY6hLbL+ENlI3YMjDO1zITdKSOk56lsbImPZtP131jIOPTb7PwRfEqJ0uFQNzsi/Pju7N63eHbMEXpT5eC5/my4KQpRc3GXpUQYEPzEJ+AzePRuMHh0YKv08uN5sKnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112404; c=relaxed/simple;
	bh=/iUAAOt679TeIoxp6g2heJgXYc2AHhUqUX4EiIEiMWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ex3hKURPWf2ZcxE3xYFuKMfJURouJM30g7rSzR5HjSP6AwVWi/RNtFT6g85ttSSVMm3vRI7GHDp4IkWMP8CoPWpqhOyH6fIJvDmttQqv4yEZI7bGO4EOmgaErd6AFAig7udnjXyXlRe51mXySkg5LTHbyj0G0sb0DEp1qqv2Pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6kRL2lxYz6M4J6;
	Wed,  5 Mar 2025 02:17:02 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C2D61400D7;
	Wed,  5 Mar 2025 02:19:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 19:19:58 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 4 Mar 2025 19:19:58 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Borislav Petkov <bp@alien8.de>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
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
Subject: RE: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Topic: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Thread-Index: AQHbidw989DsJKt5skazfuISb8i7/7NhGsIAgAAQuYCAAh5NIA==
Date: Tue, 4 Mar 2025 18:19:58 +0000
Message-ID: <977a011b1ede4093a8e49d9cbcf49d19@huawei.com>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250303173538.000007cd@huawei.com>
 <20250303103529.GBZ8WF8flezRahE-1h@fat_crate.local>
In-Reply-To: <20250303103529.GBZ8WF8flezRahE-1h@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMDMgTWFyY2ggMjAyNSAxMDozNQ0KPlRvOiBKb25hdGhhbiBDYW1l
cm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+Q2M6IFNoaWp1IEpvc2UgPHNoaWp1
Lmpvc2VAaHVhd2VpLmNvbT47IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5h
Y3BpQHZnZXIua2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5j
b207DQo+bGVuYkBrZXJuZWwub3JnOyBtY2hlaGFiQGtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNr
Lm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtY3hsQHZnZXIua2Vy
bmVsLm9yZzsgai53aWxsaWFtc0BpbnRlbC5jb207DQo+ZGF2ZUBzdGdvbGFicy5uZXQ7IGRhdmUu
amlhbmdAaW50ZWwuY29tOyBhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsNCj52aXNoYWwubC52
ZXJtYUBpbnRlbC5jb207IGlyYS53ZWlueUBpbnRlbC5jb207IGRhdmlkQHJlZGhhdC5jb207DQo+
VmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IGxlby5kdXJhbkBhbWQuY29tOyBZYXplbi5HaGFubmFt
QGFtZC5jb207DQo+cmllbnRqZXNAZ29vZ2xlLmNvbTsgamlhcWl5YW5AZ29vZ2xlLmNvbTsgSm9u
LkdyaW1tQGFtZC5jb207DQo+ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyBuYW95YS5ob3Jp
Z3VjaGlAbmVjLmNvbTsNCj5qYW1lcy5tb3JzZUBhcm0uY29tOyBqdGhvdWdodG9uQGdvb2dsZS5j
b207IHNvbWFzdW5kYXJhbS5hQGhwZS5jb207DQo+ZXJkZW1ha3Rhc0Bnb29nbGUuY29tOyBwZ29u
ZGFAZ29vZ2xlLmNvbTsgZHVlbndlbkBnb29nbGUuY29tOw0KPmd0aGVsZW5AZ29vZ2xlLmNvbTsg
d3NjaHdhcnR6QGFtcGVyZWNvbXB1dGluZy5jb207DQo+ZGZlcmd1c29uQGFtcGVyZWNvbXB1dGlu
Zy5jb207IHdic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOw0KPm5pZmFuLmN4bEBnbWFpbC5jb207
IHRhbnhpYW9mZWkgPHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpDQo+PHByaW1l
LnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2Vp
LmNvbT47DQo+a2FuZ2thbmcuc2hlbkBmdXR1cmV3ZWkuY29tOyB3YW5naHVpcWlhbmcgPHdhbmdo
dWlxaWFuZ0BodWF3ZWkuY29tPjsNCj5MaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj5T
dWJqZWN0OiBSZTogW1BBVENIIGxpbnV4LW5leHQgMC8yXSBBQ1BJOiBBZGQgc3VwcG9ydCBmb3Ig
QUNQSSBSQVMyIGZlYXR1cmUNCj50YWJsZQ0KPg0KWy4uLl0NCj4NCj5Ib3dldmVyLCBqdXN0IGZy
b20gYSBjdXJzb3J5IGxvb2ssIGl0IHdvdWxkIG5lZWQgc29tZSBzY3J1YmJpbmcuIFRoZXJlJ3Mg
c3R1ZmYNCj5saWtlOg0KPg0KPisgICAgICAgICAgICAgICBwc19zbS0+cGFyYW1zLnJlcXVlc3Rl
ZF9hZGRyZXNzX3JhbmdlWzBdID0gMDsNCj4rICAgICAgICAgICAgICAgcHNfc20tPnBhcmFtcy5y
ZXF1ZXN0ZWRfYWRkcmVzc19yYW5nZVsxXSA9IDA7DQo+KyAgICAgICAgICAgICAgIHBzX3NtLT5w
YXJhbXMuc2NydWJfcGFyYW1zX2luICY9DQo+flJBUzJfUEFUUk9MX1NDUlVCX1NDSFJTX0lOX01B
U0s7DQo+KyAgICAgICAgICAgICAgIHBzX3NtLT5wYXJhbXMuc2NydWJfcGFyYW1zX2luIHw9DQo+
RklFTERfUFJFUChSQVMyX1BBVFJPTF9TQ1JVQl9TQ0hSU19JTl9NQVNLLA0KPisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhczJfY3R4
LT5zY3J1Yl9jeWNsZV9ocnMpOw0KPisgICAgICAgICAgICAgICBwc19zbS0+cGFyYW1zLnBhdHJv
bF9zY3J1Yl9jb21tYW5kID0NCj4rIFJBUzJfU1RBUlRfUEFUUk9MX1NDUlVCQkVSOw0KPg0KPg0K
PndoaWNoIGRlZmluaXRlbHkgbmVlZHMgc2hvcnRlbmluZy4gVGhlcmUncyBubyBuZWVkIGZvciBh
IHdob2xseSB3cml0dGVuIG91dA0KPiJyZXF1ZXN0ZWRfYWRkcmVzc19yYW5nZSIuIEkga25vdyB2
YXJpYWJsZXMgc2hvdWxkIGhhdmUgbWVhbmluZ2Z1bGwgbmFtZXMNCj5idXQgd3JpdGluZyBmaWN0
aW9uIHNob3VsZG4ndCBiZSBlaXRoZXIuDQoNCkhpIEJvcmlzbGF2LA0KDQpTb21lIG9mIHRoZXNl
IHZhcmlhYmxlcywgZm9yIGUuZy4gcmVxdWVzdGVkX2FkZHJlc3NfcmFuZ2UgYXJlIG5vdCBkZWZp
bmVkIA0KaW4gdGhpcyBwYXRjaCwgYnV0IGluIHRoZSAnaW5jbHVkZS9hY3BpL2FjdGJsMi5oJy4N
Ck15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aG9zZSBjaGFuZ2VzIHJlcXVpcmVkIHRvIHVwc3Ry
ZWFtIGZpcnN0IHZpYQ0KaHR0cHM6Ly9naXRodWIuY29tL2FjcGljYS9hY3BpY2EgPw0KPg0KPitz
dGF0aWMgaW50IHJhczJfYWNwaV9wYXJzZV90YWJsZShzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIg
KnBBY3BpVGFibGUpDQo+DQo+WXVjaywgQ2FtZWxDYXNlPyENCkZpeGVkLg0KDQo+DQo+QW5kIEkn
bSBwcmV0dHkgc3VyZSBpZiBJIHN0YXJ0IGxvb2tpbmcgbW9yZSwgSSdsbCBmaW5kIG1vcmUgZnVu
a3kgc3R1ZmYuDQpXaWxsIGNoZWNrIGFuZCBmaXguDQo+DQo+SFRILg0KPg0KPi0tDQo+UmVnYXJk
cy9HcnVzcywNCj4gICAgQm9yaXMuDQo+DQo+aHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4
L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg0KVGhhbmtzLA0KU2hpanUNCg==

