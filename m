Return-Path: <linux-edac+bounces-1587-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73258941BF6
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 19:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293B3283DDC
	for <lists+linux-edac@lfdr.de>; Tue, 30 Jul 2024 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426418990F;
	Tue, 30 Jul 2024 17:01:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087C156F30;
	Tue, 30 Jul 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358889; cv=none; b=j/w0ZqSILbYMftvqHH5YqxEdq0KKflG+w5PIR1LkcP1AcuJwARNL8+OMWOiOSPIgSbo0fTb2PEt0B4hXN+WvKKZGzDCkACxgpV/yErVcAcXLMetirh8xTAU2xL3xgi0Tcw3vcNCHXeCKEWKBk987be/aCfY4k89Mr6HBe/BsHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358889; c=relaxed/simple;
	bh=Fl4YpwZG65rsVJag5s7RbOquj1urRIGQ0o3YX2Yzlp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SRRx6MwXoBVODab8j4xWnCb6BvSUegp2YI+FYZLfM22H5u2hAxbgLMu/k4Rbduacj0M5ImKFKhT6+wL+iAOAr8Gbn2H3cI6Zg2UzXJqnk9nSzATMhLF5Dqu9nhmpGiWVYvV1vQJGxzjG3nu1zdklMkXkigt2BmkN6ROD3i41V5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WYLz82CnZz6K8qR;
	Wed, 31 Jul 2024 00:58:44 +0800 (CST)
Received: from lhrpeml100003.china.huawei.com (unknown [7.191.160.210])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C0C8140A70;
	Wed, 31 Jul 2024 01:01:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 18:01:17 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039;
 Tue, 30 Jul 2024 18:01:17 +0100
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
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v10 01/11] EDAC: Add generic EDAC RAS control feature
 driver
Thread-Topic: [PATCH v10 01/11] EDAC: Add generic EDAC RAS control feature
 driver
Thread-Index: AQHa33XRsQYYvx89v0isWis2IAG8f7IPNZuAgABNybA=
Date: Tue, 30 Jul 2024 17:01:17 +0000
Message-ID: <f83a17db2c054483a450af73f7b9966b@huawei.com>
References: <20240726160556.2079-1-shiju.jose@huawei.com>
	<20240726160556.2079-2-shiju.jose@huawei.com>
 <20240730131611.GAZqjnm9D4ZJoGBIuZ@fat_crate.local>
In-Reply-To: <20240730131611.GAZqjnm9D4ZJoGBIuZ@fat_crate.local>
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
bGllbjguZGU+DQo+U2VudDogMzAgSnVseSAyMDI0IDE0OjE2DQo+VG86IFNoaWp1IEpvc2UgPHNo
aWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmFjcGlAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+dG9ueS5s
dWNrQGludGVsLmNvbTsgcmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsNCj5tY2hl
aGFiQGtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgZGF2ZUBzdGdvbGFicy5u
ZXQ7IEpvbmF0aGFuDQo+Q2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgZGF2
ZS5qaWFuZ0BpbnRlbC5jb207DQo+YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hhbC5s
LnZlcm1hQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsNCj5kYXZpZEByZWRoYXQuY29t
OyBWaWxhcy5TcmlkaGFyYW5AYW1kLmNvbTsgbGVvLmR1cmFuQGFtZC5jb207DQo+WWF6ZW4uR2hh
bm5hbUBhbWQuY29tOyByaWVudGplc0Bnb29nbGUuY29tOyBqaWFxaXlhbkBnb29nbGUuY29tOw0K
Pkpvbi5HcmltbUBhbWQuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207DQo+bmFveWEu
aG9yaWd1Y2hpQG5lYy5jb207IGphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0b25AZ29vZ2xl
LmNvbTsNCj5zb21hc3VuZGFyYW0uYUBocGUuY29tOyBlcmRlbWFrdGFzQGdvb2dsZS5jb207IHBn
b25kYUBnb29nbGUuY29tOw0KPmR1ZW53ZW5AZ29vZ2xlLmNvbTsgbWlrZS5tYWx2ZXN0dXRvQGlu
dGVsLmNvbTsgZ3RoZWxlbkBnb29nbGUuY29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcu
Y29tOyBkZmVyZ3Vzb25AYW1wZXJlY29tcHV0aW5nLmNvbTsNCj53YnNAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbTsgbmlmYW4uY3hsQGdtYWlsLmNvbTsgdGFueGlhb2ZlaQ0KPjx0YW54aWFvZmVpQGh1
YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgUm9iZXJ0
bw0KPlNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+OyBrYW5na2FuZy5zaGVuQGZ1dHVy
ZXdlaS5jb207DQo+d2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IExpbnV4
YXJtDQo+PGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMDEv
MTFdIEVEQUM6IEFkZCBnZW5lcmljIEVEQUMgUkFTIGNvbnRyb2wgZmVhdHVyZQ0KPmRyaXZlcg0K
Pg0KPk9uIEZyaSwgSnVsIDI2LCAyMDI0IGF0IDA1OjA1OjQ1UE0gKzAxMDAsIHNoaWp1Lmpvc2VA
aHVhd2VpLmNvbSB3cm90ZToNCj4+IEZyb206IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2Vp
LmNvbT4NCj4+DQo+PiBBZGQgZ2VuZXJpYyBFREFDIGRyaXZlciBzdXBwb3J0cyByZWdpc3Rlcmlu
ZyBSQVMgZmVhdHVyZXMgc3VwcG9ydGVkIGluDQo+PiB0aGUgc3lzdGVtLiBUaGUgZHJpdmVyIGV4
cG9zZXMgZmVhdHVyZSdzIGNvbnRyb2wgYXR0cmlidXRlcyB0byB0aGUNCj4+IHVzZXJzcGFjZSBp
biAvc3lzL2J1cy9lZGFjL2RldmljZXMvPGRldi1uYW1lPi88cmFzLWZlYXR1cmU+Lw0KPj4NCj4+
IENvLWRldmVsb3BlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3
ZWkuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2Ft
ZXJvbkBodWF3ZWkuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogU2hpanUgSm9zZSA8c2hpanUuam9z
ZUBodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9lZGFjL01ha2VmaWxlICAgICAgICAg
ICAgfCAgIDEgKw0KPj4gIGRyaXZlcnMvZWRhYy9lZGFjX3Jhc19mZWF0dXJlLmMgIHwgMTgxDQo+
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrICBpbmNsdWRlL2xpbnV4L2VkYWNfcmFz
X2ZlYXR1cmUuaCB8DQo+PiA2NiArKysrKysrKysrKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMjQ4
IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA3NTUgZHJpdmVycy9lZGFjL2VkYWNf
cmFzX2ZlYXR1cmUuYyAgY3JlYXRlIG1vZGUNCj4+IDEwMDc1NSBpbmNsdWRlL2xpbnV4L2VkYWNf
cmFzX2ZlYXR1cmUuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvTWFrZWZpbGUg
Yi9kcml2ZXJzL2VkYWMvTWFrZWZpbGUgaW5kZXgNCj4+IDljMDk4OTM2OTViNy4uYzUzMmI1N2E2
ZDhhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9lZGFjL01ha2VmaWxlDQo+PiArKysgYi9kcml2
ZXJzL2VkYWMvTWFrZWZpbGUNCj4+IEBAIC0xMCw2ICsxMCw3IEBAIG9iai0kKENPTkZJR19FREFD
KQkJCTo9IGVkYWNfY29yZS5vDQo+Pg0KPj4gIGVkYWNfY29yZS15CTo9IGVkYWNfbWMubyBlZGFj
X2RldmljZS5vIGVkYWNfbWNfc3lzZnMubw0KPj4gIGVkYWNfY29yZS15CSs9IGVkYWNfbW9kdWxl
Lm8gZWRhY19kZXZpY2Vfc3lzZnMubyB3cS5vDQo+PiArZWRhY19jb3JlLXkJKz0gZWRhY19yYXNf
ZmVhdHVyZS5vDQo+DQo+RURBQyBhbmQgUkFTIGFuZCBmZWF0dXJlPyENCj4NCj5PaCBib3kuDQo+
DQo+RURBQyA9PSBSQVMuDQo+DQo+ImZlYXR1cmUiIGlzIHNpbGx5Lg0KPg0KPkxvb2tpbmcgYXQg
dGhlIGNvZGUgYmVsb3csIHlvdSdyZSByZWdpc3RlcmluZyBhbiBFREFDIGRldmljZS4NCj4tIGVk
YWNfcmFzX2Rldl9yZWdpc3RlcigpLg0KPg0KPlNvIHdoeSBpc24ndCB0aGlzIHRoaW5nIGluIGVk
YWNfZGV2aWNlLmM/DQpTdXJlLiBUaGVuIGNhbiBJIGFkZCBkZWZpbml0aW9ucyBpbiBlZGFjX3Jh
c19mZWF0dXJlLmggdG8gL2xpbnV4L2VkYWMuaD8gICAgDQoNCj4NCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2VkYWNfcmFzX2ZlYXR1cmUuaA0KPj4gYi9pbmNsdWRlL2xpbnV4L2VkYWNf
cmFzX2ZlYXR1cmUuaA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+IGluZGV4IDAwMDAwMDAw
MDAwMC4uOGYwZTBjNDdhNjE3DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL2xp
bnV4L2VkYWNfcmFzX2ZlYXR1cmUuaA0KPj4gQEAgLTAsMCArMSw2NiBAQA0KPj4gKy8qIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+PiArLyoNCj4+ICsgKiBFREFDIFJBUyBj
b250cm9sIGZlYXR1cmVzLg0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChjKSAyMDI0IEhpU2ls
aWNvbiBMaW1pdGVkLg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgX19FREFDX1JBU19GRUFU
X0gNCj4+ICsjZGVmaW5lIF9fRURBQ19SQVNfRkVBVF9IDQo+PiArDQo+PiArI2luY2x1ZGUgPGxp
bnV4L3R5cGVzLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2VkYWMuaD4NCj4+ICsNCj4+ICsjZGVm
aW5lIEVEQUNfUkFTX05BTUVfTEVOCTEyOA0KPj4gKw0KPj4gK2VudW0gZWRhY19yYXNfZmVhdCB7
DQo+PiArCVJBU19GRUFUX1NDUlVCLA0KPj4gKwlSQVNfRkVBVF9FQ1MsDQo+PiArCVJBU19GRUFU
X01BWA0KPj4gK307DQo+PiArDQo+PiArc3RydWN0IGVkYWNfZWNzX2V4X2luZm8gew0KPj4gKwl1
MTYgbnVtX21lZGlhX2ZydXM7DQo+PiArfTsNCj4+ICsNCj4+ICsvKg0KPj4gKyAqIEVEQUMgUkFT
IGZlYXR1cmUgaW5mb3JtYXRpb24gc3RydWN0dXJlICAqLyBzdHJ1Y3QgZWRhY19zY3J1Yl9kYXRh
DQo+PiArew0KPj4gKwljb25zdCBzdHJ1Y3QgZWRhY19zY3J1Yl9vcHMgKm9wczsNCj4+ICsJdm9p
ZCAqcHJpdmF0ZTsNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCBlZGFjX2Vjc19kYXRhIHsNCj4+
ICsJY29uc3Qgc3RydWN0IGVkYWNfZWNzX29wcyAqb3BzOw0KPj4gKwl2b2lkICpwcml2YXRlOw0K
Pj4gK307DQo+DQo+U28gZWFjaCAiZmVhdHVyZSIgd291bGQgcmVxdWlyZSBhIHNlcGFyYXRlIHN0
cnVjdCB0eXBlPw0KPg0KPldoeSBkb24ndCB5b3UgZGVmaW5lIGEgKnNpbmdsZSogc3RydWN0IHdo
aWNoIGFjY29tb2RhdGVzIGFueSBSQVMNCj5mdW5jdGlvbmFsaXR5Pw0KRG9uZS4NCg0KPg0KPlRo
eC4NCj4NCj4tLQ0KPlJlZ2FyZHMvR3J1c3MsDQo+ICAgIEJvcmlzLg0KPg0KPmh0dHBzOi8vcGVv
cGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo+DQoNClRoYW5rcywN
ClNoaWp1DQo=

