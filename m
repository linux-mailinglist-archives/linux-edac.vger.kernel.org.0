Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CFC43D38A
	for <lists+linux-edac@lfdr.de>; Wed, 27 Oct 2021 23:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhJ0VLP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Oct 2021 17:11:15 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:63176
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235939AbhJ0VLO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Oct 2021 17:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKmOImfeV+mRR9iWUj+7twxl/Vey3putNowEH7zwrs6AlOa/57VR21HvF7ZS5SK0R17kOWxyJ6alPah9oSkV3IetQ60TDWunB5CVIwTu/9YVoU0aokq/3Q2XcTH5cSu1QKB+jAILKSIZB3JXeGDAPm5NSyEC/pnnwoY0n9RoaAWg5WNlnZPckZl0e0JPvoTweUBdmMzx5GyvUeVLRFFmzsWEHBU6+CEvLB/oCDle5o9Z3R2mHAplrvay4aEDWnnUi/mk3VwuGy204XiN7bfIZpbMRwCBrRUMO8PRJ1JsvUSJGwHsIzXodal6o346+xtu5OCHkoahxRSVCinRdnkWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN+o/As8jrv8ry1ylm65zpwdKYoUJEhTimx0FIgUO3Q=;
 b=cLwvTX4BT3KK7+c79s9P7sJHMAk3mR//Sa/yi4SgKhHVWNTHw3AGGD3ooFuGm953J1bYoN5CsZ7gjE1K1aeFgfCxoUs0Nn8zd0iCx5TtKHB+puUcQBfPSokh2WO5AOwOh2u4+iyE4eNNYJ1Mma+HCvCK0VYY1lB+Hewn0Cifbd0TnKz/DG5aqgC5n0WSWj1ALi7FZtB5Xtuij92yLAU7+IquxHV/TjHz/20Cr7GiktQOOB3lo5lgJ3MCRd5U5+BNEDZE7jk0+4rLLP63jYDpCW52AwyuTzUmsLfdxHL0WpqRVoVMi3GY8Fzu4TyDjmczm0oJOECk2Od+XzVur96S0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN+o/As8jrv8ry1ylm65zpwdKYoUJEhTimx0FIgUO3Q=;
 b=hn/0bS2XDStHKihmjCIv9EgYBmHjc3YczlGE/DYGt4QENgJgh6CJcjmnOeq0rL2RTwDHRvDfVYUnelAdXIyQGJqo34frk6aMdgXBJuoMnw39Nc0pazvwrK4dFN2j/HWvTuc6aaCfS3cl4ciw3xwCtigbfkBuTVun+B+7XL5zC/w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2948.namprd12.prod.outlook.com (2603:10b6:408:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 21:08:46 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Wed, 27 Oct 2021
 21:08:46 +0000
Date:   Wed, 27 Oct 2021 21:08:35 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v5 3/5] EDAC/amd64: Extend family ops functions
Message-ID: <YXm/0wBVvplOzFva@yaz-ubuntu>
References: <20211025145018.29985-1-nchatrad@amd.com>
 <20211025145018.29985-4-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145018.29985-4-nchatrad@amd.com>
X-ClientProxiedBy: BL0PR02CA0096.namprd02.prod.outlook.com
 (2603:10b6:208:51::37) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BL0PR02CA0096.namprd02.prod.outlook.com (2603:10b6:208:51::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 21:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eabaf3ac-0f39-4dca-8150-08d9998df715
X-MS-TrafficTypeDiagnostic: BN8PR12MB2948:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2948A06E6AAD8926F08A54EFF8859@BN8PR12MB2948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaSgkiJL19DBPkIhJlJDPCJirUeUdd7i3GliCQ1yzhjxsCMJVRJIZbGGByEtM0HIlyFJUAF/reYt+ndoFXK0RCqyDZG6ygCx6k1NqbnZiSif5v5eoXadiSqopwQ3wNK/t5LUnTMQR2loY5MIJ+ggSpPmVMBLM0nRZsvg34PCvzah4kKen1EVFNI7TL6FaXWDBFxXMwWU/UFHqxaicHIu+q6UNWYvAmq38hF8kk5RIOCf43bFm1L1lO9rugCK+7ajMGsohB61DVBv01AsmyU4wCWc8IA+pwVm1nKsPqfqtoW3wLeSWKt2fBBt2LDWhMJV/xTBzbGbUCu7+6KQrnmz4WIGGzcyaWpp98T0azpSXxeAMzRg80+kl3F6nlHtM3GWrzjmlOZtlKd8pDpJwDzCka1deZIuF7Ae6XZTvhob22yxAnWtEvHRuHD34O13OOBmQp4PeBx5FHZi9/eVWiIKMaqqlST2H1/dxN6d2chQ/9g2waZan1r8I1XmDW/yhgTtxg457FuhdOLhnFLUcojYGnP6eANS+8VkOYNHm/rIEHP96+sSTC1bVCkxOh56qWI/8PQUKGnFCTQijafgRuD3vFQBSl+wjEVmAnXD7CnsIL40CrjiJMuvxa3ivdFU5Inpw625LZTrx68nbYdnVYGouw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66476007)(9686003)(5660300002)(4326008)(2906002)(316002)(55016002)(8936002)(33716001)(66946007)(6862004)(44832011)(6666004)(86362001)(66556008)(83380400001)(956004)(8676002)(6496006)(6636002)(508600001)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rTir4ar9ilakWh7RqxI4GHSkV1LFskCq59SGgE4IqCXxIjM557t8iOcViaJ5?=
 =?us-ascii?Q?tQLizkqGI++dSeM50k+LxQAKIdRFd72zwqCNY/Dp4/AGSQsYHJXPUrZU3xU0?=
 =?us-ascii?Q?X95CEV9iYWXJXbgFu3yX40TnZF3wwgDCZrlWA0i6MM+sQq5H5TEZIhaaze0A?=
 =?us-ascii?Q?yeMohIoT7KupPBnjTgCh+g0dnlAWvHIki+1ezYIaRADkcBxrlTC5moT5i3GR?=
 =?us-ascii?Q?L1dZvDhqaWnIEjCimFMxXkGZtndxGxaFbvNe0fAvSL9zSYWjPcF0TqN3/gfa?=
 =?us-ascii?Q?L4Uy6dCZ86Da74mHBzy45qC7dcwcRQ7hkjBohZ1BQOXHSNOk0bt56D6x/l5Z?=
 =?us-ascii?Q?/pF72WvNExNS17jNF58kTgwqzGLT0bcbVrAdG8t+pU4V7s4jgYVwOV3kyoKw?=
 =?us-ascii?Q?BwyCqcszeTaELk3WcRvhXZRlqQSxUZMmbgNgAENLf6VsJT5v0YG5Ln/6rtvP?=
 =?us-ascii?Q?UZfVwmb0NywGdenJhsuOMOE2+2HTdj8/AbfEsfxGdkcAf81ixhrWsYH9QUs2?=
 =?us-ascii?Q?nP0E63O9dHtHAzev8whXxOyFQDwHVebEWWnDqLzdqO6wBAA+uW3umZ/hIR33?=
 =?us-ascii?Q?7Pfzt3ZOxK7e1fnqnaFBa8RtEE59Dw0w8+RcrPUWgVeIoDwWFQxQIl0O1jYx?=
 =?us-ascii?Q?Wgz5SFhyEsxuKF59rail6OI4x4T/Sr34l9OG7NlJT9JAjke+y8vn3HyNTFi2?=
 =?us-ascii?Q?j7NOFfFwukw2o01FqFhDLRC3bhryXAz4bnhQ7ZoM3df9NUgs32L+uf7xx9hJ?=
 =?us-ascii?Q?bjcuV2i0LWV2P8JRqfXAV13ZQNu8peQIAZhRXmCRrpyVBU+4xm8FZBF/pfT0?=
 =?us-ascii?Q?dZe2Yn2XxCvv7ySoAcn+GDxASr+/q3fVrtzFWJg+Yk3CWdPhSWmJg3h9c2Dx?=
 =?us-ascii?Q?hdTmLRj3T9zXwwidNm3UCUQZEH7QQb5CCRmzzaxuAE77XSr+X6XPZ80OJPGP?=
 =?us-ascii?Q?L0ZAobWOOhV3F4XwqY4iE5b2rL4Sxi5V1oeiPIWjRgtFB4R8PN68kTrg4elc?=
 =?us-ascii?Q?IcOzYOyoa5owpvV1ODqYo/MGIJaxhbosV8m6t1BJ4f/48Zw9EU+wp0X8Rdr7?=
 =?us-ascii?Q?edNEZ5AHVnmTpzjE7m2K0CTyWkWEwF1C+n7P4NLJjFFms8NlsPbE9dvz2OK7?=
 =?us-ascii?Q?6TmEvIoK0HpeO4l3Sea3e1plu8NEFpGe+xOtdri98e7BzeJlqssywPGe3Wao?=
 =?us-ascii?Q?ImvkbcNLZSy71/rSTJiPUPoTLSJ5VZtJbw/Jt166Fz+iOkhe7kwrIYD3szoe?=
 =?us-ascii?Q?RgVDTWI13LVNNHjVwPhNRDfDFRY/m142WhdyiqDkiZrEC6GWjOsHDlg3nM/E?=
 =?us-ascii?Q?BL1LUKVdUBxY0G0UsI2NVEL0xLfUV4ntNeagsrLD9MhxfWngR2/m22Qe1SH8?=
 =?us-ascii?Q?F4FIn4yEXx9J2amj2HsZpH+3eAUuFRJ9SPOa/Y2+u8nXPqDMiJTucuiP6gEW?=
 =?us-ascii?Q?GIdjIqgqb91971hTF07zDkDGJqH5VO11+BYRrTlDViqv5lvAEfp1mzEpjvTq?=
 =?us-ascii?Q?6y2vr5mciRmyNui1m6GclLr+5ZXcekYx+GPDo6vePa4GtH2egZjEgaGosXay?=
 =?us-ascii?Q?8fwTrza76Mb0qNq1PhCSHaoneRPHLAMHXC68AajL1XaarS+H6E2uN+lI6eYF?=
 =?us-ascii?Q?MNEq5h4aLcVj8gA7gh2yDHw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabaf3ac-0f39-4dca-8150-08d9998df715
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 21:08:46.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcjxwwOOKJwWRshoyN+C12CSagX9Neio+F/AzjF2DhFUTRIuYdNg3SkERuXg0348cXJUe9i/cqleeDfCFblYHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2948
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 25, 2021 at 08:20:16PM +0530, Naveen Krishna Chatradhi wrote:
...
> @@ -3106,8 +3141,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  		edac_dbg(0, "  TOP_MEM2 disabled\n");
>  	}
>  
> -	if (pvt->umc) {
> -		__read_mc_regs_df(pvt);
> +	if (pvt->ops->get_mc_regs) {
> +		pvt->ops->get_mc_regs(pvt);

This entire read_mc_regs() function can be split up like how you've done the
others. So get_mc_regs() is set for all family types. The common code can be
split out into another function.

> +
>  		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
>  
>  		goto skip;
> @@ -3154,7 +3190,10 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  	}
>  
>  skip:
> -	read_dct_base_mask(pvt);
> +	pvt->ops->prep_chip_select(pvt);
> +
> +	if (pvt->ops->get_base_mask)

This check is redundant since it's done below in per_family_init().

...
> @@ -3703,6 +3739,20 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  		return NULL;
>  	}
>  
> +	/* ops required for all the families */
> +	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
> +	    !pvt->ops->prep_chip_select || !pvt->ops->get_base_mask ||
> +	    !pvt->ops->display_misc_regs || !pvt->ops->populate_csrows) {
> +		edac_dbg(1, "Common helper routines not defined.\n");
> +		return NULL;
> +	}
> +
> +	/* ops required for families 17h and later */
> +	if (pvt->fam >= 0x17 && (!pvt->ops->get_umc_err_info || !pvt->ops->get_mc_regs)) {
> +		edac_dbg(1, "Platform specific helper routines not defined.\n");
> +		return NULL;
> +	}
> +
>  	return fam_type;
>  }
>

Thanks,
Yazen  
