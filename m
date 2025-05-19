Return-Path: <linux-edac+bounces-3939-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BECABBD62
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5417BDB0
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830F2750EB;
	Mon, 19 May 2025 12:12:48 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3B1C683;
	Mon, 19 May 2025 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656768; cv=none; b=i6l4z2sUWIuy/MGSLf4lhIqYTe+jVbaqsQhzTjTdQwo4tvaAIpK+E/Cs4bCXOO+x8+TbXvNQQ1dOxv+ZsFmr0e/AQDgwreL3QrDKo3xKrqtRdVFJEV9JrDMmXI0RzK1lb4v/0JXt+FAq4YkK/fisTnaEpzOk5VuGVGJkkfWzoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656768; c=relaxed/simple;
	bh=rFRIvFuWUliJwSLHrP/h/3fIaAtmVc4vP2aeAbKLg5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rPm5/hLu5g/9VxyP+yQ83c95cYRFh34UoYwO12iH1DLd2HQLVV8Lqsi3clr+D1wvOWQ4QZaMvKeEEQppB5KUR9OzY77UCwT8Z/cR2tlOcW+6dgzjsARagr11D7OXhuNYZT9IOb9/DCoFZICIrnrYCtGkk+OAhTw4GB3Lh2hCJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1Gky1LM6z6K9jp;
	Mon, 19 May 2025 20:11:54 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B9C4140133;
	Mon, 19 May 2025 20:12:41 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 May 2025 14:12:41 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 19 May 2025 14:12:41 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Linuxarm <linuxarm@huawei.com>,
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
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: [PATCH v6 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v6 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHbxmZ7uLoEIE5IaUS4NXsz+YRI27PVfH2AgARkgPA=
Date: Mon, 19 May 2025 12:12:41 +0000
Message-ID: <a98451bf422e4dcba7bb0075fa892e5b@huawei.com>
References: <20250516132205.789-1-shiju.jose@huawei.com>
	<20250516132205.789-2-shiju.jose@huawei.com>
 <51bcb52c-4132-4daf-8903-29b121c485a1@os.amperecomputing.com>
In-Reply-To: <51bcb52c-4132-4daf-8903-29b121c485a1@os.amperecomputing.com>
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBGZXJndXNvbiA8
ZGFuaWVsZkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPlNlbnQ6IDE2IE1heSAyMDI1IDIwOjA1
DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT47IGxpbnV4LWVkYWNAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj5hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZn
ZXIua2VybmVsLm9yZw0KPkNjOiBicEBhbGllbjguZGU7IHJhZmFlbEBrZXJuZWwub3JnOyB0b255
Lmx1Y2tAaW50ZWwuY29tOyBsZW5iQGtlcm5lbC5vcmc7DQo+bGVvLmR1cmFuQGFtZC5jb207IFlh
emVuLkdoYW5uYW1AYW1kLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOw0KPkpvbmF0aGFuIENhbWVy
b24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IGxpbnV4LW1tQGt2YWNrLm9yZzsNCj5M
aW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IHJpZW50amVzQGdvb2dsZS5jb207DQo+amlh
cWl5YW5AZ29vZ2xlLmNvbTsgSm9uLkdyaW1tQGFtZC5jb207IGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbTsNCj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsg
anRob3VnaHRvbkBnb29nbGUuY29tOw0KPnNvbWFzdW5kYXJhbS5hQGhwZS5jb207IGVyZGVtYWt0
YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207DQo+ZHVlbndlbkBnb29nbGUuY29tOyBn
dGhlbGVuQGdvb2dsZS5jb207DQo+d3NjaHdhcnR6QGFtcGVyZWNvbXB1dGluZy5jb207IGRmZXJn
dXNvbkBhbXBlcmVjb21wdXRpbmcuY29tOw0KPndic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tOyBu
aWZhbi5jeGxAZ21haWwuY29tOyB0YW54aWFvZmVpDQo+PHRhbnhpYW9mZWlAaHVhd2VpLmNvbT47
IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBSb2JlcnRvDQo+U2Fzc3Ug
PHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47IGthbmdrYW5nLnNoZW5AZnV0dXJld2VpLmNvbTsN
Cj53YW5naHVpcWlhbmcgPHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjYgMS8yXSBBQ1BJOlJBUzI6IEFkZCBBQ1BJIFJBUzIgZHJpdmVyDQo+DQo+PiArc3Rh
dGljIGludCByYXMyX2NoZWNrX3BjY19jaGFuKHN0cnVjdCByYXMyX3BjY19zdWJzcGFjZQ0KPj4g
KypwY2Nfc3Vic3BhY2UpIHsNCj4+ICsJc3RydWN0IGFjcGlfcmFzMl9zaG1lbSBfX2lvbWVtICpn
ZW5fY29tbV9iYXNlID0gcGNjX3N1YnNwYWNlLQ0KPj5jb21tX2FkZHI7DQo+PiArCXUzMiBjYXBf
c3RhdHVzOw0KPj4gKwl1MTYgc3RhdHVzOw0KPj4gKwl1MzIgcmM7DQo+PiArDQo+PiArCS8qDQo+
PiArCSAqIEFzIHBlciBBQ1BJIHNwZWMsIHRoZSBQQ0Mgc3BhY2Ugd2lsbCBiZSBpbml0aWFsaXpl
ZCBieQ0KPj4gKwkgKiBwbGF0Zm9ybSBhbmQgc2hvdWxkIGhhdmUgc2V0IHRoZSBjb21tYW5kIGNv
bXBsZXRpb24gYml0IHdoZW4NCj4+ICsJICogUENDIGNhbiBiZSB1c2VkIGJ5IE9TUE0uDQo+PiAr
CSAqDQo+PiArCSAqIFBvbGwgUENDIHN0YXR1cyByZWdpc3RlciBldmVyeSAzdXMoZGVsYXlfdXMp
IGZvciBtYXhpbXVtIG9mDQo+PiArCSAqIGRlYWRsaW5lX3VzKHRpbWVvdXRfdXMpIHVudGlsIFBD
QyBjb21tYW5kIGNvbXBsZXRlIGJpdCBpcw0KPnNldChjb25kKS4NCj4+ICsJICovDQo+PiArCXJj
ID0gcmVhZHdfcmVsYXhlZF9wb2xsX3RpbWVvdXQoJmdlbl9jb21tX2Jhc2UtPnN0YXR1cywgc3Rh
dHVzLA0KPj4gKwkJCQkJc3RhdHVzICYNCj5QQ0NfU1RBVFVTX0NNRF9DT01QTEVURSwgMywNCj4+
ICsJCQkJCXBjY19zdWJzcGFjZS0+ZGVhZGxpbmVfdXMpOw0KPj4gKwlpZiAocmMpIHsNCj4+ICsJ
CXByX3dhcm4oIlBDQyBjaGVjayBjaGFubmVsIGZhaWxlZCBmb3IgOiAlZCByYz0lZFxuIiwNCj4+
ICsJCQlwY2Nfc3Vic3BhY2UtPnBjY19pZCwgcmMpOw0KPj4gKwkJcmV0dXJuIHJjOw0KPj4gKwl9
DQo+PiArDQo+PiArCWlmIChzdGF0dXMgJiBQQ0NfU1RBVFVTX0VSUk9SKSB7DQo+PiArCQljYXBf
c3RhdHVzID0gcmVhZHdfcmVsYXhlZCgmZ2VuX2NvbW1fYmFzZS0NCj4+c2V0X2NhcHNfc3RhdHVz
KTsNCj4+ICsJCXJjID0gcmFzMl9yZXBvcnRfY2FwX2Vycm9yKGNhcF9zdGF0dXMpOw0KPj4gKw0K
Pj4gKwkJc3RhdHVzICY9IH5QQ0NfU1RBVFVTX0VSUk9SOw0KPj4gKwkJd3JpdGV3X3JlbGF4ZWQo
c3RhdHVzLCAmZ2VuX2NvbW1fYmFzZS0+c3RhdHVzKTsNCj4+ICsJCXJldHVybiByYzsNCj4+ICsJ
fQ0KPj4gKw0KPj4gKwlpZiAoc3RhdHVzICYgUENDX1NUQVRVU19DTURfQ09NUExFVEUpDQo+PiAr
CQlyZXR1cm4gMDsNCj4+ICsNCj4+ICsJcmV0dXJuIC1FSU87DQo+PiArfQ0KPg0KPkhpLCBJJ20g
dGVycmlibHkgc29ycnkgZm9yIHRoZSBsYXRlIGNodXJuDQo+DQo+SXQgaXMgb3VyIGN1cnJlbnQg
YmVsaWVmIHRoYXQgY2hlY2tpbmcgdGhlIHNldF9jYXBzX3N0YXR1cyBpcyBub3QgZGVwZW5kZW50
IG9uIGlmDQo+dGhlIFBDQ19TVEFUVVNfRVJST1IgYml0IGlzIHNldC4gSXQgc2VlbXMgdG8gdXMs
IHRoYXQgdGhlIFBDQ19TVEFUVVNfRVJST1INCj5iaXQgc2hvdWxkIG9ubHkgYmUgc2V0IGlmIHRo
ZXJlIGlzIGEgcHJvYmxlbSB3aXRoIHRoZSBQQ0MgcHJvdG9jb2wuIFdlJ3ZlDQo+aW50ZXJwcmV0
ZWQgdGhlIHNldF9jYXBzX3N0YXR1cyBhcyBhIGNhcGFiaWxpdHkgc3BlY2lmaWMgZXJyb3IgcmVw
b3J0aW5nDQo+bWVjaGFuaXNtLiBXZSBoYXZlIHRlc3RlZCB0aGUgZm9sbG93aW5nIGFtZW5kbWVu
dCB0byB0aGlzIGZsb3csIGFuZCB1cmdlIHlvdQ0KPnRvIGNvbnNpZGVyIHRoaXMgY2hhbmdlLCBv
ciBhIGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50IG9uZToNCg0KVGhhbmtzIERhbmllbCBmb3IgdGhl
IHN1Z2dlc3Rpb24uIEkgaGF2ZSB0ZXN0ZWQgd2l0aCB0aGUgY2hhbmdlcyBhbmQgd2lsbCBpbmNv
cnBvcmF0ZQ0KaW4gdjcuDQoNClRoYW5rcywNClNoaWp1ICAgDQo+DQo+ZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYWNwaS9yYXMyLmMgYi9kcml2ZXJzL2FjcGkvcmFzMi5jIGluZGV4DQo+NmJiYjAwOTFi
NGIzLi4zZjczYzlmZjMzYTMgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9hY3BpL3JhczIuYw0KPisr
KyBiL2RyaXZlcnMvYWNwaS9yYXMyLmMNCj5AQCAtMTE2LDE4ICsxMTYsMjAgQEAgc3RhdGljIGlu
dCByYXMyX2NoZWNrX3BjY19jaGFuKHN0cnVjdA0KPnJhczJfcGNjX3N1YnNwYWNlDQo+KnBjY19z
dWJzcGFjZSkNCj4gICAgICAgIH0NCj4NCj4gICAgICAgIGlmIChzdGF0dXMgJiBQQ0NfU1RBVFVT
X0VSUk9SKSB7DQo+LSAgICAgICAgICAgICAgIGNhcF9zdGF0dXMgPSByZWFkd19yZWxheGVkKCZn
ZW5fY29tbV9iYXNlLT5zZXRfY2Fwc19zdGF0dXMpOw0KPi0gICAgICAgICAgICAgICByYyA9IHJh
czJfcmVwb3J0X2NhcF9lcnJvcihjYXBfc3RhdHVzKTsNCj4tDQo+ICAgICAgICAgICAgICAgIHN0
YXR1cyAmPSB+UENDX1NUQVRVU19FUlJPUjsNCj4gICAgICAgICAgICAgICAgd3JpdGV3X3JlbGF4
ZWQoc3RhdHVzLCAmZ2VuX2NvbW1fYmFzZS0+c3RhdHVzKTsNCj4tICAgICAgICAgICAgICAgcmV0
dXJuIHJjOw0KPisgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gICAgICAgIH0NCj4NCj4t
ICAgICAgIGlmIChzdGF0dXMgJiBQQ0NfU1RBVFVTX0NNRF9DT01QTEVURSkNCj4tICAgICAgICAg
ICAgICAgcmV0dXJuIDA7DQo+DQo+LSAgICAgICByZXR1cm4gLUVJTzsNCj4rICAgICAgIGlmICgh
KHN0YXR1cyAmIFBDQ19TVEFUVVNfQ01EX0NPTVBMRVRFKSkNCj4rICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU87DQo+Kw0KPisgICAgICAgLy8gQ2FjaGUsIENsZWFyLCBhbmQgUmVwb3J0IGZlYXR1
cmUgc3BlY2lmaWMgc3RhdHVzDQo+KyAgICAgICBjYXBfc3RhdHVzID0gcmVhZHdfcmVsYXhlZCgm
Z2VuX2NvbW1fYmFzZS0+c2V0X2NhcHNfc3RhdHVzKTsNCj4rICAgICAgIHdyaXRld19yZWxheGVk
KDB4MCwgJmdlbl9jb21tX2Jhc2UtPnNldF9jYXBzX3N0YXR1cyk7DQo+KyAgICAgICByYyA9IHJh
czJfcmVwb3J0X2NhcF9lcnJvcihjYXBfc3RhdHVzKTsNCj4rICAgICAgIHJldHVybiByYzsNCj4g
fQ0KPg0KPlRoYW5rcyBhZ2FpbiwNCj5+RGFuaWVsDQoNCg==

