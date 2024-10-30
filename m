Return-Path: <linux-edac+bounces-2342-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9109B616F
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 12:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE7A284353
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6A156F54;
	Wed, 30 Oct 2024 11:26:35 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A11E47C3;
	Wed, 30 Oct 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287595; cv=none; b=RA0mdQfU6Rea4/CU7G3vxkJ/Ic+5kWhdH8AtpBESAXRxtIy+B2n6khR9Aatay4ZcybEP+J3nBX7kTy7Fkwl0Nu5u9XXRDRqjhb6EZGLv9LaN/obJnkFnowErkBsU4QspkrPef2UIqv0c3oco6+4rEh3eguTI7WeJQaROj+pxjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287595; c=relaxed/simple;
	bh=PN1knUCRZXE/Uop20QO9Tkxhd9JCAkGT98weRl4zB0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5VCntHemY2eK9OxTYN9BTcIe2GxI0kiRu4AHYqa4dHbr775tg4sHMgnZmEr/lFkpnIdcQN3G0khZtD1fR5p5WjrMgVoIu2OB4h+qLRqOjBtAeSf0yEwJxmPhhscIcTaxHouCyOX+1iGr2hdW8zQ/q1tVFHtaatTFOn2uY873Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdlCr1rRqz6D94H;
	Wed, 30 Oct 2024 19:25:12 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 36760140A35;
	Wed, 30 Oct 2024 19:26:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 12:26:29 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 30 Oct 2024 12:26:24 +0100
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
Thread-Index: AQHbJwFiEsGT6VLXSEWw7XeCpRer7rKeIDaAgAEOqbA=
Date: Wed, 30 Oct 2024 11:26:24 +0000
Message-ID: <e01f73394d7e4f66a15b577ea42c164e@huawei.com>
References: <20241025171356.1377-1-shiju.jose@huawei.com>
 <20241025171356.1377-8-shiju.jose@huawei.com>
 <20241029201653.GBZyFCtVpb3V4CcgKe@fat_crate.local>
In-Reply-To: <20241029201653.GBZyFCtVpb3V4CcgKe@fat_crate.local>
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

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4NCj5TZW50OiAyOSBPY3RvYmVyIDIwMjQgMjA6MTcNCj5UbzogU2hpanUgSm9zZSA8
c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsg
bGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj50b255
Lmx1Y2tAaW50ZWwuY29tOyByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPm1j
aGVoYWJAa2VybmVsLm9yZzsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBkYXZlQHN0Z29sYWJz
Lm5ldDsgSm9uYXRoYW4NCj5DYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj5zdWRlZXAuaG9sbGFAYXJtLmNvbTsgamFzc2lz
aW5naGJyYXJAZ21haWwuY29tOyBkYXZlLmppYW5nQGludGVsLmNvbTsNCj5hbGlzb24uc2Nob2Zp
ZWxkQGludGVsLmNvbTsgdmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBpcmEud2VpbnlAaW50ZWwu
Y29tOw0KPmRhdmlkQHJlZGhhdC5jb207IFZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOyBsZW8uZHVy
YW5AYW1kLmNvbTsNCj5ZYXplbi5HaGFubmFtQGFtZC5jb207IHJpZW50amVzQGdvb2dsZS5jb207
IGppYXFpeWFuQGdvb2dsZS5jb207DQo+Sm9uLkdyaW1tQGFtZC5jb207IGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbTsNCj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsgamFtZXMubW9yc2VAYXJt
LmNvbTsganRob3VnaHRvbkBnb29nbGUuY29tOw0KPnNvbWFzdW5kYXJhbS5hQGhwZS5jb207IGVy
ZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207DQo+ZHVlbndlbkBnb29nbGUu
Y29tOyBndGhlbGVuQGdvb2dsZS5jb207DQo+d3NjaHdhcnR6QGFtcGVyZWNvbXB1dGluZy5jb207
IGRmZXJndXNvbkBhbXBlcmVjb21wdXRpbmcuY29tOw0KPndic0Bvcy5hbXBlcmVjb21wdXRpbmcu
Y29tOyBuaWZhbi5jeGxAZ21haWwuY29tOyB0YW54aWFvZmVpDQo+PHRhbnhpYW9mZWlAaHVhd2Vp
LmNvbT47IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvDQo+
U2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47IGthbmdrYW5nLnNoZW5AZnV0dXJld2Vp
LmNvbTsNCj53YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsgTGludXhhcm0N
Cj48bGludXhhcm1AaHVhd2VpLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxNCAwNy8xNF0g
Y3hsL21lbWZlYXR1cmU6IEFkZCBDWEwgbWVtb3J5IGRldmljZSBwYXRyb2wNCj5zY3J1YiBjb250
cm9sIGZlYXR1cmUNCj4NCj5PbiBGcmksIE9jdCAyNSwgMjAyNCBhdCAwNjoxMzo0OFBNICswMTAw
LCBzaGlqdS5qb3NlQGh1YXdlaS5jb20gd3JvdGU6DQo+PiArOk9yaWdpbmFsIFJldmlld2VyczoN
Cj4+ICsNCj4+ICstIFdyaXR0ZW4gZm9yOiA2LjEzDQo+PiArLSBVcGRhdGVkIGZvcjoNCj4NCj5X
aGF0IGFyZSB0aG9zZSBzdXBwb3NlZCB0byBtZWFuPw0KDQpJIGRlbGV0ZWQuDQo+DQo+LS0NCj5S
ZWdhcmRzL0dydXNzLA0KDQo+ICAgIEJvcmlzLg0KDQpUaGFua3MsDQpTaGlqdQ0K

