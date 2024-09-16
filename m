Return-Path: <linux-edac+bounces-1878-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD61979E58
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC312828AE
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E6614B95F;
	Mon, 16 Sep 2024 09:22:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73A5FB9C;
	Mon, 16 Sep 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478524; cv=none; b=NhZzZsjfvcww+4AFd3hWcc+8UU2Hy5zCQZ6BQXikDxW3boHzad+P/X6yC+Z8afLdut18GGn7bGlCA3uM+75X/GwwNwK+E4j8MmPORhWQwxgBnZbCUuFIvHsMsHq8J1bkDT4QDO6Vs9lDiBkF3IFS+R4lDBQ8C5lYcmoBfrfoo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478524; c=relaxed/simple;
	bh=je9iSwWaYNKrQdRjC4h7SLJ8iNruUF5R1K8hAb0R2YU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMNJd1oEJK/nwpYrrOg1mkR8fIX1WK/k/Pa0iDmZdJw8SASMJIiWMoeFEY0v6auermpFy/SBh/NFM6bYiLZBc25jXTSLwkDXP1fsv9NU99FbmwukbdC9QgoZV0mMHxAIczDRsKjDBkeKlI4rZFt4RRio55JpXe9K/AoxMUuK4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6fT72X2qz6K60p;
	Mon, 16 Sep 2024 17:17:47 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
	by mail.maildlp.com (Postfix) with ESMTPS id 86E60140F1C;
	Mon, 16 Sep 2024 17:21:58 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 11:21:58 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 16 Sep 2024 11:21:58 +0200
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
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
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
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "jgroves@micron.com"
	<jgroves@micron.com>, "vsalve@micron.com" <vsalve@micron.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v12 01/17] EDAC: Add support for EDAC device features
 control
Thread-Topic: [PATCH v12 01/17] EDAC: Add support for EDAC device features
 control
Thread-Index: AQHbBCn2X0FlmKPPaUWpEENlHZJn/rJVzXyAgARPCJA=
Date: Mon, 16 Sep 2024 09:21:58 +0000
Message-ID: <c31c733bb6e742f580721ec9d0e2f3b2@huawei.com>
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-2-shiju.jose@huawei.com>
 <20240913164041.GKZuRrCeoFZBapVYaU@fat_crate.local>
In-Reply-To: <20240913164041.GKZuRrCeoFZBapVYaU@fat_crate.local>
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

VGhhbmtzIGZvciByZXZpZXdpbmcuDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZy
b206IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPlNlbnQ6IDEzIFNlcHRlbWJlciAy
MDI0IDE3OjQxDQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzog
bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPmFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+dG9ueS5sdWNrQGludGVsLmNvbTsgcmFmYWVsQGtlcm5l
bC5vcmc7IGxlbmJAa2VybmVsLm9yZzsNCj5tY2hlaGFiQGtlcm5lbC5vcmc7IGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbTsgZGF2ZUBzdGdvbGFicy5uZXQ7IEpvbmF0aGFuDQo+Q2FtZXJvbiA8am9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207DQo+YWxpc29u
LnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55
QGludGVsLmNvbTsNCj5kYXZpZEByZWRoYXQuY29tOyBWaWxhcy5TcmlkaGFyYW5AYW1kLmNvbTsg
bGVvLmR1cmFuQGFtZC5jb207DQo+WWF6ZW4uR2hhbm5hbUBhbWQuY29tOyByaWVudGplc0Bnb29n
bGUuY29tOyBqaWFxaXlhbkBnb29nbGUuY29tOw0KPkpvbi5HcmltbUBhbWQuY29tOyBkYXZlLmhh
bnNlbkBsaW51eC5pbnRlbC5jb207DQo+bmFveWEuaG9yaWd1Y2hpQG5lYy5jb207IGphbWVzLm1v
cnNlQGFybS5jb207IGp0aG91Z2h0b25AZ29vZ2xlLmNvbTsNCj5zb21hc3VuZGFyYW0uYUBocGUu
Y29tOyBlcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29nbGUuY29tOw0KPmR1ZW53ZW5A
Z29vZ2xlLmNvbTsgbWlrZS5tYWx2ZXN0dXRvQGludGVsLmNvbTsgZ3RoZWxlbkBnb29nbGUuY29t
Ow0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29tOyBkZmVyZ3Vzb25AYW1wZXJlY29tcHV0
aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJlY29tcHV0aW5nLmNvbTsgbmlmYW4uY3hsQGdtYWlsLmNv
bTsgamdyb3Zlc0BtaWNyb24uY29tOw0KPnZzYWx2ZUBtaWNyb24uY29tOyB0YW54aWFvZmVpIDx0
YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKQ0KPjxwcmltZS56ZW5nQGhpc2lsaWNv
bi5jb20+OyBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPmthbmdr
YW5nLnNoZW5AZnV0dXJld2VpLmNvbTsgd2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2Vp
LmNvbT47DQo+TGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MTIgMDEvMTddIEVEQUM6IEFkZCBzdXBwb3J0IGZvciBFREFDIGRldmljZSBmZWF0dXJl
cw0KPmNvbnRyb2wNCj4NCj5PbiBXZWQsIFNlcCAxMSwgMjAyNCBhdCAxMDowNDozMEFNICswMTAw
LCBzaGlqdS5qb3NlQGh1YXdlaS5jb20gd3JvdGU6DQo+PiArLyoqDQo+PiArICogZWRhY19kZXZf
ZmVhdHVyZV9pbml0IC0gSW5pdCBhIFJBUyBmZWF0dXJlDQo+PiArICogQHBhcmVudDogY2xpZW50
IGRldmljZS4NCj4+ICsgKiBAZGV2X2RhdGE6IHBvaW50ZXIgdG8gdGhlIGVkYWNfZGV2X2RhdGEg
c3RydWN0dXJlLCB3aGljaCBjb250YWlucw0KPj4gKyAqIGNsaWVudCBkZXZpY2Ugc3BlY2lmaWMg
aW5mby4NCj4+ICsgKiBAZmVhdDogcG9pbnRlciB0byBzdHJ1Y3QgZWRhY19kZXZfZmVhdHVyZS4N
Cj4+ICsgKiBAYXR0cl9ncm91cHM6IHBvaW50ZXIgdG8gYXR0cmlidXRlIGdyb3VwJ3MgY29udGFp
bmVyLg0KPj4gKyAqDQo+PiArICogUmV0dXJucyBudW1iZXIgb2Ygc2NydWIgZmVhdHVyZXMgYXR0
cmlidXRlIGdyb3VwcyBvbiBzdWNjZXNzLA0KPg0KPk5vdCAic2NydWIiIC0gdGhpcyBpcyBhbiBp
bnRlcmZhY2UgaW5pdGlhbGl6aW5nIGEgZ2VuZXJpYyBmZWF0dXJlLg0KV2lsbCBjb3JyZWN0Lg0K
Pg0KPj4gKyAqIGVycm9yIG90aGVyd2lzZS4NCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW50IGVkYWNf
ZGV2X2ZlYXRfaW5pdChzdHJ1Y3QgZGV2aWNlICpwYXJlbnQsDQo+PiArCQkJICAgICAgc3RydWN0
IGVkYWNfZGV2X2RhdGEgKmRldl9kYXRhLA0KPj4gKwkJCSAgICAgIGNvbnN0IHN0cnVjdCBlZGFj
X2Rldl9mZWF0dXJlICpyYXNfZmVhdCwNCj4+ICsJCQkgICAgICBjb25zdCBzdHJ1Y3QgYXR0cmli
dXRlX2dyb3VwICoqYXR0cl9ncm91cHMpIHsNCj4+ICsJaW50IG51bTsNCj4+ICsNCj4+ICsJc3dp
dGNoIChyYXNfZmVhdC0+ZnRfdHlwZSkgew0KPj4gKwljYXNlIFJBU19GRUFUX1NDUlVCOg0KPj4g
KwkJZGV2X2RhdGEtPnNjcnViX29wcyA9IHJhc19mZWF0LT5zY3J1Yl9vcHM7DQo+PiArCQlkZXZf
ZGF0YS0+cHJpdmF0ZSA9IHJhc19mZWF0LT5jdHg7DQo+PiArCQlyZXR1cm4gMTsNCj4+ICsJY2Fz
ZSBSQVNfRkVBVF9FQ1M6DQo+PiArCQludW0gPSByYXNfZmVhdC0+ZWNzX2luZm8ubnVtX21lZGlh
X2ZydXM7DQo+PiArCQlkZXZfZGF0YS0+ZWNzX29wcyA9IHJhc19mZWF0LT5lY3Nfb3BzOw0KPj4g
KwkJZGV2X2RhdGEtPnByaXZhdGUgPSByYXNfZmVhdC0+Y3R4Ow0KPj4gKwkJcmV0dXJuIG51bTsN
Cj4+ICsJY2FzZSBSQVNfRkVBVF9QUFI6DQo+PiArCQlkZXZfZGF0YS0+cHByX29wcyA9IHJhc19m
ZWF0LT5wcHJfb3BzOw0KPj4gKwkJZGV2X2RhdGEtPnByaXZhdGUgPSByYXNfZmVhdC0+Y3R4Ow0K
Pj4gKwkJcmV0dXJuIDE7DQo+PiArCWRlZmF1bHQ6DQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+
ICsJfQ0KPj4gK30NCj4NCj5BbmQgd2h5IGRvZXMgdGhpcyBmdW5jdGlvbiBldmVuIGV4aXN0IGFu
ZCBoYXMga2VybmVsLWRvYyBjb21tZW50cyB3aGVuIGFsbCBpdA0KPmRvZXMgaXMgYXNzaWduIGEg
Y291cGxlIG9mIHZhbHVlcz8gQW5kIGl0IGdldHMgY2FsbGVkIGV4YWN0bHkgb25jZT8NCj4NCj5K
dXN0IG1lcmdlIGl0cyBib2R5IGludG8gdGhlIGNhbGwgc2l0ZS4gVGhlcmUgeW91IGNhbiByZXVz
ZSB0aGUgc3dpdGNoLWNhc2UgdGhlcmUNCj50b28uIE5vIG5lZWQgZm9yIHRvbyBtdWNoIG5vb2Rs
aW5nIGFyb3VuZC4NCmVkYWNfZGV2X2ZlYXRfaW5pdCAoKSBmdW5jdGlvbiBpcyB1cGRhdGVkIHdp
dGggZmVhdHVyZSBzcGVjaWZpYyBmdW5jdGlvbiBjYWxsKCkgZXRjIGluIHN1YnNlcXVlbnQNCkVE
QUMgZmVhdHVyZSBzcGVjaWZpYyBwYXRjaGVzLiBUaHVzIGFkZGVkIGEgc2VwYXJhdGUgZnVuY3Rp
b24uICAgDQo+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9lZGFjLmggYi9pbmNsdWRl
L2xpbnV4L2VkYWMuaCBpbmRleA0KPj4gYjRlZTg5NjFlNjIzLi5iMzM3MjU0Y2Y1YjggMTAwNjQ0
DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2VkYWMuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9l
ZGFjLmgNCj4+IEBAIC02NjEsNCArNjYxLDU5IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGRpbW1f
aW5mbw0KPj4gKmVkYWNfZ2V0X2RpbW0oc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KPj4NCj4+
ICAJcmV0dXJuIG1jaS0+ZGltbXNbaW5kZXhdOw0KPj4gIH0NCj4+ICsNCj4+ICsvKiBFREFDIGRl
dmljZSBmZWF0dXJlcyAqLw0KPj4gKw0KPj4gKyNkZWZpbmUgRURBQ19GRUFUX05BTUVfTEVOCTEy
OA0KPj4gKw0KPj4gKy8qIFJBUyBmZWF0dXJlIHR5cGUgKi8NCj4+ICtlbnVtIGVkYWNfZGV2X2Zl
YXQgew0KPj4gKwlSQVNfRkVBVF9TQ1JVQiwNCj4+ICsJUkFTX0ZFQVRfRUNTLA0KPj4gKwlSQVNf
RkVBVF9QUFIsDQo+PiArCVJBU19GRUFUX01BWA0KPg0KPkkgc3RpbGwgZG9uJ3Qga25vdyB3aGF0
IEVDUyBvciBQUFIgaXMuDQpJIHdpbGwgYWRkIGNvbW1lbnQvZG9jdW1lbnRhdGlvbiBoZXJlIHdp
dGggYSBzaG9ydCBleHBsYW5hdGlvbiBvZiBmZWF0dXJlcw0KaWYgdGhhdCBtYWtlIHNlbnNlPw0K
RWFjaCBmZWF0dXJlIGlzIGRlc2NyaWJlZCBpbiB0aGUgc3Vic2VxdWVudCBFREFDIGZlYXR1cmUg
c3BlY2lmaWMgcGF0Y2hlcy4gDQo+DQo+LS0NCj5SZWdhcmRzL0dydXNzLA0KPiAgICBCb3Jpcy4N
Cj4NCj5odHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0
ZQ0KDQpUaGFua3MsDQpTaGlqdQ0KDQo=

