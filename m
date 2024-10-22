Return-Path: <linux-edac+bounces-2179-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B59AA335
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 15:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D341F218AB
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAC78297;
	Tue, 22 Oct 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdZKKZf7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA21E481;
	Tue, 22 Oct 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603986; cv=fail; b=ACPrkWkk5fA2vx41WVp6JGt8+OWfrQ+4vxsUy3/C04WytLFTJW9D/PPD4yx4WCWdk9MTX/1UfgHTf5a0VXBoOYBENwCt+bmTf/9+LP3J72sy9HSkpN1F3jIlFNxG3FgKDLKkDYHUGUPHyla63GUtlKUZ6BbExzBNov1Etl/LkNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603986; c=relaxed/simple;
	bh=5sWnKf3ygbxPXIP/DTlK/TiLDET9PXWN2RHmeDBc5as=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cBOulGhbx4v9eVrcL/C+niLnc8u2vQzjctxBQE5fnfj4nmvwE0Lm/jxQUTeiCfEpIJXczlgJCLwSFjlcjZtYqCcenLwApnH9AMPz7KzU8TXHhnAlhoaI00wNZ34GDKpyFt8S5qnAL/VV21bd7L0u57HFw3W1h7kr8oZ25cl41fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdZKKZf7; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKLEeJGOQskMO91ogNxtsJ59r8z/5tQvZP9EKSG7RC2+2SVB5mnbvScrQBago6qQmCdbWU/RHEyEb+0Bl2WNA7lEPOYMcE0VebqimIno4x6Jvf9biCfQH/vfnFmUOXb10BdMDzgPLPTppLRr8YKAVUcF3mfC7eg04vLQ1K4b/2MHs+wtw9t6y8I5cY+sUiH2WBttHvBd6FqYOHf2K7MtAkxXSmqy0kEHpnJDnWbfkVKPAnBa4OMWhLgIoZNcIPpSQU7FKQwmi9OL7+HOtyuSYUsq+uioQn0dLHeI8nrLJ4UWb8WWnhfoxJ7Si7dfPgQOVzzkYE0/rxO6UDNrBZ8B2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sWnKf3ygbxPXIP/DTlK/TiLDET9PXWN2RHmeDBc5as=;
 b=jB5cAFqbe57vRP06KbQxEU+X1emslBwUeYWVomewqG/XmuMOCDu5jUg59Qff4lJ/nkvkZ8AqUix0rMtbZaocW9zyrFjeK1fmuGgxMeDtQ3try7WBSae8ZfnkEDrcucFy/R5bG38fnsAGwipkPbRP6GeG+8ils9aSD3OJhbelA6R/fTtr6BWgXKeyF1RL7DjBHL/EsH/d1SsORRMCQeGrT5lueWbCzUgvK81IO69ElRw+JwJRbYarIi50V1M4uz3UR9eZjNQU7csGUWLiselFc0/vIXaKSiQPTiCfnI53h/hQx5EQivDNV8LNJTSJZclBlJpCIdcvAvq+q+So6hTNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sWnKf3ygbxPXIP/DTlK/TiLDET9PXWN2RHmeDBc5as=;
 b=cdZKKZf7HDUOpXsrwDokojNYdnqOfHuVB6UsiwYBPbYp/y7fmkUng591DiBcADmLMhdmG6YKupy0unTpYLwV1seMBt56YSRr6OFxzRxKCStXvjVDap+VrE62Raa12QZa47iQNY53pXuSNRT0AJXWjv8u0dHbAUgD2Jklv8T++cB2gVr1+ckRiFHaqeHcDb0DHxuOBWyeky6JVneG4quEUs9nN1Y02B1xzU17w3V3yBHZoaahv8GDVqbeuk3QBh8kemu/KXPVVsO/zxeJdqHPq7bouD3KNgxtyWoaSLauNdDTEzE6hs0SBjzqKZ470vhIeOjnwchSRqbKEVMEhTHftg==
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:33:01 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 13:33:01 +0000
From: David Thompson <davthompson@nvidia.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shravan Ramani <shravankr@nvidia.com>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Thread-Topic: [PATCH v3] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Thread-Index: AQHbJBE8RREOPdUThkKex+D2yFmH8LKStNUAgAAQgGA=
Date: Tue, 22 Oct 2024 13:33:01 +0000
Message-ID:
 <PH7PR12MB5902E36788A73447C8DA10DCC74C2@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20241021233013.18405-1-davthompson@nvidia.com>
 <20241022123240.GGZxebaKRONhSThUCC@fat_crate.local>
In-Reply-To: <20241022123240.GGZxebaKRONhSThUCC@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|DM4PR12MB6063:EE_
x-ms-office365-filtering-correlation-id: 62005b01-00cd-43a7-ff50-08dcf29e0cab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjVZVkkzSXhqeGMvcEsvS2wwK3pDb0F5bGNCOFJ0dEJXa3RoYTNmejlwTjI0?=
 =?utf-8?B?SjZ2MHRFa0dycTNiOUx5bGE4dkpzd3NkSU05QmJBbkVES2FBMmN2VjZoWXFI?=
 =?utf-8?B?RTA5c2JFYW5DYWNRd2tPZ3BuYWswTjU4YmFFQjhuUmRNWEpCaFJweUkvci9j?=
 =?utf-8?B?VFBIaXlZNnBTZ2RLaTdtK2RPWGpoQmxIeitQMGtFd2hMVmMrNGprQjJVaHJi?=
 =?utf-8?B?U2JQR1NZSjljKzBxNm9vbWpIdEcyNXJBTEsyR2VmOGJrcTdPK2h2TVFKYk51?=
 =?utf-8?B?azdmWkZlamhFK1N1QVR1VGZoKzE3RTZ1dkpyZXRiTWI5Z0RoVUMzU1EwaFIr?=
 =?utf-8?B?a0tjbU9CdlN5Z0pickhhMXdEZ2pkSUZwM0xJKzhFQjdjdTJ1ZmoxUzRZTThu?=
 =?utf-8?B?M0hiclY2UlJKQzdiY1NqMVRvQXNVcGd2ajBYQUJpdjNqVDF5TnhSdG5YZzdi?=
 =?utf-8?B?QUhDU3VVeU1hQ0x2dTdkdkJOaU1EWjJiVTl6SjJ2aWo0ZG5tQzZKSDJNbDg0?=
 =?utf-8?B?TE5zdjd2NXM0dkZwc29TVFk1THhad1ppeVVSVk0rRU8wTUkyRTd5QWlUTEp2?=
 =?utf-8?B?VFpmVkNBa1lTdUh1bVpidzEzOGR2cHkwTi8rayszQTRFR28vSzlpZi8rOTNK?=
 =?utf-8?B?SmtBbjlxVy9FL3RmbEk1R2NHNytwVUx0bDl2eFNZQ0FNRDMrRlBCbFhTbm1G?=
 =?utf-8?B?TmF0aFVoNlFjalBaUFNRdDNSaFdtV0JmeWtIMCtKMEhxOC8rTUlRZW5QWDRT?=
 =?utf-8?B?Slp5a0todk9mbTRaMGxUZGk2MFFKYXdKYklUY1VzVThqQ2c4NWd6a2NrZ2JG?=
 =?utf-8?B?c0YzV3JMYVlnb2kxN1hBd081ZUdudmI1VnQzU0owQVlCUGlwYTlkaytEd3c4?=
 =?utf-8?B?NE1qZkpEdi9MY2xrbDdGeDVzN0MyMlBkVHBzcndUNzlDMzh3a1RWQmFKSm9L?=
 =?utf-8?B?UVcrQk95RTA1N0RVSXFORENQL2dLUTdHczhZL2o3a0ltL2wxUjhha1pHWkRR?=
 =?utf-8?B?WTVoc3A1ajN4eWowSnZaQUZCdzNrTWcvRnBUMjh4RjRUUlNROGdTTi9YczN4?=
 =?utf-8?B?SGRQdk41d1lwU1Z6ejVwc0ZkaFlpOXFMUDJPc2hOeWRIbUVvMVVEMHJlRTlE?=
 =?utf-8?B?NVYvUE1DaHlTbytncWhWVkg1aUZWbHRVNTlnbm5hSXhFVkduVmMzbVRpSk9p?=
 =?utf-8?B?bFlRVWZ5SVNnTG50czJBNmJDTkpFR1paYlMwNFh5REdLUkpzQ3B1RXdmZHhz?=
 =?utf-8?B?K0w0V0dOWTlnQUZMYzBqNldkU2R1S2FxNy9vcENOTkxjOWU1MEJYMjgyVFBC?=
 =?utf-8?B?SUtaZHFJUmR5YXhYUlNrem1RS1g1bWJ3TmJJUUF2Y01ORnRJcm9kRlczZTJ1?=
 =?utf-8?B?ZkxuOW5CZy9VYXhoRVBqc1R2bTZlSHdVQnFnM2xnVjZCMlpWL0R6T0NMa3lW?=
 =?utf-8?B?b05sZFhjS3lWSEMwSk5YYTRIU0tqemFtMW9DNitTS0g1TEdONDQ1TkNEOW5L?=
 =?utf-8?B?VUprK2VnaGxuL2RKK3FTS2EvVzdhclo4dHFtbUhLYm9rUm5Hb0t4dmJwaW1v?=
 =?utf-8?B?WWlLZVpSZDBaZFkxbWVDMUlGRmVVN0N6VmVzanlhc3F4Z2Yxc1FTYnpwM3U3?=
 =?utf-8?B?bkFnV0dPRlVySXIwbitmb3MyY2dyS0xlYUlka1NXeFNCaUx6RWdybHBGZUVp?=
 =?utf-8?B?UnhZWlRuYWdsWUdBdVovdXFhTFgvSVhCQm9vbWZ4czBma0s1cWVtU0J4UHMz?=
 =?utf-8?B?R0g3QnBMakY1UWhhd3lkNE9pTXdyVVdrMnZTaVN2TlZGMnNJZFRUbGdUS3VM?=
 =?utf-8?Q?T4NIqvAln+w/FXhNA3D2SVRkwQQ0bY8VJ6BeQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzM3MGdoWjZLK1E2eDR0bHl6ZkN1dWxNeXFVZmh1RS8vemFRcTJRNkc4WDI2?=
 =?utf-8?B?Y25jV01MZzdPbGhwZWg0K3kra2ZBYjV5SUhIUzR1dzVsbW01T2dJTk0vQkdu?=
 =?utf-8?B?WUN1eDRZUmZ0ZzQwZHl6RFFSeCtubkN1MVY3akcxd0tlV2Q3UGd3QnpyZUE4?=
 =?utf-8?B?RXZoa0ZHY3BJeEE5dlZyUUpCV1RKN01qKzdyK3QyUkxCUGJDa3BWTURIUm9l?=
 =?utf-8?B?ZGt2M2dCbzBjWFRpbjJDK0dGSDE2aGw1dTEwb3JNQXE3RWhVSi9GVGltRGY4?=
 =?utf-8?B?ekJOTnhxL29mRGhBQWxrRnRTV014UEJtVWtyRG9pNGxIL1dtanJMa0xPa3dk?=
 =?utf-8?B?UTV3NkVSY2JxMDBzMVpDRTkrbys3S1QwTmUxY3o0aHNxVjNJN0U1aHp5aksy?=
 =?utf-8?B?Q0lPTFNzV3JlV3NRMTdJWnBJNVBmVStTbG16MG8xbXhob2ZhT1JxNmp6K09G?=
 =?utf-8?B?Q0FIK2VldmFZT2ZZUmpDRk9tb0Z1eUVLbzhLVk1lOHBxNUkxZzVMcmI5cEdo?=
 =?utf-8?B?T2VTeUJvSFR3UW5kSFF2b1FITXdFN01ZelFJYlVTQ09UTXpJak40L0MyOHpE?=
 =?utf-8?B?d1ZzWTRkS0VHNENGSE5nb0poZEhydy83YmxPWDVKUWEyWnRlN2owTjJGSVNQ?=
 =?utf-8?B?ZC93MWJZTS91bVdmYWJKZGZUNytYUXNWYUhlOE5HcVR1cEV6Z3htbVJ0Qkwy?=
 =?utf-8?B?TllJc0Y4bWkyM0NBRFlxU1MyVTRaM1dyKy9DZSszbnNkTE1XZFIwL1dtQTlz?=
 =?utf-8?B?cVVmTWMrK09nTUxQRGdzT3h4eFgwQ21TRDBQM0FwV3RpaVN2NWNPbGtHVWVj?=
 =?utf-8?B?Ylg2c0RSTXk2MUMwMzI2QVJNVW1WSkNwekpCcnhsZnBZK1kxT21NYWVRUXJl?=
 =?utf-8?B?N0p6alNXZ1htWTdNRnFCSDFsSWh6NVNaZ2EzWk8xOUNuVjRCbHhnR09OVGhY?=
 =?utf-8?B?ZHJnL3hRVG50NWllZHhHN0pObHhZTWxJNkNvRks4cFNnUnk0a1dSRVNZeW0w?=
 =?utf-8?B?a0hFTXF4dFY2K0puNUlpOGJVdDdYTjdrSlpRK3ZabHR2VlUvWFdlcjdkMEsx?=
 =?utf-8?B?Z2UyL3h1bTZ4SXFiL3BELzI0eVVPWE9ieSt1M0dpRmdWZHJscHd5NktheElT?=
 =?utf-8?B?d09ya051V0dMSkU1NjVpZnV3VGMzeWFpdWhjaEhaOHVRQ2xxd3E4QXZFbmlD?=
 =?utf-8?B?TUV5YldIZDdxc0M3Zit4QW1KRW41TThJSlpvdnM1ZnJzdkp2RUYyMFNmdjdC?=
 =?utf-8?B?TDJNY2tCVGdNblBxbkxIbUtxNGlGNndYdnZ0Szh2N2pCK3M1UHVsZ2gvekpN?=
 =?utf-8?B?OERQOFBKaFRYM2d6MmE5a1dNVUxaVWk5NkVLZGxvd0l6d21pY2RXYWs3Z0Zi?=
 =?utf-8?B?Z0hhd0hzLzhjQk9YWW1EMElZeWI5bmMvTHRkOXpETzhDNC82RGY4ZlV5bjdX?=
 =?utf-8?B?bThNMjNiTE5vOUpweUlpcjBVb2o5ZExRcmJEMVJOdTdNNjRrczB0RWZHWDdk?=
 =?utf-8?B?TGxGenJaREtDNnlDZlBvN0puRGFLU3gyRFM2ZE1NaW96RFpNQlAzcEVRUm5G?=
 =?utf-8?B?bENyNmhoN0lsUzE2TlZobmxjS2I2c3NRbkJHY0FCN3NQOWd3YUhnRWIwV2tk?=
 =?utf-8?B?UmRIT29QWC8rT0hJUEwxTzBuUDQwby91dEJWeEtUbjdmZHMwbmpJQUdTMHF0?=
 =?utf-8?B?S3lxelI4OG0weUYvLzFVd25GVWxLSFpHTEtBTEd0MHo0Vm00bEx2a1VJMTlM?=
 =?utf-8?B?ZW9UQ3VPeUtMZHlyclFJVlhOVUhpWWppY2NUN1l0eTRHUStyekUwOVpCTXMz?=
 =?utf-8?B?N20rTnE3bGVQR2d4aXc5bzNTVzg3eDZWNzlyTzdxYXJOblNlYWhyZGJweUQ0?=
 =?utf-8?B?SjhDdVhHYWI4Sk9YUjVWRHdPRDFvMzZhems1NHFEU3RwdVFMKzZzd3VrODFL?=
 =?utf-8?B?aStGbG8vL2ZjUFVhczUzaHV5K0Yrci93eUZaL0Z4MVBINlRFVHNKT2szeHZl?=
 =?utf-8?B?WStySExLOE8wME5DU3pjV0pqNWFHSXNJU2N4UStlUWZNUm1DM0cyMm1sQmMw?=
 =?utf-8?B?M1ZWNDFhdnRtNmI5VWt5amoxVmQyQU1KWlZYcG9SSUxEVzFHQ0FRUFJhQzlu?=
 =?utf-8?B?NG12TWZoNDRlREZ3SHVzOTBTd3o5U01sVEVVUzZNY0d3SS9oaEl3MlNFdzV2?=
 =?utf-8?Q?IL7gZG/dGq9rHsc0HaG1vnJu2KHL2FCalzYT5oMp1e8i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62005b01-00cd-43a7-ff50-08dcf29e0cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 13:33:01.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1W9oabzJZmNgw/tDpbuvLAnsbFh7JCRKti2pIAQ5UJMIj7xoQ4nXb6sK0FEk0yn+ukp/WrFRZXLACTtPYdSYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyMiwgMjAyNCA4OjMzIEFNDQo+
IFRvOiBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT4NCj4gQ2M6IFNocmF2
YW4gUmFtYW5pIDxzaHJhdmFua3JAbnZpZGlhLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207DQo+
IGphbWVzLm1vcnNlQGFybS5jb207IG1jaGVoYWJAa2VybmVsLm9yZzsgcnJpY0BrZXJuZWwub3Jn
OyBsaW51eC0NCj4gZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gRURBQy9ibHVlZmllbGQ6IFVzZSBBcm0g
U01DIGZvciBFTUkgYWNjZXNzIG9uDQo+IEJsdWVGaWVsZC0yDQo+IA0KPiBPbiBNb24sIE9jdCAy
MSwgMjAyNCBhdCAwNzozMDoxM1BNIC0wNDAwLCBEYXZpZCBUaG9tcHNvbiB3cm90ZToNCj4gPiAg
ZHJpdmVycy9lZGFjL2JsdWVmaWVsZF9lZGFjLmMgfCAxNjkNCj4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNTAgaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBTb21lIHRyaXZpYWwgc2ltcGxpZmljYXRpb25zIG9u
dG9wIGFsb25nIHdpdGggbW92aW5nIHRoZSBzdHJ1Y3QgbWVtYmVyDQo+IGNvbW1lbnRzIGFib3Zl
IHRoZW0gKG5vdCBzaWRld2F5cykgYXMgcmVxdWVzdGVkLg0KPiANCj4gSSdsbCBxdWV1ZSBpdCB3
aXRoIHRoZW0gb250b3AgdW5sZXNzIHlvdSBzZWUgaXNzdWVzLg0KPiANCg0KSSByZXZpZXdlZCB0
aGUgY2hhbmdlcyB5b3UgaGF2ZSBtYWRlIHRvIG15IHYzLiAgTG9va3MgZ29vZCB0byBtZS4NCg0K
VGhhbmsgeW91IEJvcmlzbGF2Lg0KDQpSZWdhcmRzLCBEYXZlDQo=

