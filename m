Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D24E9D2C
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiC1RPv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiC1RPu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 13:15:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF77271E
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 10:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1im8qxFvCpcHL9tIVxbmK7XPMu6oh5cSNMsWYkuM4uGLbJ9Q3uCBTO8asnsxV7CEfzjyWEA2jS+iErwlnv/f+KNJ3uDcmGZ0yEVJQeS3n2n/NZ3Tn3ziokGJIphHEXMMupf7YkJrVbzZnWM8Lz/mfc3LJ9vGvB/B87ErCMhxiQB/sC75qkJiwMkc9/BfCINais/ARn1CcMw3p3MnBT8/tDIuUgIChtKpyjBBbj139vqpi9Wj7KjXBvZ5icwpNtJbhzhV4y2d7wcjmijQfQ9PqKaAhlKF/CbrS4IWuVfD+xm257hwGYkOAkQMYq49fb2O4Su49O68T30JFDGo7SEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mYJmx2kT72n0vV5DIzXcjJlqP8/xyJMmoeT/SJ+ojg=;
 b=RMX6J9xwrD10s4Mna+5jJrwOsQgdwLNhtA412DWcZyYqT2o02kxeKSe5W8UIji9iNXWVJy1GStHySgq2xtjo6SUaEOYU25psQlfa1iC+10iopJSGR+agaZJX2KQuyOBqslD7/2jvRSHezmmpiJzf36ahU8O3Nz9rIqDP8gzC/Eqb2y+tR9QIl+oLY1LZopEPdnoWfpgO4117pesh98I3wsEYrlSOyE3KkLG/DQ4a6q47biaGdYW/Ayoc49vG9wKnAnJyh4ryoE/XOe39GYjkzvqYU20wk00d558XeFK2/XrUF+fQjfc63TBSyPhE9sfIzn/4ODJ1xGh+MO6bJ8tHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mYJmx2kT72n0vV5DIzXcjJlqP8/xyJMmoeT/SJ+ojg=;
 b=R6m5WJvOc1L6qCJ+GoRnRdrRIPVKY8ujNoIzLlIahZ9QQoyRpvODvZZI31oi8A6LPOp7sECcm/f+dqCX6AY5I+097zYsc6/hDry5tvq4JbLQOWxjBe8XJdXdk5pjyc4eOoSaV/zBc+JG48uvKusfy3ykA08zQHMrAWDuhTSL3Qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3252.namprd12.prod.outlook.com (2603:10b6:408:69::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 17:14:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 17:14:06 +0000
Date:   Mon, 28 Mar 2022 17:13:58 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 14/14] EDAC/amd64: Add get_umc_error_info() into pvt->ops
Message-ID: <YkHs1lVDCPQWZcTO@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-15-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-15-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:208:15e::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba99e2a-e301-4556-f18e-08da10de5d16
X-MS-TrafficTypeDiagnostic: BN8PR12MB3252:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB325283129EA12A653B4B580FF81D9@BN8PR12MB3252.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQgbLoCc2TOVDKSMDDf/Jp1Fv9Ck9zF+HahtDWVJJfBTUZcjNxFlNWO70inEulGuNq+YMHrFWLYnIeZ6AQS66hmO13BQj6TfT/rYcIxx5TLgt8SLVkACkn6NjhsVxoaejWTBUuwDqAgwmUzbbT/DZYvpbDwd0WfmdImxGY0WJm3s3uoIizMWF9yedhe28ee/OH2/a1fsK9AYAJxy/L1xNXils2/LZ5Jl79SdOmPYaXbGAjlnoQNXpx/ApKpHcz9fTjRpWXDSGDvdVWMbbs2+3iJVEHkGDP+rxumCtK6MzYlhunb6nhRr52XStdcepQFU+pyoKrMkoXqdVfzlocCz5ok7s//QtNnYYWM4KC6deYFwPkZcLE2Mv2aVawfhqVhYcDAohje4GDVa+Q1oM7uzi06EQQ6n3euQv1BkKk/vHrsICk9TG2CUDXZW339Jv6gpOYZ7j/EAfowI0/SbwG6wIk5dt05LZrzI5Q80O7Fh1hS+9QEKbQj1dj/hiMr+RCoCUxZbuwNYO2vCDUcWE/1caBtLdtGRqwfSV71cEaADfnhZA1JzDMqUsALlPWSraB2MG9JuJxnnjM0vq7SiOc1P8Ti5FSq22At4I0kY07/yIF2nWx7gN6sfOaKJtUSW79ybuLO20Fs+lV0RCITx0ppfcvosEiTL8ArPKnEn7J7I13r/t/DDSWxlGaq4K7y8VeLKnBk8D166UMcXows6vJ7nW8y5PTTFJ/ldkYtoRvT6YNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(6512007)(9686003)(8936002)(66946007)(86362001)(508600001)(6506007)(83380400001)(66476007)(2906002)(44832011)(186003)(4326008)(6862004)(8676002)(66556008)(26005)(966005)(6486002)(316002)(38100700002)(6666004)(33716001)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?531QgVGWnetaEFCklVVC8a5hGfpxDu+VudYyha38C1D1dkizY+wshI1mzHdc?=
 =?us-ascii?Q?WMelgC974Zo+MxGDaRP2v4NwQMaC2b9slVXCKFhloyViQKxVwgQHFcO2BOYU?=
 =?us-ascii?Q?FOzf9qKIk8w9GMBvtxYQcq5v1Ui0u+BZMT0A4zaAz1VQ80UKNaRTgWQHJbgo?=
 =?us-ascii?Q?3g9RyNvfrqsE8yt+a+xFLydXM+GYKCFb6PBGoBmTtjiFOR+yG3LYRpHCQYU1?=
 =?us-ascii?Q?aMyHXQqckvWkhOe9GaO6U83y2hAPHQo1pdbew+f2khUxz7pSlrCJklQf5Ddp?=
 =?us-ascii?Q?ezz9cCe5ccXR+LLAL/REGOP1/GZ/oaj4/9U61FluSIxi8JizDTIb7yDnoh3D?=
 =?us-ascii?Q?GitBDdLVeeOlemJfWyOQ5q0C9fK1S5l/8Lha4u4JosRMnRMXCZtsfmyJnLzT?=
 =?us-ascii?Q?yXMSyGm8Y2gbuRR/EsKUA/w97xs7YRtV5NOd7cGkJjcyXrqVkM5uvqeNMQLr?=
 =?us-ascii?Q?0CQdAUQwmDBNI3dASynSY/9InaBpZQopf+3dgshqtWTAWIVvVrnkKSOkmDfy?=
 =?us-ascii?Q?IXMktt2HCGWyhWO8D9t3u4I92ImoOinCAiUhni2myYDiCw4G8CYBY5qpilFq?=
 =?us-ascii?Q?Rana9vhXn7jD0GdY1LJ4UDfa4UMblpHZr2NmlYAit/JQR7ImboNGa9mvbLwz?=
 =?us-ascii?Q?qOyZa17bBwK9z/jcfHkWOYwGGrbw8/iOFJDhw9KhUns4VFxPj/sxuVZZP2to?=
 =?us-ascii?Q?APjmjQJ3bi2PmOHjjOrKBGMUgRLF1kN/38dzpsZdtg5f3+xrXXCh8/nq0Vni?=
 =?us-ascii?Q?MtM96oz3huYTS0Zy2V9anH1alKiUfLXmS9mgZFMR/mljWWL0or05NHAkaXjM?=
 =?us-ascii?Q?0W+PFCmMS1di5XWCAk0b2CIUxHmrelQEUWGz4mOyTO1SiHKWxNWZ4xrhur4b?=
 =?us-ascii?Q?3WS3u6WFMKEYqLRNB/gGYv6wZDEdovLL/rbyT7VFj67zGQ/WQbfHZ58gAkoe?=
 =?us-ascii?Q?1GV7aW5z3gdpyIVTa8m4uYhDFiBXmlrCBZS1Y1HQ7og4SXlKRSzcQaHnlsUl?=
 =?us-ascii?Q?r3RVIygIRKqntaqRNer5ouGkHex2yCeAoVYckdp9GIh1fLIgOotgUZw562Qm?=
 =?us-ascii?Q?YyAEYHBt8IbKY0yNPzHt+PkUH1XgP6W6+X8VYQCXaVJ2Er3ZvTDQeggakO3L?=
 =?us-ascii?Q?lEO0uL3fYI+r37Sk4yCVYanyaVYAhm4XO/w7Ytm4QQ65gR9QXZYSZc/Vee/D?=
 =?us-ascii?Q?u1iI45grPB4b/rP4fM0PAqYjs4VGEwKXNOim1WmWOLKJ6MiQhwrUh/1pNyhG?=
 =?us-ascii?Q?DJcXa5YinJxhmUTMQmBUwgyquojVc3EzciKMfDnHano/BkfzDy09pFcSgKhp?=
 =?us-ascii?Q?JQzLX3gGNFNWLWXGeL8m4oGl+g30PzPeRzkyZNhknyjgTtUUHCCzEuVR5raG?=
 =?us-ascii?Q?UuIr1FFMMSXklM3FExMmn0dfNEUieJmln8bOE7804ByTy7P0S2aR6OpevrlQ?=
 =?us-ascii?Q?naEgX3tfA3YWfVjpNEaVtDok9EHQN89AFFFilzyx6Ul06NbFk9SHmgfBxTgS?=
 =?us-ascii?Q?CQ4b/wqfCxKeW5yrR6EW1H4NgMOnAnPlPdbPC55rEnrEskDaxtXncohefi7/?=
 =?us-ascii?Q?asdal/wo70Zs0g0sP0VyIzNiMHwbraBzaT8za39GbqERV6YLRLbv8NugIcsu?=
 =?us-ascii?Q?nBtH3o7VdCbu1PYCLcjVru4q6WS376gomvO4NqSRzeWaLhgQNKwDMIypFH00?=
 =?us-ascii?Q?JwO1EIQSARHF8CgRfEG+uDLZydyssMeyzGhFJBfktUowPcAeJiWbsGVw218J?=
 =?us-ascii?Q?V4bTYHd03w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba99e2a-e301-4556-f18e-08da10de5d16
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:14:05.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fbmxzc88JJ6u46DNdR5UB02/9parKeKRHrPhcgPiijmAh7hjTwcdASwK7zKX7NxaSpmcxEFNoP3feBnDPm3DSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:54PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for get_umc_error_info() in pvt->ops and assign
> family specific get_umc_error_info() definitions appropriately.
>

Please include the "why".
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 19 ++++++++++++++-----
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 7a20f8a696de..ab4e16070a02 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3056,10 +3056,13 @@ static inline void decode_bus_error(int node_id, struct mce *m)
>   * Currently, we can derive the channel number by looking at the 6th nibble in
>   * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
>   * number.
> + *
> + * csrow can be derived from the lower 3 bits of MCA_SYND value.

I think this comment can be expanded.

For DRAM ECC errors, the Chip Select number is given in bits [2:0] of
the MCA_SYND[ErrorInformation] field.

>   */
> -static int find_umc_channel(struct mce *m)
> +static void f17_umc_err_info(struct mce *m, struct err_info *err)
>  {
> -	return (m->ipid & GENMASK(31, 0)) >> 20;
> +	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
> +	err->csrow = m->synd & 0x7;
>  }
>  
>  static void decode_umc_error(int node_id, struct mce *m)
> @@ -3081,8 +3084,6 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	if (m->status & MCI_STATUS_DEFERRED)
>  		ecc_type = 3;
>  
> -	err.channel = find_umc_channel(m);
> -
>  	if (!(m->status & MCI_STATUS_SYNDV)) {
>  		err.err_code = ERR_SYND;
>  		goto log_error;
> @@ -3097,7 +3098,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  			err.err_code = ERR_CHANNEL;
>  	}
>  
> -	err.csrow = m->synd & 0x7;
> +	pvt->ops->get_umc_error_info(m, &err);
>  
>  	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
>  		err.err_code = ERR_NORM_ADDR;
> @@ -3927,6 +3928,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->populate_csrows		= init_csrows_df;
>  		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
>  		pvt->ops->get_cs_mode			= f17_get_cs_mode;
> +		pvt->ops->get_umc_error_info		= f17_umc_err_info;
>  
>  		if (pvt->fam == 0x18) {
>  			pvt->ctl_name			= "F18h";
> @@ -3974,6 +3976,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->populate_csrows		= init_csrows_df;
>  		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
>  		pvt->ops->get_cs_mode			= f17_get_cs_mode;
> +		pvt->ops->get_umc_error_info		= f17_umc_err_info;
>  		break;
>  
>  	default:
> @@ -3993,6 +3996,12 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		return -EFAULT;
>  	}
>  
> +	/* ops required for families 17h and later */
> +	if (pvt->fam >= 0x17 && !pvt->ops->get_umc_error_info) {
> +		edac_dbg(1, "Platform specific helper routines not defined.\n");
> +		return -EFAULT;
> +	}
> +

I think this is a case where having the Family 17h+ ops as default would make
sense.

Thanks,
Yazen
