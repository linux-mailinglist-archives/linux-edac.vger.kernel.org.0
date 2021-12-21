Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9F47C729
	for <lists+linux-edac@lfdr.de>; Tue, 21 Dec 2021 20:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbhLUTDI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Dec 2021 14:03:08 -0500
Received: from mail-mw2nam08on2053.outbound.protection.outlook.com ([40.107.101.53]:57979
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232879AbhLUTDI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 Dec 2021 14:03:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlpGe6W3uF5Bsc1GGMcFGctbXN/wqrtBQNYA/l7RKvwl9mn7YUuF6y09GxxNlxWFFda5sHcIA1NH1q8kmySHy/h/fmEATYsA7zrgrXofhgUBwYd59u87ml6SCvdLYDSykB8gW9DupbTNnRsJ6DaYpJfZ6ibdm8gkyT//XMpHGEKRa+6Y+qslwxmdsvWtJrFL6b70B9CCkWdjWXeDQV3nPXzvNwAfyn6BXpj8WeggIXpXZFi9X7IRvWnwjD27t6A9TpnwNnpqPsmP6VXknr788vIIlQaRge/CzPSxOcHdV2VmcOUgMpPf67RYir0iRPvmMnz461u1347OtK3/gXm18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21iIwTLT+kaJCbqXHTgZj1ojmr3nF2gXQhCYYBhI69s=;
 b=MJkEDwDTpbn6Yih/uS83tWEyTRukTJb7fKb6YxzvUPomAWLQ+Ml0i/pBf7coPqmYfvwFySicPjGqsjh2NeDQQM4g4JH+akGdkk8/BYfVNdTpOr3z+CdDUlnRzb8T+8HW2kkP0lJd6S+cV1HZE7WIjoUIFWFoVdSOx3/pPXYEPzoidCsm+fN/zxplaLEAKDhcjnE5uN5Hl6GSmpUTHuYhteVjfXctSBqHQER83bihtAe/dapUILNSJHQMOM4BGInNk4soMOJ6h+aWMDEzH0dXFYzr4U9i+mDHyypzOaL9hCiEZQm7Wh03z35Wf/Ohb/tGvd7MK6LCSOmFiDqQHQD2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21iIwTLT+kaJCbqXHTgZj1ojmr3nF2gXQhCYYBhI69s=;
 b=V1EuEPdSv3tuQvyNeaielQ03yoKIkasJnRAbQ18fOIraAKsHTPHPJVRwQnGzHV9oNLGhsKxtKhjy1wKVCT06onHHDycH8MhCl8KrU2Qq9iv3o7mnXfJAWWKzjFrB1HbC9UkusCuiVVD+3QuAnfqnTz8vMf5xKlT4kCOItG0Lm0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3284.namprd12.prod.outlook.com (2603:10b6:408:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 19:03:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4801.022; Tue, 21 Dec 2021
 19:03:06 +0000
Date:   Tue, 21 Dec 2021 19:02:57 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Marc Bevand <m@zorinaq.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Add PCI device IDs for family 19h model 50h
Message-ID: <YcIk4XJaBZs/aihF@yaz-ubuntu>
References: <20211219223127.71554-1-m@zorinaq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219223127.71554-1-m@zorinaq.com>
X-ClientProxiedBy: CH0PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:33::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0c2db85-f02d-4faf-5ff3-08d9c4b48520
X-MS-TrafficTypeDiagnostic: BN8PR12MB3284:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3284E054066447432B34D379F87C9@BN8PR12MB3284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UD4KGOecKBTIPk2N4TMcUmaZg61I+iqx9msa1HDpCaA/v/iaW5Y/y6f8M9/2Zy7qvotfvnugqU8/IXAl5Wa85tD5eYvWHDfwvP8J3hCySTcfv1NUFGdMON2YNcWiB6G5M4Nfak3Ryr/rNfhHkwJcIvRh4uPN1zU9HDjV/Yi8H7N7dfM2iVvdkGjApF2G9lwzz4vEEZQ6y8gqqhZ1ED3PCERMAy0ZMc9gcPuJTuhUE6QbmIRt/s3q14J/MEvnWWvje06AqAzB9e68X0ch5Lu9p57yeViC2ZuJznudI1SF/fI2DfjVlozLJQPV0hOcu9wg9fQq8BwG+dSkeVkwvAyek/43m0+mbhEzdTYFDOWm6cTDqL4fFMvGoBgMGeN3F/YvpEHC1d73BAggRjBiqUOLY0XnawOtK4Xd65KDLoCicBQKBLvobzNwgGN1oJArq+3LGHxyUEGRQOD9/P8YGxsp/XQuxZ+wV3XiSLHBDFakAr/L1hoCpQOnuzGYiDUH4WU27YCKJYO9JEnhiCXja/NpfwBUTAJq9CgHjicuHECjgLo+qurWkx90wgonoeYwhzUgEYLlF68w+A5W1OpGDfh03wDUVdS+y3q+lAGgbpWlfTBr+Ow1TuK77IsAJHGkU8WLg1+r7vw6l2kQQYIupdMXlpwuNVOVURX6PbXiWIVnigXvJQaQCAoMrmLWEHNR2wNYnPqG3dzC/zGLjTwc84w+VD+q+CWVEuP4UtU0P2x6LVzv4WvDymBzFBcmqifFhfh5MKPPd0b9comF+NTpadLrkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(38100700002)(6916009)(9686003)(6512007)(44832011)(26005)(66556008)(66946007)(6506007)(8936002)(2906002)(86362001)(186003)(83380400001)(508600001)(5660300002)(4326008)(966005)(6486002)(66476007)(6666004)(316002)(8676002)(33716001)(781001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEXP/Cdtzn18JYP9SyanR/wI0mS9pOIHwElAtJAnGzA2YByC9bWGjCfJptOt?=
 =?us-ascii?Q?/n7gqh1IUvBu61DG4YmnCOW4FlH2CNQ9cBP/OLPaF5Lp/mvIRTbwrlTbpUkA?=
 =?us-ascii?Q?QchwHUm8A4zK9/wwQSEHvMAxnK06LMKHE4d6k/XYLMfLxpNwxyQxTYRf8fNA?=
 =?us-ascii?Q?lSCKoNbArr+LoNFhrIrG/KkVsdznaSGTi4MqW2TPzCYSBZfxUGWwQiIsx1i5?=
 =?us-ascii?Q?nENF1k7WVpa5UcxN3erp/TG6lrdUX0sGkaed+W2W5xdc2mxEVLNbE3d2IeBE?=
 =?us-ascii?Q?urvfWJLDhcVNFBvJqUY+kwBfIeb4E2EMASiejcKQDV9oD5ABIlpAUtTVWGOP?=
 =?us-ascii?Q?S5ZAGI4reJvvWNcxgsn/NFInlCweQBwM/hUQoyAtdiOeQnE8eIj9DRJaE8Kr?=
 =?us-ascii?Q?uAznIoagdhKM1eE42Ew4jEKYOsckbQ5W6WNg+8jv+VsChHQcFsXqtxFG2bCj?=
 =?us-ascii?Q?UwSAu9xAz3UG1w6MhTDQ2fDi74DQN/+QHZAkwXboF/D45mQThyAu/ig8PNPV?=
 =?us-ascii?Q?yFvQK2sd7HqqC5oPvPZO6cvS0/BUlNNKsO0LOzPbv+gWzhIDO0vRsBcqqcp/?=
 =?us-ascii?Q?5nDvrB3Mrtl5YTuyfpRPgXje0OY5AF8P/4HvLS3bwFChmAfo2BWgV5vucxg3?=
 =?us-ascii?Q?G2h9PxQR/s+rFQ7ZTNSZcVcSugM/PrCAy/7cpfVYWXvApniiwQCddvzpmZDj?=
 =?us-ascii?Q?7tRRNZw/037ly/pWq+yjHPjtNdEvEJviRwhp1RcZpLcANbh1VXfKcmlRdJmf?=
 =?us-ascii?Q?0TQ4C11lsBMIYiTP/OiqnFfPeMgI6JZuvCfV0nlKvXvLyu9od7WO3khQUJyQ?=
 =?us-ascii?Q?THp0MsuFjgWDL8GQvJaTohvIfmhXp53rQ7zoKn06cGh7jRV4i/q29rc9wN9Q?=
 =?us-ascii?Q?nSUQelWPCYhWchuHKy2sYieVP+by6eTtI1nvA6kWd3DIPm2GW/jWOPsewIgj?=
 =?us-ascii?Q?57idf1yLJ05cbnzqmXJXPtkeesC5TPMoGVV295iP57n3eMougWCMp/1Hc+sJ?=
 =?us-ascii?Q?2SKKJVB99c1l/S57JwsBWH4Nd0tZP3S2vvp9bIGu1mLJ3aLp+tIwBykkTfES?=
 =?us-ascii?Q?YH/Y025DZCxnEJGI6H85CiIEIvK2uOeGhaE1iA5EdNgcGxR3/sin3xj6ACzj?=
 =?us-ascii?Q?YE/Xq4KkQp+RRQsZcIuHr4WtkyDa+tU7/DcvhZ6E6W6YguU18O4VxI4lvjXU?=
 =?us-ascii?Q?WFdxtATrGgLFPk9/vpv56f6MczRepZ7sNzevRBxTHeS0F8G+5tOxsEx5h6gO?=
 =?us-ascii?Q?10Zp4m8UIvliFvFTmGFsnoNA3WW4bXS2bNUOws2u8REIK3FdGoq8Pmc4TL2K?=
 =?us-ascii?Q?IuMqrJK+QHkwy0ydWPptVgepEqM//qOSHFkLCz44YH2l1Kqg/U7gSfHlA+2J?=
 =?us-ascii?Q?EvqGo6Kgxy7Uqk6LoYWASG8qQhdJh6AAnU10ZuIZFPIFpGhSSxVoSzgMKW5S?=
 =?us-ascii?Q?hNUtNha9VnEI4lx9L1Xc5wkpYpfAMG2fy+goN16Q2hdYlzWpabOF9kgrWPlT?=
 =?us-ascii?Q?JOqBsROL9qwnOTVicaUQ2TRnixkxpgJ8Grm1ca1Xuh3muhXFGOuwrMSmXpBy?=
 =?us-ascii?Q?UStYrcShzGO6L8sQTgMrYB67e9pctKF4ekg4vy0Hu+MZXSeHPd+Jbn2j6OKo?=
 =?us-ascii?Q?s9zkD/OsqWm5ke0c3nXvK0M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c2db85-f02d-4faf-5ff3-08d9c4b48520
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 19:03:05.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwKhuvOTDwPxwCdWdfWMHcTkTiPmRD4sCyq2efMi5iFoBxO3Y1hBoejXErXTyu4bU7e0nKeKY8ut0/j0SrKfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3284
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Dec 19, 2021 at 02:31:27PM -0800, Marc Bevand wrote:
> Add the new family 19h model 50h PCI IDs (device 18h functions 0 and 6)
> to support Ryzen 5000 APUs ("Cezanne").
> 
> Signed-off-by: Marc Bevand <m@zorinaq.com>

Hi Marc,
Thanks for the patch.

> ---
>  drivers/edac/amd64_edac.c | 16 ++++++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  2 files changed, 19 insertions(+)
> 

There are some recent changes in these files upstream. So this patch won't
apply.

Can you please base this patch on the following branch?
https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-for-next

> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 4fce75013674..45c81c0a232f 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2650,6 +2650,16 @@ static struct amd64_family_type family_types[] = {
>  			.dbam_to_cs		= f17_addr_mask_to_cs_size,
>  		}
>  	},
> +	[F19_M50H_CPUS] = {
> +		.ctl_name = "F19h_M50h",
> +		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
> +		.f6_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F6,
> +		.max_mcs = 2,
> +		.ops = {
> +			.early_channel_count	= f17_early_channel_count,
> +			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> +		}
> +	},
>  };
>  
>  /*
> @@ -3693,6 +3703,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  			fam_type->ctl_name = "F19h_M20h";
>  			break;
>  		}
> +		if (pvt->model == 0x50) {

AMD systems are generally released in model groups. So this change should
apply to models 0x50 to 0x5f inclusive.

When updating this patch, you should find that there some "if/else if"
statements for the various model groups sorted in ascending order.  This
addition should be inserted there.

> +			fam_type = &family_types[F19_M50H_CPUS];
> +			pvt->ops = &family_types[F19_M50H_CPUS].ops;
> +			fam_type->ctl_name = "F19h_M50h";
> +			break;
> +		}
>  		fam_type	= &family_types[F19_CPUS];
>  		pvt->ops	= &family_types[F19_CPUS].ops;
>  		family_types[F19_CPUS].ctl_name = "F19h";
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 85aa820bc165..796e39e1890c 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -126,6 +126,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
>  #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
>  #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F0 0x166a
> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F6 0x1670
>  
>  /*
>   * Function 1 - Address Map
> @@ -298,6 +300,7 @@ enum amd_families {
>  	F17_M60H_CPUS,
>  	F17_M70H_CPUS,
>  	F19_CPUS,
> +	F19_M50H_CPUS,
>  	NUM_FAMILIES,
>  };
>  
> -- 

Everything else looks good to me.

Thanks,
Yazen
