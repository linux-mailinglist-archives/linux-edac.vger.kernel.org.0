Return-Path: <linux-edac+bounces-2515-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C657E9C5C0E
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 16:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E05A1F22EEF
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6989201262;
	Tue, 12 Nov 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u9AVYqJx"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC2720111A;
	Tue, 12 Nov 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425934; cv=fail; b=M0inU2GcyjabknKFX1OZJO6EzhLLHTmTZARf0TA7MB8Aqyk5oRcNUusYVb+9ACLVe6eKvCuqUKBYAxOysgBgmHsJMcTMybidXEKc6V3K37fq+9OxciLOXISXVCjubgcLojZEsI2EFKnrlVJULnMAg2qUCYlKRBQUjufbb/nu0Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425934; c=relaxed/simple;
	bh=wy3Oo4UHh3h9/WicW2v2VhTXQMX6WYERD6jc2uG0uXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ISPkoWYgPOsBXASKc9tkBo8pPisInvPZ4byRtGM6bEkSjzOg5F3YGBaXc0UPtyND/JGOkEC8Dsfb1fs3OhIx4QoAbbrfMRsu+5syT71/Cc2Rz2g1wsKkyHhr6aFEbJVimH274h9K8Wfb2EKvDL7Ao1iM7qgOBbndHVnxOs7KBaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u9AVYqJx; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qquGDtMhgI7LwfyiYQFbL0OH1fmVXCHz/YcjZRUWJYfn+LSdZQ8xPGbKFOzFbLNYUUaWoAeB4Ju7dxTjcB0Q1vXK0xFlz4kcryZNttd8BEZ8QvpG2q1vmAR5xUWlRuRSJ12aQxmxVxB8R5m8z1biHhMkDMVJZ7S3998UVQYEGHyX8k9FPliKkIPV5vqA77TFjXQkXR68njiOoPJXozCze/UVXhJxWMzw3p803tcD+Ns0peMM8pvnac1rtrm04Z+NisMi8B/ixFuujmBtPL0Qc0h6W5TVEDpAigyz05JwEpPNKTwAmIPJLqnifIsMy0v6lkPP0BjL16lJ/Pju1bw0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blpl8Ptsi5BZen2xSgc3Ohy4THBQZBGcqkFOJEIrehc=;
 b=iNvZjJibiJ/AuPyapkV5CfxYkYOIZg53rsZvFn1kgDYA2Wz88GkEUD4BGkZVfCrES3uWP7V0XFsWi0hC1YDNT3vsCkR2qXeBaKVSWmjBuKupgRwfT6e7Tq+vfs564L1s4YNEH1MWe0MLMDiNrKgfNh2Zx2Dsbo6aW0ZgYShiYQvrKF6y2bTClQH0sDKCd51M/bMKljq0mAfxWxMa7+0aoLRpnOLk89EHowtqJMTF+Fr9sIGFY9ViSZJWgUwpH4tQR35fZDE7IIjfEqj7MA0JceerOv6GWUNKScuTQ79lS1uO/kMonpELmFDPlwOpe9buppoDWNXuGd+4RYaBsRi/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blpl8Ptsi5BZen2xSgc3Ohy4THBQZBGcqkFOJEIrehc=;
 b=u9AVYqJxI0HDhk7nCLpWftxJhDEMhAuwBG3fW2lhPzE0LyZs6af2a40TBnO8Z/6i9Tkf+QqQQao+Gadr+iWlM4wCV6uE74k2DtPD1Y4Iko0m4vOVHGdFB0cYEc2m46shOq5edRiukRmW/q1SNyCR7B6VG4HrsDAC4/N6YQQlLrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 15:38:50 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:38:50 +0000
Date: Tue, 12 Nov 2024 10:38:42 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] x86/mce: Fix typos
Message-ID: <20241112153842.GC3017802@yaz-khff2.amd.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-9-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111060428.44258-9-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BL1PR13CA0272.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::7) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ca4ba1-8757-4166-3bd3-08dd03301ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KjEyfR/L7kEfDtlQrpd5wZh3V0JuuJaEGU2+isk9kXLarTQMfgFaydPUWvyS?=
 =?us-ascii?Q?UCF+gf6Q24pElTKFGl88yMNpSuvLeCoejrVzWzX0VXvveA1GMsfB4u7Cfy4n?=
 =?us-ascii?Q?8Ij2m/u/iTk/HHlY5wezDcOYOjBGIOjDLb34bnrOOB68oYcdEeB814/3p2pC?=
 =?us-ascii?Q?cKTR5CwyhSx4bd5FrXCVVUDn9ZRx95yhulfvDseN/BAuS/KA4VD51+xMP7aH?=
 =?us-ascii?Q?CV76Btx1Lu0EEi9P9Y+eRq9KQXwuywJmtz2LD3/82UE6qsrxvYtzfh7mOLil?=
 =?us-ascii?Q?2wicgp4xe1bETIoRtsTFB6M42diZ69vR7QwcKpv9EexZTxE9Ot1/X1wvRVtA?=
 =?us-ascii?Q?gdVDPJrYRHkgEkW7ll7+td5GCx2TV/o4UqfarLc/FV+MKaR+Cm00VVrXpBlc?=
 =?us-ascii?Q?HaBtJs6RMjflH5SdCOo392KnK1C0z8zidSqWDvyYLTHAlD6sril70WhckYwj?=
 =?us-ascii?Q?Clj2vj+Y2XbP1kxkEiwcOe1LYeOJWdykilJQpUTd7VV3UIPiHi3c4izNBs4j?=
 =?us-ascii?Q?xriJkCTvv3h+uwLH4BDIZ3LfQQZHZEszOPz71PRm2CjCZfuhYUHwcyAiFJTk?=
 =?us-ascii?Q?OGj/CXKMR5JE+Scd1q4bZdw5C3rbppVtMdKqd9yPyxYA29DnOM4JNbMl+JBL?=
 =?us-ascii?Q?ljoAM4LbHeMn2E51149Io4G10XsA4mMOcLyuLg92SwwxBsXReEAypR/TjNNU?=
 =?us-ascii?Q?nrtyMJUjjIbkQbLkUV5ghXblg1u4v6AePqbcxOLQG6lqUz/GWg7f5She1pPc?=
 =?us-ascii?Q?PHfOmgygK3NrahJLlyoF6IR/nnVxQUfYBYbvhjedoEJkDVKElI51GS0ilRLw?=
 =?us-ascii?Q?6jXSp/OZ5ykgDW9Ij14Ky946gxXrkdVAY/XbWE2/Y2MeWLdm2GyVpNkvfhAN?=
 =?us-ascii?Q?lnoa7V5VBY6wDxynRaDqnhiEJ7zS7mSaHLEWBUfTl2ZAHdQ4Arf3dWJux0RF?=
 =?us-ascii?Q?NRnUCDwhbIzpR35BQSdldRFQyHvuRDktEWydNowWIdDukIaNmWu2/E+BEt0c?=
 =?us-ascii?Q?xoAQEaC8Qn3DGZJIcG0H6iElfw1N+Mf2uME1C/Ln6VcIkcaJ26yP6HqxVWRn?=
 =?us-ascii?Q?xHuAgKuqrsIvdguSmQ11/z+OQd2cPJRrMPbR6FSnXXVRv15Z/vA6Fx84Eic9?=
 =?us-ascii?Q?GaID9hrXqCh0MKtrwZKHEZpnhS9uDX1HxgvoMLu0oXd3TnwG6DGOIT7Q0pru?=
 =?us-ascii?Q?rM7BqHgiQOgeK7E5ZHcKj1MlkS/jMGtp3cdOjqpP8UIIh/bxjHud/l8FnhtX?=
 =?us-ascii?Q?fNkwMn3EYmK+IkZG9osmvVyDQzlEZVMQ5PqRCyPzXCslxWTcwhrm0uo5kBE3?=
 =?us-ascii?Q?EQFULMl+VhPlhjqW98EawD8D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrYsgFQr89zrmHryrXKsZ6g+URctZtxklCiLx9dzQElgP+X5ieDGgK5JBS5t?=
 =?us-ascii?Q?DiiqDIwMVK7pvf/9az0roUmANyAZZkHlOldiqhhJS95HzDTYt4w3214bfBQ2?=
 =?us-ascii?Q?gJBzybrzLxYeT6yt3/Zmvh44g6iLL6+pN6JrkN1F1MeaGbEe0l+Z/COv00tc?=
 =?us-ascii?Q?2GVzS2gUyWC/DmP/0xAN6vMfO34WA/nfc7V7Xk6OsI36nq1J6dwXSNgoqTEh?=
 =?us-ascii?Q?g/5WHEATCF9vQQSyumGmR48RfgO4N+vj4Kybbz3vbd57+fkOaXL8xoHFkcY+?=
 =?us-ascii?Q?MtPoK2+ViJj/+RjWAEk8T/BRB2X399hBhJK8wRCWlM70BHrrgk4TnS5TC6ab?=
 =?us-ascii?Q?UEEcr8HJFFvFAW/ANkDD6NZyUwRmv5DUQ987zQZrLcA4I9PgVEZovwnQPKty?=
 =?us-ascii?Q?Jdx9mg/Ms5H4KnNfCzTcwo2AIlNyUB8exwImCf5i4aEWNHVoRN91m6BzAqFx?=
 =?us-ascii?Q?DNFsUD9nmxocRVO00s7XKOcYW6h/k9xG67hkz0kU/DFCetLL9DVX33JusIqR?=
 =?us-ascii?Q?Xf9OG80Sio3ZsUwHknVc0V0mezrpU7x+ehyt7hds+tg45q0C9CqPR56LMmC4?=
 =?us-ascii?Q?1Ghzn1sWzzgjoXA+avzUOHCrdag4K6nOXjiZ3EZ41l6mjDykd53vpOtcupMP?=
 =?us-ascii?Q?bi7JwfMvYDUtrGaqiPCVR3DngrcDnKz8m9wV6ZLpx0MliHckhi4kLww3niQK?=
 =?us-ascii?Q?LAXFYarTi3zulLOpPMgwkmoM+T4s0dXnYfn8h8ohVV3yBFuDGmfj3ldkuHnk?=
 =?us-ascii?Q?U/8qs+mxO0SWHmGKhwSfFHzxWc5853WDDli26GpifQollfYNGvfM7+u6Xkdj?=
 =?us-ascii?Q?AFfBJ0Un+zAiKZLGnbyzQsSn7DVqr8jNvWM0Mw6Mgp9jwMS6S3zOSorlNDAf?=
 =?us-ascii?Q?GcnPDpEqaxAbVb21isiTUed94bUZURxYR9lRfW4h/5hNRD+LsTQd715R9qfS?=
 =?us-ascii?Q?QnG/Hd+HKfsF+qsGH2a5xg4FlaIPyo/VUt1cO8UwEgCgf6ejGV5yEQPBgvGh?=
 =?us-ascii?Q?sZpQ4LkoNuAUIjML/tsqMBWsfkUUZJyNrQYJi3CpwrFBFiwps5VcA2ia4L4x?=
 =?us-ascii?Q?ETPBmLPQwUJGTIHt+6bMpG+uaWB5+DpJVxjxSpbQWqLJMREDJOWXlfBmT3Rx?=
 =?us-ascii?Q?XGf2BkaLM05S4vtGk/rL2/wjA60Em5ZCflzzlpT+lFfNI26s5dw23oTNFxCQ?=
 =?us-ascii?Q?M+bqFd9n3s+vKWVeXeoYM5XIwe0JuVZtILSSGfJB9uDeHxQQ3yYYiCEOzD26?=
 =?us-ascii?Q?1Ymecl5l/3WLfhBaDwjqegA+6UDQ3N6swuUDcTUkW6rFTzF2s6aZmA60TGJB?=
 =?us-ascii?Q?NMYU/lW70reZ/U9Obdtbow/3eVEHG1kKmIim4497wZuZdH9oHrfbY3X2rIeF?=
 =?us-ascii?Q?eblsESxRnnEVhSb8ep1mo4b6gOM7DpP/kUzSd0Bib0KX+/DVIPDlmIjBxGLU?=
 =?us-ascii?Q?7do38KM4uBWL6REqpwqNGs62N5bFOS+MY3d7RTQuj3lincOd1E6uOfBOWbJb?=
 =?us-ascii?Q?c+d/0yMXRgny7Prfkug4p7yHRpm07FzdHLrlKBzK/cyKDU5Wqt3yv31sTYrq?=
 =?us-ascii?Q?9qfSiOp7O7tDWld/ow8UU2cWv0igkfJhz6ojUr6P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ca4ba1-8757-4166-3bd3-08dd03301ab8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:38:49.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXQZ6vZ6GNTuLWHGZpoaKSTmPFb/M2ojbi/qcAGtQ45mmwxcxhJ8tsXCUuUBN1QF6GMz9/isgs2tsN8qwkTH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

On Mon, Nov 11, 2024 at 02:04:28PM +0800, Qiuxu Zhuo wrote:
> Fix typos in comments.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> Changes in v4:
>   - No changes.
> 
> Changes in v3:
>   - Collect "Reviewed-by:" from Nikolay & Sohil.
>   - Remove the detail typos from the commit message (Sohil).
> 
> Changes in v2:
>   - Collect "Reviewed-by:" from Tony.
> 
>  arch/x86/kernel/cpu/mce/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 0f0c6e9d9183..6e194ccffc7c 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1144,7 +1144,7 @@ static noinstr int mce_start(int *no_way_out)
>  	} else {
>  		/*
>  		 * Subject: Now start the scanning loop one by one in
> -		 * the original callin order.
> +		 * the original calling order.

I don't think this is a typo. It seems to refer to the mce_callin
variable/idea.

For example, each CPU "calls in" when ready. This is independent of when
each CPU is "called" to do something.

	CPUs are called in this order 0, 1, 2.
	CPUs "call in" in this order 1, 0, 2.

When a CPU is called can be different from when it responds.

Maybe I'm reading too much into this. :/

>  		 * This way when there are any shared banks it will be
>  		 * only seen by one CPU before cleared, avoiding duplicates.
>  		 */
> @@ -1917,7 +1917,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
>  	/* This should be disabled by the BIOS, but isn't always */
>  	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
>  		/*
> -		 * disable GART TBL walk error reporting, which
> +		 * disable GART TLB walk error reporting, which

This also is not a typo. TBL -> table

From old AMD K8 BKDG document:
	10 GartTblWkEn GART Table Walk Error Reporting Enable R/W 0

Thanks,
Yazen

