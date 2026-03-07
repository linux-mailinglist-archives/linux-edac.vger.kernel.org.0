Return-Path: <linux-edac+bounces-5780-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI7XJj19q2lUdgEAu9opvQ
	(envelope-from <linux-edac+bounces-5780-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 02:19:57 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64422952C
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 02:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB3393024A38
	for <lists+linux-edac@lfdr.de>; Sat,  7 Mar 2026 01:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF7296BDC;
	Sat,  7 Mar 2026 01:19:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E21CAA6C;
	Sat,  7 Mar 2026 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846393; cv=none; b=ZiC44pcheDlmdyCchSRxmncYXKKG+KLLFVJJSBvu5OK3LlZvfueUlWCZZW75QOODuBJRAX6q8LIeHMaB03NUgqUmbsdfPDzdWNj9OsnnWLO7iMRfD1/zO9UqYlWC3qAR83WlqWJ0TpUbZYa2PfRUKQLu5fks9XF4mPJNSgYlsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846393; c=relaxed/simple;
	bh=H93Mks/eCNSVk3gYjm3aqT8y81Nt7Rb9Fn7J8+v0VzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUJYOulDh25RWjwxyfI0OcpTak/JPVzdMa+HPnjq8RIxtnzMHZRbGJXvrwptkPwfDkok2k729veObzOm+9Rnby62Mt5eAWey19ISQZP7zdUKTHrFatb/slFhSsgpov+nF20VcgIM0DXgnYU67+MV7jj1GgFSbCSVUhtsVi1Tk4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQ?=
 =?utf-8?B?QVRDSF0geDg2L21jZTogRml4IHRpbWVyIGludGVydmFsIGFkanVzdG1lbnQg?=
 =?utf-8?Q?after_logging_a_MCE_event?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIHg4?=
 =?utf-8?B?Ni9tY2U6IEZpeCB0aW1lciBpbnRlcnZhbCBhZGp1c3RtZW50IGFmdGVyIGxv?=
 =?utf-8?Q?gging_a_MCE_event?=
Thread-Index: AQHcmp5Dzqz6YDwr30OsiY5+cifXvLWhQmRw///lcYCAAJB84P//iEKAgAEqi7A=
Date: Sat, 7 Mar 2026 01:18:50 +0000
Message-ID: <ee87e4cb35624a5cb85741725bfbcbd0@baidu.com>
References: <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
 <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
 <20260207115142.GBaYcnTp7maUDVv3Nc@fat_crate.local>
 <aYobX83_0kElO3NZ@agluck-desk3>
 <20260210150117.GBaYtIPfsP0Txw7iIc@fat_crate.local>
 <3748e8c7057a4182bc2a361b44dda51b@baidu.com>
 <E4BFF14D-85CC-44FA-A217-603C102B1D66@alien8.de>
 <3431b52760444d209f8460059264cc13@baidu.com>
 <20260306152903.GEaaryvxD9BTT7Fd10@fat_crate.local>
In-Reply-To: <20260306152903.GEaaryvxD9BTT7Fd10@fat_crate.local>
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
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Queue-Id: 1C64422952C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-5780-lists,linux-edac=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.902];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email,amd.com:email,alien8.de:email,intel.com:email]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEJvcmlzbGF2IFBldGtv
diA8YnBAYWxpZW44LmRlPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQz5pyINuaXpSAyMzoyOQ0K
PiDmlLbku7bkuro6IExpLFJvbmdxaW5nKEFDRyBDQ04pIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4N
Cj4g5oqE6YCBOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgTmlrb2xheSBCb3Jp
c292DQo+IDxuaWsuYm9yaXNvdkBzdXNlLmNvbT47IFRob21hcyBHbGVpeG5lciA8dGdseEBrZXJu
ZWwub3JnPjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlIEhhbnNlbiA8
ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsNCj4geDg2QGtlcm5lbC5vcmc7IEggLiBQZXRl
ciBBbnZpbiA8aHBhQHp5dG9yLmNvbT47IFlhemVuIEdoYW5uYW0NCj4gPHlhemVuLmdoYW5uYW1A
YW1kLmNvbT47IFpodW8sIFFpdXh1IDxxaXV4dS56aHVvQGludGVsLmNvbT47IEF2YWRodXQNCj4g
TmFpayA8YXZhZGh1dC5uYWlrQGFtZC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZw0KPiDkuLvpopg6IFJlOiDnrZTlpI06IOet
lOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0geDg2L21jZTogRml4IHRpbWVyIGludGVy
dmFsDQo+IGFkanVzdG1lbnQgYWZ0ZXIgbG9nZ2luZyBhIE1DRSBldmVudA0KPiANCj4gT24gRnJp
LCBNYXIgMDYsIDIwMjYgYXQgMDI6Mzg6MjlQTSArMDAwMCwgTGksUm9uZ3FpbmcoQUNHIENDTikg
d3JvdGU6DQo+ID4gV2UgYW50aWNpcGF0ZSBwb3RlbnRpYWwgVUUgaXNzdWVzIGJ5IGFuYWx5emlu
ZyB0aGUgdm9sdW1lIGFuZA0KPiA+IGZyZXF1ZW5jeSBvZiBjb2xsZWN0ZWQgQ0UgcmVwb3J0cywg
ZW5hYmxpbmcgdXMgdG8gcGVyZm9ybSBwcm9hY3RpdmUNCj4gPiB0YXNrIG9mZmxvYWRpbmcgYW5k
IG1hY2hpbmUgbWFpbnRlbmFuY2UuIEhvd2V2ZXIsIGluYWNjdXJhY2llcyBpbiB0aGUNCj4gPiBj
b2xsZWN0ZWQgZGF0YSBhcmUgY3VycmVudGx5IHVuZGVybWluaW5nIHRoaXMgYXBwcm9hY2gsIG1h
a2luZyBpdA0KPiA+IGRpZmZpY3VsdCB0byByZWxpYWJseSBwcmVkaWN0IFVFIGluY2lkZW50cy4N
Cj4gDQo+IFRoaXMgbG9va3MgbGlrZSBhIGNhbm5lZCBBSSByZXBseSB0byBtZS4NCj4gDQo+IEkg
dGhpbmsgeW91IHdhbm5hIHNheSwgeW91IHdhbnQgdG8gZ2V0ICpldmVyeSogc2luZ2xlIGVycm9y
IGxvZ2dlZC4gWWVzPw0KPiANCj4gU28geW91IHdhbnQgdG8gYmUgYWJsZSB0byBkZWNyZWFzZSB0
aGUgcG9sbGluZyBpbnRlcnZhbCBpZiBuZWNlc3Nhcnk/DQo+IA0KPiBEbyB5b3UgYWxzbyBkaXNh
YmxlIHRoZSBSQVMgQ0VDPw0KPiANCg0KQ0VDIG1heSBub3Qgd29yayBpbiBzb21lIGNhc2VzLiBG
b3IgZXhhbXBsZSwgd2hlbiBRRU1VIHVzZXMgdkRQQSBkZXZpY2VzLCBhbGwgb2YgUUVNVSdzIG1l
bW9yeSBpcyBwaW5uZWQgYW5kIGNhbm5vdCBiZSBvZmZsaW5lZC4gaHVnZXRsYmZzIGhhcyBvbmx5
IHJlY2VudGx5IGdhaW5lZCBzdXBwb3J0IGZvciBvZmZsaW5lIG9wZXJhdGlvbnM7IG9mZmxpbmlu
ZyBodWdldGxiZnMgY2FuIGNhdXNlIGlzc3Vlcy4gVGhlIGtlcm5lbCBwcm92aWRlcyBhbiBpbnRl
cmZhY2UgdG8gZGlzYWJsZSBvZmZsaW5lLCBhcyByZWZlcmVuY2VkIGluIHRoZSBwYXRjaCAibW0v
bWVtb3J5LWZhaWx1cmU6IHVzZXJzcGFjZSBjb250cm9scyBzb2Z0LW9mZmxpbmluZyBwYWdlcy4i
IA0KQW5kIGV2YWx1YXRpbmcgQ29ycmVjdGFibGUgRXJyb3JzIChDRSkgaW4gdXNlcnNwYWNlLCBt
b3JlIHBhcmFtZXRlcnMgY2FuIGJlIGNvbnNpZGVyZWQsIHN1Y2ggYXMgbWVtb3J5IG1hbnVmYWN0
dXJlciwgYmF0Y2gsIGFuZCBmcmVxdWVuY3ksIHRvIGltcHJvdmUgcHJlZGljdGlvbiBhY2N1cmFj
eSANCg0KDQpbTGksUm9uZ3FpbmddIA0KDQoNCj4gVGh4Lg0KPiANCj4gLS0NCj4gUmVnYXJkcy9H
cnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4
L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg==

