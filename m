Return-Path: <linux-edac+bounces-5773-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBzVOkLpqmkTYAEAu9opvQ
	(envelope-from <linux-edac+bounces-5773-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 15:48:34 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCB3223097
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0628630B89D9
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD539C637;
	Fri,  6 Mar 2026 14:40:03 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240152848B2;
	Fri,  6 Mar 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808003; cv=none; b=EtyoIJoWnmIVOK52Kh3IYwb/cGpX7qTniwslzbueF0bRsFbgzvdFC4Leg3QGJbJotfEVTjgD5PZmsJLfG9T0gpgPYE9OI1rSVp9UE4j7HDQupZmsOecIQzPQPgqPgqGBehTq1RMkWKrHZn5Q8Pp3uP/4sQZYs6XosMx7Xo6hd1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808003; c=relaxed/simple;
	bh=pSK+uKl5ymQ/pp5ZOPffVWLqA4eeBtXZkMZelh9FKnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUpOTEULTW8fkfXYlQwveY+kl6pBcGDsVUYHYBnF0q3jopTOZI6lntcFAKBDz9CmdvDuaVcz6D7was4LQMV6BCIDfYGWccT6+u0k87w1DTRhPzCweq/1EvjEf+Is52deaPy6jwRocBxcKMCLFcbMHcRqMchMQ6cjdVXoo5M07GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
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
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIHg4?=
 =?utf-8?B?Ni9tY2U6IEZpeCB0aW1lciBpbnRlcnZhbCBhZGp1c3RtZW50IGFmdGVyIGxv?=
 =?utf-8?Q?gging_a_MCE_event?=
Thread-Topic: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSB4ODYvbWNlOiBG?=
 =?utf-8?B?aXggdGltZXIgaW50ZXJ2YWwgYWRqdXN0bWVudCBhZnRlciBsb2dnaW5nIGEg?=
 =?utf-8?Q?MCE_event?=
Thread-Index: AQHcmp5Dzqz6YDwr30OsiY5+cifXvLWhQmRw///lcYCAAJB84A==
Date: Fri, 6 Mar 2026 14:38:29 +0000
Message-ID: <3431b52760444d209f8460059264cc13@baidu.com>
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
 <3748e8c7057a4182bc2a361b44dda51b@baidu.com>
 <E4BFF14D-85CC-44FA-A217-603C102B1D66@alien8.de>
In-Reply-To: <E4BFF14D-85CC-44FA-A217-603C102B1D66@alien8.de>
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
X-Rspamd-Queue-Id: ADCB3223097
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-5773-lists,linux-edac=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.963];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,intel.com:email,alien8.de:email]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEJvcmlzbGF2IFBldGtv
diA8YnBAYWxpZW44LmRlPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQz5pyINuaXpSAyMjowMA0K
PiDmlLbku7bkuro6IExpLFJvbmdxaW5nKEFDRyBDQ04pIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT47
IEx1Y2ssIFRvbnkNCj4gPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IOaKhOmAgTogTmlrb2xheSBC
b3Jpc292IDxuaWsuYm9yaXNvdkBzdXNlLmNvbT47IFRob21hcyBHbGVpeG5lcg0KPiA8dGdseEBr
ZXJuZWwub3JnPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlIEhhbnNlbg0K
PiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRl
ciBBbnZpbg0KPiA8aHBhQHp5dG9yLmNvbT47IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1A
YW1kLmNvbT47IFpodW8sIFFpdXh1DQo+IDxxaXV4dS56aHVvQGludGVsLmNvbT47IEF2YWRodXQg
TmFpayA8YXZhZGh1dC5uYWlrQGFtZC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiDnrZTlpI06IFvl
pJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIHg4Ni9tY2U6IEZpeCB0aW1lciBpbnRlcnZhbA0KPiBh
ZGp1c3RtZW50IGFmdGVyIGxvZ2dpbmcgYSBNQ0UgZXZlbnQNCj4gDQo+IE9uIE1hcmNoIDYsIDIw
MjYgNzozNzowMSBBTSBVVEMsICJMaSxSb25ncWluZyhBQ0cgQ0NOKSINCj4gPGxpcm9uZ3FpbmdA
YmFpZHUuY29tPiB3cm90ZToNCj4gPklzIHRoZXJlIGFueSBwcm9ncmVzcyBvbiB0aGlzPw0KPiAN
Cj4gTm90IHlldC4NCj4gDQo+IE1heSBJIGFzayB3aGF0IGlzIHlvdXIgdXNlY2FzZSBmb3IgdGhp
cz8gDQoNCg0KV2UgYW50aWNpcGF0ZSBwb3RlbnRpYWwgVUUgaXNzdWVzIGJ5IGFuYWx5emluZyB0
aGUgdm9sdW1lIGFuZCBmcmVxdWVuY3kgb2YgY29sbGVjdGVkIENFIHJlcG9ydHMsIGVuYWJsaW5n
IHVzIHRvIHBlcmZvcm0gcHJvYWN0aXZlIHRhc2sgb2ZmbG9hZGluZyBhbmQgbWFjaGluZSBtYWlu
dGVuYW5jZS4gSG93ZXZlciwgaW5hY2N1cmFjaWVzIGluIHRoZSBjb2xsZWN0ZWQgZGF0YSBhcmUg
Y3VycmVudGx5IHVuZGVybWluaW5nIHRoaXMgYXBwcm9hY2gsIG1ha2luZyBpdCBkaWZmaWN1bHQg
dG8gcmVsaWFibHkgcHJlZGljdCBVRSBpbmNpZGVudHMuDQoNCltMaSxSb25ncWluZ10gDQo+IA0K
PiAtLQ0KPiBTbWFsbCBkZXZpY2UuIFR5cG9zIGFuZCBmb3JtYXR0aW5nIGNyYXANCg==

