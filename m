Return-Path: <linux-edac+bounces-4597-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA12B280C8
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0004D7B98E1
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3EC3019DB;
	Fri, 15 Aug 2025 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="reHJWX4S"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5B3002A5;
	Fri, 15 Aug 2025 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265388; cv=fail; b=Kzephr7k5Sl2onTzpvHC5fUkseOv2Kl2d/n9XEx70u31uOktE6vC8Wmznnu0VcpmoznqmX2+w1gqqTfvVP+Nskyp7vURHWLbxpxI3LiBwHAL+svazJ1s8tUXl3Tp4JW9Gb23mciP9IfCbELWnVV1MQtZHD409y8hvPMEy4Nd0uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265388; c=relaxed/simple;
	bh=MXKZN+WtrX7St6ZE5IUV0LSw6wxgXUd0ftPlbponte4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e26WTJJDTgz5uy2tlAM8KJUAcqAJJr5cXzA8LhO2oumu3RrYl19DRXeuWGw+JxRphOAZsymM033ziGHNs5I1M50zDvkg2SVGnbohMhk+/NEggQc9GR+gthshPlYYTmdLRt8+iIVeCDk8u8ZKitueGRzuNEx/o7xj6cA+XQfVs2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=reHJWX4S; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxqnvkgMB6YBonGuJtXR1cz+2aabPRDxzWG7vmOXH/rwEBgeiZST2eBgpdWg5NjX8c7GBZrJV8dJdqvKdNkZUHO7iKaCeCGz8K+ZJZ2c5IhTtJkeyYzNIDsmBDvD+YeR0PyE2KJfKxsbsYXJJANtbNHCscThdSpmJRmlaaq8YguhNHwLvjbcVUxxup0cC9LP0Jxbz8WjgHjZSKnXkmX/RdAaRudpzjrCjEDv/63BkEntyif5mrgsCN89+vzOdqa9okCtV+x3DpecIReY80FWgl2ynIOLFZXaqGaJVbdgLXRCS+WZszYXzxaBtfBaRZkorZ8kqzG8fE+z6TyzbUFDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMgERtXG3PVWqjPCqzDwRhX+MMWb1X9bkQ0Oy8UsFa8=;
 b=ePcyxaZULIfFzHlpOxSoP0mIHlthFhjU5PUQrAQK4ESy4gJm43rfvbO5y4d1OHJDmCmQ3UCnqHsn9LqAieN4gVTfpQfwRiXpSJevJAqALHqkjtF6yBiRpkoScBSkalc8EbRQr0P+ihyxCTw9tDKBYLGgx0/deoIcmp0IX6mQUGQoLdbxGukzmbd4on1GdlS+5m6UEXlP8M8r5qIHFzrMdnOglYdbhbEiKlhkb9qrOVnQOX11h8o/rb8bJAdrvbM9BT1HRWT6HNV6/HPGHMtYLzo0ygrD7hlsIM5PuwJDuj/PcNk+C7LwSX+iuUC85oNXsmM/jzlWhgvDQP1a389Abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMgERtXG3PVWqjPCqzDwRhX+MMWb1X9bkQ0Oy8UsFa8=;
 b=reHJWX4StTm1OFE/sNrp+y4RXidmf5bjHCWbNTtSKjvMc4o4Yogf79Dx8B0ffQsRzhcIOAUKz61/5le/9uKDv1cw4IOYvod23CEBUTzVweYCTciEWbi02dfg8xtBxx8rECLc0iamsb3g8in5dP7HNbzmSzLXXE8QB5ymImS/MPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Fri, 15 Aug 2025 13:43:04 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 13:43:04 +0000
Date: Fri, 15 Aug 2025 09:42:59 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Message-ID: <20250815134259.GA27834@yaz-khff2.amd.com>
References: <20250814154809.165916-1-yazen.ghannam@amd.com>
 <aJ4U3g4fDNNibUOz@agluck-desk3>
 <20250814193056.GA192444@yaz-khff2.amd.com>
 <aJ4-c0gNPbwwU3jk@agluck-desk3>
 <20250814210730.GA228071@yaz-khff2.amd.com>
 <aJ5gcUsaKK2AXDsu@agluck-desk3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ5gcUsaKK2AXDsu@agluck-desk3>
X-ClientProxiedBy: BN9PR03CA0799.namprd03.prod.outlook.com
 (2603:10b6:408:13f::24) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2541b8ac-a5a2-489c-25a9-08dddc01a8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0pNOVZGNldoTTFRWDk3aEhDd2ltRGsrTU5jMDB6MTQ5YWwydmpKTVV5WlJH?=
 =?utf-8?B?RGw4SUFVZ3kweC9oKzRkQlJGOG42aEJZR3ZyREJEMWdaL3ZEczdVV25FMUNG?=
 =?utf-8?B?Mkl0c1BXRXFwdTg3N2RpMWRLT05wVDdJZ1JVSEhEZWhLNWE5dHJ6cjZVbXow?=
 =?utf-8?B?djJiUzZ0Z0pJWm4xL0NYSitiMkErQ3YrWmZ2NzE5OG9GZnZUUXpUc1BiSnJF?=
 =?utf-8?B?UjFOcStGUUZUNkg3SDRqK29nYjFETm5KTTVRREF1NmREQzBZZG1Kd2F1WUM2?=
 =?utf-8?B?aDk1Vzl1amZzR01jQWRod1NWWXJYdEx2cXp2UHdDYnRkQzRzUFpmcThkUXZk?=
 =?utf-8?B?ZU0rbHRNRFYwamlITmpPY1NIcnozNGNaRUVZaVMvRTNnRGxON0xMU21kMzdk?=
 =?utf-8?B?QTVZeEw0ait1UHB5UnBBVmVHb1Nhd0xqRHR1clFKeURZYUhhYlZkREVTOExi?=
 =?utf-8?B?SGdUckdtNG9OdHpDZkwwc3JsL3FadFI1N2lmWStFUkRpdGdNM3VGUmFPS2hk?=
 =?utf-8?B?d2RpcDBPL0t3R2hGN1d3citnWi81N0cvSGx1VWRSNVViZTNPK0NGWnFISmJO?=
 =?utf-8?B?N3Y2N1lrVmY0NHR1dmxrOU5WZnloazlySnh4djN3UzRtQ2pQOTQ1MmxPRkY4?=
 =?utf-8?B?bFk1S05nK29LS1RsK0FhN3FadDNiQnIrNzl6dWs1ZUhiL3ZjVjBHYS9lT0R2?=
 =?utf-8?B?NTBqMytiYjQ3RjlKYmlTSHptMERwNlh1N1drN1VhWDlsK2grTkZQclkzeExn?=
 =?utf-8?B?THpRL3BYQW1ZQitLS0JhS2hqMUpRQlJvdVlKcC9WdnIvQ1NLY3k4b3hPQ1hs?=
 =?utf-8?B?VzJzNTRoVzVmemhHd0RQUU5YalNVNDVDV0dDNHFFWnJZUlBGaXJIYXBQaEtM?=
 =?utf-8?B?YW8xeHZOZkU4SERYVmgvc3ludXA1Uldpd05Hb1hkQW90M0t5SGNXdmFZbEh2?=
 =?utf-8?B?U0NCeUVEcmplbTdZYkdrMjF5ZGxwcDM0Qk5zZWxyMklwOEExeS9ndVBCM1Zs?=
 =?utf-8?B?VkUzbitsd3gwbjJMc3l0cTMxeXdac1RDZTNBbWtOYnE1SGY0UkJ1dUlLNjg4?=
 =?utf-8?B?YVJybnBzZERKOVNQclYrTCtkZ2ZIMVdFbkt6dGxPaTdYTjBBQkZldDJsTXB4?=
 =?utf-8?B?MUgvcWQ2Z1AxVzhHVndiblRkV2MydTBGUEN2WDg0bFJHb2k1NjBYdzRvZjZr?=
 =?utf-8?B?TDJRUG1kOVVNUUEyRjVtRU5FQXF5VWNkV1A2SVYwV2taQ09ZN2V4ZVRIYlFN?=
 =?utf-8?B?cmtNSE84cVUwQUtlVFpTUHZoMXNYVkRWOHhua3VBVnRCYTM0Q2hsWHV2NFR3?=
 =?utf-8?B?UnV1ZU1aRTBDZGwxYUZ2cWcwR0hFTGVrWDQ4ZU04Mk9kNDZ1a0hTdjM5eHUy?=
 =?utf-8?B?MmFqTzR4cG4zbkJ1aURLWUlxWEJHT0puN2phU1FQMnlBdlJDaVFqcjRnWjZ4?=
 =?utf-8?B?K0xoMXV3WFRra1h0TmRFaXF4OTYvOXgyUEpnY3hhZjdDYmhOM3BRUnBXZ0k2?=
 =?utf-8?B?TlpvN2hjeVlNL2Y0bUl4azYwZGprQlF3ZUZjT3dUcUtEKzR6T2ZjS2JsQWhG?=
 =?utf-8?B?ZVpmQ05BVmhwOXNyaHdKMUFVc2E4eWM2RnFkc2Q0RWRpS1NJNVlEMFQxM3Fm?=
 =?utf-8?B?V1krUjVkNUxvSUlDblY4NVk5aUZkM0tVRlhCdFdCLzFGdnF3TTFmcGt6UWsz?=
 =?utf-8?B?RGNrekxWbTJwYXpFVkdyUFVVRnk2WUpEVmRmY1Z3NkNZeEUxWlExd3JWYnNW?=
 =?utf-8?B?bGpGZ0d6WHZKZnlQYXM4Q1N1RC8yMmRMQkhSdE96dHFTYlNVeXVGRm85ZElL?=
 =?utf-8?B?a2o2MGtDS241NHFySFRkYUFJcGJnd0JtS1pVNHFhQzg1N3VHVGYra0E0UTNR?=
 =?utf-8?B?Qk5NeTJuaXBhRW9GQUxSWEdsd2s1SFFXZWVsbDdGWWp1VUxtM3dTdHpjTzlQ?=
 =?utf-8?Q?aQb3PffUQuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjIzakZJVlltdHBNTURabkxSbkF3R3J6dW12NGkwcmdiZ3F6K3VCSUJFd0Mz?=
 =?utf-8?B?Y1FuNU5nU3JyWnJaWlVQaDlXQTFzU2gvcVJPOG80UVN1VmRaTG5pTjk4ME5V?=
 =?utf-8?B?VVZwQkhpOU9Sb09NYjREMXF3S0NSSlQ0NnpOUUVxKzd1N3kyK01NMnVVdXNw?=
 =?utf-8?B?UUxqNjFjT05wZ3c5cmRaSVIwWWtEbDdid3NqM1d1WHVFQldidUZwM3JRemZw?=
 =?utf-8?B?WkpHM2o3ZnJoQUZlUk5yQlJoMXloUUVudk1qeDJwWjB5ejA4d2xCc3JIZERM?=
 =?utf-8?B?TVcrQnc3UjZoOFhzajFNREpFS3l5NnBLTVk0ZnRsMWJiOFFMcTRSNkFiUExN?=
 =?utf-8?B?RmEzZTV4SHNtYVd4MVNZOWR0NXNSS1NZUGJlOUQ3MC91UTcwRVkzMURlZUJo?=
 =?utf-8?B?bzB3aXFZemUwQ1gxL3FJYmtsQk45dDZ4Y0EyTUxFV3cxVHVWdk91aWVzQy94?=
 =?utf-8?B?OTNLNkFQWmIxNGx5aWJPcVhGZ0NKQ2dndGhLRGZnRVpxY2FUSWFlZkVaaDhB?=
 =?utf-8?B?clREOXhidHpiVHFoR25JRnB0dU52TmhINjVwMVg4dk9jS2djdlNHRFlkUkk5?=
 =?utf-8?B?WlREQnVRRzh3L1NZdk9nMXV1eFJnaXBQYWtQa0tNZWVTZmxHQUs1K2RVNmYr?=
 =?utf-8?B?NE9rNVVMUm55Y3hWYWtyY1RnVVRLbjVXT1NvZ3ZGdjlxdEdNN2I2M0dwSUZx?=
 =?utf-8?B?Qm9WQjNHc2F5SkJMOEMrbTd0WmhVaUR1UzBCV3p0Um5XYjBSR0NCNVFjWjcr?=
 =?utf-8?B?S2xkMlhWdG16a284K1BXc0QybWs0OW9VNHRYYzJrT1ZIODJOUWdweWNla3Ux?=
 =?utf-8?B?TkdieGlKWVBXMVVwTmVsb3R3d01uOFVEdHN0ajEyUmkwazhzQTh0V3ZPelpt?=
 =?utf-8?B?T2JZSGszMHQwM2M4QWNVM3VSMXpaOXJyMjBGT0lqdy9aeG5rSmNhaFRmOTlq?=
 =?utf-8?B?V281SlZOQTlDM3hJSXF0LzU3bjdnTllYOCswcTBWTEtJVGRhRUhURVFKT05L?=
 =?utf-8?B?Y3dDT0tqZVZreE96YVcxeVhhN2phaXVNRnVGUlYwTFhwdnUyK05GcVZzZk9G?=
 =?utf-8?B?SWV2Yy9ycHp4bUd2cTVrb29zQUtKaXZtV1A0THplS05JUmZxMUNyeG9VTHhQ?=
 =?utf-8?B?ZXJobnU0bmtYc1RnVEt4YlF3ZWd4OWNKcjBzQnpMWkJUQU9MSlE0UFpsSFI0?=
 =?utf-8?B?YUMvVUZmcFBOR2NHR294a24xQ0Y0S2xhUXlTUnQyWmJCZGFsd3hnOXFwU094?=
 =?utf-8?B?QW1mUDlSaHdiQkZUOVdHblMzL1RvOWRyMklFQkt4dDYvUW9SVWtoZlR2bHk2?=
 =?utf-8?B?UzFtUzVRakI3UmF5KzNvNlFuUUhCQjJVY0dIZTNaQStsMXdnbXNXenhLSVVl?=
 =?utf-8?B?Y1FxRWZaM1VKdks5UW9OWWkvdWNmUDhnSDZyZUFDRGRFVzlTQ0IyUXN2cTRo?=
 =?utf-8?B?M1hRRFZMYkNxbGlJaURyN2ZRalJKdVdjbVREVjNZZnVtSHRTcmFWQUVkU0Ni?=
 =?utf-8?B?NTkxSWZjZlFJaDlxUExKQWo2UWovNk5Xc0VVRFAzNDdUTGlWQi9TR0lsN1lv?=
 =?utf-8?B?WnpyRjVJTk1tZEpzT3FJcDkzMVd2OS9JMlBUS3g0V1ViYTd3dlZnTW9lTnd0?=
 =?utf-8?B?Q2RjR1F3cjJpaTlQVWZtTCt4NHY1dTBNbDNVdHdIdGVIUmxHcENIeHJ5cjJy?=
 =?utf-8?B?ZWxkMHV2MWRJZGFtempuaXVYS0gyeDNKMmR1WUhPUzlodmp5M0plVmVQdXVE?=
 =?utf-8?B?SUowZ2FQcWljNzA3RVpSVDBlL2RubjFraXlIb0lKb1owQUF2VjFOWUVRSmxi?=
 =?utf-8?B?MjhscHNUcjU3VTVBcm1mWjc0b2JldWdsa3NPbm9aeVBKRHdZWmVQQ0E2bzA4?=
 =?utf-8?B?MTJhdkwxRnlSRUQzdmxrRWpOdkh6SkJGNEZOeE9qbFpNRVZKK1hvdVRpZ0Rh?=
 =?utf-8?B?QUpvRGwrNnU3NFJXcTdyT1o5dnJCL3liRmdFKzVmUlhydGFHeGE0Ujd1UkFW?=
 =?utf-8?B?djR6a1ZONUpNc0xvVDZ3aldrN1VKT3NkTUVmRUV2ZGZHM0tCdFdIcm4yUkta?=
 =?utf-8?B?VkNrUEJSM3hEM294U25kc3FKcXVua21zVDhrVXFIbnU3YU12c1ZDNXBEUGdm?=
 =?utf-8?Q?S9P/5pAY45RcACEj7xCeD/zQL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2541b8ac-a5a2-489c-25a9-08dddc01a8b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 13:43:04.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnN84Y2zV3zK6MchLGtKFlHkS+5AxzHDkVVD/IlTnmCb4/fM5O/3EtLvsx04mJwiRt7Vhgt5caHMZZ5P2z2F8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

On Thu, Aug 14, 2025 at 03:17:21PM -0700, Luck, Tony wrote:
> On Thu, Aug 14, 2025 at 05:07:30PM -0400, Yazen Ghannam wrote:
> > On Thu, Aug 14, 2025 at 12:52:19PM -0700, Luck, Tony wrote:
> > > But the first match nature of the table means that this rule hits
> > > (becauase neither or RIPV or EIPV is set):
> > > 
> > >         /* Neither return not error IP -- no chance to recover -> PANIC */
> > >         MCESEV(
> > >                 PANIC, "Neither restart nor error IP",
> > >                 EXCP, MCGMASK(MCG_STATUS_RIPV|MCG_STATUS_EIPV, 0)
> > >                 ),
> > > 
> > 
> > Thanks Tony. I see what you mean.
> > 
> > Do we really need this rule? It is essentially the same as the following
> > rule:
> > 
> > 	        MCESEV(
> > 			PANIC, "In kernel and no restart IP",
> > 		        EXCP, KERNEL, MCGMASK(MCG_STATUS_RIPV, 0)
> > 			),
> > 
> > ...since we assume "KERNEL" context if RIPV|EIPV are clear after
> > checking the CS register.
> 
> I'm not sure this could ever happen. But if it did, I think I'd like
> to see that message.
> > 
> > The message is not as explicit though. 
> > 
> > I did have an earlier idea that we introduce an "UNKNOWN" context for
> > the !pt_regs case.
> > 
> > We could add the "UNKNOWN" context to the "Neither restart nor error IP"
> > rule. That way it'll be skipped if we have a "USER" context and then it
> > should match the one you want.
> 
> I don't want to do that anywhere execpt that Sandybridge instruction
> fetch case (which wasn't classified as an erratum, because the h/w
> guys chose to set RIPV==0 and EIPV==0 ... but it was a poor choice.)
> 
> > Also, I just saw this in the Intel SDM:
> > 
> > "For the P6 family processors, if the EIPV flag in the MCG_STATUS MSR is
> > set, the saved contents of CS and EIP registers are directly associated
> > with the error that caused the machine-check exception to be generated;
> > if the flag is clear, the saved instruction pointer may not be associated
> > with the error (see Section 17.3.1.2, “IA32_MCG_STATUS MSR”)."
> > 
> > But I can't tell if this is true just for P6 or all, because the CS
> > register isn't referenced again with EIPV.
> 
> Should probably have said "P6 and newer". The intent of EIPV is to
> indicate that this machine check is because of something that happened
> on the current CPU (remember this bit was defined when all #MC on Intel
> were broadcast, so knowing which CPU(s) are involved, and which have
> just been pulled in to the #MC handler by the broadcast was very
> important.
> 

Okay, fair enough. It seems like these quirks should stay. Thanks for
the discussion. It really helped me better understand these quirks and
their history.

Thanks,
Yazen

