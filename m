Return-Path: <linux-edac+bounces-5616-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F41D11A39
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07263069D68
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jan 2026 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60184275AE8;
	Mon, 12 Jan 2026 09:52:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580F23EAB8;
	Mon, 12 Jan 2026 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211560; cv=none; b=MpnQP52nPGX8d+Ov0pL+yLiiHxexaGhwKFcL9kKVioSqJZoJ4cbWkR+ozt4XacFgbLCxOJfnHog/IfYjAK+hb+e4V/Ms0xrECzlcrE/wFUwyc/XFeRPkSB4SwM6HeRgRX5JrElsFnc92Alu3G+2qgD2HsdK69dljMhsazF4mjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211560; c=relaxed/simple;
	bh=TvoK0dKnie9Xkwfq4BqI6FB+GnIfPeIZX33/pdXyYe4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeOStCKxa/H5xr/2KbyTGDwcj2jCwxedkr5TqAn08AxtvEoUXsRtbbuKaOyIKQ9zg4tk/E2WEwivN7vrp9lu7MhIX9tTTsLAATEjeqz9BNWO+vK4EMdRuN7s4HoHSGccsg7vkdO6YzdkfOdZ8mooksA5t8Xm+1Ofufs0BNNadpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik
	<avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNlOiBG?=
 =?utf-8?B?aXggdGltZXIgaW50ZXJ2YWwgYWRqdXN0bWVudCBhZnRlciBsb2dnaW5nIGEg?=
 =?utf-8?Q?MCE_event?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0geDg2L21jZTogRml4IHRpbWVy?=
 =?utf-8?Q?_interval_adjustment_after_logging_a_MCE_event?=
Thread-Index: AQHcg51apqteKEUlTE6A1cyDr3var7VNtWyAgACQpxA=
Date: Mon, 12 Jan 2026 09:36:21 +0000
Message-ID: <56d12335986e41da81581ef724742319@baidu.com>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
In-Reply-To: <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
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
X-FEAS-Client-IP: 172.31.3.13
X-FE-Policy-ID: 52:10:53:SYSTEM

PiANCj4gT24gMTIuMDEuMjYg0LMuIDEwOjI3INGHLiwgbGlyb25ncWluZyB3cm90ZToNCj4gPiBG
cm9tOiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4NCj4gPiBTaW5jZSBj
b21taXQgMDExZDgyNjExMTcyICgiUkFTOiBBZGQgYSBDb3JyZWN0ZWQgRXJyb3JzIENvbGxlY3Rv
ciIpLA0KPiA+IG1jZV9ub3RpZnlfaXJxKCkgaW4gc2hvdWxkX2VuYWJsZV90aW1lcigpIGFsd2F5
cyByZXR1cm5zIGZhbHNlIGV2ZW4NCj4gDQo+IHNob3VsZF9lbmFibGVfdGltZXIgZG9lc24ndCBj
YWxsIG1jZV9ub3RpZnlfaXJxDQo+IA0KPiA+IHdoZW4gYW4gTUNFIGV2ZW50IGlzIGxvZ2dlZCwg
YmVjYXVzZSBiaXQgMCBvZiBtY2VfbmVlZF9ub3RpZnkgaXMgbm90DQo+ID4gc2V0IGluIG1jZV9s
b2cuIFRoaXMgcHJldmVudHMgdGhlIHRpbWVyIGludGVydmFsIGZyb20gYmVpbmcgcHJvcGVybHkN
Cj4gPiBhZGp1c3RlZC4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IG1vZGlmeWluZyBtYWNoaW5lX2No
ZWNrX3BvbGwoKSB0byByZXR1cm4gYSBib29sZWFuDQo+ID4gaW5kaWNhdGluZyB3aGV0aGVyIGFu
IE1DRSB3YXMgbG9nZ2VkLCBhbmQgdXBkYXRlIG1jX3BvbGxfYmFua3MoKSB0bw0KPiA+IHByb3Bh
Z2F0ZSB0aGlzIHJldHVybiB2YWx1ZS4gVGhlIHRpbWVyIGludGVydmFsIGxvZ2ljIGluDQo+ID4g
bWNlX3RpbWVyX2ZuKCkgbm93IHVzZXMgdGhpcyByZXR1cm4gdmFsdWUgZGlyZWN0bHkgaW5zdGVh
ZCBvZiByZWx5aW5nIG9uDQo+IG1jZV9ub3RpZnlfaXJxKCkuDQo+IA0KPiBUaGlzIHdhcnJhbnRz
IGEgYml0IG1vcmUgZXhwbGFuYXRpb24gd2h5IGl0J3MgY29ycmVjdC4gQmVjYXVzZSBtY2Vfbm90
aWZ5X2lycSBpcw0KPiByZWFsbHkgYSBtaXNub21lciwgaXQgd2lsbCBpZGVhbGx5IGJlIG5hbWVk
IG1jZV9ub3RpZnlfdXNlcigpLiBUaGF0IGZ1bmN0aW9uIGlzDQo+IGNhbGxlZCBmcm9tIDIgcGxh
Y2VzOg0KPiANCj4gMS4gRWFybHkgbm90aWZpZXIgYmxvY2ssIGJ1dCB0aGVyZSBpdCdzIGd1YXJh
bnRlZWQgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nIGFzDQo+IG1jZV9uZWVkX25vdGlmeSBpcyBleHBs
aWNpdGx5IHNldC4NCj4gDQo+IDIuIEZyb20gdGhlIHRpbWVyIGZ1bmN0aW9uLCB3aGVyZSBhcyB5
b3UgaGF2ZSBwb2ludGVkIG91dCBtY2VfbmVlZF9ub3RpZnkgaXMNCj4gbmV2ZXIgc2V0IGJ5IHRo
ZSBwb2xsaW5nIGNvZGUsIGhlbmNlIHRoZSBmdW5jdGlvbiBpcyBhIG5vb3AuIEJ1dCBhY3R1YWxs
eSBjYWxsaW5nDQo+IG1jZV9sb2coKSBwcm9jZXNzZXMgYWxsIGxvZ2dlZCBlcnJvcnMgaW4gdGhl
IGdlbiBwb29sIGFuZCB0aGF0IGlzIHByb2Nlc3NlZCBieQ0KPiBjYWxsaW5nIHRoZSB4ODZfbWNl
X2RlY29kZXJfY2hhaW4gd2hpY2ggd2lsbCBEVFJUIHcuci50IHRvIG1jZV9ub3RpZnlfaXJxDQo+
IHNpbmNlIHRoZSBlYXJseSBub3RpZmllciB3aWxsIGJlIGNhbGxlZCBmcm9tIHRoZXJlLg0KPiAN
Cj4gPHNuaXA+DQoNCk9rLCBJIHdpbGwgYWRkIG1vcmUgZXhwbGFuYXRpb24sIGFuZCByZW5hbWUg
bWNlX25vdGlmeV9pcnEoKSBhcyBtY2Vfbm90aWZ5X3VzZXIoKTsNCg0KVGhhbmtzDQoNCi1MaQ0K
DQoNCg==

