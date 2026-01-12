Return-Path: <linux-edac+bounces-5617-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7299D11D97
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32461301FD30
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226CA29D294;
	Mon, 12 Jan 2026 10:26:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E732C11D9;
	Mon, 12 Jan 2026 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213572; cv=none; b=hvU+OHGqnEkrN7F8MT1o73VfHLXnVzO1N+rqYr+O2ACypgIncu87Q56r26MoEYQviIw1KpGnDFzU+hPh/sKYq1gxK5IM2n21utCTqv/2B47pXIOAP3nbuZ5laCEkhRncNv2qCLjnfKWoVnkJ4q2y7/MmPOBL16YqiW2qn0n0zXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213572; c=relaxed/simple;
	bh=8X4pn0QUH4N3ewQkB+pXPs6DXYUAF5N5dx2kYKo8BTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0Mvw3YRsDY5p0gmI8enfyfiv+oV+OOUpnea9Kk38/0BFF3PtzZCXnmemAXJozZ8O6Xl+PH+VBf7J5CyWgHWkwPkNqvWsl/KZUkKnIHgwLXKqiPdxyiBpRaufntwsB7mZOpkub+0FYDfi3xugHxMJbKevRibLFKfnqygQ41J534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Borislav Petkov <bp@alien8.de>
CC: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Tony
 Luck" <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIHg4?=
 =?utf-8?B?Ni9tY2U6IEZpeCB0aW1lciBpbnRlcnZhbCBhZGp1c3RtZW50IGFmdGVyIGxv?=
 =?utf-8?Q?gging_a_MCE_event?=
Thread-Topic: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNlOiBG?=
 =?utf-8?B?aXggdGltZXIgaW50ZXJ2YWwgYWRqdXN0bWVudCBhZnRlciBsb2dnaW5nIGEg?=
 =?utf-8?Q?MCE_event?=
Thread-Index: AQHcg51apqteKEUlTE6A1cyDr3var7VNtWyAgACQpxD//36VAIAAjr2g
Date: Mon, 12 Jan 2026 10:24:11 +0000
Message-ID: <268e2f0512db435685af987a2ba6893c@baidu.com>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
In-Reply-To: <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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
X-FEAS-Client-IP: 172.31.3.14
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBPbiBNb24sIEphbiAxMiwgMjAyNiBhdCAwOTozNjoyMUFNICswMDAwLCBMaSxSb25ncWluZyB3
cm90ZToNCj4gPiBPaywgSSB3aWxsIGFkZCBtb3JlIGV4cGxhbmF0aW9uLCBhbmQgcmVuYW1lIG1j
ZV9ub3RpZnlfaXJxKCkgYXMNCj4gPiBtY2Vfbm90aWZ5X3VzZXIoKTsNCj4gDQo+IE5vLCBmaXJz
dCB5b3Ugc2hvdWxkIGV4cGxhaW4gd2hhdCB5b3UncmUgZml4aW5nIGhlcmUgYW5kIHdoeS4NCj4g
DQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQoNCkhvdyBhYm91dCBt
b2RpZnlpbmcgdGhlIGNoYW5nZWxvZyBhcyBmb2xsb3dzDQoNCg0KICAgIHg4Ni9tY2U6IEZpeCB0
aW1lciBpbnRlcnZhbCBhZGp1c3RtZW50IGFmdGVyIGxvZ2dpbmcgYSBNQ0UgZXZlbnQNCg0KICAg
IFNpbmNlIGNvbW1pdCAwMTFkODI2MTExNzIgKCJSQVM6IEFkZCBhIENvcnJlY3RlZCBFcnJvcnMg
Q29sbGVjdG9yIiksDQogICAgbWNlX3RpbWVyX2ZuKCkgaGFzIGluY29ycmVjdGx5IGRldGVybWlu
ZWQgd2hldGhlciB0byBhZGp1c3QgdGhlDQogICAgdGltZXIgaW50ZXJ2YWwuIFRoZSBpc3N1ZSBh
cmlzZXMgYmVjYXVzZSBtY2Vfbm90aWZ5X2lycSgpIG5vdyBhbHdheXMNCiAgICByZXR1cm5zIGZh
bHNlIHdoZW4gY2FsbGVkIGZyb20gdGhlIHRpbWVyIHBhdGgsIHNpbmNlIHRoZSBwb2xsaW5nIGNv
ZGUNCiAgICBuZXZlciBzZXRzIGJpdCAwIG9mIG1jZV9uZWVkX25vdGlmeS4gVGhpcyBwcmV2ZW50
cyBwcm9wZXIgYWRqdXN0bWVudCBvZg0KICAgIHRoZSB0aW1lciBpbnRlcnZhbCBiYXNlZCBvbiB3
aGV0aGVyIE1DRSBldmVudHMgd2VyZSBsb2dnZWQuDQoNCiAgICBUaGUgbWNlX25vdGlmeV9pcnEo
KSBpcyBjYWxsZWQgZnJvbSB0d28gY29udGV4dHM6DQogICAgMS4gRWFybHkgbm90aWZpZXIgYmxv
Y2sgLSBjb3JyZWN0bHkgc2V0cyBtY2VfbmVlZF9ub3RpZnkNCiAgICAyLiBUaW1lciBmdW5jdGlv
biAtIG5ldmVyIHNldHMgbWNlX25lZWRfbm90aWZ5LCBtYWtpbmcgaXQgYSBub29wDQogICAgICAg
KHRob3VnaCBsb2dnZWQgZXJyb3JzIGFyZSBzdGlsbCBwcm9jZXNzZWQgdGhyb3VnaCBtY2VfbG9n
KCktPg0KICAgICAgICB4ODZfbWNlX2RlY29kZXJfY2hhaW4gLT4gZWFybHkgbm90aWZpZXIpLg0K
DQogICAgRml4IHRoaXMgYnkgbW9kaWZ5aW5nIG1hY2hpbmVfY2hlY2tfcG9sbCgpIHRvIHJldHVy
biBhIGJvb2xlYW4gaW5kaWNhdGluZw0KICAgIHdoZXRoZXIgYW55IE1DRSB3YXMgbG9nZ2VkLCBh
bmQgdXBkYXRpbmcgbWNfcG9sbF9iYW5rcygpIGFuZCByZWxhdGVkDQogICAgZnVuY3Rpb25zIHRv
IHByb3BhZ2F0ZSB0aGlzIHJldHVybiB2YWx1ZS4gVGhlbiwgbWNlX3RpbWVyX2ZuKCkgY2FuIHVz
ZQ0KICAgIHRoaXMgZGlyZWN0IHJldHVybiB2YWx1ZSBpbnN0ZWFkIG9mIHJlbHlpbmcgb24gbWNl
X25vdGlmeV9pcnEoKSBmb3INCiAgICB0aW1lciBpbnRlcnZhbCBkZWNpc2lvbnMuDQoNCiAgICBU
aGlzIGVuc3VyZXMgdGhlIHRpbWVyIGludGVydmFsIGlzIGNvcnJlY3RseSByZWR1Y2VkIHdoZW4g
TUNFIGV2ZW50cyBhcmUNCiAgICBsb2dnZWQgYW5kIGluY3JlYXNlZCB3aGVuIG5vIGV2ZW50cyBv
Y2N1ci4NCg0KICAgIEZpeGVzOiAwMTFkODI2MTExNzIgKCJSQVM6IEFkZCBhIENvcnJlY3RlZCBF
cnJvcnMgQ29sbGVjdG9yIikNCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVz
LWFib3V0LW5ldGlxdWV0dGUNCg==

