Return-Path: <linux-edac+bounces-4579-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE124B26173
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77B73AF993
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B272ECE9A;
	Thu, 14 Aug 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GiOb3/c/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EC2BE7DC
	for <linux-edac@vger.kernel.org>; Thu, 14 Aug 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164751; cv=fail; b=soS1kHeIDVYOKqwWSBMRTQWjoVhhEC/IwQtvMsr11qIGpd0YL98d5HT9UAGAyFk7RORYaldm7VBQqWTmSFX9tVWlV6N7TJ5aaii7RQc7arBv1vVLGQwh1svdUBfdJVSc45kh5ltuZn3mcveG7KzfYuZD2SEjpO9TXBuBxn1gmcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164751; c=relaxed/simple;
	bh=LXcpOVKlQKum3CRWzj5ThCeRqCkvE+LW+j1MQX2SAV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lLbxBISGqFEoOs5LthZq+N4P2NJnMB95/j0Jn1rkPfqC0wwbj4wbkufTR4osvkCPBxAMxmF+D2/VWJTVtfpQTQxj7CZv8escOF/SAQyDGi86KwGWW5SgGRfsdpvfraBKtKdB1LsgJ2brqgAFv+V2ATYN7D0VTNlLCdXM2Nq3W9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GiOb3/c/; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeeZ7PjfaI8rZ+6v+6oFq09+KGKNXJhLZb6tLZY/814CoqRZHdFRhwIaOdhHBbxGZZtqU3PmQrwoBxbVp5qeTFK34HVKr7Bi5j4gAKWxYqdByQjDZ355/D4fTYOQl7EF0EOpalpIlD8xKnX/8DWPLsaNO4x5KWNE0G28gJ84fUrERvwd99S0UaEgl2dttbfwyiKCjj2nuQG8ZrozsUgpWOvkfpJwKJ2qmD5scd5j8MYRz5mcH7eO/deE8rgGFg0cwjSaLOlejb7XznEqmchSYxUzLpcj35eLO8ymJjGvjfjSKC2gEPrcnL3vgldKpxwH4lAe0f9RgS28cb/1y1Hs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXcpOVKlQKum3CRWzj5ThCeRqCkvE+LW+j1MQX2SAV0=;
 b=QjKtPEb50iLiPrSUjHXQ05O8lwbBRLdQMCuQWzy0m7hPpSN7bPc1AvXTolxvvesDWPREFL/l0KdhwiswCcTXZPghz4Sl7jLrsv6e6dgKk8Y8ep0ccHVNI2vYCIghBNc4W2y1N3dM8AbguHCHmxtJ3uCuJDhP/RwQ+UxJEUm1FW6yEMzZj6WYFUr3UlP6OD1XsK1lpKXbnfiwTtS/YZ3NEaMprvl7eS9XtD7BYiPrs4IYJ0jkF4MrUAiWTLh2Mt5Ssu0VtwIBe8n2lRQRW5s8Ti55DlkOZAsCrE8rz/nG2lyQnf2zzi/CuRhU3DahrQBG2+yD/xNM95KkoihsgTMkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXcpOVKlQKum3CRWzj5ThCeRqCkvE+LW+j1MQX2SAV0=;
 b=GiOb3/c/pnSu1qp58oSZU8ojdrR0bT9AYo2PRzhzNK0cYYIhL8tmqbDrgeoy2GpOPq4pxCekgPUjTpn4JjYdrttaiR3LeV9baSYVItpl3kwfHzlR4ublnWUlMfyYTgA2Zp1Doi0eIquzrmpP5BOtG6oLlo//+Ve0TSe1XGLzbd0=
Received: from MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 09:45:45 +0000
Received: from MN2PR12MB4253.namprd12.prod.outlook.com
 ([fe80::ea15:570:4c2d:188f]) by MN2PR12MB4253.namprd12.prod.outlook.com
 ([fe80::ea15:570:4c2d:188f%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:45:45 +0000
From: "Veggalam, Rama Devi" <rama.devi.veggalam@amd.com>
To: "bp@alien8.de" <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: RE: Re: [PATCH 0/6] Add support for Versal Xilsem edac
Thread-Topic: Re: [PATCH 0/6] Add support for Versal Xilsem edac
Thread-Index: AQHbs6L51LuFTsKa4kiAcNvdFZfrHrOv7Z2AgLKrg7A=
Date: Thu, 14 Aug 2025 09:45:44 +0000
Message-ID:
 <MN2PR12MB42539E64E1CF2BFD2058DC50CE35A@MN2PR12MB4253.namprd12.prod.outlook.com>
References: <20250422171737.GAaAfPMbFtNKN6paJT@renoirsky.local>
In-Reply-To: <20250422171737.GAaAfPMbFtNKN6paJT@renoirsky.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-13T04:32:28.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4253:EE_|LV8PR12MB9666:EE_
x-ms-office365-filtering-correlation-id: bbd89223-b09d-40f8-6a8f-08dddb17572e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUY0VXNZbkgyNmVWb3dta2RUVUxLYkR4UXBHWjBTbzFKbkNuVXBlYkVMTkNn?=
 =?utf-8?B?SmlKSEJma0VaL2FVUStUaWNTQXZLTENqYWZCM1MvYkJwVkY3Uml2aWFQeUNE?=
 =?utf-8?B?cm1jb0JNQW1wYXV3dmpralluNnVESW1Za1E4K1VUekZoeHVpZTlmWUtWRXZu?=
 =?utf-8?B?ZWdSeWg5bW5iaUp1VVFMYW9PN3VZZFRxWnlqZEk0L0l6S0V5TGFYbEpFYVNy?=
 =?utf-8?B?L09DdTNXUlRIbEVndHk2MGNuZkxhOXdqTHFxMStxUitnUW5tUlpRSDE5R3ZB?=
 =?utf-8?B?dS9lTzlBNUlTdUc3TE9KM1hqL1kvQTJRMi9talQvbnU4V21lcEFXZ2hURmlK?=
 =?utf-8?B?MW9rQnZiVEFLMU1DTUNVQVZqSGMydGZhRFV0TGJSQlFaOFhlUkg2OVVXenBz?=
 =?utf-8?B?RVBEYlFFVEJKekxidTNaYnNDa0NxbkYybUMvZytxM3pkUnhqQzU1NzlBV3FD?=
 =?utf-8?B?ZG0wVUQ3Q3NBVTBjU3ZuZmpCT3M0eXhiYXozRUVwRmNTVWVXM0Z1VS9sVFhH?=
 =?utf-8?B?THVGdGNPMDlybitRbzhoVTdLNlpyVmVFWmwvckZwZ0RIRERtbGp2MXlkT0tW?=
 =?utf-8?B?bFpVMzY2MUJVczRTbmdhQlRSa3pLVXM0RFZkaHBCbWNraGZVaUhCWWhoZGhB?=
 =?utf-8?B?d0ZWZU5vN1FOUHVrQk94ME5QWjY3S3FwOWlmTmFTZWpHR0g2R0liN2M2a1NO?=
 =?utf-8?B?TW9PdG5PMWRLd3hueUJTRzlTazZkam5DMHNQR1ViNkV5Y1NDblRGbWE0WUpI?=
 =?utf-8?B?cjM0YjJDSWwzVXdKRm16elJMNjRPVTlWOUtyVi9MSExaMlZ2bzRPb0k2Q3Ru?=
 =?utf-8?B?OE44Y3dyU3pnQ0dEdTJiSWpLTUpzbXVFcFJVZU9pcmYrR3B6QjMyNENnMzFC?=
 =?utf-8?B?R2dieDZudlpOajZ4V0lFbzdDcjdZTE9TTFY0S3U1TFgyVnlpc29WZmttcUxt?=
 =?utf-8?B?QXJDRFV5emM1ZUt2c1ErWG9raDdtc29tNmpYUnhRUURldEFEMEpKaDdpc3VL?=
 =?utf-8?B?ZUVpcWRCS0tDM0E4STFPMEh1VFAwY0gvaFBsN0lqYmpUY0hSeXFWMzBzMWFz?=
 =?utf-8?B?K1ZTWlJoVHdVaUtQQlJUb3FmUW5Ba2QxU0ZCdy9Hd1I2Ui96UEJCdWxXUFlI?=
 =?utf-8?B?M2lzMWNrUmZMYVIwR21zNUowSm8ydnJYSy9qLytWZUNhem1VSnlqSGE3M1RS?=
 =?utf-8?B?bFd1K2xJMk1qM3Y0WWpjYnFPV3BZU1diVU05dzduU1B6c3dqOXNmUS8vQVBN?=
 =?utf-8?B?ZXpkeURqbll5V2tiWUdQUWpsdWkvWHlKUXBlRkt2dkU0RjF5eUFOTnlwV3Fp?=
 =?utf-8?B?YkZGZXZ0NFJzT0Q0TVVvVW42NDlobUFyMVJ1N1pQdDRVN0FGYVNlYlhNamhD?=
 =?utf-8?B?cjJWR2lmRUtkU0xPcXh3cDFsbURDTXhvQVhONmtLbG8zVDJKdHhmSjlzbC9N?=
 =?utf-8?B?S2xOVCtCc1BsK3B1VjRVWU9QTS92VE0wQlZxQXFrbTd5b21DY0lsRnBnZXdp?=
 =?utf-8?B?M0kzajQ3UFJkSTdCSHNTYWkzZTAxMk8vZWpGL203aXRwL1NkSVVNUzBTUDhp?=
 =?utf-8?B?Vnd5ZUc1blYrbzR1L3pPOEEvd1ZVODhGMW1TKzlnVGI4NitZdWVsd0tWWDd4?=
 =?utf-8?B?V2g4aUQ0T1pyNmxtNGw1K3RqNW9qZHIzbXl5UzNvS3VlcUVyRURlN29XVUdz?=
 =?utf-8?B?MWM1STBCMlQ5WERNRjJ0Z2Vid2dqTEQ3QlFkVlErb1k4anJ4em96OC9BR1o1?=
 =?utf-8?B?aVg2ZDVaUlJSNzUrQ3VSOTBkSk43OXBWM2VidGtpeXZ2WFJBRWdKaTl5ZitQ?=
 =?utf-8?B?bGlDbGtuNmJqUnB1TDF0dGtkSUVRZ2JxSjBqamYyUEkvZlBQd1VoK20wZVhM?=
 =?utf-8?B?MjlLQ09FSERDTFJHTVdhV2xxSzUwOHZjWitaRFlCbmphVHYrOHErdis5QUQ0?=
 =?utf-8?B?c0JDRSsrQ2llRWdMT25BNGRJejlEcXBsWGJ6Vmx2Y3RRdUJFbXV3eUtmTE5V?=
 =?utf-8?Q?2GtK7TKz5dXqHUi/wTCWZtfXgFshoU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2NMdUZwRXNSRGR2YUVnUWMwcEt0T1YwdUV3Ui9BMWpLSXpYUmxqSnlCUllq?=
 =?utf-8?B?bEFhZDdiR2pqdDBMM3VIWndNeENMTDN0Mld2M1FCcG1KekdhZW1tQUtsSDUw?=
 =?utf-8?B?VWVrUStoZmhvd01rczdBYkhQcS9zbGYwcGQ5Ym9aakVxaWc1dU1uVkxnRTE5?=
 =?utf-8?B?am1lbFBxMTVQZTRiWjdPanJFMGhVY1lReFRscitiTE1tWlZ1YkpDb2Z5YUpV?=
 =?utf-8?B?bkk0N1NyaFJFaHpJN0JZYW5XRW0yNGJVK2FrRU1wQU12MnFqWjZVMm13ZmY5?=
 =?utf-8?B?OWQ3OWhGVUNHOWYza3ZVNXNMMWVZa0pMY1hRT2hncUJsck9SckFBamNIU3Bi?=
 =?utf-8?B?OVMvREh3UVhMU2dVOWlQNW5uenNqWnFNK1NWSytZVjlSRTRVdldXdEw5RlBx?=
 =?utf-8?B?OHh2RXdXVmQvelVRYnpFL2ZHUHJHTlFYZHZlaThmSWhsb3hnOHRzMXRhUi9T?=
 =?utf-8?B?Tm5BYmtWa29DM0NBbUpjNFFnK3JPVXVaY0JNSGFtZ0VacUl1OUN3cTRpVlFw?=
 =?utf-8?B?Z3E5OHd3UFNkc3ZESnlzOTFEd3d4cEVjWkYyOSs1UW5LbHRUZXh0akZZaVFh?=
 =?utf-8?B?dTB1YnV3KzJQSXUyOHR4SGNpeGJ6QWxEbHJIMzViMkI5b0VEVXE1UzZiN25q?=
 =?utf-8?B?NzNoenNybEppOG1oRkNGbTA5R3pEL2RkQzFOOGo1dklvVzBmQ1ZMVjBRdWdG?=
 =?utf-8?B?cVRaOFAwd2ZiVDR4UmFTZ1g0R2lCVGhyKyswT0EzK213djJKYncxY0h6Rzdu?=
 =?utf-8?B?RHg1WCtzMW14aXIxU2F1SCtHenRxL2JKNTVQdE1OSU01OWx1USt6VHYwOE9D?=
 =?utf-8?B?SUhtMlVwRHRMQVJkWTAyaENPNTYyaG5oOFFrTEFkaHFBb3c0VTRqcWtrMUU5?=
 =?utf-8?B?Mld3bVcrVGNsN1ZzQy9JZEorbENJdmN6ekR3cGtOdzBzcDRSenkxcitVcmFa?=
 =?utf-8?B?Nm16Vm5acjdoa0tub1NoMXcyem9TWlkzcjdaV29lQVlyVm5UQmZIeU5URlBs?=
 =?utf-8?B?eG5na0hIb0dXYlRkZ1c0d1c2d1hUMXZVRkV0aFJkejRtL1JsUVh0NEdPb2lm?=
 =?utf-8?B?VzBpQXZrZ0c0V3U2eURpRHc3bUh3bnN4Ry9USmdEU0ppUkFPeThSd0F6VXFP?=
 =?utf-8?B?aFFVdTRUQnIzMjRBbjJIaC9iSFR2U3JCTFY3QTE3NnNmRk9kN3NTVVZGbnkv?=
 =?utf-8?B?aUF5MTZWTUIzUURnNEg5R0p0M29pcTI4VTFRcFlNckxDOWF4aUVycVNGd09j?=
 =?utf-8?B?UEZ0RGZKQ3QvWkV1aXpnVnRxRUUvL0JqcVBkTnh0OFhYZXVrdXdmWFdSSGxt?=
 =?utf-8?B?eVFZejFKc25raXRmLzNVNmxCcklZaXh1bzNFNEpNaWdhMERQUUo5eG0xUGxE?=
 =?utf-8?B?bzF5NWdTcGdXdFRmWlRIZXQzQ0p6M1MzTWtTTllCbkt3bzFGU1dYRzZZMkFu?=
 =?utf-8?B?ZWpPMHcxaDN4bk0vMTZKcWR1MGFpQVJrZmdMVnlEeDNJRHhGRFRuQkhEL1dn?=
 =?utf-8?B?WjFEWEpMb0dETVdOMVJxQWZEVW0xcFZuVjVwY2FaUi9POGJEQVBFOTZYcXBR?=
 =?utf-8?B?YlIvQ09NWWpnK0VoeUg4Y0ZBV1RYdEhzQ0JzT0NQUFhsSjZIREJ3UmpPVmxX?=
 =?utf-8?B?ZjRrRWtNdm1aNTYybWNlRER2VW5qT2dKTnlQeC9oVVBsMEhjUDNFVThSTXMv?=
 =?utf-8?B?QVl1S0VNWTZVRGNWWEJiSk91SVNNbXY3My9ndkRtRUlNSU9xNEJWTit6SHJM?=
 =?utf-8?B?d2pOZ0dPaHdiQUgwRFYvYW04R20yaFVEdmFhTVhkekZZUFgvMlk5alRSRnZT?=
 =?utf-8?B?QmVUb2JzcXlxelJ4SUw2NXZYRUlFcUtnRWlUU2FNNG1kMWNnaFJkdW9aRDNm?=
 =?utf-8?B?MUkza1JJVzl5ZEFYdnFJdTBINUovRVc5Wm41bGlySHZDbjRIbm9hSDRXTlNk?=
 =?utf-8?B?NmU4UWJJbVRLSnhLQXdzS2dkK3M1NjZFdEZrb1Y5eCtrM1VsNHk4ZVIrclJD?=
 =?utf-8?B?akFnRWYyVExhSkhuUURpWnNpL09RaG1oVEY4TVZhQkxzOUtOcWhwRmpudktq?=
 =?utf-8?B?NGhOK2xQMXFrZVYvOTNpc3BDSUZyN25UNE5rd3N0aEIzcllSRHc1a1dCQ05n?=
 =?utf-8?Q?b37Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd89223-b09d-40f8-6a8f-08dddb17572e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 09:45:44.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RON9JqaX4PrBVUw9d/GsN/tmkpaPK+Daqu6XoJrOKDpEM8yAsWXQGAbuJ1m6Hs15E4WKdW1AQgMOQ92CBuVyAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQm9yaXMsDQoNClBsZWFzZSBzZWUgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQpUaGFua3Ms
DQpSYW1hDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDIyLCAyMDI1IDEw
OjQ4IFBNDQo+IFRvOiBSYW1hIGRldmkgVmVnZ2FsYW0gPHJhbWEuZGV2aS52ZWdnYWxhbUBhbWQu
Y29tPg0KPiBDYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGdpdC1kZXZAYW1kLmNvbTsg
bWljaGFsLnNpbWVrQGFtZC5jb207DQo+IHJhZGhleS5zaHlhbS5wYW5kZXlAYW1kLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDAvNl0gQWRkIHN1cHBvcnQgZm9yIFZlcnNhbCBYaWxzZW0gZWRh
Yw0KPg0KPiBBIGNvdXBsZSBvZiBub3RlcyBvbmx5IGFmdGVyIGEgY3Vyc29yeSBsb29rOg0KPg0K
PiBPbiBUdWUsIEFwciAyMiwgMjAyNSBhdCAwOTo1Mzo0MVBNICswNTMwLCBSYW1hIGRldmkgVmVn
Z2FsYW0gd3JvdGU6DQo+ID4gQWRkIHN5c2ZzIGludGVyZmFjZSBmb3IgWGlsc2VtIHNjYW4gb3Bl
cmF0aW9ucyBpbml0aWFsaXplLCBzdGFydCwgc3RvcA0KPiA+IHNjYW4sIGVycm9yIGluamVjdCwg
cmVhZCBFQ0MgYW5kIGNvbmZpZ3VyYXRpb24gdmFsdWVzLiBIYW5kbGUNCj4gPiBjb3JyZWN0YWJs
ZSBhbmQgdW5jb3JyZWN0YWJsZSB4aWxzZW0gZXJyb3IgZXZlbnRzLg0KPg0KPiBXZSBhZGRlZCBy
ZWNlbnRseSBhIHdob2xlIHBpbGUgb2Ygc3lzZnMgc2NydWJiaW5nIEFQSXMgLSBJJ20gc3VyZSB5
b3UgY2FuIHJldXNlDQo+IHRob3NlIHdpdGhvdXQgcmVpbnZlbnRpbmcgdGhlIHdoZWVsOg0KPg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAyMTIxNDM2NTQuMTg5My0xLXNoaWp1
Lmpvc2VAaHVhd2VpLmNvbQ0KW1JhbWFdOiBJIGhhdmUgZ29uZSB0aHJvdWdoIHRoZSBpbnRlcmZh
Y2VzIHByb3ZpZGVkLiBYaWxTRU0gaGFzIGN1c3RvbSBvcGVyYXRpb25zLCBub3QgZ2VuZXJpYy4N
CkluIFhpbHNlbS1lZGFjLCB3ZSBhcmUgbm90IGRpcmVjdGx5IGRvaW5nIGFueSBzY2FuL3NjcnVi
IG9wZXJhdGlvbnMsIGVycm9yIGNvcnJlY3Rpb25zLiBXZSB1c2UgZmlybXdhcmUgZHJpdmVyIHRv
IHNlbmQgdGhlIGNvbW1hbmRzIHRvIFBsYXRmb3JtIE1hbmFnZW1lbnQgQ29udHJvbGxlciAoUE1D
KSBmb3Igc2NhbiBjb250cm9sIGFuZCBlcnJvciBjb3JyZWN0aW9ucy4NCg0KPg0KPiA+IFJhbWEg
ZGV2aSBWZWdnYWxhbSAoNik6DQo+ID4gICBkdC1iaW5kaW5nczogZWRhYzogQWRkIGJpbmRpbmdz
IGZvciBYaWxpbnggVmVyc2FsIEVEQUMgZm9yIFhpbFNlbQ0KPiA+ICAgRG9jdW1lbnRhdGlvbjog
QUJJOiBBZGQgQUJJIGRvYyBmb3IgeGlsc2VtIGVkYWMgc3lzZnMNCj4gPiAgIGluY2x1ZGU6IGxp
bnV4OiBmaXJtd2FyZTogQWRkIFhpbFNlbSBlcnJvciBldmVudHMNCj4gPiAgIGZpcm13YXJlOiB4
aWxpbng6IEFkZCBzdXBwb3J0IGZvciBYaWxzZW0gc2NhbiBvcGVyYXRpb25zDQo+ID4gICBlZGFj
OiB4aWxpbng6IEFkZCBFREFDIHN1cHBvcnQgZm9yIFhpbGlueCBYaWxTZW0NCj4gPiAgIE1BSU5U
QUlORVJTOiBBZGQgbWFpbnRhaW5lcnMgZnJhZ21lbnQgZm9yIFhJTFNFTQ0KPg0KPiBEbw0KPg0K
PiBnaXQgbG9nIGRyaXZlcnMvZWRhYy8NCj4NCj4gYW5kIHNlZSBob3cgRURBQyBwYXRjaGVzIGFy
ZSBuYW1lZCBhbmQgaG93IHRoZWlyIGNvbW1pdCBtZXNzYWdlcyBhcmUNCj4gd3JpdHRlbi4NCltS
YW1hXTogSW1wcm92ZWQgaW4gVjIgcGF0Y2guIFBsZWFzZSBsZXQgbWUga25vdyBpZiBhbnkgZnVy
dGhlciBjb3JyZWN0aW9ucyByZXF1aXJlZC4NCj4NCj4gPiAgLi4uL0FCSS90ZXN0aW5nL3N5c2Zz
LWRyaXZlci14aWxzZW0tZWRhYyAgICAgIHwgIDEwNCArKw0KPiA+ICAuLi4vZWRhYy94bG54LHZl
cnNhbC14aWxzZW0tZWRhYy55YW1sICAgICAgICAgfCAgIDQyICsNCj4gPiAgTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiArDQo+ID4gIGRyaXZlcnMv
ZWRhYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTYgKw0KPiA+ICBkcml2
ZXJzL2VkYWMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAg
ZHJpdmVycy9lZGFjL3hpbGlueF94aWxzZW1fZWRhYy5jICAgICAgICAgICAgIHwgIDc3OSArKysr
KysrKysrKysNCj4gPiAgZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLmMgICAgICAgICAg
ICAgIHwgICA5MSArKw0KPiA+ICBkcml2ZXJzL3NvYy94aWxpbngveGxueF9ldmVudF9tYW5hZ2Vy
LmMgICAgICAgfCAgICA4ICstDQo+ID4gIC4uLi9saW51eC9maXJtd2FyZS94bG54LXZlcnNhbC1l
cnJvci1ldmVudHMuaCB8ICA2NjMgKysrKysrKysrKw0KPiA+ICAuLi4vZmlybXdhcmUveGxueC12
ZXJzYWwtbmV0LWVycm9yLWV2ZW50cy5oICAgfCAxMTI1ICsrKysrKysrKysrKysrKysrDQo+ID4g
IGluY2x1ZGUvbGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaCAgICAgICAgICB8ICAgMjkgKw0K
Pg0KPiBBbHNvLCB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCB0byBmaWd1cmUgb3V0IHdo
byB0byBDYyBvbiB5b3VyIHBhdGNoZXMuDQo+DQo+IEFsc28sIHRha2UgYSBsb29rIGF0IGh0dHBz
Oi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy0NCj4g
cGF0Y2hlcy5odG1sDQpbUmFtYV06IEZpeGVkIGluIFYyIHBhdGNoLiBQbGVhc2UgbGV0IG1lIGtu
b3cgaWYgYW55IGZ1cnRoZXIgY29ycmVjdGlvbnMgcmVxdWlyZWQuDQo+DQo+ID4gIDExIGZpbGVz
IGNoYW5nZWQsIDI4NjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2Rl
DQo+ID4gMTAwNjQ0IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLXhpbHNl
bS1lZGFjDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9lZGFjL3hsbngsdmVyc2FsLXhpbHNlbS1lZGFjLnlhbWwNCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZWRhYy94aWxpbnhfeGlsc2VtX2VkYWMuYw0KPg0KPiBX
ZSBhbHJlYWR5IGhhdmUgdmVyc2FsX2VkYWMuYy4gV2h5IGlzIHRoaXMgYSBzZXBhcmF0ZSBtb2R1
bGUgYW5kIHdoeSBjYW4ndCB0aGlzDQo+IGJlIHBhcnQgb2YgZm9ybWVyPw0KPg0KPiBUaGVyZSdz
IGFsc28gYW5vdGhlciBWZXJzYWwgRURBQyBwaWVjZSBpbiBmbGlnaHQ6DQo+DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDEwNjA1MzM1OC4yMTY2NC0xLQ0KPiBzaHViaHJhanlv
dGkuZGF0dGFAYW1kLmNvbQ0KPg0KPiBIb3cgZG9lcyB5b3VycyByZWxhdGU/DQo+DQpbUmFtYV06
ICBWZXJzYWwgRURBQyBpcyBmb3IgVmVyc2FsIEREUiBtZW1vcnkgY29udHJvbGxlci4NClhpbFNF
TSBFREFDIGlzIGZvciBDb25maWd1cmF0aW9uIFJBTSBpbiBQcm9ncmFtbWFibGUgbG9naWMgKFBM
KSBhbmQgTlBJIFJlZ2lzdGVycyBzY2FuLiBCb3RoIGFyZSBmdW5jdGlvbmFsbHkgZGlmZmVyZW50
LiBTbywgd2UgaGF2ZSBjcmVhdGVkIHNlcGFyYXRlbHkuDQouDQo+IC0tDQo+IFJlZ2FyZHMvR3J1
c3MsDQo+ICAgICBCb3Jpcy4NCj4NCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25v
dGVzLWFib3V0LW5ldGlxdWV0dGUNCg0K

