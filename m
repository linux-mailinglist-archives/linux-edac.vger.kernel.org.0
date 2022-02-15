Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08564B70DA
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 17:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbiBOQVP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 11:21:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbiBOQVN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 11:21:13 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4DE4D19;
        Tue, 15 Feb 2022 08:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY8x3rWR+HPc+xi2wm0xI5r03WAHW+BKP0vE1RV9RqQt87YrVH9LAKTDhqU7CDqLUDO6LmcbGu6nfWlA/rg8hhE6eGF9rTmCH0rlZ8RWHDtaIZNficFfV1hg7bN+LKORQIiSFMibZwJTiSs6wsYn3mM6sPTUeJBTV4w6WyxTAi5f7q+/NjLLj6NBZh3eJWvD5nqx4yz9EIEXvThAi8xbMX4irpbX0GSLUJdeRTKwDKZIgaMuHtOdrayBIpHURcU3euky5B1sfbugc6EPCpXW6SNQjyxZFwEIVSK1S7B/J2K2u5B/xCVInF0QCvm5hDs2QAUnl7WyBpWXsYmvBSTC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgfbwUv5Xu8KjuDlBUrFVZZuYb27+mBABKAu4BRPkoY=;
 b=TZL5GNNrT9PIerTzdpAyM+IK/IWZDlQFF/R/PJ9nTRHwpJG2LkkRFkPs8ODUEE18Eh/nQSGF+WJoDT3RHLtuf9vbFN9YJk/fzUSM9WgwdfrVxS+Z+2EuKgsfRR4Iim35p7oqEFjdTzick+ET4uzW/1Q2RQ++3U0fCEoHdnkgIhVJehjIZINrq8vvKzgP9/Kkd7tkmqwwiNTFNJc6WDZskCjHft+VxVdgLy+bu/nPiAMPiyWaC6Aw5vMxnaynYLA3aLus97gsUkgkLEhkOH2Ff1MoMF21cxnBKIqjdbUJz8uQeYXaCWO+MYHzomJx+b0afG+GCf7ftChYM/27xzLB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgfbwUv5Xu8KjuDlBUrFVZZuYb27+mBABKAu4BRPkoY=;
 b=Uw+y5eHZTivfYjMGxHB36Qi4O2VwcyuPsUgHcFz9+at+A+1wjNJXg5YKSzxJ/xQcvhWVp+sSXzO5kJQdCTPU8cQxk6RzXVG8qTvb98oGbY6mKLg5inWlXzutKbO/hQJFcx5LkDIinnGYt/Sn5hIyY9L1cBRS148xLHbXvegZaQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB3003.namprd12.prod.outlook.com (2603:10b6:5:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 16:21:01 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 16:21:01 +0000
Date:   Tue, 15 Feb 2022 16:20:52 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 06/12] EDAC/amd64: Add AMD heterogeneous family 19h
 Model 30h-3fh
Message-ID: <YgvS5JWaNT049vXt@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-7-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203174942.31630-7-nchatrad@amd.com>
X-ClientProxiedBy: CH0PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:610:e6::15) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74bac02-60b3-4be4-7d02-08d9f09f27e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3003:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30032252C2A3475EC577600AF8349@DM6PR12MB3003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0QWcNob0WqHsDCOZyX2SV/KvrV67tEwZlCygoovXUmldop1xfV2qKq/Zc+fN4wPcNifM67mAKeNz6KBbKP2hjVtNa9AP5Acv9W4uuywbDERej6xLzqmCjKu9m4hE0Gn9XPp9MMbXnJ8MosrbWrJ8PtJszV9zOVVBWYUkEKLT18+rRwRu8jO+t3dB7n57m5N/qM9YB92IuZhnruvkGNlYgCSOL8D4nVsvopg7gWiUbbc4JNZksKOYQsG4I5EwjDKjJD5P261cN23HkrASF3NAiv3l0ZwKxvsT83iornamTPTSUH4UP9pAVvg8DX7ML6TkHkoS+dud5FnyuP8qVt7fIPfjjAa8ZwbLHTpKt+/FDcnZIrSp8+XkDIk7n5mLFdbKRaL1mD7R2LX7G2puJY9wrcUPzyv2AJ2sDuSDlJ0MF2f/cQYUipXcQbLi2qgyzkqZCYhCpm0m0zahNJHvnf03YTv8kd0JHoZtbAUMBTEPEAitUPAH/T+ksQJjm+SizaOu9f6DcJkPHpXGQCvCWBNPy2ymk70BnPfnF5ZCFiQuOIlMCCz+1z4OtjPOct0czggvm/jyb0EVlq9KhxEloqCG5jGdPWwwjFx831ryNXVhVIgIsss0Xn5BjY8BXLDdmTFh6g8KKbNOEyXV2YLoPff/rfmHsnEqQ5+1HUc+zJzUvpxNihoJEiEDyPZr5+z1As2maVByioPYG4Ovz8z/xmF5Dthtn9LRcR51RWcgbndUKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(86362001)(83380400001)(966005)(9686003)(6636002)(316002)(508600001)(6506007)(6486002)(6512007)(6666004)(186003)(44832011)(2906002)(33716001)(5660300002)(26005)(8676002)(4326008)(66476007)(66946007)(66556008)(38100700002)(6862004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkBGwaZ9yTv3qrtAUsPS9pDWwaXIt0RziQCl3XBphNymVnolavGL9QxE8Ljy?=
 =?us-ascii?Q?5EJBaihjuOaYGZ4iKpu2fz96Z95Ju14k58eSVh6vBRsHa/HEpEp4OmDwYXCU?=
 =?us-ascii?Q?002zOSGcVmTkG6jaPu/irQC2uTyul6msFg7W0aMl4Nx00O1+3vyXt4NvY0f9?=
 =?us-ascii?Q?f386DrR9Fud+adbDGvjYti2jvIt9ATQ+Nz0h15B3apM+e/L7vWCNupIxLftn?=
 =?us-ascii?Q?HSftyH91SHoxdIcUnmr1a09y/Jtt/71X2nEHpYUWUBDek0fxLDPTw7XawYm/?=
 =?us-ascii?Q?SAAHW7DT7gqKwdjGMbc4jdgg1MJ4glqMC00fzaq2Xzb3v+HaOmcGVzVso5D1?=
 =?us-ascii?Q?VdI+HIPNuDXiF27+nVexn9UGPZvIfdNaQ5qpXLjroZzPdTmkjSug1qlwC9sw?=
 =?us-ascii?Q?B8jPQCuqi6MUv9O5mRReBx9tvzCDQbXOTWkx2s1VAwT+omhDzlkKoWfUJdqL?=
 =?us-ascii?Q?zREIqN/ndED6Pa4PGA8lY+d6xi/0f7y2JELJcxN0lgle/Y/5CJbvPLWkze6S?=
 =?us-ascii?Q?xYOFLUKLyen89yqf1QXE1XBTGPQH3AvunJVHskcxwrCQhRan6r5ghm/At1Vl?=
 =?us-ascii?Q?KYLOuIe1CNfVqW2PRpSIU8/EHnm6faxAjJmT+DXrhJPtRONLWLJxbFJVmIpI?=
 =?us-ascii?Q?dN4VP34dzI5RKgvd95BrTbnKwcvI97AUIYK458WSaHTy0Eeli2gFZnIt1Ren?=
 =?us-ascii?Q?k9Z8fZJMCf5R9XSE1py5IvWT8MayQQVszvSzak1z2MtO4rAO//Rqw8l7A6Pd?=
 =?us-ascii?Q?ToWNQPIH3pmHvCZWSHnlcz+F86wrzDjHxGGZR1BVoTGFuxJJqT4P3dUZ0b2Z?=
 =?us-ascii?Q?7s3qDNKZOVNKt020ED7U1opSjldZHKt8xcFAhOhIRahDIouO9GQz9zIl5h/4?=
 =?us-ascii?Q?QseC7syhZPtO9THrZU44Yfnj5AAiVFRD4FAJEUnW+9SykOaexjg4c3C3V7mZ?=
 =?us-ascii?Q?CSInpdVtXkeqeJcME4Harjfp7lbLuAEs/LjpBjIisC5zqxGYbDoy7zs7wZr3?=
 =?us-ascii?Q?fczZMvv+HEBWCOZOoQG8n/qLeXO2VO1ouVJqfG21JVi2bIniQ6SVTYUcV3RQ?=
 =?us-ascii?Q?42rU7lKkmUVGH8jI8aBQo81yhkAHF+j91fPVaHS1qIpemFWeNcjpfmQ8bdJU?=
 =?us-ascii?Q?4c/keTLTE4uGtXUkGrv2j8qoMUcU1h1z4FgUqua0UEt48gRadhjJqJKCAawT?=
 =?us-ascii?Q?z/+rOzsz9WrPBxe7EXxuM9HNnSWhBTQA6Y24rgAxSl0aD7AW+GiO1cmkVr/c?=
 =?us-ascii?Q?ntfo4pkrtrr9KxDHjF6lS2CrnCb/HoqY6NwlUnnKQYdoQ4NXZnrJsPF++Nxs?=
 =?us-ascii?Q?Kpe/ULkPnfhnXjhecW6MOnycFOLeiHCyt9OYYe3G5PokNIxa5eFu2PpmOaSP?=
 =?us-ascii?Q?2NzT3yjuAEj4mxEtkOvCFztuU/ZQeIDdDLfa4eZJvGfKIctWlfLxO2BMlT8A?=
 =?us-ascii?Q?jEl9pESlBCTKbQXTKuepd8VA/U/TsDfmb3AnixemmLzLy1/9+UxyxHAZfxD6?=
 =?us-ascii?Q?vO7ngm6tRSOxSm3iT5Xcy91i+sU+pHpXS+xreuhA0csp9uvWZ9ziUThrqw5W?=
 =?us-ascii?Q?jx96F4tlWNGazksDTf4GfaK/TNwCpSq7354U6cBrGHuJKkCxKlvPl1wjv+HC?=
 =?us-ascii?Q?IiaEfUfCdb80Utq2SgErBAU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74bac02-60b3-4be4-7d02-08d9f09f27e6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:21:01.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuiZnAG636iuLGQ05oYbAbEjMicPvVuKRBVBXs4PIbvPjkk9Yl8VU0tM5RAiHhpfWBz2KhZ9SF0lsnk1S1WulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:36AM -0600, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On heterogeneous systems with AMD CPUs, the data fabrics of the GPUs
> are connected directly via custom links.
> 
> One such system, where Aldebaran GPU nodes are connected to the
> Family 19h, model 30h family of CPU nodes.
> 
> Aldebaran GPU support was added to DRM framework
> https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html
>

This message doesn't describe the patch.
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20211028130106.15701-6-nchatrad@amd.com
> 
> v6->v7:
> * split the model specific assignments in patch 5 of v6 series
>   
> 
> 
>  drivers/edac/amd64_edac.c | 14 ++++++++++++++
>  drivers/edac/amd64_edac.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index babd25f29845..54af7e38d26c 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -4454,6 +4454,19 @@ static void per_family_init(struct amd64_pvt *pvt)
>  			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
>  			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
>  			pvt->max_mcs			= 2;
> +		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
> +			if (pvt->mc_node_id >= amd_nb_num()) {

"ALDEBARAN" is a specific device with unique PCI IDs. So this dependency on
amd_nb.c can be removed.

For example,
			if (pvt->F3->device == PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3)
				...

> +				pvt->ctl_name		= "ALDEBARAN";
> +				pvt->f0_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0;
> +				pvt->f6_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6;
> +				pvt->max_mcs		= 4;
> +				goto end_fam;

Why not just "break" here instead of jumping to the break below?

> +			} else {
> +				pvt->ctl_name		= "F19h_M30h";
> +				pvt->f0_id		= PCI_DEVICE_ID_AMD_19H_DF_F0;
> +				pvt->f6_id		= PCI_DEVICE_ID_AMD_19H_DF_F6;
> +				pvt->max_mcs		= 8;
> +			}
>  		} else {
>  			pvt->ctl_name			= "F19h";
>  			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_DF_F0;
> @@ -4476,6 +4489,7 @@ static void per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->get_mc_regs			= __read_mc_regs_df;
>  		pvt->ops->populate_csrows		= init_csrows_df;
>  		pvt->ops->get_umc_err_info		= update_umc_err_info;
> + end_fam:
>  		break;
>  
>  	default:

Thanks,
Yazen
