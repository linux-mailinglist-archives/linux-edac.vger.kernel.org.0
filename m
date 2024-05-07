Return-Path: <linux-edac+bounces-1012-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682F78BEB16
	for <lists+linux-edac@lfdr.de>; Tue,  7 May 2024 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E25C287B1F
	for <lists+linux-edac@lfdr.de>; Tue,  7 May 2024 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3816C866;
	Tue,  7 May 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L2ymjMr0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFB16C864;
	Tue,  7 May 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105127; cv=fail; b=K/WPbOqBaBjvLZwJtS+6vw8CG0gjU9yemoUH7rIJltf36LOw0eMElZnfHP+WJL3WFtf/hknzpmYBEv25GlWoL9r4OKi3PPwz1WqyIj1DKxkGRBUb8JWYaiUIGJ/ErkYoO+1rVJWN8jVx1Gm5NTONHg3AppjCuID4oNTBnl5kSnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105127; c=relaxed/simple;
	bh=SiPz7d4EUQSItmlVblU+QQW5o9owVDzZDTLZNVPHF/g=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HMvO6cl/lppXcaXaA2+R66TROZRbGCBEYicWmgFb8q9qFSqqG4VtrDqyd707Ra8zpYcbyP06AMXEhZFK8SPaifYLMFARZtxSzMP3gN7Qcp3MVGEW8hJE+ZtzkyW4ZB8tjF1GSlsIL10hRMA25/871BbCWKcrbGIqSZ5tpsqZP4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L2ymjMr0; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKG7qCcpxRPVLpMA+MdDPRe7WpucBy16F0ZXBsbnsijdij9Kavwxp59joz/uGYA0ui/llpl2fD0mCAa4UuWBHJo39Fec/KM0qarjHiGavUgamVoQi9JjClx3dIotUelfMUIYMZOccwktWHjCrNk9DAuwVZy5B7TRH6Bs66/dkUPGMYHV8dNUc4hQYruKYvkYP3SSgaaIis1cK4tcr4SVGcFO7j4vGunD2g5+wChERYTeKF0VXbuWpM2DWk6zjHtCQDjC5n34BT4L1KkKRAOagLl+uSw/q0hSUsiQwdAdk+s5FzeqivQIMZgGete1UVAX8RixI9XnSBlAx+u6pW9FLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMibGAWb4wbehkUdrKrdBUuu5H40eJRFMSxPk7Y9bkE=;
 b=TUWZ35kptyyEZ7p3mfKCo1YbSZ1PkpLNMYw9NyLZJ6WXgt8Qe1TEca7qtf5vg1YSKWkNYFRJx079WFrPH3yNpxl5O4M31YyT/OupqiehyJa79kLfljcG4tR/+ne2xLgNruWZAkW4F260IgkKIDSFUShuEGZJBjaP0iSDgnpJl0Z8vkJ9vxitRJP2+S8WzY5MKl5w+TnEuYqiBWLvigXm5Ak6ALbkPSiqJH7uR1BOjzkGA7j8/f2/7k41QANtJjqkTe5rQ079Uqks+KExwjhbX48SL5PvPBRclTy0A4iTpxtmKH3tFd6+aPUrZjOpHFswnsFA+Uxf/zm3jgJkyrq+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMibGAWb4wbehkUdrKrdBUuu5H40eJRFMSxPk7Y9bkE=;
 b=L2ymjMr0gJCPTnHhewkzJwLDR7ztBYfj5T/3Mg/JDqLDNmPMZwjOS+7ws3Eedbp222HniQXoSaLwBHGpfxaXMZ5oNz1zWWHAh3Mc8vm1ifr7q9MOguIvT99MYT9m3oZhW2sJTt2ZSkPWR55dLnWFKiID8gkge9yO2o2Jl12VZck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:05:22 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:05:22 +0000
Message-ID: <8b396843-4505-415e-b989-14bb37245877@amd.com>
Date: Tue, 7 May 2024 12:25:07 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 09/16] x86/mce: Unify AMD THR handler with MCA Polling
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-10-yazen.ghannam@amd.com>
 <20240429134043.GPZi-jWzoVe3bJkyYX@fat_crate.local>
 <7b68f364-a324-4e2c-87be-19cdef4e3ad2@amd.com>
 <20240504145253.GFZjZLxf3lzAHGaHhh@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240504145253.GFZjZLxf3lzAHGaHhh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:408:e9::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b64da7-1814-40e7-0f37-08dc6ec0437e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjlqK3k3b044MW1ydHpwSnlBbnB2MXI1VUtLV2dSM0RjMkJsa0Rqb014K1lo?=
 =?utf-8?B?YU9Rdm9jSmg0bHFBU09QVHBQT2VjMUxiNGtHTDExY0RTSXJBeEIwNzA1bFdh?=
 =?utf-8?B?TW5nR1MzY1J3RTllaGJKRDR3cnRRbXhrNThZcFhNbXcrVGJZbEo1VUxpOWla?=
 =?utf-8?B?MUx6WUNEUUNweGVpRHdpNFQxaHdIZXJ0TWlma2ZIdm96QXJyUXIzblBCcmZy?=
 =?utf-8?B?UTZCK3U0WDNYYk9KemJmNVdOaG1VcWV0bHlIT1Exb1FmZGFxRUdDTVpxOVVR?=
 =?utf-8?B?LytyZldZZnE2dWF0Vm5DRld4RFQwaDh1UWFYcjQ0SnBzWnY0Vlp4M2h2dHpk?=
 =?utf-8?B?NHUxNDNYeGh3RGZYck12M2c2OUFMcG5IQW5jTTl5dDdCMTRvVHoyd0psdmx2?=
 =?utf-8?B?ZFdSQ2wrd1VvQzZ0TUpTN25hTU51QnN6amhMM3FHV0Fjckx3cG5VRnJmclZ1?=
 =?utf-8?B?K0MrdmlodC8rMUk4UFIzTUJvOUQzUFhTSG5Pb0FKQ2JscXJaVENlazMramNH?=
 =?utf-8?B?WEszcEgzODZxQWVuOW1uRmd4TVlpS3BtNVJRcWErMVdlRXlISnNVK0lOeWE2?=
 =?utf-8?B?TVBxWUhHSEZLNUVJcEZBZHBHMG0xY3k2RVJmazRleUpoZUM2MDFqTzFLd0Mv?=
 =?utf-8?B?aElvV3hwOGJWVnIzVVdyV2dDZnBxTHVZcWRVK2NlaTZ2Ry84S0lGQ1RacDQx?=
 =?utf-8?B?bkFna1pvYWZqTXpndGV3QitNVWI1dlNxUDdjeHZKcllvMzdabkpLUWtsWUlh?=
 =?utf-8?B?dWJKOW9pMEttQ01Vb0FXNEsvdjRXb091aVZKM2l5QUhPdHEvR3FwR2xkK3BS?=
 =?utf-8?B?Vm9YeEFQMHgyZUlRRld1aUhFU0x4eXNLSkNpKzNmRmJhUWt4TnJPMVp0NlMr?=
 =?utf-8?B?Rjc2b0VOcUdTUTBzWEVBaWxYdlROMnByOEtqOXVON21ncEJISk1UMVVkT21N?=
 =?utf-8?B?SG0zT2dnZ3hpYVVodlppVWx5UjlsdmJEZ1F5TmlSaEp1Sm1HV1pGS0lQdG1P?=
 =?utf-8?B?a05iU09LN1Y5SVNYU1lmNWpKWDZSb0pEYkxIYmx5NEczSnhZZ2crdGl6V0V2?=
 =?utf-8?B?VkxzTUNXeW5INjY4NzU5VFREWFZyZzdhb21rclJVTVZjd0VDaE5QZlVZdDRX?=
 =?utf-8?B?eFdKY0oxeGxrVm9CT3ZTSnlaU2lBUVFqRCs2Sk5panhKbjM5VlJjcDdLemJk?=
 =?utf-8?B?K2h6MWxoUW42Y0tvUnJaTkg4SW5XbTV3dFhjL1kvVXhlQkdNNHRjK0lMTUZm?=
 =?utf-8?B?SkxFSEQ0UjlQQlVkZ1Z0S1NwOWJ6aEd2SmVURzdxeXh4K01OS0JKYUVSWGlo?=
 =?utf-8?B?OGc3d3VYV1BaRHFyYlBmejVSTWo5T3JxSHpBaUZybWszcTB3R1pFOWtjNVJR?=
 =?utf-8?B?NzNjMGM3M21pb0hLODdVOFFhU2dSWW5RUVZ6Q0JMQ0p5cWwyYWZOTkR5VWhX?=
 =?utf-8?B?WDZscG4xd2t5Uy8yU2NwQW9pUjlsbDBFNklWT045VmNQbEJWWVVobDhFM1U4?=
 =?utf-8?B?SUZTVVNBWmxocVdDNUtBWjR4eXJWbHpyM1Fsb1pybnUwWmZ2MmtENUtCZCs3?=
 =?utf-8?B?UmdTakc1UEwwdXFsWnZJVGJiL3RxbmZaTXVVZUFISEJXMWNxbzVLSkJ0S1Bi?=
 =?utf-8?B?dXRDTnlHMFMvWWlOaFptbFUvVDgwR0VBbXR6TWpkcHFWNU93WVdwdndaWGMz?=
 =?utf-8?B?LzJrVUlORkc0aU9IRU8yMVlRVGxwTE1VUXpBSDBHME01T3hPMk1GcGV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anA0c1liQmxYMjZPNmlsRWdwNkxKV2V1c3hQUjR5eCs0RnVQb21Nd1BIdnly?=
 =?utf-8?B?SEpDNXo1NkYrT0d6SXp3T1luVG1HZUh3czFnNEJpVlFLQWYrc0ZNbllrUHVB?=
 =?utf-8?B?K29Ia0hDUzJQTmVjeGhQbDhKWTNJNGNzK09PdEFUQ3BIV2RhWVNZYlVCM1VK?=
 =?utf-8?B?Z05zZXFXdU9pR1pMSTdrbEUzYXNkK3pHbi9BNkRPQmJ6NzNKVjZnUkN6RTFL?=
 =?utf-8?B?L2ZJNm5SM00rNTNFK3djWHY5VFhMWjc1ZkZ3OTBmVEgreTVVUnAzaGN4NlhL?=
 =?utf-8?B?QXBiSUhnR292bjRkc09QQkpzSk9zTGRMOWp2eFloNmtTcjJhcFBMVWNrMExo?=
 =?utf-8?B?SXFDOUxXamt3WnlvWklmb0p5bmNSNXZUN21wVU45MDVEaC8xRUlpVVUwemUz?=
 =?utf-8?B?YTZ3Ti9WV0J0MzRiQjdHK0dWRnlzenVTYkNrSVlrYWYzbmgvUHBjUm1UZytp?=
 =?utf-8?B?aE9DeTl5Q0VjaGJOUHo5MG1XYXh4dlJpQUpzQmU0alllblVoYnpLN3BCbEVm?=
 =?utf-8?B?WVZFbktCa1hxWTlYVXdjSmxtUXhTTWp6OEJWSUVDQlBXYnNZMDN5MVhnb1Zl?=
 =?utf-8?B?NUQzamEvUWNUY2s2alRlZ3Q1ek5obnN3clFZT2N6bThmUmx6SEIvb2crRFpW?=
 =?utf-8?B?Nk9wdGJMdUc2TW1PQU1wcE42VXlDQk1xb2IwSEtJOWtSVTFzRXFBbGlubTJn?=
 =?utf-8?B?NGsxWGdaSlRMNE1UZ3ZwaHNRdFRHNDEvaEhtRXVVbG54VmozcCtmc2svbTAv?=
 =?utf-8?B?Y0pwejRGOXFtYlFqM2FObk9zTzhFTjlSc2dCNnZnRXhvYTZtN3d2NUhmNUJU?=
 =?utf-8?B?bkNtblY4bXBNV0kyVS90ZnBrdTR2RUdBZXhIVnpONGxZdGtDOHBibDMvRExF?=
 =?utf-8?B?NkJlMENtQi83Z0JlbEU2azNrRUtSUlBUS1l2MFlGVjVyMnV2WVpHd0RuRlhB?=
 =?utf-8?B?RDRieGNwbG1nREV6VHJkUnRuc3p2UWxmMnlNdkFvVVk0UUlnR3IxcjFrRElR?=
 =?utf-8?B?S2FnSzFtRkQ4a0pjdnVxNndXK0wyaWNMT1RGekd0NWNTbHVWb2FnRGc4WWpi?=
 =?utf-8?B?VEJ0NGhFR0c4dGhuSE9XcS9IVWdwcm96SE9kWm5RWU0xL1BBcG0yNDNkWm5l?=
 =?utf-8?B?NnBFS3JiYkFhaUpLdS9TQ1F5T0t0bE5nc3BZcjRPVk9vZDFXUk02SC81S2ND?=
 =?utf-8?B?cHd4dkwwaXlkNUEwaTByZ0EzMWRvZGd5eWZMRHVab3RKSTkrYmk1aDRSRHJI?=
 =?utf-8?B?UFhMemJhUDY4cjNpZ0M0aTVJYlIybkZmU1A3ejI0alMxbHBMZWJqdDlrdlpa?=
 =?utf-8?B?OG4rQ25VMnFoanBEZXBJTUpwY0xZUWtBaXF4SEQ2QVh4aTA2d2ExcUdDNkQ0?=
 =?utf-8?B?b0xXeGtxM1pwVFlzMXNJUWpMc1lqVXYvTHdxQXc3NDJhRVUwNHlsNXZ2eU1B?=
 =?utf-8?B?ZnJPakZCL0IyYW9VVktzTTJrSjNzS3UrZ3lLRXpqWXR4ZEdyYmhaNEplYzgz?=
 =?utf-8?B?Yjc4MHFpZ0REbHlBYmdmRjBoT2ZDSHJaVWtuWlFIMlhHUm5GZ1FqWjNPWWhr?=
 =?utf-8?B?b0dlNVZlNlBzK3J3RWZyZ1lpN05oV09VRDdvVDBmNVFLRTBqZm9yUW5wT1JJ?=
 =?utf-8?B?SSs3RHpFeG14YTI5Zm9IUk5UTEpYTDV5QkFvS3lxajJRaXFneVB1a0VITXZE?=
 =?utf-8?B?R0FLT3pPNlVwUFIrOE04QXpOMDJ5SFVEWWVrcXVvOTNYaE1PanFnS2tLakJX?=
 =?utf-8?B?UkZDZDBpOS9mMGkvQVNlazJHUHVaTFRRL1lMRmZxei92dlI4djM4QUV3S1Na?=
 =?utf-8?B?NmdmQ1czM1FPbGJDWFJwOCtwdTRrMGIrcUc2MjVML2FqNSt6U01WaWJUcytr?=
 =?utf-8?B?cURldmNNblVTYU9UVW4yUUFHZDNqQzNEYnpnSUdpM2c1UzZjQkVTRStWMHl1?=
 =?utf-8?B?bTdnazVHVHNLZ3BLdkdOL3V3azl5bFBOaStmNFp4RVFJZUtscFlUZDRQK2Nq?=
 =?utf-8?B?czhBem5Kb1Q1REJuMU9sVmJsVnM0NHRlRGY1UlVjU1Z6SC9EN2l1SmdsUlJS?=
 =?utf-8?B?bGRFSjVhS2hjQVErZlJIWjk3SEovTTlhaHJxMkVtdkJYZXB6K3F2S1l6ckxU?=
 =?utf-8?Q?KpFAERaXG3lBJ681VoGUjUHcD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b64da7-1814-40e7-0f37-08dc6ec0437e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:05:22.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NZ03WXLXqr/RHHBI+v3MxCuN5oCMGY+YRIYXswys+Sjc88XDJqczg/8jtBiBrI2AwHyzw4QJBzfHQb3sMzYHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717

On 5/4/24 10:52 AM, Borislav Petkov wrote:
> On Mon, Apr 29, 2024 at 10:36:57AM -0400, Yazen Ghannam wrote:
>> Related to this, I've been thinking that banks with thresholding enabled
>> should be removed from the list of polling banks. This is done on Intel but
>> not on AMD.
>>
>> I wanted to give it more thought, because I think folks have come to expect
>> polling and thresholding to be independent on AMD.
> 
> Yes, this whole thing sounds weird.
> 
> On the one hand, you have a special interrupt for errors which have
> reached a threshold *just* *so* you don't have to poll. Because polling
> is ok but getting a a special interrupt is better and such notification
> systems always want to have a special interrupt and not have to poll.
> 
> On the other hand, you're marrying the two which sounds weird. Why?
> 
> What is wrong with getting thresholding interrupts?
> 

Nothing. This patch is not disabling the interrupt. The goal is to get
rid of duplicate code and have a single function that checks the MCA
banks.

This would be similar to intel_threshold_interrupt().

> Why can't we simply stop the polling and do THR only if available? That
> would save a lot of energy.
> 
> So why can't we program the THR to raise an interrupt on a single error
> and disable polling completely?
> 
> Because that would be a lot better as the hardware would be doing the
> work for us.
> 
> In any case, I'm missing the strategy here so no cleanups without
> a clear goal first please.
>

We could do that. In fact, there's a request to use the threshold that
is pre-programmed in the hardware. And we could use some of the current
kernel parameters for overrides, if needed.

Thanks,
Yazen

