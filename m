Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721474E9CED
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiC1RAL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbiC1RAK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 13:00:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4815F78
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 09:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj16tAOPgXM39eqQOig7QBBkvRfgo4xZLRe3qFSTi+bgWC9GG7FwmISHvjwCJoO4aaY4wA5axaDCZ4R9AfmQEI+AXgDIqAWLZ7nwQG62GVePf8GlA1NEOFdGJhDw4vsK7elGsjnYtUnPxFfTsf7Duvw2l6BlDmHz74MP6aevWX+3YWLoOe8tMuDZW6BLbp78YDDIV1SNtPgs92+kqMXgK9D6YB8goezE8hTBM7gGMnhA2TBGZcglKsAZxqPVLjD6jn63N2gqic6VINV5EcIyaXnEpo08o08ZyE0PlADf1CbeTGuBLrzyG0v6YNyigxqGJqWiQF8Rm/RP8yoeop6Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2A9oZbkAW77WVqU4VVTJsesovY0p7imfmRXxji0Hj0=;
 b=dpweVS8kFBCCJb5FM/C5WAadI6bA+QlO4sJYp6H92KeGs5AkWz6GQ2VQ9L+Dga602qdAiGFJV68ZXf71d5d0QQV3KfVN2/aF+lb2ZTXU+iBwuhxeLy1fE/5FSt3L7r4k/mA6Xw+LYmR20YyvUhs2uBEb5eclFfpdxt9cmaojYbOoqoxsKbg6CVW1mtwTjpFj1RuNm1i4AWz1TUg1WcoG+SH5MC0al9pj4F6qIvErZMGlUgcpivpktD+xdnmtlNMScomdqjVWn8fyCJFfcWjbvoZcnfcocfuLPmjmSFnQwfNL5AbdjbKbLnNhZKneTfm4VrRxEjaOW+0ql9d1pUSXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2A9oZbkAW77WVqU4VVTJsesovY0p7imfmRXxji0Hj0=;
 b=jPE0hKtvHOpFz9ggXKSg0VVMaJBfEwCJKYVHqh+zhB0t+rdsFNkoW2gvMqe8UThfmFE8T6t2mYORMI3LleJHFpEeu8Oq5AjwQKGzbaLu6g2RLLdPb3oHl+ACopRFzEOn1yRcXcAzW084V+4mg4LDexPZv3r0rBEFs0ZPil+9oBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 16:58:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:58:25 +0000
Date:   Mon, 28 Mar 2022 16:58:18 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 12/14] EDAC/amd64: Add dump_misc_regs() into pvt->ops
Message-ID: <YkHpKgPC9BO7NuA+@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-13-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-13-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e06c9544-6596-4748-bd6b-08da10dc2cae
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5086539868F768E62129FA50F81D9@DM4PR12MB5086.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2/cNuDlCfGCzhw+/nF6rNiOJ+fvWQu0NWNAdtzRaKa0fhku4opkai2PH29ubFG4VND+BpKCwbcCNa58mn+thRfRmOzHHlvf/Fjnk/WIhRtz4DB6AsQ3KpTqGyPIB+i+oB5pWhdA+y75cY+p38lJ2Gl+bOiDtKMZ00nV99AYO4qOkmdXOxkb4LB94Z2pTyrKbIIEV2DfonOWAFnft38tSXecdRBkroS4wEVkr6+/WVx+kuZxi9u8DdnmUYWCjx6usvp0lFbyfMzU3PL44YouxmdZ4yXTf+73piroF4ywqxNeOzhT1UhDFW8rx0B5J++72Dl3HNwnIzFwsJiSYBcnKycJTyz2hDNezuLXLr6EizGM9Nb+qSSfJS1zlvfKtj40dsUdPy9Jvz7kj1IjrmCSeuRgan+/6cc5GoOrO0SWlHs3iv8dbenGwweuwd2323DDo5KG1J0E/Kph15Xk+2PImPvMUVEro0m+14TZZsKGqvGQkmOVqtRIxaqq9wB2KqPc3xpUcTNdruiD07asUYDgC169F8d3CvIAgrqvGFHt5rvJ73RLlufevDZH5dsSdAFS4JsgKv9zquRSBelK/8dud98NvTPbaGRVH2ikE+ZGdM4xaZYTm3a07JA+ZKgZ2jJGFUBCHATweYphNWAUumqkLYcjb51oEM9R+DVHqE+7wa7OOJRJNT/yPNND8v7BRG7SenFOCxBr1o8RgsX7S/SkQwy1nlfSOizTSEwVbcPesNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(4326008)(186003)(6862004)(6636002)(83380400001)(44832011)(66476007)(6506007)(66946007)(66556008)(33716001)(316002)(6486002)(2906002)(6512007)(508600001)(9686003)(8676002)(966005)(38100700002)(86362001)(5660300002)(26005)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8fuic953SQlnsNSnYD4lk8Zd1HNq+M/8SJK5aFtSchg1PKFzXqMLjgU2sbp?=
 =?us-ascii?Q?isVjUo/qddnqu/vfXBumS3JJBtXotE8Uu5K7Jur/xMMyaWc7quIK6auANS9a?=
 =?us-ascii?Q?7I35lkxXNCLVBdkLwpFwg3L7Fj32tTJW93O7lzrVu+6MGE1iQfDoq4UQ0ktn?=
 =?us-ascii?Q?X+YmN/NoQHD79BNVgaq56CiWIqluKcNmCjZlCAqUyMj2yiSyA3roVPULHcxW?=
 =?us-ascii?Q?9tixD8B22JRqsol70dLYxn8Zjw0MzVLRYbpKoB3qD0Id2YOn0MSB6IcTWl+l?=
 =?us-ascii?Q?kcx+5ZEoN9gK1hN1CP3QMq2fegfzKA1Ean2AZSxVpIv7fsIXtkmK5+6Pj8m/?=
 =?us-ascii?Q?RGyzDbXPdcCHXj8o0IRXWeBkCVOhDsVlc8xUq2B09Ddu6r1gIpiRybqGmSI7?=
 =?us-ascii?Q?MEwKrDcYublYu/kWXduVX1n1r4Hhm5WjQsrXAVNf2gqL5kxoRWEh+wTS/N7y?=
 =?us-ascii?Q?8Q70AP/xsZX+yncsGKWsdTxTQbMAwLiKC8+xQWpN55yXAGn0Uyt5n5fW2qOb?=
 =?us-ascii?Q?IbcmNN5hg+X3MUtncKvETKbZiDgvcaEjz5eg+IxepKTImZ9IanRrlQQCLW7L?=
 =?us-ascii?Q?J8RpH4Nq09KeTQjRIFM8HCnMfvQR4AEnxsFrCaZZaNqCvq6qR7alv+PZB6ZU?=
 =?us-ascii?Q?V3h1vB3QuVSR/Ae2y2YVg3zp7mrfWz7jTLLSdjHBACJQkJ8PwO5J+RWYYIM6?=
 =?us-ascii?Q?QaGMr62G7D+A5pb/7JSEFMS2C/VTlcXzhfo1gabwUw5EU8S1/qjTsx6/bdGc?=
 =?us-ascii?Q?3JTBk1ztj6jerpOAfAbCiJ8/i+MZDfWRA73Mq/bBQSCYtEUrZ59vkfS9bzji?=
 =?us-ascii?Q?xv7cSbfaAGwuK2YB0bWvisDYqRwTnLHlwNJBn4Dy3/n8fZJhV5knCGWUXgaG?=
 =?us-ascii?Q?molMsg8urdMvU60WrMuwszu5zvF2TF/OCbGLIr1UmVYRHMMYowxuICtACoQe?=
 =?us-ascii?Q?2G8acloLZ9Cxtt7yEWKrHhXi8L/8apj4zqFj0hW68IMTdMrFw1+4vUQGVmHm?=
 =?us-ascii?Q?QF+ym/xV8ou2MhdrG52drbqki2lZD/HZBI7lqPCVHH8zey1Dhg4GIutEUZcC?=
 =?us-ascii?Q?UFs+u7OKgcepdAUNMgIEVA6ZjcpqysK3PUknjYIHC4/oHiAG5QzA4AfXe9hx?=
 =?us-ascii?Q?/uawT96/wougkltAaDv3NyrfZ/scExoqBPtG6IIywL3D+ARSwI8PvZHr/aCE?=
 =?us-ascii?Q?pTJAWu5chMg0oKUmMDVJLpfrTxkccAygXbnmdqfrpOk8jaiVj/wEZ3bc518A?=
 =?us-ascii?Q?MJ8DIQwkmlPqth+tu4Ivp6lApmoXUTVx7R1C+kq29fO1B4A/Ty2eyoVyWS+U?=
 =?us-ascii?Q?up3Au5x7djI1tIyVNiEc2bjNw1NfGCIXYel0MahhmPKHPCkogkDhwCxFwLic?=
 =?us-ascii?Q?PTZONtrGnpi5ofXIiocM+KeBI8PfhUQeh1cZA7/wuo902dawVjBV+fJoXaHA?=
 =?us-ascii?Q?vW/GkVmo4i3kbZoPNO9WLe0v0bE2ZwhnCWyomWMQuwl/gmGcFxgI4Oo8KOj2?=
 =?us-ascii?Q?v2aQp8r7qE4NUezyP1+kVwQkMIlNpvu9JQj9PH1DsvmIq1I5cZwgD7n2WgvZ?=
 =?us-ascii?Q?0MKOhdBxqIYS9e7uhT6AkDB4ddcSI7xWXB3s3GrBcrAGyReNgjsDT3pvc3SY?=
 =?us-ascii?Q?fle0aRlL0C7QmZNz+fdu5Aiq0NpF7X1iJcz/2hOZVY3Wm/hmDQhhiQrO1pRf?=
 =?us-ascii?Q?glhgggdnkffGC6UWJKNiOReAlWuiUE6wsjJLdcKIW+nrnPEfpSPENhTZVP17?=
 =?us-ascii?Q?MiTEEyLJlA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06c9544-6596-4748-bd6b-08da10dc2cae
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:58:25.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBRJHeOvkfAr+Cl+t4TAJ9W7Zkk+qMSSHde8VvjW0xysbdeSkjwrPYsmFAbc56KEwNsMZjmg0HPFFqGX5mxQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:52PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for dump_misc_regs() in pvt->ops and assign
> family specific dump_misc_regs() definitions appropriately.

Please include the "why".

> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 25 ++++++++++++++-----------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index a799594c9574..1063dda20ce9 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1442,6 +1442,10 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  
>  	edac_dbg(1, "F0x104 (DRAM Hole Address): 0x%08x, base: 0x%08x\n",
>  		 pvt->dhar, dhar_base(pvt));
> +
> +	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
> +

This line can be dropped when dhar is removed for current systems.

> +	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);

This line can be dropped if we decide that symbol size isn't needed on current
systems. We should double check if it's needed when determining "edac_mode".

If we keep it, then it should be printed at the end of the function where we
read the symbol size.

>  }
>  
>  /* Display and decode various NB registers for debug purposes. */
> @@ -1476,15 +1480,6 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
>  	/* Only if NOT ganged does dclr1 have valid info */
>  	if (!dct_ganging_enabled(pvt))
>  		debug_dump_dramcfg_low(pvt, pvt->dclr1, 1);
> -}
> -
> -/* Display and decode various NB registers for debug purposes. */
> -static void dump_misc_regs(struct amd64_pvt *pvt)
> -{
> -	if (pvt->umc)
> -		__dump_misc_regs_df(pvt);
> -	else
> -		__dump_misc_regs(pvt);
>  
>  	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
>  
> @@ -3803,6 +3798,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
>  		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
>  		pvt->ops->populate_csrows		= init_csrows;
> +		pvt->ops->dump_misc_regs		= __dump_misc_regs;
>  		break;
>  
>  	case 0x10:
> @@ -3822,6 +3818,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
>  		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
>  		pvt->ops->populate_csrows		= init_csrows;
> +		pvt->ops->dump_misc_regs		= __dump_misc_regs;
>  		break;
>  
>  	case 0x15:
> @@ -3857,6 +3854,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
>  		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
>  		pvt->ops->populate_csrows		= init_csrows;
> +		pvt->ops->dump_misc_regs		= __dump_misc_regs;
>  		break;
>  
>  	case 0x16:
> @@ -3882,6 +3880,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
>  		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
>  		pvt->ops->populate_csrows		= init_csrows;
> +		pvt->ops->dump_misc_regs		= __dump_misc_regs;
>  		break;
>  
>  	case 0x17:
> @@ -3921,6 +3920,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
>  		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
>  		pvt->ops->populate_csrows		= init_csrows_df;
> +		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
>  
>  		if (pvt->fam == 0x18) {
>  			pvt->ctl_name			= "F18h";
> @@ -3966,6 +3966,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
>  		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
>  		pvt->ops->populate_csrows		= init_csrows_df;
> +		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;

I think the underscore prefixes can be dropped.

>  		break;
>  
>  	default:
> @@ -3979,7 +3980,8 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
>  	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled ||
>  	    !pvt->ops->determine_edac_cap || !pvt->ops->determine_edac_ctl_cap ||
> -	    !pvt->ops->setup_mci_misc_attrs || !pvt->ops->populate_csrows) {
> +	    !pvt->ops->setup_mci_misc_attrs || !pvt->ops->populate_csrows ||
> +	    !pvt->ops->dump_misc_regs) {
>  		edac_dbg(1, "Common helper routines not defined.\n");
>  		return -EFAULT;
>  	}
> @@ -4169,7 +4171,8 @@ static int probe_one_instance(unsigned int nid)
>  
>  	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
>  
> -	dump_misc_regs(pvt);
> +	/* Display and decode various NB registers for debug purposes. */

Please drop "NB" from the comment since other registers can also be printed.

Thanks,
Yazen
