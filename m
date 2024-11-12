Return-Path: <linux-edac+bounces-2514-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 988EC9C5BD4
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 16:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48571F22D11
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0A2010E0;
	Tue, 12 Nov 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xhpkgmit"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41015201020;
	Tue, 12 Nov 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425249; cv=fail; b=EnthOMREc/UpDAWxalvJsGInn6VpcfCBeV4XLqfYDkoMwR2mh9iTOYV39M/DbiOZsbV6OVGLonxCbJBjabB2MSpkq30yqFHmDYHsChEWQ7VuifvPSqaQm1GrQ3ihjpnpkdnDE8bPbw+Ch+7VhiWNH7s+O/Lwtk3GEp3phAA/J2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425249; c=relaxed/simple;
	bh=uNcJ/bnwebEt9lG3HuFEF7FM4vzjaVMftvQVd3NiqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JL8siy1HCENky+hZaD3d9jVHvbLOf8Gj2xAr1QF+eLY5VX4ADxzyIMJY00G0NM9jsylTBcIeTJ5mHVXnHg5DXAF7840YpCWjoI0IVdNvyHLBxV7r1Atkzy2z8Av7x/oq3wxfaLSFNm27EVIzcQyMH1UYflRvmz1EO3rQeFcxa+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xhpkgmit; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAGmmXCJbg7duvlZNAd/ZYBNQha49mDqQpK/pGCDxtmd3WnMl42HSwz/uH+90zVYUtqLVjtXJWON1qnfp3wDhgZNoTjKx4ufGxJv0tKSrcdjd2BlDMQhMrSKVdc9+G117pgIpvC+vJsLUeV6jYngyjufS3L/T81YduapSKejozhbf5e1KZPva4bZODgW+gcUEIEYPB0yKzDmUAuHkWALZp0oxrD/gewIj6O9/XNidy/YcdAI1+K5EcAmlblBHDB8buvr/ZNVqKBOk4HHdIoqjSvhFl4gGhUEmHch1zlFlrHqDsOSZJHqS7xC0uqZYsjsYN28jeeCTFNgLr57hkBs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZMuXhByeYZzj3nXEv+itPtEx0oktWrOkm+Z1Pz2YLs=;
 b=wgfJ0qs797Rm9BAF4d0Jw1PuUkMpnIpksj3bFw/za7yP4RM0GLGjM5FZ7hJDXm/M1aJ3I0/la60HaLXnUUDYedL4N3oVTYeWJH1gAA2DJMOa6uXCh3Bc4doJrjB4DRJtrFJLKbI/0hGwW0zjnWORM3L6+UW5sGHdRqpM7HZ5Q+z2t75F/IoFaeRoR9+5hEHm4yoUBJi8jgJ7SHN4B7HXES24E6bMOvYfhBhVWgxwBkZ4tpO8UjAvvxHlswTkfwophyUFBZubfdzsZRrL6++7UuGwW1+EyOk/2I+1ds3pKVg404S/khGczfFZiDSG1OA+MA30JrMebkp3Nru2SOVFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZMuXhByeYZzj3nXEv+itPtEx0oktWrOkm+Z1Pz2YLs=;
 b=XhpkgmitCLj9jOqfC9X6pijAKZlijsnNa2XgnkliA0ghAXSCJ1g5DWz7AtvPX9SPz+hj6X7F3BhtHD7Uba7acb1ccJAmnlDxecZWBI1rgJLvJ9/aQSIluslOQwXXR/csllI9b14oaVWX6J4qjeIvFZA/+Z0qNknC6RKw9jFSsdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 15:27:24 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:27:24 +0000
Date: Tue, 12 Nov 2024 10:27:16 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	sohil.mehta@intel.com, nik.borisov@suse.com, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to
 VFM-based checks
Message-ID: <20241112152716.GB3017802@yaz-khff2.amd.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-6-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111060428.44258-6-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: a358956a-1efc-45fd-3ded-08dd032e81d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZaFxrzar8wUS7SIrIOYoly5a8tJCUMWYDRXmLao/pGRLOOXoF4l4okzxKggG?=
 =?us-ascii?Q?yOiZcv7/6OskFhgiMRmszMUV4puCd6aRnebOEHoxI2HMukG7Fgy5O6sbTDCA?=
 =?us-ascii?Q?Q/aw2XbhU10/iqY59Wzhbx4bSCCTL7uA5HrVsXjygXLDHaFn7hVD9hiTRlWF?=
 =?us-ascii?Q?TGbRuNEqAiz09pJ6gdRysGyoVN60s73LmpGpRR+atQWtua//fV4vugqL4fit?=
 =?us-ascii?Q?e+MJF6ptSkamHHk8XGjgEwd6L6H2lc3cT9RmSvb3wJYWfWBKln7J8pyBFgCs?=
 =?us-ascii?Q?XQAIaLe5RYgZLFZ9lSkDcp62OUwl+c2dOgP4DuIjSnLAzXlhoeGv9VL+wA4m?=
 =?us-ascii?Q?yB/ox0bvlB6RMyZEOnuG0BLoANjN4cmk/V+QzW0GLCLVRTUgv/oqrPs6lmZ/?=
 =?us-ascii?Q?iu7qX2IO0hbSIaxKxjbHM0+9J6cIEAEGPy//uyNscrZUAzMD7+0EhP3l8FUg?=
 =?us-ascii?Q?qkBOwyu/ln24SgBcm7vLPqAwZ++H1zVhNZPaTFYq/tPPTuQejyHU/YBZRl+2?=
 =?us-ascii?Q?i8R439/J2qobf0/9v9nwaZ2DLXUaAD98eD3MrI8eXUUVKf8ucNjfcvcmcfLD?=
 =?us-ascii?Q?VAqSHStX7LJkZOOOz+y6RiBQ4SRCTbDFs42afbRo8tc6wF9jdo0ITUfVlDbj?=
 =?us-ascii?Q?GzARp1tXTh/xoIIIxEhUHLXBY5yFGwcLXALst5h4bHA/L1lsJhVJ7cYoerEV?=
 =?us-ascii?Q?DG1nj56zkwnGBPZIHlp6pifJAFsfFyVs0X0Dukc2IMdezWKgmY/lnujRT9T1?=
 =?us-ascii?Q?00kzuKsKeB7bPtu7swV7lsFhze6KGjUbjHd+uuRXrTnCYE7L1W5q6+2Snai3?=
 =?us-ascii?Q?moCiv0PUTiC1UP9KwYfkxk0Tu7VYiIs7LJc5ezKI2UR78AgWUc6fCKQriZz0?=
 =?us-ascii?Q?Gf7pkU7YCN+UQlHk4ZgxmXPFmm7mYY1RAr1LydB5yQMX13+2DHU2T27a5y83?=
 =?us-ascii?Q?/jl+HZXcmbfgsa5SkkkpExdqG9z26Td4tl+dZV/8v4FReEonk6YFF1NB8aTW?=
 =?us-ascii?Q?BDfaB/4anSVvpLP6iNTBBf5RmXwMaRcMrAbMr7vcxeivBdF/4+jBngQXjRyn?=
 =?us-ascii?Q?NRUndhH9QgvX5txHV7QniToXTog1c2t2o9ol0GiUX+3iKi+WpZMJCqoZmUiH?=
 =?us-ascii?Q?w4I45DDXCd6xhEc26B2kDcbLGKJ0CuzGuTM/KI0LRLpvIapA4fw8eyMutqen?=
 =?us-ascii?Q?uHogMRaYgv1cpNZnhsufLkpyY757eAP5F8Oj4UVSaPKHt6E4yRplNnZL0xL9?=
 =?us-ascii?Q?8H+1vY0RRkJHdywjD2g4Q355kPO980/a6i4SiDhQB2avx0+Iz6Sb6G+6y4ZQ?=
 =?us-ascii?Q?lnwfXqw33CeJPi7gSguIyCod?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZo/L+8pXERTRoylQBRU/j7An8RVegqoht2pNQ6BSIiMGNCq6J5L5G6PN8mz?=
 =?us-ascii?Q?4a4/yMLzDoN5KJs4DyecqvxO6nkGve8iCyz0XA8vvlt8B9OIvJlNxlf/Myvo?=
 =?us-ascii?Q?cprFb6zS+auGTtTJsUW8SPlivA1VrVdpdjH4Smoo6zsD3oo64AKYPLUg9xsS?=
 =?us-ascii?Q?UM6Ojwb1MoWO++j8LUeQcBJfDUKJdesuz6VSRdsiOeGZGrM3MpfI+YJplczC?=
 =?us-ascii?Q?bY+7EyEMi17bh0cD+lxFPafoArlU/+6fiH8nS95+bGMpP98pblbXCoqqo6sq?=
 =?us-ascii?Q?0uFuWl3hZarxgEYPKy/os4VuA3qGZxN4/0JlFDlRab6uHKSNH01eE99QTRjs?=
 =?us-ascii?Q?crEvKCOHQLsqeSt9YNupbrxoDu1o9DFIyy/FFt+RFd8xznhvrOVIKibYk2vg?=
 =?us-ascii?Q?CoC2EYTgrCm2JjABCZqfFXAB5wZV5R99rcEYNsm02WsGl0v/tGRyq4H0iM7N?=
 =?us-ascii?Q?BIuVytlghZAMp8MPvDDPcWdKgO8S8VSQKSMuSyp7PVDyEAtOvYfL0YeVrkV+?=
 =?us-ascii?Q?QW6cQ/MA83ZMeKIUb0dvKe/Z2jNi0RS5QtikS2M+kgeDZhhQ767HRMjnSlqL?=
 =?us-ascii?Q?Qv0hKUhy5CNTnJbtgOffwDLbhluM2BXyg6m0JNoMjfmUfH56gYV4PbfNrAlD?=
 =?us-ascii?Q?MPofGst2G2Iy5YEk5wwcU2PbbEc2EJ45kh27Nejp53yqLpeoHhNIpX9Ngc2G?=
 =?us-ascii?Q?HyuQ9jKdH5f7OSS+XvkEj+flJ7ex4o7qR4Qz6WGlqqTRzWv6vD+fcZ2nLr64?=
 =?us-ascii?Q?RDcuuMdyLneUCTdxAaQD1Aasqit7vrkhG5CYe/8iXtupXg2fbNx7wgOxZngC?=
 =?us-ascii?Q?Sh9CGP2vuUkIRMp2EHLmm+00x9zp5u0IjSCnhzcyJD4ByxiQqjZNNfZ3xMR1?=
 =?us-ascii?Q?uVVYuZZ5ipSmN8qTf+TwzLeqhnsqJiucy0CfGkUrWw1oMc5B6ecVmywcw2Ig?=
 =?us-ascii?Q?j3Lmqa+NlrJE91tvM8nM8grkjiODStlp7Hji2QPs1UJIk/vfMSc2MQf08TaZ?=
 =?us-ascii?Q?il4fZYv/qJbYlv/ABTUT+rceXUZm8tsDjcxsa4TOtcZuCYPDlWsqlrLZ3OZx?=
 =?us-ascii?Q?+19wbmr4NYT6F9qfR/S6IaJRdTAlLtqTKW0lYZEyOoBWFwx8/hoWE6fL9KUG?=
 =?us-ascii?Q?hHt2aR4gl0/VP5QOPyv+9Bn+SiqBC2Z4GemDXSmmo17BTaoi3TFFAG/77AgL?=
 =?us-ascii?Q?1Km2ZsNLwg+S7HR37Ug65b5+m58jsqaUGBUSleYzDq+JwCtZY8PMETQcRmtO?=
 =?us-ascii?Q?QLogwwKHGTZnXtVn6VKAIe0K0mpFRUKKWteTSH6yIwUSnipxnmCDzZNwXefb?=
 =?us-ascii?Q?YYmxdmwuWgk5VbF+fkT296kj9+2XuNhrGwcZyWHLt9kXSNjZUmKVZ2wDgfdi?=
 =?us-ascii?Q?jWQwTCVQpAP+NZVPL6KMOyRUw3jMg/WxyqupQKqNH3DpyauHpiLWyT9DtFWK?=
 =?us-ascii?Q?K9HfEnN3T8rB1ELBj3TgJRaafNLjcN/IAaP1VVehki7ym1hQTn2TkmljOVX6?=
 =?us-ascii?Q?c8gc+5cMVPZcwYYTYQj9t/wICJPmjMJGSoNHxGbd6iMP0Ju8S95XwNvXHjEO?=
 =?us-ascii?Q?26wDBWmNQnXQAPxSprh7U/Dqgqi6jIVdbiWEjo3h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a358956a-1efc-45fd-3ded-08dd032e81d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:27:24.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnKyeNMqwHy6BnWPhAyN17+4lCVhSLr3xwneT0Q4trdqtA67q4nJAFc9CA3O8Vhw4vz4ENk+6cunCByi5cb5jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783

On Mon, Nov 11, 2024 at 02:04:25PM +0800, Qiuxu Zhuo wrote:
> Convert family/model mixed checks to VFM-based checks to make
> the code more compact.
> 
> Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> Changes in v4:
>   - No changes but rebased.
> 
> Changes in v3:
>   - Newly added.
> 
>  arch/x86/kernel/cpu/mce/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 3855ec2ed0e0..d288cc7390f6 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1954,6 +1954,10 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
>  {
>  	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
>  
> +	/* Older CPUs (prior to family 6) don't need quirks. */
> +	if (c->x86_vfm < INTEL_PENTIUM_PRO)
> +		return;
> +

Is it possible for pre-"family 6" to get here?

Family 5 is "ancient" which has its own MCE init path. And I assume
anything older doesn't support MCE/MCA. Is this correct?

>  	/*
>  	 * SDM documents that on family 6 bank 0 should not be written
>  	 * because it aliases to another special BIOS controlled
> @@ -1962,22 +1966,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
>  	 * Don't ignore bank 0 completely because there could be a
>  	 * valid event later, merely don't write CTL0.
>  	 */
> -	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
> +	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks) > 0)

The "> 0" is not needed, since mce_num_banks is unsigned int. 

Otherwise, looks good.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

