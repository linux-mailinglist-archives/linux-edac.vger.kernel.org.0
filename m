Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A874E9C0B
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbiC1QSs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiC1QSr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 12:18:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440243137F
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 09:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMVytat6p5KKTFDECLeRPs65PzDG9W7efbB4k/tSQdK4u9amJOzBszV/a/uHXbDDOEDa70YgXNKsDBpBmdaxrAGGoSGo05lxyvO06iBILR/qO0pw3hxyruz9dOe+Jy3oL/xHnDGmh7RZEVNgdEhCuS4AUpFqdCIrm4GZG5Bg1Fs76MPdLqS4UwGuWyThQmwM1vPA4ubZBS2eUIjWj0aLfbc41WhI58xPC/g3WXLLXnHeKtqQExCHVYYoS2075LtWjYbZNiDVmWHdDszIb8/tIOmVlB5N6FXhr//ixNQC4ESwpzD1+h3aP1uZgCvbmlWp6nrg3gtg0EBVzL6cc5bs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFYBc2y+1ebSEzAxMCJhqak4ULDIQHxgxu3FdAHdvoc=;
 b=klrzebX6DGu/ejZKQuFFiCY5tXwMqQYuohFXM3gvuRBRgwgR3iqq0ckBk622XDWhP6nvWywnHX0pFByfjmjxBs4ZeNBKjQNDSdHbI5QaKz7OVzYTdyj8xqS1X+qUb2ie4OVX1K7JzBH9N1CUK2hALE/7MpK7Uzlyn9r5dLLfXA56CJod8dxth5sZ/QTCa5rJPDkJJsWtIPHdwEWyJu/v+MKBOlt7YKzKnEV6EgeRSg8gmONvZgLBjgIT1wDKSr8AOdy9dtMlDehz2xAT0oi2RsZRm4UkG9q+r2mcSY7E5NYpSkERYcYW/RVyqeJsCjnWKGU0sMX504um2343Zbef8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFYBc2y+1ebSEzAxMCJhqak4ULDIQHxgxu3FdAHdvoc=;
 b=sCSi3iFoBaZmYkR5ZD/sRcupNLS8noU3NjL36/OsDTRjDcbjf7DD12nOlmB96WmJ9MmyFVyZOezVHyOiQfJQX5/acoiPr92AnMn7XhuxB/0kUFAhScTy5Tkk8cpKxhX8AIXIUddCJdMZP6pU+swGrYFaxLPrG8RPp3Gc/i/XcmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 16:17:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:17:04 +0000
Date:   Mon, 28 Mar 2022 16:17:00 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 07/14] EDAC/amd64: Add ecc_enabled() into pvt->ops
Message-ID: <YkHffKdAv9XByabw@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-8-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-8-nchatrad@amd.com>
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ba89d0-c9e8-409b-9623-08da10d66570
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB249180847FF7D2946E1434D6F81D9@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAZqt8uLxupTslVcjRcRCWhMDZ6ntUWcatzSX3qzA3AOum+Yk6C5gapagCJ/4RdJCWn2Z1adaHgeRwHgpwgc6XE/A9PKThfijyL3yr0c+6BmXaAtPTH5Zuh6AntKwGAZ3WE0gixX/oGz+m/Z9dZwuSOp2APTMSdazCFtTzlv26vPxUVTeUoUnf/Vq4x0bRRB+bm4IzWXKfKBhA+MUe+QhUoehjxGoGAaKDrXV6Rd/4RoBsSeYPauFMmHv29ZPuCwKr5N3ldRS5sHKOC8V0kisaF8QrOYxd0R6Jf3qh0AaWL6+EDji1TVlujD5Cq90grs8qqC1Hsl3dPGCvrwGhSP+v6Cj7Mba7vfL3JMdhX8gaIXmNpSIGgUFhM/fmK5WfPkplI6wVCEloXyYbzfdVt8OiG/DfLTMnANV/HY3HZXbX8Bw6QCueqs74UfWETeh14fEOrmaqAJY7Xh578jL9wvJ8XD9j16xavZx3E5MGnm9ds3KoAgXimGmJkeZalkCK5vTbeCo8Gz9wxi90n3yp58q/fHTiDU6BQEQj74iHbDaoZoX11TsrThROCndZzeQWLf7VQ/N/xyi9BgyjZjxuyzawL7Jz1dtkiEBqS3rsZYn6GJN8lTBfa16B0jg2rlRg5WMcQ8QxF5vp7WOPJ7G8JtJkzMPVPDFjAean08vWMPMZwFg/WHHuEylwYz0gcZXc8UnLbvud4lrJTTRJHlVKilWtvFbR218haEgCiXLugcWHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6666004)(26005)(508600001)(186003)(6486002)(966005)(44832011)(2906002)(5660300002)(316002)(66556008)(66946007)(4326008)(6862004)(8676002)(6636002)(66476007)(6512007)(9686003)(83380400001)(6506007)(33716001)(86362001)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gcd6BRPkFRICvHJ+GodbXP30PwAnlmZk+eodIh+0KbhJRe+dMi8IE0F8yqW7?=
 =?us-ascii?Q?WFAWRDVoLX7nwX8H+jgnzh7lw2uxliyXD9MmKKYl7ZPV05HLbGICXpvJ38ah?=
 =?us-ascii?Q?dGzbGD+mbyhu09Ldaq/hKH68ISM2xFytXIEpC72oPJeLc4uNw7as0jjw9wmT?=
 =?us-ascii?Q?ws/lHSyt8aQbt+DHFvaymTK6XtKBxlajq9nH/PnKVKW716Ec/N5/dXHyOxqj?=
 =?us-ascii?Q?NCJF5/iNIiGJKEUl73EtL4mspyLnjrUt8RLKOmu/zkO/WqlaZYXxY5UXrshY?=
 =?us-ascii?Q?CV0+CtiH2X8PKzQwVq6JK2gDZAy2MwrbaD8wRo4qMetF2MEIqXqzSjZ6SB4j?=
 =?us-ascii?Q?ocrvlRhG1PzFotqsVD/yq25g7b+kbCwXr4Txdp92wKFSn0005xnp6f7NQJxq?=
 =?us-ascii?Q?JpwY3KslunfXzU3q7eXKCOTzLV0r3uD3b8N0kSXmbXjzeCwYKo3SdsSP3ejM?=
 =?us-ascii?Q?H2VQAAjaYc5W78kB4ZZsTckOnJe96L5Unpf26T621RoREgPWPARSZpu67xdl?=
 =?us-ascii?Q?ePGB2s1l0a3HmbmAuQP4dgL9HxRLekGHOn12M+kDLd0PLtQXRMcl4jpCllpL?=
 =?us-ascii?Q?bDJp+aswPHaQvGSFldBy6zPyes6zEsy+BAQm3ESTp/Y91TuYp/3m4+Z8g6iH?=
 =?us-ascii?Q?Nd4orrZTJDHC4TR+og+g0dder8AbB3eKD9m5laoGn1F803YrcIwKKt3j6gbJ?=
 =?us-ascii?Q?ZrzQK4m0YfktYzZlOSOp0ZCEYWwEG9hT4KfrgXENllzn75Gk1tmXDPpPPyuK?=
 =?us-ascii?Q?VYJkfUmLf/S8azJBu6DM2gSOs0r0SIVlfZHipqAnMz7CthrKxp++YyKQWemK?=
 =?us-ascii?Q?yGzGRkOq9FzSVlr73/7QbTnE6Vu34K9lzHPqnA44Bvn9QSCCNtvPZI0pYR6f?=
 =?us-ascii?Q?EUcV9Qtv9kYAx72kaMuCruBBqfMjqY/QFmnaVtube6rcgzUymw56AmcfeRVt?=
 =?us-ascii?Q?9uQ4oGEB34R5tMD+XToY0FM6Rwl8gRJBQndzbE3vLcvTwrSF8jlW6xG1X1JY?=
 =?us-ascii?Q?Z9SzrrB4kCKqq8+5xIGpO6NZjb/trkLQRFKMoqfsEnKuvKKf5D0v4GKuo71j?=
 =?us-ascii?Q?RmHT45IpM9W1/5pJdik925DTqooIy3otG+LghXQ0fsXcU0tvfO6U5fPlTSgN?=
 =?us-ascii?Q?CBL/6Gb5IzOCtSHjzBIZkduHZTKvfEVfn6lDXv9Y7L/dBNh1n+gssJp1Ixv7?=
 =?us-ascii?Q?L0yjx1SCqLPWJ4Md1gbW11ZzDcFqwzWko7Hs4m8ZgXeMBscZ/vkmGOYqEJso?=
 =?us-ascii?Q?UCXtWSlIIv59hXaEpaooi6PxVZcAWs9mfCQtE6BwJWOFnM9+7Pkhxr3huxnz?=
 =?us-ascii?Q?nUJLe6FQpzq0t0UoFRcf+gBLh+RU8NiBrg3VLs7CtCAz/iUl/gt4VoKRKSl8?=
 =?us-ascii?Q?AUc4JkObY36e2J2PTy9UXmmNgQbI3QYHCqMJkoOtFcH/jYn5DvVhev2yG+j+?=
 =?us-ascii?Q?l/o/pefsq0EnBAdTCCn1DQn8tfAQXRRtz5l5agRfO2YS4bsAh7AzvulrhdfN?=
 =?us-ascii?Q?Zb2YO1GjsxOrcZI9lGWNnQRH8pTRjtONBZqikJYuU2GyAxxhXXExCiJJLUMc?=
 =?us-ascii?Q?fjTotMN/g13zlP1PsZkfcCShW16mxOGE5JraOASdBAugzkSi3pU5kKSXBXw/?=
 =?us-ascii?Q?zJIY+g65IPpMB7MizIU3CIJ34FLnJ19sHBp8+UlTKqG6wmRJc668lkRdXl0d?=
 =?us-ascii?Q?4TrI7wQvg02o/P4xAuoO181sjmcHL3XsXhf1EhAzqj8Neb0YCfYmQ4JkL8/+?=
 =?us-ascii?Q?/IX48kq6lg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ba89d0-c9e8-409b-9623-08da10d66570
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:17:03.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNgNnQXWR9fYqPgH/1Mh6L2vCBC0nbYV3qixNB8P+QaIZEPM8x39lHRYIyacptUQvXRL8x+j46SX/mX//bfzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:47PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for ecc_enabled() in pvt->ops and assign
> family specific ecc_enabled() definitions appropriately.
>

Please include the "why".
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 77 ++++++++++++++++++++++++---------------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 48 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 713ffe763e64..15d775a9ce7e 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3649,49 +3649,60 @@ static void restore_ecc_error_reporting(struct ecc_settings *s, u16 nid,
>  		amd64_warn("Error restoring NB MCGCTL settings!\n");
>  }
>  
> -static bool ecc_enabled(struct amd64_pvt *pvt)
> +static bool f1x_ecc_enabled(struct amd64_pvt *pvt)
>  {
>  	u16 nid = pvt->mc_node_id;
>  	bool nb_mce_en = false;
> -	u8 ecc_en = 0, i;
> +	u8 ecc_en = 0;
>  	u32 value;
>  
> -	if (boot_cpu_data.x86 >= 0x17) {
> -		u8 umc_en_mask = 0, ecc_en_mask = 0;
> -		struct amd64_umc *umc;
> +	amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
>  
> -		for_each_umc(i) {
> -			umc = &pvt->umc[i];
> +	ecc_en = !!(value & NBCFG_ECC_ENABLE);
>  
> -			/* Only check enabled UMCs. */
> -			if (!(umc->sdp_ctrl & UMC_SDP_INIT))
> -				continue;
> +	nb_mce_en = nb_mce_bank_enabled_on_node(nid);
> +	if (!nb_mce_en)
> +		edac_dbg(0, "NB MCE bank disabled, set MSR 0x%08x[4] on node %d to enable.\n",
> +			 MSR_IA32_MCG_CTL, nid);
>  
> -			umc_en_mask |= BIT(i);
> +	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
>  
> -			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
> -				ecc_en_mask |= BIT(i);
> -		}
> +	if (!ecc_en || !nb_mce_en)
> +		return false;
> +	else
> +		return true;
> +}
>  
> -		/* Check whether at least one UMC is enabled: */
> -		if (umc_en_mask)
> -			ecc_en = umc_en_mask == ecc_en_mask;
> -		else
> -			edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
> +static bool f17_ecc_enabled(struct amd64_pvt *pvt)
> +{
> +	u8 umc_en_mask = 0, ecc_en_mask = 0;
> +	u8 ecc_en = 0, i;

This line should go at the end to keep the longest->shortest line style.

> +	u16 nid = pvt->mc_node_id;
> +	bool nb_mce_en = false;
> +	struct amd64_umc *umc;
>  
> -		/* Assume UMC MCA banks are enabled. */
> -		nb_mce_en = true;
> -	} else {
> -		amd64_read_pci_cfg(pvt->F3, NBCFG, &value);
> +	for_each_umc(i) {
> +		umc = &pvt->umc[i];
> +
> +		/* Only check enabled UMCs. */
> +		if (!(umc->sdp_ctrl & UMC_SDP_INIT))
> +			continue;
>  
> -		ecc_en = !!(value & NBCFG_ECC_ENABLE);
> +		umc_en_mask |= BIT(i);
>  
> -		nb_mce_en = nb_mce_bank_enabled_on_node(nid);
> -		if (!nb_mce_en)
> -			edac_dbg(0, "NB MCE bank disabled, set MSR 0x%08x[4] on node %d to enable.\n",
> -				     MSR_IA32_MCG_CTL, nid);
> +		if (umc->umc_cap_hi & UMC_ECC_ENABLED)
> +			ecc_en_mask |= BIT(i);
>  	}
>  
> +	/* Check whether at least one UMC is enabled: */
> +	if (umc_en_mask)
> +		ecc_en = umc_en_mask == ecc_en_mask;
> +	else
> +		edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
> +
> +	/* Assume UMC MCA banks are enabled. */
> +	nb_mce_en = true;
> +

The nb_mce_en variable can be dropped since this is now a separate function.

Thanks,
Yazen
