Return-Path: <linux-edac+bounces-1294-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1F9093C9
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 23:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946CBB20D89
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2024 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240BD1850B4;
	Fri, 14 Jun 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vnIE1a/W"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDA17FADB;
	Fri, 14 Jun 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718401673; cv=fail; b=lp3jtcQ4z5iONsq1sKWCS/OlrzgCHVyM6hK0Scdj/5KfHXIH9AI6Z42QoCjcMnawSO59NxX0dlQtoASxBwIfzgwy8IT3SHFBxBlFD4l0gxSVdr+eM6TrQLWCKOM0tnSMhuNvHH7sBwz6kNXPEqmv0NeNaA/HmZSJUJJZmQMaWJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718401673; c=relaxed/simple;
	bh=21+I5VHljwY+nEDE5u2jtCk0Huf7MNoeeqpcVioSoeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nVH6hBAa1c8udok76ruYXyaUOAIXvGJHlSi3PSUT5/AMR0C2ixv81J6tkoMqbyrMO1/7AzBt6yTgsXoOjaKPnRtYBY9DMwkacgdXhUgBax0I1vdE8L4to8VbgPnTmeA9rq8ZKqjhbSXuyhB828Bl49T83AA3qC7PHHtznjjExW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vnIE1a/W; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9OsCbAz2qe7PSGEyqd5DBUAUJ8e5CXPfXM6ZOKR5V9G1NL86gn8uKoDyueoZyNZ532XDsS/A+g/yg0iYSc+Dhkc7W12tO9KEPnf2OtlS+6+cJgceTHuAPxFOQW+aFs4cSKkuyf6PW4sac/hxO+1//zCt3IabMl5bVNrMd7ydddbpjLBamkESfM98Do/09QYtaIfB/jjfWzXQSMcR8Cd0JdJDKnG32fVplffrNhtbsKSAes8YSCxEvWCu7BRsZ56yyKiD+xpYEPaPbvDYbphXWIJIV0eZZUrur5WT8e9YwNpgZPTc4Pix2hJP/iNCdI3agqTj23OFFjKNDbBlYoeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVmLd1/fW1zOuLNjoinHRqWI7sbYXuYzPU3i9dKqU8I=;
 b=GWPyuNg8m4NgO5klEeVsBplYwDhhHsNMjpuuVBXlvOBnEhtVX4zsme0yiADujbEEeGtf2tcIZQhV1n6bdQ7k3PaRYlQ6l4Jrkj01DFgIMKr9ufKXgrPjcVOOLvonRt69yI3XO8EGBWOESe9kMqpiAcRQuvSieQU6bgH1o7ayvElE/7dffFfdsM14uIQNqlquP27IbR7OuD8GDPB6illnzAVmi1lG0LMrNeJTOC5sVbd/Lad2ecRjkSct14RGn41l86+OfXrQEHwMlKhd4Y4JzcZdFQ36TmxlM3ntgxveM4GbNHOHuMBEBfKUDA9IaBH/PpDfXLJdsGXyVkG2hrQXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVmLd1/fW1zOuLNjoinHRqWI7sbYXuYzPU3i9dKqU8I=;
 b=vnIE1a/WztTUWeXx7kiqyaj0TNNjqJL1NdFOMXWbVzEL3XIipRhm+Zlj8T1bbaNgMPrpFOXauj1ho9zWjx1M6XXgJzwgxurwvhTUeTYzoi7KOiJ6o94z/eH//j3IjD/oIz99uuPHo5CWkzMPqgBq6zrfy/81qVevYW2/raOARjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Fri, 14 Jun
 2024 21:47:47 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 21:47:47 +0000
Date: Fri, 14 Jun 2024 17:47:36 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
Message-ID: <20240614214736.GA726880@yaz-khff2.amd.com>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
 <20240521125434.1555845-4-yazen.ghannam@amd.com>
 <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
 <6d508036-befd-4d5c-b02e-abb228ed9144@amd.com>
 <20240603165530.GFZl31gtuABwpe1svP@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603165530.GFZl31gtuABwpe1svP@fat_crate.local>
X-ClientProxiedBy: BN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:408:ee::10) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 24df80a5-aa10-485e-565c-08dc8cbba139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kdoMSNS/ruRVtlZQ7k5e2BCp+tHNo+Y9MCcfI3Movgj/VNCCa6nG6mQcCGVS?=
 =?us-ascii?Q?8e4ky/9z7I7aeJhwCR8Z/EWUz4vDS8AKt7opQM0Vq8igwoq8ZTBPDcaPvF7t?=
 =?us-ascii?Q?FW+2qkEtoM32bDuLw210kmlry8yallJdb0XBJSa6wQ8sbddodiPHk/aiM1S/?=
 =?us-ascii?Q?FPjr8K5YiiCyMlNECLFr5L7bWw4mFPDKTCcyopHAF8rl5ged9/M/CqRfQ5F/?=
 =?us-ascii?Q?qLHNzXXkyIZLTgJO4fI0r2DZJC1oMx6EmAkLfjSZFCp09pY5FcBoHPG72Kjv?=
 =?us-ascii?Q?7C6syO5Nbk3+nCVNqjK2qUABDU8/DyIShD0KVpUKRbCvOk9mujzZz0gVJfhc?=
 =?us-ascii?Q?G0e+pRQrjx68WpnqQiN159ahk8PpxVON+Vqb1AiMCRkPrr2Tj30+/Bv13bVR?=
 =?us-ascii?Q?ddy2A7W02W1+9jV0qh1yIxHYh7h0jSrdpoF0FMyUL/Kby16I8/4MUKRrXAPn?=
 =?us-ascii?Q?SnQ+nxzVCIXuizrSmQuiPGcZS1P8tXCNbHgrJ8WWZeIyNCxNCmLkMANtGcM4?=
 =?us-ascii?Q?VhXCgl+p7rMgEDfbngSlJZkpDksfDNy0afDOzUbaqY6uQeGMq3YROQFbul42?=
 =?us-ascii?Q?G+vvnFpcZF3AFyxxiW49+GItUFy8wuuf0vH0NbivHSS+F2yHy+mFcteVQOtb?=
 =?us-ascii?Q?u2+GIq3JsYKOCriV8pXOcIxaL/h+0mA/rxucQuqj2HP9w4NeqprHAHaun+l5?=
 =?us-ascii?Q?OxlOfBQX37IJK5proGwqnHzQ8hJxPqA9kUnNNRr8aG/Sn3g4Bwvjo+SN4vJO?=
 =?us-ascii?Q?brUSQ3109YpWEmCwIi6V0TEkF+USoRCEavHUmjFC6iczFhld2PdGkIZHbbWz?=
 =?us-ascii?Q?qSUvciD+kU/nLxIhOINv0/ChlcZsXsSRbRwFWMqCZ/W6F8E2U8FfgmuGCf08?=
 =?us-ascii?Q?VnqLjtsgEofEUU6MemF8V/Oja7dflCyWOeYMjcmwrT6ZTBgNJ9WJmjGH5Ipg?=
 =?us-ascii?Q?nEdhXtUCJGhvN0hE+KbxUrFTM6kDpxClmLJw235P1fS7a8JE73zOOCDFSO1R?=
 =?us-ascii?Q?dnV1gezODTxe+0u6Ddp3cyCKhpi58VIaRBCauVkv1HZfoOT27J204ggK1tXe?=
 =?us-ascii?Q?PUG+BHwncb+2VVM4QbT6ksbWPE6fvDr4EOpTnB+K2AYQ3k6q1PVqaMoJ+KaX?=
 =?us-ascii?Q?7ayroNRtAJAFQL0wpIpmF0WhVK+suekEiR+imxIQnJDeuuIyUPz/+EdD5hrZ?=
 =?us-ascii?Q?VBVXVZouZiyMaKu1HYU1tyD+HZxWdgYHg9NgVjISuaTYAyuIrGTCSu5qcIWj?=
 =?us-ascii?Q?woO3u5nfLFE3zFD/qyN/cWJvBOJ5aDr+aGMm4rQiWavz45jWFZzoF1fWY+Cp?=
 =?us-ascii?Q?PkeqE7sKiYeBoUC9n1s6KkGz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jqpYWAkUmccsoQNLPcPfLcL1+is95sUpwqfB8n2vraFDSiXB++h4N2UlkMoV?=
 =?us-ascii?Q?AcHeYIUCoO/JCVN8tzOdB1kJbSKHWSAFZVXMlTpkv0Z3cdltDLNz3jeIUHVi?=
 =?us-ascii?Q?Te+Xzb+pC4ALuJGuqy2f/rUjOWj2rbqVduDZj9kRsP3pi/yD8wlU9gsXWpn0?=
 =?us-ascii?Q?6CYu2pdarMBKpJgt3RXlr99g7lbN5Ys31HdLACMtckdMXB38SZzmKKA3XScq?=
 =?us-ascii?Q?Sk+UUDD2KuQqN3O4K5NQTJfWxFaiu1Wxj8jpu2IRgjhDxgEQ4jLwcefKkF4D?=
 =?us-ascii?Q?3BhG7ik4Hlb+WVEG2szyMuIxAt7g6IVuV1c4MOy8lAHxf/y6Cs9Z2tUFF6bs?=
 =?us-ascii?Q?sfikne8+gSeTn6pvKVkTdiGUPH7TdRgCTy7rJt44hwMclHEERs6nTQpH0Vaa?=
 =?us-ascii?Q?JZv2QuMbUj5zbMDzt3VgkTyrsP3gvwR1/527z8cBux18UxM/gys7EfPKXCeN?=
 =?us-ascii?Q?PrlB0uvT85J+2d+ohY4eIHDIyoAoFcBXI/W6fDSirwAaeJi3x7B2nbv9c/tx?=
 =?us-ascii?Q?kenMIMWvWgzs19LW6ngvPDEgP7l82y251uzXs3rEssDK2S+kUmJCYCyV3LLU?=
 =?us-ascii?Q?t2h39KUYE+3tfmmdJiMj1LhXd3es4BA/ebslh7Oq+QpD6ZRuZxK3nIIf20vn?=
 =?us-ascii?Q?8/MND8ElXB0W3fghR435idlLX80x9o9o1FwQSKJmUjq0MlBjif9yKf/7Ivam?=
 =?us-ascii?Q?+VgP5WlO0FpgWzDEHCC6kKJgvIlqp0ELOQxpTltNGE6O3w0QcwLKhd51hzyd?=
 =?us-ascii?Q?utgGniwJThzWUKVVa4mUOVcS5xXuumoYnfuEjtG/2Y7TJGMGjsOect/7jgs8?=
 =?us-ascii?Q?xXMEr18OUMUgqhkpUUkn6fybeoV8Sh5REuU+Fp4GRfoTqCuWDM/MDT83wWls?=
 =?us-ascii?Q?aojqEK1tpNhOvui0nJ88Rq93MdiJpokNaAT/41rEGZrV3mHtwgbUYf1wAOLH?=
 =?us-ascii?Q?wxRuU1zqowiYA+x6ERT2QhDFJ0YX0UCZESZQkpoTMyW96mQfgp+wNoRKOPvu?=
 =?us-ascii?Q?grOAF5eycXZG3AbCe3pKK4BUWN4+CjlEFCqKospAsNpF2LDLbb7fITpTg2kx?=
 =?us-ascii?Q?DLR+JkGH7vwrfWpZp8bKF7Y4Pg6BaJ7ByuYAWcGdsWAkNxp2w/yQWQt4ubyv?=
 =?us-ascii?Q?DRxzo1mwDCTc7lM3+Z38wZpADIl2JuNAyZRVqc3GR37WXNcHCx9mxGMtL1se?=
 =?us-ascii?Q?lMmqOUiJxKW0xY/Oijx1e3Pvav/xxmJ4x86jKIKJ6ADD6YLX4pv3/8C3Ww6l?=
 =?us-ascii?Q?aA6QumSvd0o9XixH5kR+2/x/mODQb0/0CYt9l3kvtzhsO4ujBhgTobXjKHop?=
 =?us-ascii?Q?E4hDGTADMQ+nTL0U2LEkYwlzdfiXmzDlH140I4jRKU7PkfvL7e9gOZEx4Hnh?=
 =?us-ascii?Q?Bl8v38OkuB7C9CHuIylhMnAhEaKi0xPwY1z84UDQRMuDTzA0znMzf5gBs4DM?=
 =?us-ascii?Q?QBm1NkqxCo5gbzJSE5IaDfZjglxdyBtl8DkYjf2Sg7yWHpetfA3BIvV+NzcG?=
 =?us-ascii?Q?JXc7zr/geohAIDdd2twSx5f+60H7+XcNEHaWvGj95vbC/I/wRiYGavynBf94?=
 =?us-ascii?Q?/qFScrS+2gJPOfcu5DQ4zM1rzS1nlLOXx36oXIq4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24df80a5-aa10-485e-565c-08dc8cbba139
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 21:47:47.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxRCkN3gHkJn+Hj5LPUK5QV/KRefQmh68M11nL9cXlzQeHlG+wYURm5sjc6xqd8AeJ1v49sVnZSE8VOWCOiPTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

On Mon, Jun 03, 2024 at 06:55:30PM +0200, Borislav Petkov wrote:
> On Mon, Jun 03, 2024 at 10:34:10AM -0400, Yazen Ghannam wrote:

[...]

> > This is to catch the case where there was no break from the loop.
> 
> If the CPU is possible != whether there was a apicid match.
> 
> Here's how you do that and I'd let you figure out why yours doesn't
> always work:
>

I don't see why it won't work. If there is no break, then the iterator
ends by setting the variable past the last valid value.

For example, I ran this on a system with 512 CPUs:

        unsigned int cpu;

	/* Loops over CPUs 0-511. */
        for_each_possible_cpu(cpu)
                pr_info("loop: cpu=%d\n", cpu);

	/* CPU is now set to 512. */
        pr_info("final: cpu=%d\n", cpu);

	/* CPU 512 is not possible. */
        pr_info("CPU %d is %s possible\n", cpu, cpu_possible(cpu) ? "" : "not");

But...I like your suggestion as it is much more explicit. And I might be
missing something. :/

> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 0cbadfaf2400..3885fe05f01e 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -66,6 +66,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>  int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  {
>  	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
> +	bool apicid_found = false;
>  	unsigned int cpu;
>  	struct mce m;
>  
> @@ -98,11 +99,13 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>  		return -EINVAL;
>  
>  	for_each_possible_cpu(cpu) {
> -		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
> +		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
> +			apicid_found = true;
>  			break;
> +		}
>  	}
>  
> -	if (!cpu_possible(cpu))
> +	if (!apicid_found)
>  		return -EINVAL;
>  
>  	mce_prep_record_common(&m);
> 
>

Would you like me to send another revision with this change? Do you have
any other comments?

Thanks,
Yazen

