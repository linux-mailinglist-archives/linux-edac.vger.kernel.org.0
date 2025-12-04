Return-Path: <linux-edac+bounces-5549-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE935CA49F0
	for <lists+linux-edac@lfdr.de>; Thu, 04 Dec 2025 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D333007273
	for <lists+linux-edac@lfdr.de>; Thu,  4 Dec 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559D3491EC;
	Thu,  4 Dec 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="byKq+Gun"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968493491DE;
	Thu,  4 Dec 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867099; cv=fail; b=Iz/qUz1vxy+E0WP+rUSkApHbrBDplRghoUuRC+zugZawozqhhilGg6xwIhagH0vNaR53cD+7KZv+jaXnWitvqUJqexFRn/ANdk2OsSxw6Ox/IFxnZ6U74cbTOursgp9gVKGksIdZYV4KzMv32GXYFyU4AuH0Fm+pC0dhdx1dkvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867099; c=relaxed/simple;
	bh=M5ZcQnk22IRzpAMcuvVZYWXE6/N6CMRw662B2nmpMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heZSlYIuvVEvxXbfPW2StyYoXoExQZSN4TL75mPh6y1RhZPAkT3SS8b3HWhiBTWW8O7P+g1tDdqCLSuyoqYwwyhFE5Md6/EGoOr31pSsWOuA9/C8FhIWFTpoBciR9UH/uBBWTrAjkh8Ply+RqB9phTvhBPP7EVVILboJGvB7haY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=byKq+Gun; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTF+PjPElaS/r2wG/+sqQNQJDPeXgnZ7AEeAZnDyVZpaT6UtN9ozbD9CM53pggPPKRbZ3Tonw4Ux2fKI1WuoW8Xc7cLUcMyZd1Xi06B/fcAyw+zurDHyE9TMfQHti1hl6j3BmWU4zIYxCnTKEFrr4qOuW7UzDXdhCty8zc4UP+m9fj9/XrTVq4mZzHPQOw/UWRYOKJIWV/TuvPT/s4mhFa9WFrWFrjBUoqOJ2L0A0deUy8FqMW1R9JNfp8yZuEd0o5zxMIvYoz6KnVNLXwxqtvc1h/X3Y92HaAVAZ3LIk/Z7AGRPQmkheE+smirqRIdp/D8Eo5XXmeltWf2QDtyyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtZ7lene6+4eBwiXTumxnyO+F25Xy2wVBVQPM8HysvQ=;
 b=OiDhv78KXycuzksjnYfm6ITPBVh6K57m8BYtSbjZEoMC0UcF8h0QvvY2oajlPEuxH4Pr4MeR/uEYqMVqYvbiczUb9fPT63+1ezOfsoCROzAP3svVpKyzaMcIfNyJR26vuctVMRz0cMoT1rzJkfXNi+53LFGNrd8i3m2JZ13FWmW0RSHX/PT0+tEjln7vhBNmbuvSx4xt0BL9rMkm8P7E9ni5CSSC3SGEkebSefkHX59rQ47yC8unYdFB+mMj1gGVA3Hslm476JMiEJ08cS/6/HSSwKgCewQTgiGGbYP5JkaWCNOA3CqN8aXXaxCTWWUk/lIeIuC9FmbwVLGfCJZPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtZ7lene6+4eBwiXTumxnyO+F25Xy2wVBVQPM8HysvQ=;
 b=byKq+GunkPM5+Cfo+mFtxGpmlzOWeZKYj9YoVUp4iZmK5uCx/q1Et/sE0h8dqxuW4kwgneEPU6Lqhy8D2T/K3YYpBvIF4GAsazpcuMnCezKWZOr99pHeyV0P/awjK44dlxdvoF+YqUOUp+7Llcov0HpL+/GH1r1QWb/M9OqEI6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 16:51:33 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 16:51:33 +0000
Date: Thu, 4 Dec 2025 11:51:29 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: avoid -Wformat-security warning
Message-ID: <20251204165129.GC983706@yaz-khff2.amd.com>
References: <20251204100231.1034557-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204100231.1034557-1-arnd@kernel.org>
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb65e89-873b-4e26-9d32-08de33556184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h6XiJHBk/9FqWd9bPr/r8EIZJsKDbHIwt3OIFipD5tlS9IOXp/+8Yzddlovc?=
 =?us-ascii?Q?YudN9XPq7eXoRk+Yl3UeUh6J7jk5znf+unQMFuVJHusHXlAJlBbHzVCYDhaQ?=
 =?us-ascii?Q?cvA3a5fRq+fRYipYJvfnCKEJ6mdcbl95OFiCXWTs5DYlPGZo3QBJqPNx+kGP?=
 =?us-ascii?Q?dlgSSw5ZHZw35Ch8wEWFU+C+DghJmUAzr20/ltcfqFMEybmppyqDiORPaLxk?=
 =?us-ascii?Q?0he8uowPG3ZuGdIp4GUj5DQRXIcKl/wuBPTm5HIk1yTxqe36oNKjDV1Fslaz?=
 =?us-ascii?Q?AUHbaLRfVWu1XdiSTuQOLAk0zWZOH1fCA7UUHd0xnlcIspO6IlJSS5i6dU++?=
 =?us-ascii?Q?IUq6HWOubEprBcLHcRGisgQN6KwislAX3JY5qPXUnd6sAi0sOPndc8UQQaQ+?=
 =?us-ascii?Q?yD9mlO5Y2CEnwclMryUxem58uRYp0Y5rPYD6T0eB2R6rO93PexTEbeDpgyKv?=
 =?us-ascii?Q?aYUkbC7Iox4WfOkL3XN2BFbk2N1Qvam5Pb4y71RGTL0f03yYsmvmbZ5YN2QU?=
 =?us-ascii?Q?k/UBiDjugDvsS3PnIHpoN0VXENLqXrBdrCDf1Fhh/em0mMqXJuPCsbqnIOCW?=
 =?us-ascii?Q?YQvKlTvkPjw74+mhBHoOR1cCUBntWT5/1KK4iCGuAcVNsri/bRfm75d9Vax4?=
 =?us-ascii?Q?qFxSMsMEowdcCqAFyDTK89ID1bpqtT511sI6engDRekFFuh24JesAQ9y//pP?=
 =?us-ascii?Q?aQdnY7eOc39MS8YcCQp6U69O/Ev+6uPWfsRTk1Oetx1lIZwX+7Dv3/s+NA6g?=
 =?us-ascii?Q?K8yU3w0b/3YG7rHz09zadyUi3plCrQjLEagM1w3cZs3FPvLwBK9F2y+WSDmf?=
 =?us-ascii?Q?QVRnzBjnVckCAVGgKSXFgXpoeF2gRAZ6Ds4lpFh6wrCaA3tGtFfuPiTVq2/J?=
 =?us-ascii?Q?ztCr/YA9xEt0UZ6b4cYrqbnkYb7lC7tidA9wqBu4hA5gZcbzKCX8ennOKJvl?=
 =?us-ascii?Q?/mjdjvdywjs0kggT/kde3SmeaRSMWgu0ANCwqR4M8+RE3uesTrOzhY6H5lak?=
 =?us-ascii?Q?JhVwiEv9rfFdwi2DRqUQfPVVGnpwQjpJRmRBMPsTZJdDr9Xwc7LfIL5nWUz9?=
 =?us-ascii?Q?xSq+bl4gTdkDxSsHCavbpVUJuZZrOOVzSZMr30UvawgOwCiuZBlTfTex4uV9?=
 =?us-ascii?Q?sIj0u93KFB/Tgs0lQ+6arkBrVFx9EENnnZFQRukYfIlMVHK23heDILrbTe+I?=
 =?us-ascii?Q?Td6552mrrSXSsP6tkKJMAFBh+ozoKQPNonJNJj9GJVSAIBIrBKkEyX74f9lY?=
 =?us-ascii?Q?CFgsUfXK6+ct3CyPqUv8xvG53bLFMXpy66dzQRJShqAs7zmgmZggKfOcccID?=
 =?us-ascii?Q?zAeOEdus0WDTaFMRNMASavuEcY2LXfOiEnEiNGaNDQ0vH685hwPoSALVMUla?=
 =?us-ascii?Q?mZ/4JYZymcGuZDh0bqoI9XZqM/u3EVnyP8Ps9kTba3GnErc8kBNdvUZ6gb7E?=
 =?us-ascii?Q?dthihcotYBAup9ywM7gG1bh5KfU9LF3E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TvpqitGdnfM/NtHiHltGOlT2jJrl2+IwpIr7ECZ7I4FN96czA92cDvbGDrig?=
 =?us-ascii?Q?ZKorEVxKk2Y/hcKDXAIobTtfi2Y6xYSz40+OidQrV+ZUxmVCdvi3l8ow7na9?=
 =?us-ascii?Q?T9u8lQtehqn6iBAqoaZklfzTToYrNAMK+QReu0mPM7xH78Mm8rxpp8ShwRAQ?=
 =?us-ascii?Q?M1jTNEsMcKLUjoJ7lNG24/Up2gn34NmT4nw+mKrNBVMIhBfAMFVy2DF8zqir?=
 =?us-ascii?Q?Th3eLrNNGGtKLDr5KlOmpxl5vYQLMFqfS+55HObEthWp5F1c28uOtS1ioDZ2?=
 =?us-ascii?Q?kbwHRfa7haGfDwK7P6ktIyTyTy9mBsFxJBAC8j1xO1ApOfAsQALilpPUZANO?=
 =?us-ascii?Q?+OTMZ+NCPxUQpFA0kK2RbaeLbHjPQLT5dNUZT1dmkTmy6/z/xpdZip8bjFhK?=
 =?us-ascii?Q?/Tq7VW32Y59yajvB3+woJPlQCiqqriN/2rRKH+oMshZJD1AWFuoyLmqL3Ol3?=
 =?us-ascii?Q?A3AU3qtPgEVGWQlVF15ykKh69eETAJKzD5Ja2a889meCjT7aAqYmGfEjf6wK?=
 =?us-ascii?Q?4rTWem2YyTPGcWZ0td3psWIHBQnAlPDHaltIR+P7XtohpoOfrn8DLwFMBVp3?=
 =?us-ascii?Q?vCO3+9JWBLan38DJBjjnp8utAVs3OhKyAPtaUbJSJi4mS9AzCwW9UCswtdEY?=
 =?us-ascii?Q?ihNGlZhUwCnOLfPnL66jjzHp+iRJPygh5ImSfJnKC+m1L6U6cBka5XKCKnC8?=
 =?us-ascii?Q?eE5gmzsDCowGRR9mlT2O0UN88zCwyobGHyy//yEVYdlfV1L5NT8bC3qEu0FJ?=
 =?us-ascii?Q?Y4UWn2M+JTCxSnyjmVSxHN1Tv6fcuE7J4sd/c+R6dXEQUsFNYIBVJfkMazCI?=
 =?us-ascii?Q?3f6t46+zhrp+gHErsoVVcWilbPfyg7GKCgADYqovHWm/ZLtnw3Xfjl8dCjxw?=
 =?us-ascii?Q?bnkoi4RtkCCQ0hOBO3e9pSBW1xh3hhKfg3OoRdGbCTngtM+TSbjYCAigM2J2?=
 =?us-ascii?Q?iiPhyB3P+EJcxhkTsCUeZu1K17R4r4FnJrAGz1SZqXZQAEg2PsybKIXzIEa3?=
 =?us-ascii?Q?r2znYCwqXARXDjEyVHmWmza4mDA7JmOha9MVMCJRdxlCe061Q9K1s0Uqsk7f?=
 =?us-ascii?Q?UoTjhwRTzIXftPqb/RIpweLpRDjQxDSqJY8D5FYliGrYNG3SX8p3qzgQmNjd?=
 =?us-ascii?Q?sDoPBtYnMQQDwruHpTKjskGKWquzrZUdAGGGGLd3FVj10pyKAVK7QhI6ipoZ?=
 =?us-ascii?Q?7LPWFfnIe7wm8l8HWice4U69YHs6UB4JGJKcui/eznf1gyFkXOB9pHRDebC1?=
 =?us-ascii?Q?ABywk6WSEi1GONfCI/Vhrn+EPqZ5m4dJJXuT7e3I3JTF0HzMzSVa+q9JXz48?=
 =?us-ascii?Q?p+bNVKAiVRcgYimlm6JagWlTofA0St4vqwg386CwD5FjSGc5tAFmByW7BIU1?=
 =?us-ascii?Q?tvrXUPNufSNdco4ob9EObbieQdlM6RTz6QiWrCl9xo4BlIcvCUD+7ZZpSzW8?=
 =?us-ascii?Q?I9oa89R8Jqzlv9asAv+eSP73UTLTzzkM+mGQg2umaBPmk8c52dnQsqX9wac3?=
 =?us-ascii?Q?vXy6gm1KHt0bHQSfOeMXhgMeTuzlLkWV1lcTm3EGppiI/2s34ti6RLKOpLjq?=
 =?us-ascii?Q?wnVl+vX5+AChpcK/DMeyVwdS3BiCwdd94j9nRhtv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb65e89-873b-4e26-9d32-08de33556184
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 16:51:33.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cppP9plMBjwxmH+FKJmzo06OMnsW7dQBqTRDGs5900y2sBrUmDOVEkAO/JmYs92k3cw49JvbHcmARNUXlR6GGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

On Thu, Dec 04, 2025 at 11:02:25AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using a variable as a format string causes a (default-disabled) warning:
> 
> drivers/edac/amd64_edac.c: In function 'per_family_init':
> drivers/edac/amd64_edac.c:3914:17: error: format not a string literal and no format arguments [-Werror=format-security]
>  3914 |                 scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
>       |                 ^~~~~~~~~
> 
> The code here is safe, but in order to enable the warning by default in
> the future, change this instance to pass the name indirectly.
> 
> Fixes: e9abd990aefd ("EDAC/amd64: Generate ctl_name string at runtime")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

