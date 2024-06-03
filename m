Return-Path: <linux-edac+bounces-1167-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD28D84D4
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B86B1F22FA0
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5512E1F9;
	Mon,  3 Jun 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mi3zd3Yg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8A12EBD3;
	Mon,  3 Jun 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424551; cv=fail; b=KPuhO6qrgJuB+/2KJ1+SEGfJwrsu6nn9TIuvhDMcGoqyE2+gOFNLZTvh79zyh01pxeDcA1DYGPw4HoNRyBvBoDjN6Paykt9CYV5MD9Ks0PJbLislY/Bz9m3MNVzSYd3ewTFL6jTgDGHdBmGaJhmGJZb6RCKZz74jgjSSeg9zL9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424551; c=relaxed/simple;
	bh=KqSfQG1ciyxgY4Hmaz99xlAG2xniGeiHsray4VAsqqU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIDz089awVDejObhkVngHsSplB0eEfEqLunovxLZLfjZ5eN4AVfDH3ZUjU6YmgxMBjHlTdS5w6JoqjZ9XpBkV9x+56qKwX94qkrPUUGW0QwnkHBRfR42JUALeKlta+MxKAuMkApQyhhtAFrrsyCD67COZj7mPZR5Qk9iFh/bMZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mi3zd3Yg; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7Up5psk4q2BzRbfAjWLA14kSQd0UmNAfpv+IcKul31ZAsDd/AAORs78D5YJEWC8o2zLQilkoOEaoBtgMLS8yBcHTBUJvTsSjLu7tAPqnCs5ngcDuLyvdv9P7iD5xW1Xycn096q0MK3lWgxz5j9CTLyPyO4/DUNfoDLldK0eyxyJmHMWZQkm+rSEShW8ZK/2APYLQINloEf4GKG91VXX0aGuBzpZtko5u2YscYPF7OqprhDrKKV0q7uoaGIO27Wbdg2UNEqjnXURbhZGBGXE39mBzt342kchYFq+uicKWGGelV2nfbE+yjnnD0xOOWdXSmxSW9LyxlnaDti6+aPY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UksDgjYE1E+zG79+4IbMa9gxmiYh8FwJV8aNoIKmG7c=;
 b=MAU0EmgjlOQ/sjlt5Jg9y4CoFWn8ypkVb4kRE7RtqLgmdvXk1rfLPZjUV3bQzW0l7aFDXYrxKo3KBj523gN3DtBgakPnKUqGyOG/p+obiylAAO0z+XbJaR409zbIGBB4yNk6CiyL34LgEUdQqxs9XQQMssSymD4aVbp5tIitvj9YfLf07moU+cPPrckZI4zsqi3v7IgFXRDjjZETa9PwojtWUlw7JD80wQyUdWHT/Fd8d2P+jqR1jn/YdZf7CsSyH/5KDFW1uDRwhFRU/murO+1cTM3j9/koofMyW8cQVmRtGlaIx96vGIk/tRq3if63RtiJWWiKLh8PrpZlQ6DcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UksDgjYE1E+zG79+4IbMa9gxmiYh8FwJV8aNoIKmG7c=;
 b=Mi3zd3YgzYJDfy0qHgauM3vie1lQL5d9ln0yPKrfImSvVL65iFxVv3cMqV8FeQ0WDx2dzEF0KrOSgU1naFxCS++B6G2CvdLxrdymiqIydtgWrBXMJXfdZJ0/6TAz94n7W2qfmW7yjJS3r5qblwWxbgcummvSunh7EcPPKTWGXBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 14:22:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:22:24 +0000
Message-ID: <3990ab6d-6217-4e10-bda9-6b5c7bd668c0@amd.com>
Date: Mon, 3 Jun 2024 10:22:22 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH 3/9] x86/mce: Increment MCP count only for timer calls
To: Borislav Petkov <bp@alien8.de>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-4-yazen.ghannam@amd.com>
 <20240524145335.GAZlCp7wAO22acrGyP@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240524145335.GAZlCp7wAO22acrGyP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: ef79ecde-713c-4817-3eb4-08dc83d896bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1h4blJSNUpQRTV0U2JTSmpPSGl0TVBBdXZvZVBtdVhoSU4xRWlnaG1JVW9j?=
 =?utf-8?B?NmdIUTJsbHpnV2xQRlZ2eTJqT3VqY1lsYVJ4RTJzQVFmVkVwU25lK29kUktl?=
 =?utf-8?B?SWIvYVJJVy95bFY1bzMzV0RqZ2VzWTBCdy9EMHZ5cnZjTnM5R3FVKzltMDFa?=
 =?utf-8?B?Z1JwcWRnRWJaSEdnaHVUc3BaMFNOaUYrbzl2QjhLckFQcTgzdmliVU9Ed2o4?=
 =?utf-8?B?aGxGS3o1QzRqYjJOWHFZM1ZQVFpNdFp3NGdrNXA1T0hPK0IwZ0FFRW5hZW1U?=
 =?utf-8?B?QitWMlhHM1I2dGErQTNpbjgweWtkS3RJSHhlMzQ1MVpSSmdDTXNlelk5ck93?=
 =?utf-8?B?WndGM2dXNXBkZW9SNGZVajgxT2Y5a3M3YlVVQUM0SkVSVGhubmFIMzhHY3Bv?=
 =?utf-8?B?T0lpTmZRYVNteXA0OXdmcHdjbzZBNDdjN3I4ZVh0ZXpvSjZ2eUMzbXU1TitQ?=
 =?utf-8?B?d2dBSjY1NllRelVadS8wZ0dGZkFwa2Y4RXVxTkFvMTdnckZab2s4bllsSjIy?=
 =?utf-8?B?bGxIdzNGUFltY3JFWnVwczhtQndXcXBTSUFOZW9uejVEbkhBeEVyMlpBUmpx?=
 =?utf-8?B?TDZVSjYwUU8rK3FPVytiMVl0c0NaUGZnV2xZNGlKRDBZUE4xc2dpb0dZZmhD?=
 =?utf-8?B?U2JHaFFES1IxZXlwWElNanRXb3RoRGpWMUxKYm5GN1FEQVNpS1BCbnNBSzZs?=
 =?utf-8?B?b1JHWTlwWlpGVngraDgvTmlkK0g0RGMrNFU3SnI4RThFS0xLMmtubU9yVlJk?=
 =?utf-8?B?Q3k4d044SzVJVXBGa0k4TmpCOXZkQTBiVHVYcmxDZHVFK3o5dm1KWEtwMmtM?=
 =?utf-8?B?OTNmY2lpNG50ZVd0ZkpCOVdQWHRrNG1iKzFuM25kbmJkTWtxVmRWYldiUjhQ?=
 =?utf-8?B?aEsyNkJZeXE1YVVIbTRDUU5qaXltUGRaQmFKRnhseTdUSnkzZE9TTHhVci9R?=
 =?utf-8?B?dHNqdVJQbWd3bUhEcDY0eFpuWXplVVhueU5VSjJHb2xzVGo1RUxSMTgvbWlu?=
 =?utf-8?B?U1grdFJ3a0FjMlNyWDlrNzNwdXlVMHZtU3dZcnNDWW9LejBZbUxxcVVVazFx?=
 =?utf-8?B?R01MVUxyckIrT1JTRWtTRlI3SDQ2dTZTampVV3E4VFE2WTc2NVBKbFk4ZXlp?=
 =?utf-8?B?Wi9nK3VncHRhUHhFSVBrUjk4RGN5QXNyb0dpSUkyaXlBT1FKTGVka09Ib1pK?=
 =?utf-8?B?NmtKb1I1UU1JNTJBY0JhSUxOVEs4WHo4U1ZGSG1qb1kzOFdYRUdHTTFBTUlv?=
 =?utf-8?B?bEo1L0Mxb3JwNHQyMmFCQktjdXpTY0oxNGFOK0JEVks4c1BUK3FHYUljYUxk?=
 =?utf-8?B?QzJBU1hvTzEyS1VTS2Vib1FzR05rUFJHQ25XOXBLVEJCcWhBSVFFZFNHaGtC?=
 =?utf-8?B?ekU1cnUxTHcxTUZnaHpzWmJEUzF6bVJzTW1HSG5zOXVVdCtJTjNKVGl2blVk?=
 =?utf-8?B?a25VWmdpL0pGakhWaXpxSm05WG1DcG5kTlo3emtvc1ZrRjlhelZFZnhaQ1RO?=
 =?utf-8?B?Z245WWRTeVZHUjFKYk5td2lyM1RibElVb0M4VTN2WEgwOG1qdkhLbG5UaWg2?=
 =?utf-8?B?c2svY3FYWHp2U0Uyakp3eEl2ZFp0MUhzNllTa2ZwSUZrYkl5TEpJWUptNHEv?=
 =?utf-8?B?ZXFUTVdmMkU4L2xQcjZGWml1SGgzVVZJUVpqa3lxOU5FL2pzQUJTcFRET0JY?=
 =?utf-8?B?Z05FZmh2OXAvSjQ2VUJpVzdJT1ovaTNTdDBhVUEvM0M3dTdacGVOV0hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHdCQ1ZPajB3OUhsVkFZTGFJbXFDaGtsdFpKZDhVZHU2UFhNcFZJaFgwcG1M?=
 =?utf-8?B?TUF4dkM3YU1jK3RnaDBnOVQ3c1VKcWlMMEs5ay9VUjFuZldyWWl1T2xEYkdh?=
 =?utf-8?B?Z2t6L1dpMHMrR0x2dm9LVGdYUlhEM3lMSm9GelhJMExBQWRRbXBPdDg1TWk0?=
 =?utf-8?B?cXlJclAvNkE3R3g1azdyV2s4ZDBVY1dlVVd1SVFpUEpQVmdlbXJqN25vbzk2?=
 =?utf-8?B?QWhtRkFnd1dSM3VIc2VEdU42dHpQdS92bjNJWVpvM2NBZXlGbEduY21DUU5V?=
 =?utf-8?B?dHVTZkVTQ21ONkFtcXl2dlZHR1VPdVZGWDhndG9EMjdVOVRvYU4xdVVmWlBZ?=
 =?utf-8?B?WGpxUUlHRElDMUt3M3VHRHo1MDI4UGxtYUZUTWlUSnZQQzI1UVdKZjgySXNn?=
 =?utf-8?B?UGEvQlI4NHZ4dDVrNjFKQVlWUVRjU2JnRzg2TkZhMjVhOFhSN0RoT3JtY3Qw?=
 =?utf-8?B?Y2RGd0NxWVdKYmQydnU1YUk5UmJPbmNleXZjdndBVWJIZjlMVW9vNTRtc01E?=
 =?utf-8?B?Mk9FZ3c0SGRPVzJLbFQ0ek00eDc1MFVKQ2FDQnd1YjFCalZmVyszazdZaTN1?=
 =?utf-8?B?aURiK0FHc3c1WWIxVUF2SllrUVhnNDhTQ3VBNXA1TTNEcXB3MHU1YVlmSVVu?=
 =?utf-8?B?SzltY3F4b1FJZUV2RDA1a3J3SU5VOEV5SDRlRVRpSVlnU3JCNGF6Y09oTFBC?=
 =?utf-8?B?SE5zelYxclBIOURyb3hxOWlXc2hOaVc2bVVDU1poMlVocjZEaFc2d0RkQ1li?=
 =?utf-8?B?RGVYVEJwTEtFdGVTaHpxK0tWVnRES1dBOGNtWjVQQ3NUOHZBNUlEc2NmYkJp?=
 =?utf-8?B?VnJiS2tGV0h0WnIyTE9pZVBORXBGZ3dNT0JmTEFjNU93MDhoWGNoaTRMdHB4?=
 =?utf-8?B?b3o0SW85ZjNFS0M3ZjIwNmdzNTNpdmtKUUhSWVZEb2VhQ2hvY1R4MkNmWUJh?=
 =?utf-8?B?aUJMRlhlYzRHcjhPN3J0UkdOSW93NmRoQmRMOUR2MjJKVVZpcnpTQUlBSU1C?=
 =?utf-8?B?YzRoQnpVTUhwM1B6bnpMdEg3S2xLQ2RHVmxHOE9rUUJBWWlQNkRJcEFkTmRa?=
 =?utf-8?B?ajlVWDRFc2NqaUxaTVNnM3M3UTJvUElHTWNlMmJZU3ZDczhnYi9kOXBReERk?=
 =?utf-8?B?ZUFlTnJ1M2JHUWVmSDhZUUVPakd2elFvaGZsekY2NXFSajUyb1BhemxPSEJR?=
 =?utf-8?B?K01nb3JxdTdKanR1YSt6ZW5rNmYwY1RxSXd0eVM4c3IrODRPSWk4T2w1Z3dZ?=
 =?utf-8?B?NUsyUFlPTHFJWUdpMVFlbmZrbVlTMDdJa24zblZhNFBxREdNdVVpTzF3MkFw?=
 =?utf-8?B?am0xZnl1SnNwVDQwSlQycE1kRHh3M1dEdjl1bUhMVXA0akg2VmcycGppTFBs?=
 =?utf-8?B?NlgxSmJJcGxOT3U2U2VIUUlLU2RmRnlnSnNqeDZSOTJLeTVPUGNsK2EzcFNL?=
 =?utf-8?B?Yno0SSs0THNiRWxnSGI0cC9ZenpON1h6MTFQNWJxcjdHdVF5aC9VVjJjeDlS?=
 =?utf-8?B?SkNOR2xoTzYxMjVLbml2dnhVTVdIZElhREk0bW9MbVJGSHNRNVRtWGdhcUNp?=
 =?utf-8?B?MXp1eTBXRmRSaWNScEJDL0t3R1JNeTlnUUNEbUMzK2VGTXJLZDlaQm95bTdJ?=
 =?utf-8?B?TmwwTVY2QTA0WnI2Y2RxSi9SVkJCWUJINTFLeGVPU25uTjBSZVdZbmJYQ3Ru?=
 =?utf-8?B?Z1EzWE9iY0M2b0NJYjA1MWdWMnNWdjlPY3JCcXJESms3R2ZwOENOWkw2N2Nv?=
 =?utf-8?B?azEybHBOcHZWbklwZW5mMGpkeDVJeWUrNXJPMzY2Y2FzejcrVkRIT1gyNjVt?=
 =?utf-8?B?OUpSaVlEZDFCU0h2dVZ0QVNWMVJ3ZXFYc1EyYTRTaDA1WGg1NW14Qm96bXJh?=
 =?utf-8?B?RitnRU5vN0Z6eUZQSlR0cEV1Rkg0S2RLYjArRlBsTFQxdnhBZFlxbmkraHBD?=
 =?utf-8?B?K2xhYUQ4VEtTVUhzakJDZDN2dVZNMFZzNDR3Y2JLdUpzek9iTnRQdTBNN0wy?=
 =?utf-8?B?QkZKL3l3ZlRnNE12UGUwMStCdzJ0TUorWUVwMW90Z3J0bldKRmtvWHJDRVlX?=
 =?utf-8?B?SU9TeUxoSlFiMGJ4WUZDallQU0FZYmI3ZzZYU1Q3RGtLR1ZHWTF1cjU1QjVl?=
 =?utf-8?Q?O0pEq5zWzCs7oA+V5DCrZRMCu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef79ecde-713c-4817-3eb4-08dc83d896bd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:22:24.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwsLgIRxd43rzI5IIycIHSumSHBAvkDDr1LZQRdp/WeNGaIUpG1xjc2HkUUS+49MmzGx0kO+8S0AK/shTcopgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On 5/24/24 10:53 AM, Borislav Petkov wrote:
> On Thu, May 23, 2024 at 10:56:35AM -0500, Yazen Ghannam wrote:
>> MCP count is currently incremented for any call to machine_check_poll().
>> Therefore, the count includes calls from the timer, boot-time polling,
>> and interrupt handlers.
>>
>> Only increment the MCP count when called from the timer so as to avoid
>> double counting the interrupt handlers.
> 
> Well, but, every time the function is called, we did poll the banks.
> Sure, the count is part of /proc/interrupts but we did poll the banks in
> those other cases too. So I think showing an accurate poll number is
> actually representing the truth, no matter where it is shown...
> 

Okay, fair enough.

In this case, should we also increment the count in __mc_scan_banks()?

Thanks,
Yazen

