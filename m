Return-Path: <linux-edac+bounces-3269-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1CA4F67A
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 06:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BE93A4CB1
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 05:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FDB1C84C6;
	Wed,  5 Mar 2025 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1DcUpOG8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB0131E2D;
	Wed,  5 Mar 2025 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151905; cv=fail; b=WZkyBGScq77VKKlmm4RImSYi6iJypNGuPDL+NDWijsfuxYXzbf2wztOmR7eM0rKMR25TyIH/yIs3EuSr0Ar6/+dZoVjKf4HvQOBMm2cV/PazCRLiDil8EqKQegiyJlnsJNV6Mtwqe4ExON1NtgPZr6KUzE0m8wUJWqINarocfvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151905; c=relaxed/simple;
	bh=gvI2Q/HGFE1LNoTuvfafmT4Dn2STHwIokytCvmF7cQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jlje0lszwWnTqPMgWEaoTVwgqsmxG6fxQzuhWUz83/q2yNTsVgoPuWfaGvwSs6BJ6GIm5LF4uqwIpiX/ep0gCqUfT/8r7i9hLwiVpLfynwbPxhpkyz67SGu0SfjjvCyFDazLMin+LvQSnn2XdSj7AOrzH4VaAmWFNi2SeiA5VhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1DcUpOG8; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUxMHc3LRS9TntgFd7eKeH7Rh196m4hEvazrXA2Ie0IkBM9KiTKIuDuLYhiZQg+T23jG0bod+L4P8E7/nBrAOVcfTCNsdRCOndWBoP6PKGAzitsdU4XCGP9ZBiVtZzVtGhI4Gs6/FR1AaEdJxdqQl2hXnEBz9BGvrf9g9BFUPQGIjL8LLFCbDV/RMYsCUbfHRlQxYgl4Vs5dNDAR6mcs0mVKmjg6lVBCjhYxRsleNyF5I4/rc2v/DWEiATkdDaK5KIv7TXwuJ7jBjL0vh6zoZ1O7XeJmemxaJbSYKbro/Tj6yqBh9AcMS1jIvE1GKmJEiTXIRDTOIRQW8w9QIc9Q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvI2Q/HGFE1LNoTuvfafmT4Dn2STHwIokytCvmF7cQg=;
 b=rwmyQ/bwR3a468xJlYwuvv8cXaPk6Kguj+9Uh9nCyNnGthTxdyapiL8z30WmdQB/uOafbZWWnwS8x4slt5TYBarX6mPJWLitLBswPBeMmunLPgTdNDYkSFevagOX0gJv4AJKlYVYCJf7LZEnkgpyYwdoHLOu19Q409gTdFBqTZ9BJCSkLfFE9Eu3/iFYguaH5CwSRy4OWG7CV3G4MwLL8BzZS9SEQ5FkMkblqFTgxjGnv+NSdEoNOct4qB2YC8LYrES/aVnVBZTI9/gdIr0uEj8tFrG6xSJeMr6wckZfi4AE2u+ZATM+elhhhgMeGqdlm5bKLQeTTJ8h7akMNfeF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvI2Q/HGFE1LNoTuvfafmT4Dn2STHwIokytCvmF7cQg=;
 b=1DcUpOG8Z3+AfLfRBFt4K3Nw/fX28BG56es1dNz5NutHgCl5XAvRyNxfGnFQrTFqP/Yb3hqperjb7g7rvu3W1Tk83uMksND0AaHXHS5WxO7lLwJ/DqfanzIip0VTclbMsXXQBxpT3rBgFnOs9DMKyRtNjSuutHsuMCrypp8Whq8=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 05:18:19 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%7]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 05:18:19 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>, James
 Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v5 5/5] EDAC: Versal NET: Add support for error
 notification
Thread-Topic: [PATCH v5 5/5] EDAC: Versal NET: Add support for error
 notification
Thread-Index: AQHbX/zfX7fib4xhjUm2oMoiMl2gs7NCEd4AgBZ86hCACXwigIACThYQ
Date: Wed, 5 Mar 2025 05:18:19 +0000
Message-ID:
 <SA1PR12MB8947D2A37B834687E6EE000A81CB2@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-6-shubhrajyoti.datta@amd.com>
 <20250211094002.GAZ6sa8l_2BdJQfk0I@fat_crate.local>
 <SA1PR12MB89472E1EF3BDE072EEEF17B181CD2@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250303175527.GDZ8XtD5pOTtLUe16B@fat_crate.local>
In-Reply-To: <20250303175527.GDZ8XtD5pOTtLUe16B@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6a1eebfb-5365-4a45-a15b-338d70428eb3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-05T05:07:27Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|CYYPR12MB8889:EE_
x-ms-office365-filtering-correlation-id: b3bc678b-01d8-4be8-e813-08dd5ba5248b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXBwNWY1c2NLVnlpTUxTRTludmFtVXFEeDdzblNpNmxOcUN3cEp5K1ZsV0ZM?=
 =?utf-8?B?WmVJZTVpaDF2aS9uYndlL05YMG9ybCttODNtWm96M05pVFhiaGFwZ0NaZFVE?=
 =?utf-8?B?dTFIblZiSWViYWFXT3kvS0J5K2VGa05vNTBkNit2Yk41dE8wbWhuR3Nud1RT?=
 =?utf-8?B?OUs0alEwUVBFanRqWHh0SEl1VDRSNFA1alEzRW85aDhVNGxaNnlGcVlibVo2?=
 =?utf-8?B?QThoOHlvdW4zT2J4TmJoOTlyRHdQM1NuVFVTbmNpS2FwTGcyQnJLUW92dTBX?=
 =?utf-8?B?ZDlTMGUzUXpyTGd3UXhRNGczbVU3QTFDS2s0dWcyb1ROOUp1Z216OXpJVkcw?=
 =?utf-8?B?aXlLMVV0OUpNNnZ4Y3lZdFpBSDhSek1WdVVydDFtOEVkazlxWnRERnpBWkQ3?=
 =?utf-8?B?ZmowaTZNZUUzakVueHVXQ0p0MXB5VGJPNUlzdHFjOFhuTjhrams1ZGl1UXJ2?=
 =?utf-8?B?S0ZucDdMeTlxaVhpMG9WQ0Ftays4WHBqb3JZNDBDZDhoMndTbCs5eVJWdGp5?=
 =?utf-8?B?cHM0aG9LYjdVenlsR3QzNlp4UTRFWExDU0Y3ZnV1UVlaeEVoM3dNSkliZVBo?=
 =?utf-8?B?d0MvVDVUbWhidGozdVc2UEp5a0RLYlc0WUw3NGRzd2JrQlQ5U2lDUXlCZmpy?=
 =?utf-8?B?TWtWRWcyS2tQcml2U05aM3FMNTlsUHR1UTJIWU1PWS9MWUcvR2IyNVdzL0wx?=
 =?utf-8?B?V2hXekkyKzJNSXJ1U1UyQlZUTzJOd2R4MW9tNkM2M2V3TnM3eHlaaGs5NXBm?=
 =?utf-8?B?RHNtNlhKNDdqRVMvMmtqQUF4bytRdHZCYW9HQmpFcEN0bTZDdVNET2hQbG1U?=
 =?utf-8?B?VktWaGFxd3RnRG9lTTFIRjFXd3ZxRUJSODRRc2dua1I1ZUpSR1p3aFNHNTJ6?=
 =?utf-8?B?TmtBd3Y5d2tJaTVMYVRWOS9NWEJYaXE5WEpSUTNaNDZtY0NVd0VNZVNwWm94?=
 =?utf-8?B?VEdNVjh2STBXeUtuYjRETloxVS9hSFloaGpPYnQ3Yys1WnZYbHoyMEpsaTN3?=
 =?utf-8?B?K3VvMzJ0VHBRY2xHV0NqL2JtOUx6L0loeEpLc0J6UGtzMFk1VzhXYWJxQlJ1?=
 =?utf-8?B?dnZQakU3NXBRc0ZUNERCQktHbWtTUUVpOUc4RWwzU1NwVzU4OHlHOTJPTlUr?=
 =?utf-8?B?YTZ1Q3dIYW85SUNUcDY1T0ZYY0M4SWtTMVR5THhONzdYaW01TjNZaCtOb056?=
 =?utf-8?B?Nll5Qkh6WmhpVmtXNGxITTdZUFRvemJzTWJ6Wi9VZm8xRGNGMnlERGdMdXNM?=
 =?utf-8?B?OVhkZzdvTURRRXNGYXRTemg2dTVaTFhXUFQ1OXpCY29EODRwVWhzYlZ1UDNU?=
 =?utf-8?B?US8vWDJVSFA5OVR4OUphK0tFM3puZ3FHWGE3MGVWVG9jRXhYcGgzeG5RdUtm?=
 =?utf-8?B?YzZBZzdqM2p1MWgwc290b2RwUEpqMXB3dnJYOW1oYi9LUTZ6czZVWndDU2JX?=
 =?utf-8?B?dmVGVFJoclViTE9nREVmT2doSWZpL3ljM0doYlE3cjVvQlpiNnlaUTBVSlpM?=
 =?utf-8?B?VXdaMVN3M0hmWUNUeGRjRS9WL0JCTlVmbFd3ZmdXcTR6Q0hpdTBOcDRRT0NG?=
 =?utf-8?B?VGw2eC9KcG5KM0hwc3Nub2p4cDNyU0ZLVjZtK3drcWcvSlVJazZRR0MxL2hZ?=
 =?utf-8?B?RTZ4Z2ZNNGVQZHExbjEwWDd4eXZIMXVXZW9HQk5RaHlIblE3eWJtSHh5SG92?=
 =?utf-8?B?dU5aUGNnQ1VpOThRdGxLR29lY1p0V3lOdnNtbDVMb3AxM202RTVlSTB2NXI5?=
 =?utf-8?B?Q002MHFYOVBqQkxNbWlPZzdzZkFJSXphMkZYcWRrMmt3WTdueWFiQXNSV2M3?=
 =?utf-8?B?Y1BXczZoWC9PQmJsalpteVFFaWFSZ2F5Qk54bXk1VHY2Y0w2a3RDTjM0T3pT?=
 =?utf-8?B?UGpkQVBDZDd1NG5vM0J6c2hNY2ovOTNuRlZKVFZBanF1SUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTdLRndrZUZXRlVWdEhPT3c3aHdsRVVXUzl3ay9oSFowS3Vhby8xNmlXNFNF?=
 =?utf-8?B?dnNYVnJWMEdLOENVVEVvQVRBNnk0R0g0eTRBU3VtZ2d5a2ZrQkl1b1N3cXNp?=
 =?utf-8?B?cVJsSnRwYWxRRnhVOVlCT1FwTS9tTEV3RkFBUlZlTENHQUxFdEdtZldUeWRG?=
 =?utf-8?B?TTJYVllHUmMrU09MclJQaWZ6ZFZXLzhWdnVvb0gvd0xtL3VGWXc1cVd4eHho?=
 =?utf-8?B?bTliNEJET3hGdGZLUUhjSFNyR0N0N3dFV1JQbkNVYkxLM3RWMFhqSVE4VTJR?=
 =?utf-8?B?ZUk5QXlzQ2Y1aXA1ZlVrNGVpVFFPR3hKa2NBZEdWY1F0amNJRzBTMTQ0TnNl?=
 =?utf-8?B?Q3RGQTJwRXJVd2VBT2htemJ0b1Q0d2ZGVFVBNE9FVWRHV3R3eDVrYTg5SlB4?=
 =?utf-8?B?QXNmWEs0K29GbWZtMW1UU3JQaHdDVlNjS2oxOW40WmhGNEhvYVJwbkt3a0pz?=
 =?utf-8?B?V1VxZkp6U25FL0JYdm1UWTlrNXR0UGhISDRQWklQQlRxRjFOSk5ULzNTWkhQ?=
 =?utf-8?B?a2x2Mm9Wdm8za2RYdVQrY0h4bUZUd0lpZDVZbWV5YWcxZGNDclQ4TlJRMk14?=
 =?utf-8?B?ZTJ2Q2laazVoUnQvRGYvM2E2TDRhWWdGcng0UXM3dWRZT3VwNjlCcW1sVmUz?=
 =?utf-8?B?M2Vna0FsWnpTOUNlQ0VlcVZnaDJ2WnFjR0JzTTFRaS95MVVkSXMwM00xdGhp?=
 =?utf-8?B?UzR5UlM4MXhsZWlsOXRGY3VLYXdZNmN5Q2tqLzJyQ2VUR2xaK1hGMU1ZSmNF?=
 =?utf-8?B?cUlNRWlGM1FrUGdBVW8zRFlGSVo3SUZjQUpmVHVHVFpaaFlRYUhZMFhkcnhs?=
 =?utf-8?B?N0FmQmhJbWp0Ky9yRW9CS3Z1cTZPcVZ3R0RtYzZNdkxLckZxbzhhMVlIaEl6?=
 =?utf-8?B?MklxRHQ1aTRrUC9NeXprbGFFVGxlV0lTb1g1Z0tFMHVVVC85ZWRBQlQyMDE1?=
 =?utf-8?B?SHJVaUR3dEg3dUJrdG4wRVFDb3phNUN3K1MyTStCdkYxRzc0VFZBZVJtR0pD?=
 =?utf-8?B?cHZwTzB0TlNMSzdPbllzNUl3TXVVY28rUU1Qdng4eEVvQ1kzbkpSSzNFWHJG?=
 =?utf-8?B?LzFaQWd1S0pIdnRhbmh0ZEJSeW4zdzhKYno5MUZkQTVydE5mRnNWZ2JxSndQ?=
 =?utf-8?B?aUg1MEZiMTZJUGpGNjg5b29IbzBxWWxqVFBmSHdxdFZnMU9SSnBDR0FwaGkx?=
 =?utf-8?B?d0swNVIzV1JmR1NjRW10YmVkZ29XZkdoalo2aUNrMXo3bXdReW05em92UjZ5?=
 =?utf-8?B?UG9NdWpiMXpmMFNkT1NMeVdDYUdxV05qUjY4UzFIanpqZmpGT1pKeGNwLzBE?=
 =?utf-8?B?SDczVmpGQmxtWktPT1JRL0YrTnJ1ODZwR25lVlYyUUhBQVoxeG5Kd0NYamZk?=
 =?utf-8?B?Uk5YTXRnR2ozSEdxSkZGLzQvTGJ6K2ErN0ROQ0pYNmxSeFZsNDlScjRhME9P?=
 =?utf-8?B?UEVqOWRGcXA0U2UzUGw1blJDUTJneHdKOVNuZUcxZVVjblJlcktqRDZxOGdT?=
 =?utf-8?B?b25CQjJ1b0tiNmhlSXBGbjFOSVVhMnhmNlBlbk9JcDdDYXV3Z0pJak12eEgv?=
 =?utf-8?B?YWxNNkVxaittTUNvMWN4MGpaTUJITm1GRi96Ni9WTithRC9Ic2RaWEg4T0M1?=
 =?utf-8?B?clNRUHJFbmJiL1A4eW42U2xwR0ZuNlNBOGtpTENORUpFdHRoSHFCRjVWM0ZP?=
 =?utf-8?B?VVBrUnlXcFJsUlRvaWFVbkFSKzIwZjB0VVZFczdzTDhhUEJtZ0R5blBoV3Fq?=
 =?utf-8?B?ZHNqMTZ2TmJ5NFVKRTJEaTF3NnBGS2JaNk1zekI1S3VmVGxMRitDellwVEVw?=
 =?utf-8?B?amJYcmRxMStDMHVTbDVYTjg3bWpvSm1ZU3c3eGZyYTBtMGF2NGpWeENXRHZl?=
 =?utf-8?B?eGNtZkJoM3FlYVFNdWk1US8rNmhacnoxSWxCVGRmQ1F1cjFUanJYa2hwTFdW?=
 =?utf-8?B?N2FaMFUyMmtveGVsVkZFY0x6am9semVQTnJTYmtiaXErOFZiU1ZadmRxWStG?=
 =?utf-8?B?YzZsVHIwM2xWSWJ3c3RBdWZmNENzWXNzWWVRbk9DQk5Vcit0a2lVRlVYNVoz?=
 =?utf-8?B?N2p1cFp3RElVL25ralZYQ2ErZEtHemd2MklNQ1c5WkVESXdiTHFLWVRDdGJ6?=
 =?utf-8?Q?a00M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bc678b-01d8-4be8-e813-08dd5ba5248b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 05:18:19.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEbj8H7GrjAwdxf9jKddm4goY5FoT1c1irWT6EEB6+9EyGQsxue2DYUlWHpgNFMkHRi/SVJeiCQKfE7sJACCKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzLCAyMDI1IDExOjI1IFBNDQo+
IFRvOiBEYXR0YSwgU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT4NCj4g
Q2M6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+Ow0KPiBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBU
b255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+OyBKYW1lcw0KPiBNb3JzZSA8amFtZXMubW9y
c2VAYXJtLmNvbT47IE1hdXJvIENhcnZhbGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3Jn
PjsgUm9iZXJ0IFJpY2h0ZXIgPHJyaWNAa2VybmVsLm9yZz47IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2Vy
Lmtlcm5lbC5vcmc7IGdpdA0KPiAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY1IDUvNV0gRURBQzogVmVyc2FsIE5FVDogQWRkIHN1cHBvcnQgZm9yIGVy
cm9yIG5vdGlmaWNhdGlvbg0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBm
cm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3Blbmlu
ZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9u
IFRodSwgRmViIDI3LCAyMDI1IGF0IDExOjMyOjEwQU0gKzAwMDAsIERhdHRhLCBTaHViaHJhanlv
dGkgd3JvdGU6DQo+ID4gPiA+ICt1bmlvbiBlZGFjX2luZm8gew0KPiA+ID4NCj4gPiA+IFdoYXQg
aXMgYW4gImVkYWNfaW5mbyI/DQo+ID4gVGhpcyBpcyB0aGUgcm93IGFuZCBjb2x1bW4gcG9zaXRp
b25zLg0KPiA+IFdlIGFyZSB1c2luZyBpdCB0byBleHRyYWN0IHRoZSBwb3NpdGlvbiBmcm9tIHRo
ZSBhZGRyZXNzIGRlY29kZXIgcmVnaXN0ZXJzLg0KPg0KPiBOZWVkcyBhIGJldHRlciBuYW1lIHdo
aWNoIGlzIGRlc2NyaXB0aXZlIGFzIHRvIGhvdyBpdCBpcyB1c2VkIG9yIHdoYXQgaXQgcmVwcmVz
ZW50cy4NCg0KQWdyZWVkIHdpbGwgdHJ5IHRvIG5hbWUgcm93X2NvbF9tYXBwaW5nIG9yIGFkZHJf
ZGVjb2Rlcl9pbmZvLg0KDQo+DQo+ID4gPiA+ICtzdGF0aWMgdm9pZCBnZXRfZGRyX3VlX2Vycm9y
X2luZm8odTMyDQo+ID4gPiA+ICtlcnJvcl9kYXRhW1JFR1NfUEVSX0NPTlRST0xMRVJdLA0KPiA+
ID4gc3RydWN0IGVkYWNfcHJpdiAqcHJpdikNCj4gPiA+DQo+ID4gPiBeXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXg0KPiA+ID4gV2hhdCBpcyB0aGF0IGZvcj8NCj4gPiA+DQo+ID4g
VGhlIGVycm9yX2RhdGEgY29udGFpbnMgdGhlIHJlZ2lzdGVyIHZhbHVlcy4gTGludXggZG9lcyBu
b3QgaGF2ZQ0KPiA+IGFjY2VzcyB0byB0aGUgRERSTUMgcmVnaXN0ZXIgU3BhY2UuIEl0IHF1ZXJp
ZXMgaXQgZnJvbSB0aGUgTk1DIGFuZCBnZXRzIHRoZSB0aGUNCj4gZGF0YSBmcm9tIHRoZSBycG1z
ZyBjYWxsYmFjay4NCj4NCj4gSSB3YXNuJ3QgY2xlYXIuIEFycmF5cyBpbiBDIGFyZSBwYXNzZWQg
YXMgcG9pbnRlcnMgLSB0aGUgY29tcGlsZXIgZG9lcyB0aGF0IGFueXdheS4NCj4gWW91IGRvbid0
IGhhdmUgdG8gZG8gdGhpcyB3ZWlyZCBwYXJhbWV0ZXIgc3BlY2lmaWNhdGlvbi4NCldpbGwgZG8g
dGhhbmtzLg0KDQo+DQo+ID4gPiA+ICsgICAgIG1jaS0+ZWRhY19jYXAgPSBFREFDX0ZMQUdfU0VD
REVEOw0KPiA+ID4gPiArICAgICBtY2ktPmN0bF9uYW1lID0gImFtZF9kZHJfY29udHJvbGxlciI7
DQo+ID4gPiA+ICsgICAgIG1jaS0+ZGV2X25hbWUgPSBkZXZfbmFtZSgmcGRldi0+ZGV2KTsNCj4g
PiA+ID4gKyAgICAgbWNpLT5tb2RfbmFtZSA9ICJhbWRfZWRhYyI7DQo+ID4gPg0KPiA+ID4gRG86
DQo+ID4gPg0KPiA+ID4gZ2l0IGdyZXAgbW9kX25hbWUgZHJpdmVycy9lZGFjLw0KPiA+ID4NCj4g
PiA+IHRvIGdldCBhbiBpZGVhIGhvdyB0aG9zZSBuYW1lcyBhcmUgY2hvc2VuLg0KPiA+ICNkZWZp
bmUgRURBQ19NT0RfU1RSICAgICJyODI2MDBfZWRhYyINCj4gPiBtY2ktPm1vZF9uYW1lID0gRURB
Q19NT0RfU1RSOw0KPiA+IGh0dHBzOi8vd2ViLmdpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQNCj4gPiAvdHJlZS9kcml2ZXJzL2VkYWMvcjgy
NjAwX2VkYWMuYz9oPXY2LjE0LXJjNCNuMzE2DQo+ID4NCj4gPiBodHRwczovL3dlYi5naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0DQo+ID4g
L3RyZWUvZHJpdmVycy9lZGFjL2k1MDAwX2VkYWMuYz9oPXY2LjE0LXJjNCNuMTQyNA0KPiA+IG1j
aS0+bW9kX25hbWUgPSAiaTUwMDBfZWRhYy5jIjsNCj4gPiBodHRwczovL3dlYi5naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0DQo+ID4gL3Ry
ZWUvZHJpdmVycy9lZGFjL2hpZ2hiYW5rX21jX2VkYWMuYz9oPXY2LjE0LXJjNCNuMjE4DQo+ID4g
bWNpLT5tb2RfbmFtZSA9IHBkZXYtPmRldi5kcml2ZXItPm5hbWU7DQo+ID4NCj4gPiBsZXQgbWUg
a25vdyBpZiBtY2ktPm1vZF9uYW1lID0gcGRldi0+ZGV2LmRyaXZlci0+bmFtZTsgaXMgZmluZS4N
Cj4NCj4gSSB0aGluayB5b3UgZGlkbid0IGdldCBtZSBhZ2Fpbi4NCj4NCj4gYW1kNjRfZWRhYy5j
IC0gdGhlIHg4NiBkcml2ZXIgaXMgY2FsbGVkIHRoaXM6DQo+DQo+ICNkZWZpbmUgRURBQ19NT0Rf
U1RSICJhbWQ2NF9lZGFjIg0KPg0KPiBDYWxsaW5nIHlvdXJzICJhbWRfZWRhYyIgZG9lc24ndCB3
b3JrLg0KPg0KPiAidmVyc2FsbmV0X2VkYWMiPyBUaGF0J3MgcHJvYmFibHkgYmV0dGVyLg0KV2ls
bCBkby4NCg0KPg0KPiA+ID4gWW91IGRvbid0IG5lZWQgImlubGluZSIgLSB0aGUgY29tcGlsZXIg
Y2FuIGRlY2lkZSB0aGF0IGl0c2VsZi4gQW5kDQo+ID4gPiAicHJvY2Vzc19iaXQiIG5lZWRzIGEg
YmV0dGVyIG5hbWUuDQo+ID4NCj4gPiBXaWxsIHJlbmFtZSBpdCB0byBwb3B1bGF0ZV9yb3dfYml0
DQo+DQo+IE9yICJhc3NpZ25fcm93X2JpdCIgb3Igd2hhdGV2ZXIuDQo+DQo+IFRoZSBmdW5jdGlv
biBuYW1lIHNob3VsZCBiZSBkZXNjcmliaW5nIHdoYXQgdGhlIGZ1bmN0aW9uIGRvZXMgYXMgY2xv
c2VseSBhcw0KPiBwb3NzaWJsZS4NCj4NCj4gPiA+IFdoeSBhcmUgdGhvc2UgZnVuY3Rpb25zIGNv
cHlpbmcgc3R1ZmYgYXJvdW5kPyBXaHkgYXJlbid0IHlvdSB1c2luZw0KPiA+ID4gY29scyBkaXJl
Y3RseT8NCj4gPg0KPiA+IFRoZSBjb2x1bW4gYml0IHBvc2l0aW9uIGlzIHVzZWQgaW4gY29udmVy
dGluZyB0byB0aGUgcGh5c2ljYWwgYWRkcmVzcy4NCj4gPiBXZSByZWFkIGl0IGF0IGluaXQgYW5k
IHVzZSBpdCBldmVyeSB0aW1lIGFuIGVycm9yIG9jY3VycyB0byBnZXQgdGhlIGFkZHJlc3MuDQo+
ID4gRGlkIHlvdSBtZWFuIHRvIHJlbW92ZSB0aGUgcmVndmFsLiBPciByZWFkIHRoZSBlcnJvcl9k
YXRhIGV2ZXJ5IHRpbWUuDQo+DQo+IEkgbWVhbiBzaW1wbHkgdXNlIGNvbHMgaW5zdGVhZCBvZiBh
c3NpZ25pbmcgc3R1ZmYgdG8gcHJpdi0+Y29sX2JpdCogYW5kIHRoZW4gdXNpbmcNCj4gdGhhdC4N
CldpbGwgZG8NCj4NCj4gPiA+IFdoeSBpcyBwcm9iaW5nIGEgd29yayBpdGVtPw0KPiA+ID4NCj4g
PiA+IEV4cGxhaW5pbmcgKnRoYXQqIGlzIHdoYXQgYSBjb21taXQgbWVzc2FnZSBpcyBmb3IgLSBu
b3QgZm9yDQo+ID4gPiByZXBlYXRpbmcgdXNlbGVzcyBpbmZvLg0KPiA+IFRoZSBSUE1zZyBwcm9i
ZSBpcyBpbnZva2VkIGZyb20gYSB0aHJlYWQgd2l0aGluIHRoZSB2aXJ0aW8gZHJpdmVyDQo+ID4g
cmVzcG9uc2libGUgZm9yIHByb2Nlc3NpbmcgdGhlIHJlc3BvbnNlIHJpbmcuIElmIHRoZSBwcm9i
ZSBpbml0aWF0ZXMNCj4gPiBhbiBtY2RpIEFQSSBjYWxsLCBpdCBibG9ja3MgdW50aWwgdGhlIG1j
ZGkgcmVzcG9uc2UgaXMgcmVjZWl2ZWQuDQo+ID4gSG93ZXZlciwgc2luY2UgdGhlIG1jZGkgcmVz
cG9uc2UgaXMgYWxzbyBwcm9jZXNzZWQgYnkgdGhlIHNhbWUgdGhyZWFkDQo+ID4gdGhhdCB0cmln
Z2VyZWQgdGhlIHJwbXNnIHByb2JlLCB0aGUgdGhyZWFkIHJlbWFpbnMgYmxvY2tlZCwgcHJldmVu
dGluZyBpdCBmcm9tDQo+IGhhbmRsaW5nIHRoZSByZXNwb25zZS4gVGhpcyByZXN1bHRzIGluIGEg
ZGVhZGxvY2suDQo+ID4NCj4gPiBUbyBwcmV2ZW50IGl0IHdlIGhhdmUgYSB3b3JrIHNjaGVkdWxl
ZC4NCj4NCj4gVGhpcyBpcyBqdXN0IGluc2FuZS4NCj4NCj4gSSBkb24ndCBzZWUgYW55dGhpbmcg
aW4gYW1kX3NldHVwX21jZGkoKSB0aGF0IG5lZWRzIHNvbWUgcmVzcG9uc2UgZnJvbSBzb21lDQo+
IG1jZGkgdGhpbmcuIElmIG5vdCwgeW91IGRvbid0IG5lZWQgdGhlIHdvcmsgcXVldWUgdGhpbmcu
DQoNClRoZSBhbWRfc2V0dXBfbWNkaSBjYWxscyBnZXRfZGRyX2NvbmZpZyB0aGlzIHNlbmRzIGFu
ZCBycGMgKGNhbGxpbmcgY2R4X21jZGlfcnBjKSB0byBnZXQgdGhlIGRkciBjb25maWd1cmF0aW9u
Lg0KDQo+DQo+ID4gPg0KPiA+ID4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgTlVNX0NPTlRST0xM
RVJTOyBpKyspIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICBjb25maWcgPSBwcml2LT5hZGVjW0NP
TkYgKyBpXTsNCj4gPiA+ID4gKyAgICAgICAgICAgICBudW1fY2hhbnMgPSBGSUVMRF9HRVQoRERS
TUM1X05VTV9DSEFOU19NQVNLLA0KPiBjb25maWcpOw0KPiA+ID4gPiArICAgICAgICAgICAgIHJh
bmsgPSBGSUVMRF9HRVQoRERSTUM1X1JBTktfTUFTSywgY29uZmlnKTsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICByYW5rID0gMSA8PCByYW5rOw0KPiA+ID4gPiArICAgICAgICAgICAgIGR3aWR0aCA9
IEZJRUxEX0dFVChERFJNQzVfQlVTX1dJRFRIX01BU0ssIGNvbmZpZyk7DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgZHQgPSBnZXRfZHdpZHRoKGR3aWR0aCk7DQo+ID4gPiA+ICsgICAgICAgICAgICAg
aWYgKGR0ICE9IERFVl9VTktOT1dOKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gPiA+ICsgICAgIH0NCj4gPiA+DQo+ID4gPiBXaGF0IGlzIHRoYXQgbG9vcCBzdXBw
b3NlZCB0byBkbz8gRmluZCB0aGUgbGFzdCBjb250cm9sbGVyIGJlZm9yZQ0KPiA+ID4gdGhlIG9u
ZSB3aXRoIERFVl9VTktOT1dOIGRldmljZSB3aWR0aCBhbmQgcmVnaXN0ZXIgdGhhdCBvbmU/DQo+
ID4NCj4gPiBUaGVyZSBhcmUgOCBjb250cm9sbGVycyBhbGwgd2UgdHJ5IHRvIGdldCB0aGUgZmly
c3Qgb25lIHRoYXQgaXMgZW5hYmxlZCBhbmQgcmVnaXN0ZXINCj4gdGhhdCBvbmUuDQo+ID4gV2Ug
dXNlIHRoZSBkZXZpY2UgdW5rbm93biB0byBrbm93IGlmIHRoYXQgaXMgZW5hYmxlZCBvciBub3Qu
DQo+DQo+IFRoZSBmaXJzdCBvbmUgdGhhdCBpcyBlbmFibGVkIGhhcyB1bmtub3duIGRldmljZSB3
aWR0aD8gV2hhdD8NCg0KVGhlIGxvb3AgaXRlcmF0ZXMgdGhyb3VnaCBhbGwgOCBjb250cm9sbGVy
cywgY2hlY2tpbmcgdGhlaXIgY29uZmlndXJhdGlvbiByZWdpc3RlcnMuDQogSXQgbG9va3MgZm9y
IHRoZSBmaXJzdCBlbmFibGVkIGNvbnRyb2xsZXIgYnkgdmVyaWZ5aW5nIGlmIGl0cyBkZXZpY2Ug
d2lkdGggKGR0KSBpcyBub3QgREVWX1VOS05PV04uDQpPbmNlIGl0IGZpbmRzIHRoZSBmaXJzdCB2
YWxpZCBjb250cm9sbGVyLCBpdCBicmVha3Mgb3V0IG9mIHRoZSBsb29wIGFuZCByZWdpc3RlcnMg
dGhhdCBvbmUNCj4NCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlzLg0KPg0KPiBo
dHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0K

