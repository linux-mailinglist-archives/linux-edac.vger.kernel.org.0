Return-Path: <linux-edac+bounces-5753-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK2aBSCHoGlSkgQAu9opvQ
	(envelope-from <linux-edac+bounces-5753-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 18:47:12 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A823C1ACCFB
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 18:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9CEA32561CD
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BC43E492;
	Thu, 26 Feb 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qOSgt1Xt"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4943DA59;
	Thu, 26 Feb 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124750; cv=fail; b=I1oO5wu+JvKXRhuf87yDRVLcxUhNEsNkPJAbvqGp8MT3DgdCLLOL4upXJkFFpWD5LnNxaISUDaTw5u/Ej7PMWLcmn202tpspXWnpQm5HoLbXB80RdAOibl+1p1BQVHcoRqRDqSFS7Aex24wnDAVAkY24w2cTqU8/lDlHEsw0/K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124750; c=relaxed/simple;
	bh=bfFiVt04FTPWKv1Fk37Jhp3nseJH7kg6A3rRtWVzvvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UEiuhzc0DPR6Wt82nx/P8dQEWXw0yJbBPICobbBr5Js+4oLp4qUkZ6JuSV1myJDnd6wxwdN4sz1zC79tz9iE7gCL4Phu3GfybUVmYbSyyqEfA3WpsNBCaU1/cotm6vcr6LigOh6601RkufuoqexBdtTvzyD6ahGEbvpX4+Cwvew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qOSgt1Xt; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGGIus80q/y252gedVMTfh6/dtJG16q6OgCH/fJKILiajn2XjYkxUCiT0SGsXUM8jeHHxtS0Ddrt98DrFARiRpIA3DQgwqIC0ZEzcqoKVbpioTLa6MYw0lSuXPUgu5K5HsPpFhjeeYIPdmp4/Yu18SJ5z0bai8VfaeIc7p2rTlE92mVaX9w8QXxUL9O0Bs4/VG2vYLO3rwVEnG/DLKAzkqpQ4Avb65fpFbapUyDmvxTqzjFPrpoDI2ma7NctAeT08IGQuAFkmGrX/SjpQL29sBI7c2YbFzovEHcpCmvwdDuQVAmRyPAN8IvpvTPLm49RJp/LbywUeeWV/xro/Bpn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfFiVt04FTPWKv1Fk37Jhp3nseJH7kg6A3rRtWVzvvw=;
 b=p5LONqsfyqwoFNIz0jZiYXIcgpulVZy3UwInQRXp/ob9VCdfTYXMvM6Be12DaD/6fh6nTwNlCjcR3z8eHbqCX1RqXZSCoNKznQDTSdTgVjbe636eGGvvVG+0MbFzI/QUbK/+UPRx2GAy2J2KEnML5NanPADGqdBHsGH1ZioKmjOYsRnKdbu5BlvHBSPRV9byuZagVp/e2+bUVMS04L77gqu3dd+F/7DkAvXrfkOpFmLe1Wq9QvwII+jFSCSifXIHpub9kISfJJBFkqv7Pl1rhlvJTzMYzvIZxKfqGx7MKS10/04opkt8jnA0ralnDJ2MfXmnnXir8V9KWnNSsq+aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfFiVt04FTPWKv1Fk37Jhp3nseJH7kg6A3rRtWVzvvw=;
 b=qOSgt1XtI+T/r5mz1cDR4UDXJbSOzbAbeCPd1QIph+/sYugolSTHVaL6W9j1jM2wMDwyTMof/r1B1a9vAuQaLfBkUFy6m3nsFWcEksHSRkcPnGPQXr6y8rfOWvPj4plOZaIDkL9nMzeS1oIpGnxtCz/j3XzAPXODKfiEjXsR+xU=
Received: from LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:52:25 +0000
Received: from LV5PR12MB9828.namprd12.prod.outlook.com
 ([fe80::f132:7e75:fd38:8685]) by LV5PR12MB9828.namprd12.prod.outlook.com
 ([fe80::f132:7e75:fd38:8685%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:52:25 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>, Eric-Terminal <ericterminal@gmail.com>
CC: Tony Luck <tony.luck@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/versalnet: Fix resource leaks and NULL derefs in
 init_versalnet()
Thread-Topic: [PATCH v2] EDAC/versalnet: Fix resource leaks and NULL derefs in
 init_versalnet()
Thread-Index: AQHcpxMp/LShkz49+UOGTiZW+FQR2LWU8VkAgABA3pA=
Date: Thu, 26 Feb 2026 16:52:24 +0000
Message-ID:
 <LV5PR12MB9828D20D0DFD1B03C2E8A67C8172A@LV5PR12MB9828.namprd12.prod.outlook.com>
References:
 <DS2PR12MB9821250527F466180B16ACE38172A@DS2PR12MB9821.namprd12.prod.outlook.com>
 <20260226112907.76971-1-ericterminal@gmail.com>
 <20260226125932.GAaaBDtCAp5ueJVTib@fat_crate.local>
In-Reply-To: <20260226125932.GAaaBDtCAp5ueJVTib@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-26T16:51:42.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR12MB9828:EE_|DS7PR12MB6024:EE_
x-ms-office365-filtering-correlation-id: c0acc6c8-ceeb-42ee-6925-08de75576aef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 kyAPsm9D3MwgnLDtSFfdpWavVCHBasuBufEnfNbpL/CxrLbw0+7UsgMK2SeLpnSiqE53LQYIF0oN9WMNnJWLTlymogLQYePGJz2mg9JxVF3N67ZY1oo23hZGwIl1z8UPS9r+E62Ldr8BdjFg+D/iNY4mz6iSSHgFXKPHKobMxHyqcOAV0WGETYKUeDxR+p/anTCSNb9lBrFCPt6wYJHXmson7dXaRJIvgOcFNrn/cUrfcoKAyg16KH6Pgpa2U/78KXfebx0xUrWyTfS7i+5/N0yboNY39ujIYwBL4+VSBT+e2HZ8RD6OhXzDHkYPezwIUI0ipoEFX9jXkft99ouNuzwFqhj3E8GUxmC+Mablf1JiKgCeoGDKQrhOLOHjIlUBnmKHagKrvZ/stJo7GtJq4gdIlmcZqdWgpgC9ke9xGBp3oKtBz89h8fQEiE9ZMcWzZp3asrMpRLRPfckkqmR4N/M4anCtJxrKjO6f0tIjDvAQiszLpxW00KFZZFLA7t3IYjHAVXlls8M5MfvwLWa6/br77DJ5VhW9vUydpAfDWf248uLziABI0GhGWK+Vc3oIflJ6l+HdtStHF8jNFh7hDfYRel06roJ9srgw1RbVEc4r6zZ1Z2ozpe4MlA3CLnQoRLz5Cu6eEZHethicyNsko4yk7DdbRyuf6Tlw0M6rxcltuoiKq7dzOR9Cp0Ye6x7yn+k/IfaA8Wa7lXfSx7dNEUIYAROeW4NYxkLZMsAWIzvmfWOEwMowffpkUdA6itLF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9828.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0x4MmQ1QllBZ1YxV2hPa1oxR3k0VjRWRUphT281ZGVkT3pJdWdBRlVYeURp?=
 =?utf-8?B?R3Q4Q2c3VEh6SUpPZVo4YTFtaUUxT05SSi9BMmtaWU85aXRqeVJCSlQ5Y2ky?=
 =?utf-8?B?SGlUUmZLeUswLzREV2g3Z3lCa2UvalE1ZEx1bktJUUI3UWM5dUs5eTJsaDRJ?=
 =?utf-8?B?UmZjZ2VFaXd2MG11SUE5ZEZkMG54eXBSNExJRHF0cUxoUHQ5NkxXZHRxSnl4?=
 =?utf-8?B?bC9PcW5uSWlXcGcvZ3BwbkJVRmRpWTZmZ3lEc21TRXpYSTBCeXpYK0pxWXdG?=
 =?utf-8?B?NjRudmJQTG5SSFIyQzgrOGFOTStlck9vNUk3cWZzWUNVcEJ3NWJUSzdjK3NN?=
 =?utf-8?B?VjB3Q2xYeTdCdWFqSTZpZEl3aWxVSXB4cmRMQWR5VlN2SWtpU2lNbm5pM2tB?=
 =?utf-8?B?MlhaYVlWZFBaZ2lJVFNXdUxNSmJpaVh0VUFzSjVHQUNoSCtlMjhRMG5rWHRz?=
 =?utf-8?B?c0dUNGdvVmFkam04aERnQUtsaWgwSWhMQzZuMVlCNjEvbVBlcTJoNVhOQzNG?=
 =?utf-8?B?REcwclVXOUVSMld2YlNnUGN2U2Q4VEwrb05nMmsyYjVCZEs2dFErcjVESkcx?=
 =?utf-8?B?MmdTQzg5OW5GcE84NzdGSi9pQStidmRUZEhUWkljY0FBajlPS2RZOG5iM05n?=
 =?utf-8?B?U2VrNWtiandCOEVLc0ZGWk1rMitHNjN1NSt1dXN0Ym1CVzFpOGVydWMwaWw0?=
 =?utf-8?B?ZXJIaTVnRTFPTjhnMUlnc1c0a05TNUt3V2RuNGN2blJFVW1oOEVLbStFcFVU?=
 =?utf-8?B?akNkN1Nqb21qWFdwaUkzbDFOR1VqbGRtcEh0QjBTWjg2Q2VBVmIzQTY3Rldx?=
 =?utf-8?B?NE1ya0lLRm9jK3F5T3U1eTIxUUFjMmNFdmZNdkswZ3V2dHNWSmNFQWdWa1Jn?=
 =?utf-8?B?dHZSS1VJcXQ1ZkNpd3hGTlBCcVF6TWt3bmcwVnNoVFVpTnpKaFFEaERuLzZz?=
 =?utf-8?B?b3JJSEZ5L1c5OXJucjZFVW5wT0tMU3JMc2NDRjJpOG1OMzJPMnphdzFReTA0?=
 =?utf-8?B?M0NnUGVQcFkzcFBWNkFkcmpCbVFTWjZMYmw4RmJuQks0WTFJZStKWWFJRWlq?=
 =?utf-8?B?bDgrZ01NWTF5QUhzdnRIUXZGa3RIb2lrNjFWK1NqSS9DcUFrR2lROWVyZk1Q?=
 =?utf-8?B?cVFLRTgvS29QMXR4SlMzZmZ1d3BqbkFCM1RsbEtCWmNJWk55WCtUa2xaOU9D?=
 =?utf-8?B?SDlBbWFXMjFKdDZqeDAzWFNRMkhxV2h6a3pucCtOYVlzWWplQi9ickVsUm1q?=
 =?utf-8?B?elJ0TXF4cjl1bCsyR2JvWVhPOXpOK2hDVENlTnVtN2F4WVFSVUpjR0J3Sk9x?=
 =?utf-8?B?Rm9VNXI1bGVVamxJWGlpcHFpVXU3ZEVkNVF3TGNiRjdIZlhadHVOelgrZ3FL?=
 =?utf-8?B?Y0RpUFBQWTc3RGVrTEhOWmNQeFlIc0JBYWNNUDdFdzJYTmdFaFZnbElVUkVE?=
 =?utf-8?B?akxrZlBkdytJWXc5YWRMTHR5QlhCVHlTODZ1Y24yeFdSNFFUelNxYlh5aDlH?=
 =?utf-8?B?MTlBMWYxTjVqak0yMVlmVDFoWTZSTFlaT00wRWR0UjZEMk9PdzNlUFA3Mk9F?=
 =?utf-8?B?ZTlJVDIxZ1JRY3cyKzNiQVBtQkdyb2twVjc1ODRkUHJ0N1lPZS9aZXJJakRV?=
 =?utf-8?B?cHhCTlA1b3NwdFFLaFgxNnlrKzlvbmFYbWkzblQrVVhLRnFuYUV2d29VOGNi?=
 =?utf-8?B?VHJza1Z4bmU5a0VrWmdXTUpISGpWVlhrNVBNMm5JaWJaS3lUWks0QzNJeUhM?=
 =?utf-8?B?Qms1c3NFZXlIcXpoMjRRWE1ESnJCUXlUbW9NM2s5SXVLT1d4OERsdi9Td2Fh?=
 =?utf-8?B?MGhNOVJPdmJUSHNXeE0vYXhLYkZsekFKWGtMUWFrQ2h1dU1KUnJkQVdQU01R?=
 =?utf-8?B?VEk5QjI3aHpCUXZvNi84SUk4eXUwRXdBQ051UFZHaHVxSUw3TGVXbitsaUlV?=
 =?utf-8?B?NlhGeHJhQUJsVHo5d0ZSdHJjYnRQMng0b29OaFZPbnQrczlTQmVzUkRhOFV2?=
 =?utf-8?B?NElHZXllMzVOdXpFZ05nSExyWktVeWh0Y25JdjZKOGsyWkI0cFhmdW8xNGRN?=
 =?utf-8?B?Ri9QMEpCOExNdnJrd0VCdTJGSm92aEZkNEdEeGxhemwrR3M0OUtUdDlEdmFi?=
 =?utf-8?B?OWVLY2xiQzkvaFM0OUZ2M05LYlB6VG5adDQ1VXZHTEpLcUE3LzdHcmJ2VDJz?=
 =?utf-8?B?eDNlOGpyTXc2STlJZDNYZmw0RWFuTzlwRTZXUnJnblJRS1d5eVJZTWJUL09B?=
 =?utf-8?B?eHhhKzh0RFh1R3dFd2ZoVStHSXllb1RaamZLazI1OFpFV25pV2pQczlOa1Bq?=
 =?utf-8?Q?cXgJl078pDuzN6PdaY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9828.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0acc6c8-ceeb-42ee-6925-08de75576aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 16:52:24.9283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64t30BssXIG5kxBFqBcHe/zYITxJ+8IT2RYJT7N3oTe348J5WYPL0GfH49rgQZJZ1Jg52U84IxwnHCHIqatxqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[alien8.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-5753-lists,linux-edac=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubhrajyoti.datta@amd.com,linux-edac@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,LV5PR12MB9828.namprd12.prod.outlook.com:mid,intel.com:email,amd.com:email,amd.com:dkim]
X-Rspamd-Queue-Id: A823C1ACCFB
X-Rspamd-Action: no action

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI2LCAyMDI2IDY6MzAg
UE0NCj4gVG86IEVyaWMtVGVybWluYWwgPGVyaWN0ZXJtaW5hbEBnbWFpbC5jb20+DQo+IENjOiBE
YXR0YSwgU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT47IFRvbnkgTHVj
aw0KPiA8dG9ueS5sdWNrQGludGVsLmNvbT47IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBFREFDL3ZlcnNhbG5ldDogRml4IHJlc291cmNlIGxlYWtzIGFuZCBOVUxMIGRlcmVmcyBpbg0K
PiBpbml0X3ZlcnNhbG5ldCgpDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVk
IGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4g
T24gVGh1LCBGZWIgMjYsIDIwMjYgYXQgMDc6Mjk6MDdQTSArMDgwMCwgRXJpYy1UZXJtaW5hbCB3
cm90ZToNCj4gPiBGcm9tOiBZdWZhbiBDaGVuIDxlcmljdGVybWluYWxAZ21haWwuY29tPg0KPiA+
DQo+ID4gaW5pdF92ZXJzYWxuZXQoKSBoYXMgc2V2ZXJhbCBidWdzIGluIGl0cyBlcnJvciBoYW5k
bGluZy4ga3phbGxvYygpIGFuZA0KPiA+IGttYWxsb2MoKSByZXR1cm4gdmFsdWVzIGFyZSB1c2Vk
IHdpdGhvdXQgTlVMTCBjaGVja3MsIGNhdXNpbmcgYSBOVUxMDQo+ID4gcG9pbnRlciBkZXJlZmVy
ZW5jZSB3aGVuIGFsbG9jYXRpb24gZmFpbHMuIFRoZSBjbGVhbnVwIGxvb3AgdXNlcyB3aGlsZQ0K
PiA+IChpLS0pIHdoaWNoIHNraXBzIHRoZSBjdXJyZW50IGZhaWxpbmcgaW5kZXgsIGxlYWtpbmcg
dGhlIHJlc291cmNlcw0KPiA+IGFscmVhZHkgYWxsb2NhdGVkIGZvciB0aGF0IHNsb3QuIGVkYWNf
bWNfZGVsX21jKCkgaXMgY2FsbGVkDQo+ID4gdW5jb25kaXRpb25hbGx5IGR1cmluZyB1bndpbmQs
IGV2ZW4gZm9yIGNvbnRyb2xsZXJzIHRoYXQgd2VyZSBuZXZlcg0KPiA+IHJlZ2lzdGVyZWQgd2l0
aCBlZGFjX21jX2FkZF9tYygpLiBBbHNvLCBzcHJpbnRmKCkgaXMgdXNlZCBpbnN0ZWFkIG9mDQo+
ID4gc25wcmludGYoKSBvbiBhIGZpeGVkLXNpemUgYnVmZmVyLg0KPiA+DQo+ID4gRml4IGJ5IGFk
ZGluZyBOVUxMIGNoZWNrcyBmb3IgZGV2IGFuZCBuYW1lIGFsbG9jYXRpb25zLCByZXBsYWNpbmcN
Cj4gPiB3aGlsZSAoaS0tKSB3aXRoIGZvciAoaiA9IGk7IGogPj0gMDsgai0tKSB0byBpbmNsdWRl
IHRoZSBmYWlsaW5nDQo+ID4gaW5kZXgsIHRyYWNraW5nIHN1Y2Nlc3NmdWwgZWRhY19tY19hZGRf
bWMoKSBjYWxscyB3aXRoIGEgYm9vbCBhcnJheSwNCj4gPiBhbmQgc3dpdGNoaW5nIHRvIHNucHJp
bnRmKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWZhbiBDaGVuIDxlcmljdGVybWluYWxA
Z21haWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBTaHViaHJhanlvdGkgRGF0dGEgPHNodWJocmFq
eW90aS5kYXR0YUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBDb3JyZWN0IFNpZ25lZC1vZmYt
YnkgbmFtZSBhbmQgYWRkIFJldmlld2VkLWJ5IHRhZy4gRml4IGNvbW1pdCBtZXNzYWdlDQo+IGZv
cm1hdHRpbmcuDQo+ID4NCj4gPiAgZHJpdmVycy9lZGFjL3ZlcnNhbG5ldF9lZGFjLmMgfCAyOSAr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4NCj4gTm8sIHRoYW5rcywgd2UnbGwgZG8gdGhl
IHByb3BlciBjbGVhbnVwIGhlcmU6DQo+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI1MTEwNDA5MzkzMi4zODM4ODc2LTEtDQo+IHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tL1Qv
I3UNCg0KTXkgYXBvbG9naWVzIHNvbWVob3cgSSBoYWQgbWlzc2VkIGl0Lg0KVGVzdGVkIGl0IG9u
IHRoZSBoYXJkd2FyZS4NCj4NCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0K
Pg0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0
ZQ0K

