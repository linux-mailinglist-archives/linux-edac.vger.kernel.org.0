Return-Path: <linux-edac+bounces-3011-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A25A302E6
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 06:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C4C3A62B3
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 05:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922461E2823;
	Tue, 11 Feb 2025 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="30eyIeos"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9717580;
	Tue, 11 Feb 2025 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739251782; cv=fail; b=MVJdw9GwaQqe1R+7cWa4Pp5knqbodcG8dYLGWvkMvwbnvKuclkfrf4JQiGPfyRanhYv3v/8bV6ZijxJNRQ50ICNPk8AvPTA4ihDb/Mk/UveDOngQnEj781xjNbzwHz0EDRRvrSQTklLkgFCLiQqrbbKtaEAsuaLZIn+Qxk7kYZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739251782; c=relaxed/simple;
	bh=H6/9j07s3U4P7WkCX6sYOWxaYCwfCrnVBMPCK8zfRJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LK3soj8hUScnl9L7xmjY7joQ66k0dwRNOfxu1CR1ZXRIaodtzvuwGXu99Fh+039yOgE0CE+LOwgPOxmLmGurg5I0Nmnnqe/XnUTdmTel8egaWcJG95eauP3YHRiPNNNayIP9yXltd7IDnEK5IB+LNw6qdW8ycTL+vGpVwoa7q7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=30eyIeos; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSLOG9U2rnX8KSHPwzDlZEW18+dKZdjyyvlEEpCNEcWPIVOqBeAzvJTrbCpdfJ4BddXfWfcig6aA1nvTEblymHSQfmc/fcuXgY/szZ1mvJB0GAFinRiZ5R/QwGE+e2xLOvRhuxFrINXQe2kDRjaHqxk1eHeK+pooGtz8MGyy8DCfEV07L6G55F1KjfZ1PPO2653apsHu51mt3/r5sTntml+o3dpIN75jSBy/CiB5AqDiBjo51lsZsHQB/A1jQjKaRMPv7WhHtKaM8I/mgjZdSBGKnSOWVM8wUvYj+TkjjPJcLhUVRSHpwN8CUGtrmmDLGSwoy9A4161WmJqWKLHxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6/9j07s3U4P7WkCX6sYOWxaYCwfCrnVBMPCK8zfRJs=;
 b=OslCMnfx26zSe4IqhtmXRTtI2JThnjKYnwNZIiPovcqVTk8pFYa+8/Azcb81eMChUfssHrXo645BS0zPohsCGKEnMAPOw+0Nd3pV+gX8SCA1HaQoFBO+zWH1lLVac1KzxFcwGax4qveSTpbz8+12oPI8x18zUPbF6h/x8SjRE4nV337+gf9Z7gEtvRYW9qAjw/XlHldEV91JhNf3+fugw65JL8F3GXDMyAPvGnEwpFKG/abXbhn5Tr8U47wHpBKQpY2TfSk5qc2vHyOL+WfvPKsPMSHBETxGkzk/5/ZX54Z+wSyRTyRg6SQz1SezCCpn50p8NLXDhG1ONjfewV0HDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6/9j07s3U4P7WkCX6sYOWxaYCwfCrnVBMPCK8zfRJs=;
 b=30eyIeosUp9pv3YIbOYWk0WVYjyVMwQXnIIjnD3Z8FACkfhlJ6JCVfP7ZB4MQqjJpiXEvGWYSCpEzNHmBjEqJIKqtp22TwzMsXbwMHSqYFmyShu068ZKwtItFz5mvAPC/BzPoHhkCcN/GFyGBE3+trfcz4dN+loGXc2ajq7p9o8=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 05:29:36 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 05:29:36 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>, James
 Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v5 1/5] cdx: export the symbols
Thread-Topic: [PATCH v5 1/5] cdx: export the symbols
Thread-Index: AQHbX/yvWkoMZqrXkEu20qUwDRd/nbMYeTgAgClSKGA=
Date: Tue, 11 Feb 2025 05:29:36 +0000
Message-ID:
 <SA1PR12MB894784C196AFCAB18B86130C81FD2@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-2-shubhrajyoti.datta@amd.com>
 <20250115222702.GCZ4g2NhPjxGq0OmeC@fat_crate.local>
In-Reply-To: <20250115222702.GCZ4g2NhPjxGq0OmeC@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d53a5f44-0c94-4957-b024-59a7f7df2faa;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T05:27:43Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|PH0PR12MB8150:EE_
x-ms-office365-filtering-correlation-id: 282dea67-49d3-42d8-634e-08dd4a5d12ac
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzRHUlBOSXVLNEFEaEZHTjBrMVRFcjZhL0pQOVRKTWYrdHVNUmNxOVUya043?=
 =?utf-8?B?Q21XWS9ndUVhNGJqVU5NeE9yVDBrZmQyR0xkakhXMlppelkxUGI4Z0cwWmVL?=
 =?utf-8?B?NnJHUC9DM1hGUFJkUWc0QllwK2hIVXliWHRSQVNyRnl0Wk9ja3dueWpHNlgv?=
 =?utf-8?B?UHJ2cEQ0czdqR3hHR0h6aG5Fb2RhVlpya0R5RWVXa2libHFsYmxlRHNzcmhP?=
 =?utf-8?B?Y2NWRW9mcTlmdlBpOWM4dWZGYWtkNGFVVjN0SFpNbVZEMUFCU1hjZFNiUUlz?=
 =?utf-8?B?eHE3enhOUnd1YXl3SWZFSUZ2UlY1UTZCYXlRZXY4NWZaN1YxdXhocjlmdlhj?=
 =?utf-8?B?SGFvWGk1aGI1MVFySHhHTThFSzM3dk5jc1hjWUl1NGF2c1pRSCtmeVVEK1lV?=
 =?utf-8?B?bFhKNCtha041Vmg1YjcrZXlBMDZUNHZMaUFUS1V4bFUrU0FzZTRTTmdsN0RQ?=
 =?utf-8?B?S3JwUFZaWEdEcVB3RmM2ZEJ2d2RERC9tYTVjZXJHcjNXaGFsUEt1VEVSSmZP?=
 =?utf-8?B?dFJyc0hpNGdzWWJiN3hJQm9ubUJ4Zjk5bW5pSllwbVFSZmcvZ0UvQVBuN3E4?=
 =?utf-8?B?SGRrMGNaeG1yWjBvL1VENlFCTllDR2xyTVVrMysxZXpiWVlmRHROb2ZKOTNP?=
 =?utf-8?B?QjBiS21INWZTL0p6dkpRdTFPcHN3ODFKZy9kVjlkMWhKbGQzZGpNREp2c2lM?=
 =?utf-8?B?UlczWWxEbHZtZTBVa0cxU01FbkZVKzhUQ1RPN3p6N28wTE1lVzI1aGRTSnhx?=
 =?utf-8?B?TGJST2dBTnEvc1A4alRXbmw5aG1uQ01yaWx6bko2bDQ3SFVpRllYekFwRnNE?=
 =?utf-8?B?U0R0bU55NExaRjJNa0REZEV3VTRQdDA5cHo4ak5DY2hVdXFGaTlGR1FLWG1x?=
 =?utf-8?B?cjVFUUdabnpyaE9Da1JGaGwwUG5SNzZzSWxmQzd6RVBBMHNEaGZXV2ZIRmJ3?=
 =?utf-8?B?eXQ3M3VZZGVVM1YyQ2FxTGNBcjZBTWxPclJVNzkzMXJsWjJHN3BTck40QWtB?=
 =?utf-8?B?L3Y3cEdqS1JLMzl5OEk3WEVzM0Z6WWJIcXdsL1BwU1M0SUFRTC9rbFVKbFpq?=
 =?utf-8?B?Q1RwT2ZkMUNldWhWOGNDdy9uY2dsS1pmQU1JTktrWEJJcDVYd2JiOG5zMmJu?=
 =?utf-8?B?TVNqdFptUFh4UHc0U2x3UFI3MmxKUm5PVGZGMHF5SUdxaXRZR0htbmtzd0Y5?=
 =?utf-8?B?d1lITVlVNGt1V013Z2ZMQVBDVk15UmhNRlVBUHY3azM4RXQ2MEtPa0tvY0lH?=
 =?utf-8?B?d1BacG9DRDB5VHFuWVRHbklwbHpRL3NkUXd6R2s3L2p3M3NUdktOblg0SDI5?=
 =?utf-8?B?S2tvVmlUaUJTbEtvWTNIVFJrSU1za3JQSDNPZ29rL0NQdDY0MmFQNm9DQ3RR?=
 =?utf-8?B?N3o2MjBrSWxFSVJzWnFGdDA4dlJuNGlIWWptb3N0OGV1U1BlU2luUGhnMmRs?=
 =?utf-8?B?M2luTGJ0bDR1Z05oOWw5MW5PTmZ2WThmTTNxZUVOOGFkQ3Fzc3F5akdod20r?=
 =?utf-8?B?a2tpbTZuYktMbStKZXNUVzRPSnQvbnMvZXE1ai94ZWdZVVNsNVpSdUV3MGNW?=
 =?utf-8?B?bFJrT1p6Sk1veGtXM24vd1RjQUtxNmp4WVN5cTA5TThibWx4TlBLVytwZFNu?=
 =?utf-8?B?VmprNVZvVnF0cFRkSlN4WDNOQ2hXcjdyVXZJTnJmS05keUFQZjVrOGdnK096?=
 =?utf-8?B?aXNJWm9zWTZLRkZNWXBtT252czZNbWNheUhNMUEyZWlrRThiWkdaVkk4amYy?=
 =?utf-8?B?ZkxyZENJYUJqWlE1bXlwWHo2SVVab1ZmVUs3YnZRYnVWN1hHOW52dlZRUG54?=
 =?utf-8?B?dks5ZXJ1aEdkVGU0WTQxV2xFRTkrTStzQjBpNTF3MlZvTTVWSGdKUnJRd3Ix?=
 =?utf-8?B?Q2dMR1lzTlFzQ2dVRVNIaGZCdXBYa0ZRbTlEZnprTlg1NTEzd0c5KzYrajY3?=
 =?utf-8?Q?+GU+B032n4tBNzW6MFMJa/XohfBE8W/9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjM5YjQ2bi9HMS9RSU5GbXFpQ0FmVm9DY3BXbm1NOVpSc2xmSGJwTHlJRVI3?=
 =?utf-8?B?QU5TNVlQcHMzZ1pHenNBRU1HY2MyM3N2VE15eG9wcjVDQkJ2VUpBbnVYSjN6?=
 =?utf-8?B?QzNtcmJpdHZMOE1XTzBQTG1Da2hMVzk0T0duS0FYQTZiMU9iaXVFZVl4TTZh?=
 =?utf-8?B?cDZEbkdDWnRQRXczMG4wOS9KT1hCMEtWMUxtQkZuK1cvelFMNm1uMGtjdThY?=
 =?utf-8?B?RFpJaTlPTklWaWxwbHhPS2Y1LzFOVGF3R3pNcFhnaFVkY3dmVGRsK3pIejl1?=
 =?utf-8?B?TkdtWVV0VkRUaDRWZjhJNVNpNTI0c0lrVVdWQTdqTStlaEhrZVdNMjhyOXhi?=
 =?utf-8?B?dFZNdEprS3lzRGNCWnJxaU1GdUhZQlpkMFlTcWwxRElLN0VMTFBmcHpzM2tu?=
 =?utf-8?B?TmowRDBjWjhEODZjWXQ3Mis4Z1NxdUxXd2d3OVZhZ2xObzYvMm9BbEZkUVVn?=
 =?utf-8?B?cTB1MnBMZkh0WFp2VHhmZWd2VkRpNzhhdWJUZ0lBSUN6Mk1GYWQyYlhsUEVJ?=
 =?utf-8?B?bnh3Q25ORTIzN0hUQm1ja3JtU2trVjdiY24vQ1ZtTHFBSlhiaXFvY0dkSGR0?=
 =?utf-8?B?MXpLZmlIcXhSVDJUV3EycCs2Z3R0bHlCUGxKRDBpQStEVENlMGViT3BFVWxn?=
 =?utf-8?B?QlV3WVoyTXNjVGN4ZlVLOS9GZWV3ZHlaWWliZ3FPbFpFaFB3UU5FTTRjU0cr?=
 =?utf-8?B?ck5xcEkwcGJFbnpZS3ozclBwV210a1JRM2crMllDYUU3Q0hReW9PbVA0cHVr?=
 =?utf-8?B?elBxdGduWHd6SnozeDhCRXJJZkFnQnBHVFNFTExRMkNQaFVzcUtrdmdTTDNu?=
 =?utf-8?B?OGhZbzJ1Z216T2wwd0FrSEFzam4wM3ZORXZWQUdxcThuRjRUaE5VaDNxZ2NZ?=
 =?utf-8?B?dzB4eGRCcHZmeDhDSFk5NVNyclg0ejlmWGZBcmQ3dlZxb01ZN3VNQ1I2MVZE?=
 =?utf-8?B?UHRXQnFtSDM5YSsyTDhyWFdQWndiM0FxT3JCVmxYcTg2Mmh4a3V4U0VBOTd5?=
 =?utf-8?B?RERtdEdzRS84Z0ZDVDdQRk45dUEwczAxc1ZXcThvc0NiT0hkakhUa0xmT2lh?=
 =?utf-8?B?Qjh3cjRleTlqeU5uN1lobE1UaVoyWmN5SGdpQWJDTVg2VCt2eFhVSGpGVElp?=
 =?utf-8?B?eGwxU3NuMFJ5elM0YUlPTVZJbWpqRjVmOWQ1SEpRb1E1YVJCcE9TRlBiUHpy?=
 =?utf-8?B?M0RCSEhhVlJGWU9kSW4xaFFGVVFiS0Z3SU4vTHczZnRVVWxlaVp6Y2daRmFB?=
 =?utf-8?B?dU1ZZXpQdU53Q0hNMm9QVUN2eTk1WWJXR3JTN3N1M0l6a1Z4ekp4ejVPcFgv?=
 =?utf-8?B?WVF1ek03d1VpMHdBNklRem93SWJZYjVFeHdXb1dBV0FpOWZYUmU1YmFYWHhm?=
 =?utf-8?B?WGQ4VjNXMXV6ZE9VNTdTUkVWTGpxV3ZHVlhUcTJnaFh2bm9WdllHVEU1TnUy?=
 =?utf-8?B?Y3dmSkFCb0dwbFFLeVd2dS9pSHFBUUNzZUlvcy8rRHM3VUlVSW0rWDVTQkFU?=
 =?utf-8?B?M1dWM3I0akNpMERsMEJLeWUrV0FhMUh3cExNMmwxM1gxUno5SGpjVzRieVhX?=
 =?utf-8?B?MUhtR1VTVWFLMEg1V3QvTnJoWE9ZSThuL2NaaHloSXdmRkVnMExEK1lpMUoy?=
 =?utf-8?B?ak9QajNBbDlVV3lNaFRVMGkwdVBHWTJNVlRoL25NRWFVWjFnTW9EL1RKQnVN?=
 =?utf-8?B?TTVRK0Z5eDBFSnZpS3IxUmxiMmtsbFZRQWIvK3FUT1YvbjhKeGdldThMYWp2?=
 =?utf-8?B?SGt0K0hkMnNFR3UzWDdZV016QTZUcjNaUjVnL1N4OFhsN1E1aUs1K3pGYkxX?=
 =?utf-8?B?VjR2MjV2YWxQa1oxVUJMUnl0UlVwUTN0OXhRbFhOVmNVZksvVU95bktKclZL?=
 =?utf-8?B?WTNoT1JEQTNLN0p5NkYrSGQ4eThVUDlvUXVweHlJNXNyWHZ5SmNTa1U3eGRa?=
 =?utf-8?B?NW11c0lwTFJ2MngySkdWOGVTcjBMd0tYNnhpWFZlUkcyUW9BcVlodzQwclg5?=
 =?utf-8?B?ZzBZcTExOUJoUDNXSWRHcXA5VG9HTnNMVEtnaWFrQVQ4Z2NpRms5R0lWWmhq?=
 =?utf-8?B?YUs2Z1JwMEZXVXdBYmI3ejA5V0NPOUszSUN3Uy9XS3lKMzlqYis4cTA3enNK?=
 =?utf-8?Q?T80o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 282dea67-49d3-42d8-634e-08dd4a5d12ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 05:29:36.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZp8gYhJ9tUKk7ePlcZgiiNZgFxC0rZZ/kMGuhLeiJzNPtc+/qdLticeIAUlaGdfwhFMdtEIN+k/W/OgpKQTDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMTYsIDIwMjUgMzo1NyBB
TQ0KPiBUbzogRGF0dGEsIFNodWJocmFqeW90aSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+
DQo+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+OyBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsNCj4gQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3Jn
PjsgVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgSmFtZXMNCj4gTW9yc2UgPGphbWVz
Lm1vcnNlQGFybS5jb20+OyBNYXVybyBDYXJ2YWxobyBDaGVoYWINCj4gPG1jaGVoYWJAa2VybmVs
Lm9yZz47IFJvYmVydCBSaWNodGVyIDxycmljQGtlcm5lbC5vcmc+OyBsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWVkYWNA
dmdlci5rZXJuZWwub3JnOw0KPiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NSAxLzVdIGNkeDogZXhwb3J0IHRoZSBzeW1ib2xzDQo+DQo+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gTW9uLCBKYW4gMDYsIDIwMjUgYXQgMTE6
MDM6NTRBTSArMDUzMCwgU2h1YmhyYWp5b3RpIERhdHRhIHdyb3RlOg0KPiA+IGV4cG9ydCB0aGUg
c3ltYm9scyBmb3IgbW9kdWxlcy4NCj4NCj4gV2hpY2ggbW9kdWxlcyBhcmUgZ29pbmcgdG8gdXNl
IHRob3NlPyBXaHk/DQoNClRoZSB2ZXJzYWxfcnBtc2dfZWRhYyBpcyBnb2luZyB0byB1c2UgdGhl
IGNhbGxzLg0KPg0KPiBXaHkgaXMgdGhpcyBwYXRjaCBpbiB0aGlzIHNldD8NCg0KRURBQzogVmVy
c2FsIE5FVDogQWRkIHN1cHBvcnQgZm9yIGVycm9yIG5vdGlmaWNhdGlvbg0KVXNlcyB0aGUgY2Fs
bHMNClNvIEkgdGhvdWdodCBvZiBhZGRpbmcgaW4gc2FtZSBzZXJpZXMuDQoNCj4NCj4gVGhpcyBj
b21taXQgbWVzc2FnZSBpcyBsYXJnZWx5IGluYWRlcXVhdGUuIFlvdXIgb3RoZXIgY29tbWl0IG1l
c3NhZ2VzIHRvby4NCj4NCj4gWWVhaCwgdGhlIGdvYWwgaXMgZm9yIG91ciBjb21taXQgbWVzc2Fn
ZXMgdG8gYmUgYXMgY2xlYXIgdG8gaHVtYW5zIGFzIHBvc3NpYmxlLA0KPiBldmVuIGZvciBwZW9w
bGUgd2hvIGRvIG5vdCBoYXZlIGludGltYXRlIGtub3dsZWRnZSBvZiB0aGUgbWF0dGVyLg0KPg0K
PiBBbmQsIG1vcmUgaW1wb3J0YW50bHksIHdoZW4gd2Ugc3RhcnQgZG9pbmcgZ2l0IGFyY2hlb2xv
Z3kgbW9udGhzLCB5ZWFycyBmcm9tIG5vdywNCj4gaXQgc2hvdWxkIGJlIHBlcmZlY3RseSBjbGVh
ciB3aHkgYSBjb21taXQgd2FzIGRvbmUuDQo+DQo+IFNvIHBsZWFzZSB0cnkgdG8gZXhwbGFpbiB0
aGUgaXNzdWUgaW4gYSBjbGVhciBhbmQgZGV0YWlsZWQgd2F5Lg0KDQpXaWxsIHVwZGF0ZSB0aGUg
Y29tbWl0IG1lc3NhZ2UgYW5kIHJlc2VuZA0KDQo+DQo+IFBlb3BsZSBhbmQgeW91IHlvdXJzZWxm
IHdpbGwgYmUgdGhhbmtmdWwgZm9yIGl0Lg0KPg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAg
ICAgQm9yaXMuDQo+DQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91
dC1uZXRpcXVldHRlDQo=

