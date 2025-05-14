Return-Path: <linux-edac+bounces-3907-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA89DAB6A13
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 13:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DC91B63B3F
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F972741A0;
	Wed, 14 May 2025 11:32:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E570226883;
	Wed, 14 May 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222331; cv=none; b=dwrSAOuGjbB7Fq9Aw7KzrL0HctCkliy+1dxhgEQlukRUcT5kDCHeNpVzdn7hYiJ7LjTsyPgVYPBdNsDpNYMn7ES4/qmQKiQH+z7nOaCTzRopsUy7zApzZneqrlfCn4cwLAhGcCoiNZKkTTrybITQvGhC8VJaUDF8SbZDw1m7ShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222331; c=relaxed/simple;
	bh=U0a33LtWm3c7usN0bq37jysT1DqBk4K2k4WTfaLAaX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kYMCUaWOEtplAirvVgoAphrbggV3sn62YGVOuE2dIH5jfpTcLAEhgwSdS9rTaAmZYGfRC3GA6dlQOAJ+NfYw02/Q6lD48PsySCBMsojkChiw4yq9LY8ZC6uIbcJceZtMDZ1a+0SopUdnBNuMoI0bnJziFsvGyXPKNDgJREM3k60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZyB4Z54PHz6K9BK;
	Wed, 14 May 2025 19:31:26 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id E20BC1400DC;
	Wed, 14 May 2025 19:31:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 May 2025 13:31:59 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 14 May 2025 13:31:59 +0200
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
Subject: RE: [PATCH v5 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Topic: [PATCH v5 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Thread-Index: AQHbv5klMort+tGT8kGjctbrTEAbprPRVnoAgACt2EA=
Date: Wed, 14 May 2025 11:31:59 +0000
Message-ID: <19ccc1b78e104132962792b55ab92df5@huawei.com>
References: <20250507214344.709-1-shiju.jose@huawei.com>
 <20250507214344.709-2-shiju.jose@huawei.com>
 <8cdf7885-31b3-4308-8a7c-f4e427486429@os.amperecomputing.com>
In-Reply-To: <8cdf7885-31b3-4308-8a7c-f4e427486429@os.amperecomputing.com>
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFuaWVsIEZlcmd1c29uIDxkYW5p
ZWxmQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+U2VudDogMTQgTWF5IDIwMjUgMDM6NTUNCj5U
bzogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPjsgbGludXgtZWRhY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPmFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5r
ZXJuZWwub3JnDQo+Q2M6IGJwQGFsaWVuOC5kZTsgcmFmYWVsQGtlcm5lbC5vcmc7IHRvbnkubHVj
a0BpbnRlbC5jb207IGxlbmJAa2VybmVsLm9yZzsNCj5sZW8uZHVyYW5AYW1kLmNvbTsgWWF6ZW4u
R2hhbm5hbUBhbWQuY29tOyBtY2hlaGFiQGtlcm5lbC5vcmc7DQo+Sm9uYXRoYW4gQ2FtZXJvbiA8
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPkxpbnV4
YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgcmllbnRqZXNAZ29vZ2xlLmNvbTsNCj5qaWFxaXlh
bkBnb29nbGUuY29tOyBKb24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwu
Y29tOw0KPm5hb3lhLmhvcmlndWNoaUBuZWMuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBqdGhv
dWdodG9uQGdvb2dsZS5jb207DQo+c29tYXN1bmRhcmFtLmFAaHBlLmNvbTsgZXJkZW1ha3Rhc0Bn
b29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsNCj5kdWVud2VuQGdvb2dsZS5jb207IGd0aGVs
ZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1wZXJlY29tcHV0aW5nLmNvbTsgZGZlcmd1c29u
QGFtcGVyZWNvbXB1dGluZy5jb207DQo+d2JzQG9zLmFtcGVyZWNvbXB1dGluZy5jb207IG5pZmFu
LmN4bEBnbWFpbC5jb207IHRhbnhpYW9mZWkNCj48dGFueGlhb2ZlaUBodWF3ZWkuY29tPjsgWmVu
Z3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IFJvYmVydG8NCj5TYXNzdSA8cm9i
ZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsga2FuZ2thbmcuc2hlbkBmdXR1cmV3ZWkuY29tOw0KPndh
bmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRD
SCB2NSAxLzJdIEFDUEk6UkFTMjogQWRkIEFDUEkgUkFTMiBkcml2ZXINCj4NCj4+ICtzdGF0aWMg
aW50IHJhczJfcmVwb3J0X2NhcF9lcnJvcih1MzIgY2FwX3N0YXR1cykgew0KPj4gKwlzd2l0Y2gg
KGNhcF9zdGF0dXMpIHsNCj4+ICsJY2FzZSBBQ1BJX1JBUzJfTk9UX1ZBTElEOg0KPj4gKwljYXNl
IEFDUElfUkFTMl9OT1RfU1VQUE9SVEVEOg0KPj4gKwkJcmV0dXJuIC1FUEVSTTsNCj4+ICsJY2Fz
ZSBBQ1BJX1JBUzJfQlVTWToNCj4+ICsJCXJldHVybiAtRUJVU1k7DQo+PiArCWNhc2UgQUNQSV9S
QVMyX0ZBSUxFRDoNCj4+ICsJY2FzZSBBQ1BJX1JBUzJfQUJPUlRFRDoNCj4+ICsJY2FzZSBBQ1BJ
X1JBUzJfSU5WQUxJRF9EQVRBOg0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCWRlZmF1bHQ6
IC8qIDAgb3Igb3RoZXIsIFN1Y2Nlc3MgKi8NCj4+ICsJCXJldHVybiAwOw0KPj4gKwl9DQo+PiAr
fQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgcmFzMl9jaGVja19wY2NfY2hhbihzdHJ1Y3QgcmFzMl9w
Y2Nfc3Vic3BhY2UNCj4+ICsqcGNjX3N1YnNwYWNlKSB7DQo+PiArCXN0cnVjdCBhY3BpX3JhczJf
c2htZW0gX19pb21lbSAqZ2VuX2NvbW1fYmFzZSA9IHBjY19zdWJzcGFjZS0NCj4+Y29tbV9hZGRy
Ow0KPj4gKwl1MzIgY2FwX3N0YXR1czsNCj4+ICsJdTE2IHN0YXR1czsNCj4+ICsJdTMyIHJjOw0K
Pj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBBcyBwZXIgQUNQSSBzcGVjLCB0aGUgUENDIHNwYWNlIHdp
bGwgYmUgaW5pdGlhbGl6ZWQgYnkNCj4+ICsJICogcGxhdGZvcm0gYW5kIHNob3VsZCBoYXZlIHNl
dCB0aGUgY29tbWFuZCBjb21wbGV0aW9uIGJpdCB3aGVuDQo+PiArCSAqIFBDQyBjYW4gYmUgdXNl
ZCBieSBPU1BNLg0KPj4gKwkgKg0KPj4gKwkgKiBQb2xsIFBDQyBzdGF0dXMgcmVnaXN0ZXIgZXZl
cnkgM3VzKGRlbGF5X3VzKSBmb3IgbWF4aW11bSBvZg0KPj4gKwkgKiBkZWFkbGluZV91cyh0aW1l
b3V0X3VzKSB1bnRpbCBQQ0MgY29tbWFuZCBjb21wbGV0ZSBiaXQgaXMNCj5zZXQoY29uZCkuDQo+
PiArCSAqLw0KPj4gKwlyYyA9IHJlYWR3X3JlbGF4ZWRfcG9sbF90aW1lb3V0KCZnZW5fY29tbV9i
YXNlLT5zdGF0dXMsIHN0YXR1cywNCj4+ICsJCQkJCXN0YXR1cyAmDQo+UENDX1NUQVRVU19DTURf
Q09NUExFVEUsIDMsDQo+PiArCQkJCQlwY2Nfc3Vic3BhY2UtPmRlYWRsaW5lX3VzKTsNCj4+ICsJ
aWYgKHJjKSB7DQo+PiArCQlwcl93YXJuKCJQQ0MgY2hlY2sgY2hhbm5lbCBmYWlsZWQgZm9yIDog
JWQgcmM9JWRcbiIsDQo+PiArCQkJcGNjX3N1YnNwYWNlLT5wY2NfaWQsIHJjKTsNCj4+ICsJCXJl
dHVybiByYzsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlpZiAoc3RhdHVzICYgUENDX1NUQVRVU19FUlJP
Uikgew0KPj4gKwkJY2FwX3N0YXR1cyA9IHJlYWR3X3JlbGF4ZWQoJmdlbl9jb21tX2Jhc2UtDQo+
PnNldF9jYXBzX3N0YXR1cyk7DQo+PiArCQlyYyA9IHJhczJfcmVwb3J0X2NhcF9lcnJvcihjYXBf
c3RhdHVzKTsNCj4+ICsNCj4+ICsJCXN0YXR1cyAmPSB+UENDX1NUQVRVU19FUlJPUjsNCj4+ICsJ
CXdyaXRld19yZWxheGVkKHN0YXR1cywgJmdlbl9jb21tX2Jhc2UtPnN0YXR1cyk7DQo+PiArCQly
ZXR1cm4gcmM7DQo+PiArCX0NCj4+ICsNCj4+ICsJaWYgKHN0YXR1cyAmIFBDQ19TVEFUVVNfQ01E
X0NPTVBMRVRFKQ0KPj4gKwkJcmV0dXJuIDA7DQo+PiArDQo+PiArCXJldHVybiAtRUlPOw0KPj4g
K30NCj4NCj5XZSBzdGlsbCBoYXZlIGFuIG91dHN0YW5kaW5nIHByb2JsZW0uIFRoaXMgbWF5IHNv
dW5kIGZhbWlsaWFyLg0KPg0KPklmIGEgdXNlciBzcGVjaWZpZXMgYW4gaW52YWxpZCBhZGRyZXNz
LCBvdXIgZmlybXdhcmUgd2lsbCBzZXQgYW4gZXJyb3IgY29kZSBpbiB0aGUNCj5zZXRfY2Fwc19z
dGF0dXMgZmllbGQgb2YgdGhlIGFjcGlfcmFzMl9zaG1lbSBzdHJ1Y3R1cmUuIEluIG91ciBjYXNl
LCB0aGUgZXJyb3INCj5jb2RlIGlzIEFDUElfUkFTMl9JTlZBTElEX0RBVEEsIGFuZCB0aGUgdXNl
ciB3aWxsIG9ic2VydmUgYW4gRUlOVkFMLiBUaGlzIGlzDQo+ZXhwZWN0ZWQuDQo+DQo+SG93ZXZl
ciwgaWYgdGhlIHVzZXIgdGhlbiBzdWJzZXF1ZW50bHkgYXR0ZW1wdHMgdG8gd3JpdGUgYSBWQUxJ
RCBhZGRyZXNzLA0KPnJhczJfZ2V0X3BhdHJvbF9zY3J1Yl9ydW5uaW5nIHdpbGwgaW5kaXJlY3Rs
eSBjYWxsIHJhczJfY2hlY2tfcGNjX2NoYW4gdXNpbmcNCj50aGUgcHJldmlvdXNseSBJTlZBTElE
IGFkZHJlc3MgdG8gZGV0ZXJtaW5lIGlmIHRoZSBzY3J1YmJlciBpcyBzdGlsbCBydW5uaW5nLg0K
PlVuZm9ydHVuYXRlbHksIHRoZSBJTlZBTElEIGFkZHJlc3MgY2F1c2VzIHJhczJfZ2V0X3BhdHJv
bF9zY3J1Yl9ydW5uaW5nIHRvDQo+ZmFpbCwgdGhlcmVmb3JlIHByZXZlbnRpbmcgdGhlIHVzZXIg
ZnJvbSBzcGVjaWZ5aW5nIGEgVkFMSUQgYWRkcmVzcyBhZnRlcg0KPnNwZWNpZnlpbmcgYW4gSU5W
QUxJRCBhZGRyZXNzLg0KPg0KPlRoZSBvbmx5IHdheSB0byBtb3ZlIGZvcndhcmQgZnJvbSB0aGlz
IGluZXNjYXBhYmxlIGNvbmRpdGlvbiBpcyB0byByZWJvb3QgdGhlDQo+c3lzdGVtLg0KPg0KPkhl
cmUgaXMgYSBkZW1vIG9mIHRoZSBwcm9ibGVtIGFzIEkgcm91Z2hseSBzZWUgaXQgb24gb3VyIHN5
c3RlbSAoSSd2ZSBsYWJlbGVkIHRoZQ0KPmxpbmUgbnVtYmVycyBmb3Igc2FrZSBvZiBkaXNjdXNz
aW9uKToNCj4xICBbcm9vdEBteWhvc3Qgc2NydWIwXSMgZWNobyAweDEwMDAwMDAwMCA+IHNpemUN
Cj4yICBbcm9vdEBteWhvc3Qgc2NydWIwXSMgZWNobyAweDFmMDAwMDAwMDAgPiBhZGRyDQo+MyAg
W3Jvb3RAbXlob3N0IHNjcnViMF0jIGVjaG8gMHhjZjAwMDAwMDAwID4gYWRkcg0KPjQgIHdyaXRl
IGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQo+NSAgWyAgMjE0LjQ0NjMzOF0gUENDVCBQQ0NUOiBG
YWlsZWQgdG8gc3RhcnQgZGVtYW5kIHNjcnViYmluZw0KPjYgIFtyb290QG15aG9zdCBzY3J1YjBd
IyBlY2hvIDB4MWYwMDAwMDAwMCA+IGFkZHINCj43ICB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1
bWVudA0KPjggIFsgIDI0Mi4yNjM5MDldIFBDQ1QgUENDVDogZmFpbGVkIHRvIHJlYWQgcGFyYW1l
dGVycw0KPjkgIFtyb290QG15aG9zdCBzY3J1YjBdIyBlY2hvIDB4MTAwMDAwMDAwID4gc2l6ZQ0K
PjEwIHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQo+MTEgWyAgMjQ2LjE5MDE5Nl0gUEND
VCBQQ0NUOiBmYWlsZWQgdG8gcmVhZCBwYXJhbWV0ZXJzDQo+DQo+VGhlIHVwcGVyIG1vc3QgbWVt
b3J5IGFkZHJlc3Mgb24gdGhpcyBzeXN0ZW0gaXMgMHhiZjAwMDAwMDAwLiBMaW5lIDEgYW5kIDIN
Cj51c2UgdmFsaWQgdmFsdWVzLCBhbmQgbGluZSAyIHByb2R1Y2VzIHRoZSBleHBlY3RlZCByZXN1
bHRzLiBPbiBsaW5lIDMsIEkndmUNCj5zcGVjaWZpZWQgYW4gSU5WQUxJRCBhZGRyZXNzIChvdXRz
aWRlIG9mIHZhbGlkIHJhbmdlKS4gVGhlIGVycm9yIG9uIGxpbmUgNSBpcw0KPmV4cGVjdGVkIGFm
dGVyIGV4ZWN1dGluZyB0aGUgU1RBUlRfUEFUUk9MX1NDUlVCQkVSIGNvbW1hbmQgd2l0aCBhbg0K
PklOVkFMSUQgYWRkcmVzcy4NCj4NCj5MaW5lIDYgc2hvdyBob3cgSSBhdHRlbXB0IHRvIHNwZWNp
ZnkgYSBWQUxJRCBhZGRyZXNzLiBVbmZvcnR1bmF0ZWx5LA0KPnJhczJfZ2V0X3BhdHJvbF9zY3J1
Yl9ydW5uaW5nIGVuY291bnRlcnMgYW5kIGVycm9yIGFmdGVyIGV4ZWN1dGluZw0KPkdFVF9QQVRS
T0xfUEFSQU1FVEVSUyBiZWNhdXNlIGl0IHVzZWQgdGhlIE9MRCBJTlZBTElEIHZhbHVlcyBpbiBw
c19zbS0NCj4+cGFyYW1zLnJlcV9hZGRyX3JhbmdlLiBMaW5lIDcgYW5kIDggYXJlIHRoZSByZXN1
bHQuIFNpbmNlIHRoZSBmbG93IG9mDQo+ZXhlY3V0aW9uIGlmIGFib3J0ZWQgYXQgdGhpcyBwb2lu
dCwgeW91IGNhbiBuZXZlciByZWN0aWZ5IHRoZSBzaXR1YXRpb24gYW5kIGluc2VydCBhDQo+dmFs
aWQgdmFsdWUgaW50byBwc19zbS0+cGFyYW1zLnJlcV9hZGRyX3JhbmdlLCB1bmxlc3MgeW91IHJl
Ym9vdCB0aGUgc3lzdGVtLg0KPg0KPk9uZSBoYWxmIGJha2VkIHNvbHV0aW9uIHRvIHRoaXMgcHJv
YmxlbSwgaXMgdG8gbW9kaWZ5DQo+cmFzMl9nZXRfcGF0cm9sX3NjcnViX3J1bm5pbmcgc28gdGhh
dCBpZiB0aGVyZSBpcyBhIG5vbi16ZXJvIGFkZHJlc3Mgb3Igc2l6ZQ0KPnNwZWNpZmllZCwgQU5E
IHRoZSBsYXN0IGVycm9yIGNvZGUgd2UgcmVjZWl2ZWQgd2FzIElOVkFMSUQgREFUQSwgdGhlbiBh
c3N1bWUNCj50aGUgc2NydWJiZXIgaXMgTk9UIHJ1bm5pbmcuDQpIaSBEYW5pZWwsDQoNClRoYW5r
cyBmb3IgcmVwb3J0aW5nIHRoZSBpc3N1ZS4NCkNhbiB5b3UgY2hlY2sgd2hldGhlciBmb2xsb3dp
bmcgY2hhbmdlIGZpeCB0aGUgaXNzdWUgaW4geW91ciB0ZXN0IHNldHVwPw0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9y
YXMvYWNwaV9yYXMyLmMgYi9kcml2ZXJzL3Jhcy9hY3BpX3JhczIuYw0KaW5kZXggNGQ5Y2ZkM2Jk
ZjQ1Li5mZjRhYTFiNzU4NjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Jhcy9hY3BpX3JhczIuYw0K
KysrIGIvZHJpdmVycy9yYXMvYWNwaV9yYXMyLmMNCkBAIC0yNTUsNiArMjU1LDEzIEBAIHN0YXRp
YyBpbnQgcmFzMl9od19zY3J1Yl93cml0ZV9hZGRyKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAq
ZHJ2X2RhdGEsIHU2NCBiYXNlDQogICAgICAgIHJldCA9IHJhczJfc2VuZF9wY2NfY21kKHJhczJf
Y3R4LCBQQ0NfQ01EX0VYRUNfUkFTMik7DQogICAgICAgIGlmIChyZXQpIHsNCiAgICAgICAgICAg
ICAgICBkZXZfZXJyKHJhczJfY3R4LT5kZXYsICJGYWlsZWQgdG8gc3RhcnQgZGVtYW5kIHNjcnVi
YmluZ1xuIik7DQorICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRVBFUk0gfHwgcmV0ID09IC1F
SU5WQUwpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHBzX3NtLT5wYXJhbXMucmVxX2FkZHJf
cmFuZ2VbMF0gPSAwOw0KKyAgICAgICAgICAgICAgICAgICAgICAgcHNfc20tPnBhcmFtcy5yZXFf
YWRkcl9yYW5nZVsxXSA9IDA7DQorICAgICAgICAgICAgICAgICAgICAgICByYXMyX2N0eC0+YmFz
ZSA9IDA7DQorICAgICAgICAgICAgICAgICAgICAgICByYXMyX2N0eC0+c2l6ZSA9IDA7DQorICAg
ICAgICAgICAgICAgICAgICAgICByYXMyX2N0eC0+b2Rfc2NydWJfc3RzID0gT0RfU0NSVUJfU1RT
X0lETEU7DQorICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQog
ICAgICAgIH0NCiAgICAgICAgcmFzMl9jdHgtPm9kX3NjcnViX3N0cyA9IE9EX1NDUlVCX1NUU19B
Q1RJVkU7DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpU
aGFua3MsDQpTaGlqdSANCg0KPg0KPlJlZ2FyZHMsDQo+fkRhbmllbA0K

