Return-Path: <linux-edac+bounces-5771-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALqTDGOEqmnRSwEAu9opvQ
	(envelope-from <linux-edac+bounces-5771-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 08:38:11 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C654421C883
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 08:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD0E63005994
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63B374746;
	Fri,  6 Mar 2026 07:38:07 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3A33689D;
	Fri,  6 Mar 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782687; cv=none; b=KCUokHl5FymO32fPqPJomQjx4b5I5F3Vcs0SjBSwFQd8grym33bTnGIO+hDrgx7fZJhXuFoe7UMqAqso6Vq/dBBCUqWfFbDFtxXH69TYl6Rxo+9DXXqIcknQvjBkVRhlEYj/sPk2k/GopLtY7P1W87O/S8WVwMSHd2/Xk+RJaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782687; c=relaxed/simple;
	bh=7NhCUoUy6YRN7jBoJ5i8+xVJ+VcMPlnHnxaFEo9rvmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2clk1OVkz8F4eLQMBRfBB9Vju4YYq3z221ewuj9HEaKk2r3MAP/+ooN0ak8t4IBKsDgMvhl5Z4JE/crAMs6ju4llN+02b5V0uhoDt0Qk4lyqfSs6t7ztCInUTh9jP6h5kmOUER+krw242VtJPSVVezKrXKyYcyQN/wKwW9H+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNlOiBG?=
 =?utf-8?B?aXggdGltZXIgaW50ZXJ2YWwgYWRqdXN0bWVudCBhZnRlciBsb2dnaW5nIGEg?=
 =?utf-8?Q?MCE_event?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0geDg2L21jZTogRml4IHRpbWVy?=
 =?utf-8?Q?_interval_adjustment_after_logging_a_MCE_event?=
Thread-Index: AQHcmp5Dzqz6YDwr30OsiY5+cifXvLWhQmRw
Date: Fri, 6 Mar 2026 07:37:01 +0000
Message-ID: <3748e8c7057a4182bc2a361b44dda51b@baidu.com>
References: <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
 <20260207115142.GBaYcnTp7maUDVv3Nc@fat_crate.local>
 <aYobX83_0kElO3NZ@agluck-desk3>
 <20260210150117.GBaYtIPfsP0Txw7iIc@fat_crate.local>
In-Reply-To: <20260210150117.GBaYtIPfsP0Txw7iIc@fat_crate.local>
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
X-FEAS-Client-IP: 172.31.50.45
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Queue-Id: C654421C883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-5771-lists,linux-edac=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

PiBXZWxsLCB3aGF0IGFib3V0IENNQ0k/IEFNRCBoYXMgc2ltaWxhciBpbnRlcnJ1cHQgdHlwZXMu
IFRob3NlIGhhbmRsZXJzIGVuZCB1cA0KPiBpbiB0aGUgc2FtZSBwYXRoIG9mIG1hY2hpbmVfY2hl
Y2tfcG9sbCgpIGFuZCB0aGUgYWJvdmUgc2NlbmFyaW8gY2FuIGhhcHBlbiwNCj4gQUZBSUNULg0K
PiANCj4gPiBJIGRvbid0IHRoaW5rIHdlIGNhcmUuIElmIHdlIG1pc3Mgb3V0IGhhbHZpbmcgdGhl
IGludGVydmFsIGJlY3VhdXNlIGFuDQo+ID4gZXJyb3Igd2FzIGxvZ2dlZCBiZXR3ZWVuIHRpbWVy
IGJhc2VkIHBvbGxpbmcsIG5vdGhpbmcgcmVhbGx5IGJhZCB3aWxsDQo+ID4gaGFwcGVuLiBUaGUg
aW50ZXJ2YWwgbWlnaHQgZ2V0IHNvcnRlZCBvdXQgb24gdGhlIG5leHQgaW50ZXJ2YWwuDQo+IA0K
PiBSaWdodCwgdGhhdCdzIHdoYXQgSSdtIHRoaW5raW5nIHRvby4NCj4gDQo+ID4gVW5sZXNzIHNv
bWVvbmUgaGFzIGEgcmVhbCB3b3JsZCBjYXNlIHdoZXJlIHNvbWV0aGluZyBpcyBnb2luZyBiYWRs
eQ0KPiA+IHdyb25nLCB0aGVuIEkgZG9uJ3QgdGhpbmsgYW55IGNoYW5nZXMgYXJlIG5lZWRlZCB0
byBjb3ZlciB0aGlzIHJhY2UuDQo+IA0KPiBPaywgbGV0J3MgdHJ5IHRoZSBzaW1wbGUgdGhpbmcg
Zmlyc3QuDQo+IA0KPiBUaHguDQoNCklzIHRoZXJlIGFueSBwcm9ncmVzcyBvbiB0aGlzPw0KDQpU
aHgNCg0KW0xpLFJvbmdxaW5nXSANCg0KDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAg
ICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJv
dXQtbmV0aXF1ZXR0ZQ0K

