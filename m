Return-Path: <linux-edac+bounces-1188-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BA8FD014
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE1929947E
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745C19148A;
	Wed,  5 Jun 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sf8q4yhs"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFB383;
	Wed,  5 Jun 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594919; cv=fail; b=NwUw78BIn3RCk5Xa+d9R/CPQKlsRmUwdKMKCq6AsYQzYMVy/+a2br+1va9kHVtP2tvnd2Qv4gqWQcMl6IVCwR7+bxHbCKjcutMWur7cWJOm3e6QjO7eHtogQJwJEwFwq4vcY4cnqJqMieI/XGF5pFCWuZoXe87Hf0UtsPxqxmhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594919; c=relaxed/simple;
	bh=xnnzv6o6CYD4nt9PpMAtXLVUSTr4hRv8a1/gEnjtemA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qlFSwfFStaHk6HFsUWL+Us2A0l7xIGWPUTL8i+1ldXmecCk/bTL9zQPZT9qITqLPTe/j+tCwBcAFHCmrnILI0oCQfR1AH01DE9b5uNH+SCI668N7IqW00PbnokQiQ3adrbrMDZRZRY/e37xjCwn+lcTQwye1Zrxly6D1rIyU1+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sf8q4yhs; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7FrorNizfpoUnNELAWgiFLlL2jIaNMMhdW5tZSsWPDvF7qBo5BTq6cQKN/XRzdnn6GyVYc9Ldke511uZtJn88/7FC3QWDq0vG/ywEWc4dHtAOzI5jQl/NFvtymKapcdANS7+BDDUNQ0CJJLnMx6u9y6cN9Ga5/OT66vFYwvzROYjdbf8OZxXA8o+x1vgxJIszXvU1AOUiejCizo2SFVQ9TODLt6m2lkEes7H2W8igVR6ke9TQrpu9LuirxKp+yRLBwFFetIoYKkmCIU87zGcrAELZFRyNawCXTPGe0dnAP7fiCP9cXuv3sXORR5ppJl6wPtnNm9tRwzDIBvWxYMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyFh5yDpnm95ARvDeNORO1fW5PRywgDA9eesDdbh1YM=;
 b=FL1uShYiS9CMqama11Fiszq3SYGTzbQ0Wc1V7dKqVHi2zDkwUtzI+Mc/OuopO2t40nN1EuKtPlPS+0x6KbYzsGqXCCQAPZGLkCitm5MoV/l6F0ssaB8yqzydvyNMsCyRNByCrLm92xYFclwesAzP0V1rixzC4PenyJSU8I1Qj5EsFx+hMNt+D2xz18VCxIj4jnbXHjfGi5rfpB336D6XNtlb7vyFFdUI4aNXUYg3l2zOyHAlR1STWJPFARCkdQTsn31Wxrlu/8tWfQHMau2gUQZdzr9MGN1s8fkwJsR27dsWrSCYfxMrRhVRMpRXI3c7Ataa1K8v8OYfLoDUBiVx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyFh5yDpnm95ARvDeNORO1fW5PRywgDA9eesDdbh1YM=;
 b=Sf8q4yhsAdY7y9XaVXEVX8dPFLx2aDFBwqIUwEj8oqCEVqqlsKuNmBzHEEF728hSNgmW487odB2akcFRJlJdDQ1oSoJmTje7ZUCMRIZqDma2Moosi8Qf/2aS9MqDMJq7EZPiLjPowxS6qaUYkf3Mxcq8/HUUmWjrugfqqIXEzI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Wed, 5 Jun 2024 13:41:53 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 13:41:53 +0000
Message-ID: <7a7c2f41-1608-4348-9183-d99aaa51398e@amd.com>
Date: Wed, 5 Jun 2024 09:41:51 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, Guenter Roeck <linux@roeck-us.net>,
 x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
To: Borislav Petkov <bp@alien8.de>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
 <20240605122012.GXZmBX_KFQArXB9Lar@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240605122012.GXZmBX_KFQArXB9Lar@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0516.namprd03.prod.outlook.com
 (2603:10b6:408:131::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: b9878620-6945-412a-3ff2-08dc856542ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZ5dDhJajB5OUtOSEVnU1F6NTEycDZSazBTdE43aEdybzFXMSszeWZjV1JX?=
 =?utf-8?B?RFRaeFpsNjFUdFYxNlJwZDFwVWJlR1oycklNZ3JPODFuSTB6TEs3QnZWdjAw?=
 =?utf-8?B?WWtRVGJSMDRnWW1vVm1XU0FkNS9DREM5UzdkV0xxaTBja0RVM3FyQlFWdk92?=
 =?utf-8?B?YTNTS01kNXVJNzZlT2QwVng1Nm9jWmxFMmo3Vy9IaTVNdGcvZkx6dUV0THFy?=
 =?utf-8?B?THJDYy9NMUdKclhYUldKRWNIamsvOUg0N251M01RTmdjcWxURkY3c0huQXpY?=
 =?utf-8?B?TVIybFU4V2ZtNGlURk5DajZlaXd2NnpuSW5tMDBiemx4OU5xMzRGSHAwS2VV?=
 =?utf-8?B?WnNHaEVsVFluSmpHcnc5MWk4dFQwNVRRZU1ldFFLcFJOYTBVNG9XWVZ2ZFdu?=
 =?utf-8?B?clpvdjFacDNtL3F2OGlzZ2RudFpGQzNrWVY5WUZzejQ2VGc0MXJhWS8zbTA3?=
 =?utf-8?B?eFFQbXVzZW9jMVJPVXlNTS80aEJvcVBDRzY1alR5QVo2TUE1MEU4NHVoSWty?=
 =?utf-8?B?dWd0UzBuRXp0Wmx6SGFrZ3k1RytLc0xnaVhqd0R2S2VvVlZrZHF2Zm9lMThC?=
 =?utf-8?B?VzlIUU05TENaWWF1REh2KytyUkg0R0JBdThtM0NQbGYyRCszWjgwK0cydnpY?=
 =?utf-8?B?VytxdGZkTlVrcWs4ZUxQdVNjUVBPQ2R3dEdGNERaaGlCOUxSNXpJc2FjVFgw?=
 =?utf-8?B?bEI1blNHVUZ3SHNtNXoxWHlWeEMwcmVWVDhwWkE1dTZjRVVoczU2SkQ2YnJr?=
 =?utf-8?B?SUNtSy9EZU9rRlYydFdKQ1k4OUl2MUlaRENLY0JTUUJkMEQ4ejd6N3htSTRJ?=
 =?utf-8?B?cGM1MXVKc0dIYlNJblEyZy8zTnhYMDhRejREWkRWcWVZRDdRSW1Nd2ZKc2NE?=
 =?utf-8?B?NWtLdFp3UHlSOWFYZXRpcG5VVXRid2FtSjZjRlhPV3JYOCtHKytreGFiY3lp?=
 =?utf-8?B?SXhNZEg4UUErQmZhQ3JFWUJuczNiaEt3dGxDeU9TRkpwNytlTWgxRmNkZjQv?=
 =?utf-8?B?SThEU2xGWkhuUTdEc1ZER2pDSncxV3grUnl6VStNYzh2VE9SWHdydWlESDcv?=
 =?utf-8?B?MVVOSVNkNXdvQzRGV2hxVC9nT1N4V1oxS0xFcThUUGVhRjVuL3BDOTY0bkhG?=
 =?utf-8?B?cHBMWlRiYk4zNm4vUEl0VG02YmN5WUkzNE00MGc0NnVqMmZ0Um1nRmM3c2Ur?=
 =?utf-8?B?ZXV4aE9TcGxwYWx3TUJjODhWUWdPSkZaeCszL3ZCM2dFd0xaYTN5WkZQWVRN?=
 =?utf-8?B?SWFWREJrc3NXWGZndGZGbDRIZ3ExVW82ODNEY2pLd2l0b0F6cTJQUFMvSFo5?=
 =?utf-8?B?RTVqYVBxOXg2azY4MURnak9jdHk4UE9GWEtyWWpubFhNL2NTTENSQlFTMWhn?=
 =?utf-8?B?Y1lycnkvcytqQVpmMXFMcis4c1kwVngvTlI0c1VLVGZ2cStBYVl2Ulhwbm4v?=
 =?utf-8?B?Qkl0dHM5YUVOL2RTVFFoVDBTUUNIdm5oL0NPTjYwdjc4Sy81eDl5eUNXS25s?=
 =?utf-8?B?dE5vcnJsUzhVYUUzK1ZqbThYMzhWdGtMYnVmY2tCSVFTSzUzWjQxMXl5Wk1h?=
 =?utf-8?B?WEVlc1V6SHAwb1AzL3R3WnRub1kwZjdsc2xJei9rWmNLWDdaczk4K2QyTmRv?=
 =?utf-8?B?WnE4b0VuQm9hSVhLWWNEUXZWVU1OcDBWRG9UVE15TXF3SEM5cDczNlkvc3Rw?=
 =?utf-8?B?RzVLcU9lZ21reDVvQVorRUt0T3dDMXo2VHoyRjk5L2VUQ0FTa0F0TUx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y291TTJ6bDVzeXpKcEFyT0xXM1lxMVRXZUkwSkl5Qk5EZFZqYzJ1N25jbEw3?=
 =?utf-8?B?OVd6dFF1bllKeWRHQmFLS0YxazVqckIwUEZ5UUJwNlJuMFlqeURGVjd5OGF1?=
 =?utf-8?B?WGVSOWZnd09jTlRVSTZWMnNUS0Rsb2gvcFNseXB3TWU4SlJjM3RMOXM4L09z?=
 =?utf-8?B?dEFZT3pVVEE3bHR6VU83S3lRMEMyR3NtWERiRVNqR3ZEYkpKNEd4Unc4NVFu?=
 =?utf-8?B?Zkp1dXU2bExYMFdIS3gydlQ1TG9KaGRDRWJFbCt5Qy9NcncrVUVjRVMvMnZ5?=
 =?utf-8?B?V0hCZW9PYWxFS3I3aEJPUzA5QkkvbVorNGt5eTQvRWZzSE14aGdjY0RJbjBU?=
 =?utf-8?B?SkRaUVEzK0hxZTQ4Q2s5T1ZUUWlMdjFIOUNYN0JiRUUyMzZwZUJjT21iWWxL?=
 =?utf-8?B?RkZHcWVmRU56My9saTV2TlNVbUp4SkE1Vis3L0cxMlJpYnpJMjdkb3locjlB?=
 =?utf-8?B?Uyt4N3RKUE5ZZzJaeDhaUDh4VWIvZGkrbnBzYUJ2OHRKVmpmMkdESGpjZysy?=
 =?utf-8?B?eXFFRXlIK1FFMGc3cTVmTnBnSkZaUVoyYllTOGxHWGlOMC9rQXB3cjNuQjV4?=
 =?utf-8?B?dWJXZnFQODFySmxBVjR4RG5FbCtMdmIrYTVSMndXdkp3eE02TEF4Tkd5dmhZ?=
 =?utf-8?B?eE9ZSTZUQ0FkdUZlRkx6dndvUEtxU3NFVDZ4K1dFU2twVWdqNzJmQTF6aHRh?=
 =?utf-8?B?U1hCQ2pqYmlxd0l0c05mRWFFRzQyVUVFZ3R2MDYzSWlmaHRvNk5BVnF4VUM0?=
 =?utf-8?B?K0tFeUhBRDhBcnFxRk9Xb3pwRk8xbmRHZFVhZG42enpyZUNka2FFOG9JQStW?=
 =?utf-8?B?VnAxeHh3aGNVSVlMNEdpWkhyZXFVdEJYcHVidFRXSm5EWUdLRVo1WEFybmJG?=
 =?utf-8?B?bVRwR3pPNWN1RjFXeFRFcUVaZG9rcGQvMnprdHpoak9wSThVU3VJcjJYSnYz?=
 =?utf-8?B?N29UZUZiaHVGYXBaT2JCQ1JzaXdHZ0dxM3F1L0J5Wm84eWNxcmRiTEFmeXNZ?=
 =?utf-8?B?cWw4R2I4Z3JVL0p6NElwVGhQem1SK2c3L1pzZWc1Nmc3bDJIelI0b09odG90?=
 =?utf-8?B?OFRwQlI0QXp6aTZZblhOT242VENVQnplL3hRNVpQUXlIVGlnV2VaY3NlYVVE?=
 =?utf-8?B?Yy9KcDdzbWY1Q0N1UVJuLzNhRTMrNUNaYkNveDRxWXZoRWJqZmFUNDAxVDZV?=
 =?utf-8?B?TzZmOG55TlR4UUxhL0ZUSzI3OTd1M0ZrVFJsKys0eFcrZ1VMN055cnMxWjNP?=
 =?utf-8?B?cTQ0THE4NGw3VVdqNkZwa3NuaWEyMnlWV0J4OG1rTUVyMHlWakx3QlkzZkx4?=
 =?utf-8?B?Wkx1SGRaVlIvRHhrTVJzRG12czBiK3hUWUhWRGxicUFHTDcxVWlEcUxpdjgr?=
 =?utf-8?B?djlpMDN4c2lyQzF3QWdGTzdDcmZmUEZNNDhTOTVUdm43aWJmSm9TcisxSzRM?=
 =?utf-8?B?cmtVckd2TDg1ajhqdXVBNFlHSXdHbnBQNk5LZnVXK1Nzc2ZjSjdpZU10ejhH?=
 =?utf-8?B?NmQxT2dJeDBHWUcvUlVCYmpWWGQvR2dqVlgrVTdqS09EK0VaVHNwdEdVNm1o?=
 =?utf-8?B?czBQem1URG5Ec1NGOWRDeUVJd1ZSNlVwZU4xVWl1ZlROMnN3YlE5eEs3WmpH?=
 =?utf-8?B?Ym1DUjRPU1huU1FzZjgwTGFkeDNKaGd1WWx1L1lZMTYyb1QwWW16Y3I4SEll?=
 =?utf-8?B?ZVhFTjZCZHZ3MHNOdkZ1UHlnNXpSbXJDSkE3cGl1TExpMUtsc01rdUxUTEph?=
 =?utf-8?B?RWphQlVxa3B5Z0xDSnl3ZEVqR0doamdlOHUrYy9adlJHZlZDeGlDUm40ak1k?=
 =?utf-8?B?LzJMeW0yZmN3Nk9OVE9LL0EyalBMV0tBcGFPb0doaDlQdEkxUDdTUmF5RCtu?=
 =?utf-8?B?RWxmNmVKbEZDclNpajljU0xHWUVFbFNCQkFRMGg5b1l4d3Z6NElKNXh1NzBr?=
 =?utf-8?B?RkxwQ3dkSEJsdXcrR3lLT1crY2IvelNMOGZmblVYQnE3Rlh3NG82bTZ1NEE3?=
 =?utf-8?B?aXVTS1NBUGhGRjFJQXROem9SaFBuVmV3ZEdOa3JIejhVUWFFckpoSkpXNlZZ?=
 =?utf-8?B?UUFzQ3lnU0UrUHF4aHp2U1JtaHZyRWphWFpTMXJzWDdmVWRTY0lmMlhMWGpL?=
 =?utf-8?Q?HFIMcviZCTZ6C1b02KUFzv5AI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9878620-6945-412a-3ff2-08dc856542ab
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 13:41:53.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2RHmfTxotNftKOquRIcU6CJSV1/pL3QSllgXgXeyKizIPXvQtRYmcM/I4MH4RtuW2Imoqmkt9Y98kznHIndyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

On 6/5/24 8:20 AM, Borislav Petkov wrote:
> On Thu, May 23, 2024 at 01:26:54PM -0500, Yazen Ghannam wrote:
>> Cc: stable@vger.kernel.org
> 
> So yeah, I'll drop the CC:stable tagging in all patches unless we're
> talking about a concrete issue. You need to think about the downstream,
> distro folks who need to go through gazillion of patches and wonder
> whether they really need to backport them.
> 
> And I don't think misusing the stable process like that is the right
> way.
>

I agree that patches 1-3 are not stable-worthy on their own. But I think
patch 4 is, and it requires 1-3 to avoid build errors.

Is there a preferred way to highlight this while patches are in review?

Thanks,
Yazen

