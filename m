Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F4D4B7329
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiBOQe0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 11:34:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiBOQeY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 11:34:24 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F314F9ADAE;
        Tue, 15 Feb 2022 08:34:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMzv1p4Q6e1ff4aVrnc0JTscltCw+qKJb/iZF8wQykfePO72JX8DizdgaVQ6zXMQbT/MFRZTPFLhHma8EIdDtr9MojNvak5ih8xj5aZZOpsySF2akboW1TDSsQQEyFRMxCbFsJMYYj2ygHBuYVtfTdadjAoLocE6ldC7hhED40AiiYpJR5FDbLNFYxHh7U6JJlScw5Lkxhtjv+odCPZzvwJvSyizp+22fPt/L4J5BbhMYASnSSgOoAW3f0fG8GFZdzUwuTS9XoN3nbQwdTT7/+/OjQrkT2e5NkQWNrurbtb/MOU/hGm3h/caQ9oT+29OKUHP8vA+9wdiMSFyE6SPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQZjICgYLbR7kMbv2Fzxjw90aZ01SKlNF8c/vQ3022c=;
 b=Z8zSySFknZfogIrpruDtM0KFWh/2L73JibkHhmgvRV+GXbd7lUUE3BfJkZvzCsRPFjDgnJaprJjUarm4tx3ebV0NYJKJTcMKtqTo7fjRYRwwFCC2U0IoOXNwzVclAVvz9GeM8jSKIEMHdXtf613GdyC/Yw7oHDiiEqiK+pWeYie2PBL2+wE+tqMF2+QM1JHB9iyYSdXJcQZTN4Ku7o6D777+4qIvCNXcx80qObCoV68EHPxsPnT8rStURNkx8uvai7WX7BeMSB75CVUmxqhvvv+G+MMPxHGo0U72nk/1PPZf5xgdkqnEP7sk3bI4s9k+kDRwPL6u9Ho6+Kb0HPZ/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQZjICgYLbR7kMbv2Fzxjw90aZ01SKlNF8c/vQ3022c=;
 b=joHzMHbyaE8Z+iZK6FEiazUgROAG+Zwcp8ciWxNoFP/csdNvKfOS0WKTfw2OpgR1VZXHnT4RNp/oNPX7U9wpMhP0F/IcavKDANtHaiVNCVG6YDq78VSfmI2EcsgBPk5LpH5E50rN/JgXaf/LBBVvfFqnpxtbb6gJBQaim44UnsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 16:34:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 16:34:10 +0000
Date:   Tue, 15 Feb 2022 16:34:00 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 07/12] EDAC/amd64: Enumerate Aldebaran GPU nodes by
 adding family ops
Message-ID: <YgvV+GUd9YL7FKXb@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-8-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203174942.31630-8-nchatrad@amd.com>
X-ClientProxiedBy: BLAPR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:208:32a::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b6e4179-21fe-4fb8-8413-08d9f0a0fe35
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2481CD079738B33F27B661C3F8349@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:356;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vk+FHZl3SFUbPVaNuUD7WIJPldgtdvyQMPcJsc69+pxH2gsm5Xo6y99CPKl57OBPU4zbUe08u2umj+6FpDzpLfK7WeKFo5xnXoLsCHNnxIWGHdJApd/DuPzxgprbggr69zSVN5jzX0Gyrgu9RTWLx2T+Dll/nxiUDcxO9VFN2i4Qm9kwsUgqysgO1P61e9kJFy+E9n67E6/HrFOyRvCNldPYpCWo+zl52tzHB0Q7qJWKdOLfEuc1v+dElPZBcNuxPFfy33E8OCJwSBZTH8LqvHUPrDhiobyxS0/OGBy7eZG2fu9c1/nzSK+SzeyWwFmIAYO5Xx39mxNWlwOq604zLVOuFLXq9XD3tb4gK71fUKoJHN8AzDWv8pk47EuyD6QeCYTeVkjtvsUf5eS1d8zoFPoRU3Zqn8dODYoBGlSWENs9kjlORnORsHgSitHLVraVFYkiKD7VqU0mRfeZHS94/OUsf9yDFFCrkwFqcbfv/NuLkdK2WzJMSjEhEhilxtblZXnH2Y2kFY6EuV03XMZYFwFMKYoU7beBM+5yw0UlIC2jTyGWDxUx0WxzjlSM6hj9p43WeMXPuRx/3bmJBaOKwTXKHTDbBXMs2U/m2iPoanbOgkdjSBbg4NCVHvCmMcxrnRrqqbRhuAzuUGpVuDnhRfVJ1EsMh9Z+GtMDsk630i7v/89ZQAsyJeJD7DYCY8Yuj8EtpUFfTb+R+9tyAK1EXFh6FilNzlQ4LvMTN2Q9nXyMx2HWM+rlEZFjHfe6FVNd7TNjnCDEUVJ4SMk7NcLhtrpbzR3ZNUWji5vsXyu2mYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(86362001)(33716001)(6636002)(966005)(6486002)(508600001)(66476007)(66556008)(66946007)(8936002)(4326008)(6862004)(8676002)(5660300002)(6666004)(186003)(30864003)(6506007)(26005)(44832011)(83380400001)(316002)(9686003)(38100700002)(6512007)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WGuiz2rpXaXsnvf6CByY7Coeld6cctk0amR0fW3ZTlG+Hbx/e4uclVxs/Ubz?=
 =?us-ascii?Q?dw+3tugncGuEE1g0nhzGeayYPi7cAOQpaLHL3pZA/lQmBP89Uom/06N6m255?=
 =?us-ascii?Q?o3bJAXaif/UE45CILsSIQaU6VkeL+ZvaR3hkcFWBpLh+ugi6LskNtqd6TpAJ?=
 =?us-ascii?Q?l9r81QpR3YkWNbwDZqLwQsTwcU4UtXkfzBEci7zPxdc1qRoNSFFDo620HQwo?=
 =?us-ascii?Q?wgZ3Om5stG9eBEWHmXrYBPLIfO98mOjhO2MCz22EgOVEHskXhrWz9Vpfb7jy?=
 =?us-ascii?Q?nGkQQOS9CFqq+5NTrRrBD4eAbz0vX6d95J0UDZiWwgXZPzWgEpsysI1HEIr7?=
 =?us-ascii?Q?oEc3sB4MFCROkAoyt2mSC878zkZofLxi7uoqsjoMMK3ttgceeK3p8HN7HtMJ?=
 =?us-ascii?Q?n0RsK3TRq6N8O1j3dvTD2FM48jj2WcOq/7ai8kN3NaX9vARfPc86rwhBKHR+?=
 =?us-ascii?Q?Y3pj8WFF3ilL5Mf3z+xEyzEXvGnzlPh9OaW6mh6rJQVUoiMi8babP+EsbKjj?=
 =?us-ascii?Q?CQCdBMCaCiqzSPtMSX3Y9nTfhf5qThxEqDbscB6ikr2gVcn2bsjkqODfVk5w?=
 =?us-ascii?Q?e+3fXKCUA8cID4frMbLLTYlAkuWOMSPbAIETk3rBwc8NaYYc+Hw4C9Y5wWch?=
 =?us-ascii?Q?QHFWvfI8Pm8NAxza1Dq7IK/Yk2SYwdyBAXxpIDqPu10g2BakbGJLabyfwhrQ?=
 =?us-ascii?Q?CFWsI9J4VBXW96qrTIoVDZkCtdKrbNnoqsvcHzn9V0otgg1OSmv3a7Tx9q2p?=
 =?us-ascii?Q?w2KFKY7nCYwhaAfF7qZEG9Se2CN4CLQ0jHTTkWGJV0bVjNSjE4+c2yz2EiwF?=
 =?us-ascii?Q?6ksVNBnlFKILTXT4K+cRSIV7OhD1mu9Oh0ErRlUgIWOTzN6j87n/BqyMSezN?=
 =?us-ascii?Q?0+McPk0kmSjV/1T/uYPzXrqJDkthMDIIurr/7P1A5yrz74T5Z35tfushqn1s?=
 =?us-ascii?Q?NCkNb+Y77nrA4Uk8tP15iohgRCbHgrpWOeQ4U8sDEI8TkwlmGGD+WfAMgV3T?=
 =?us-ascii?Q?ceDUlPH6Dp4Gh33KUK2RErk6BgAuSWVRblcGQ+IdVeV0MNe88EW8qYRNgrHI?=
 =?us-ascii?Q?9xbLIfXLp1qKcWHxkMCWDzaL2rcKVNZNFCheWkWHFYCQSBzpLDXhj1NmjgiQ?=
 =?us-ascii?Q?6GcGPYHfhdZWefPiWFW4AZ0/mQygpIs7TmgYtv5gxdfEI7Wy9T11WPAIyTFW?=
 =?us-ascii?Q?y41eWmsjvM9MCngPxrissgEnfFqGtkr/FF9/i4AjPfRS/FSuQFh6DqsFeFp7?=
 =?us-ascii?Q?qu5qguMLCUyjd2BqqwoAli4iLR1ucoJQK7hb0ZyYACIvEedr/P5KaaRiRn3I?=
 =?us-ascii?Q?OAtLCN8jQ32uncQ0lJFIUScQv1h40Ngl/U7ZPY6gabFJhdliLwBGFcc4di/p?=
 =?us-ascii?Q?t/8/j90IaUJuHQvXAO30EVi5aT8spJ+Qlg7vmtLgrIqE0cKUo31XFiQXNfim?=
 =?us-ascii?Q?k2heqxLjQpJTl5LR05jPbAVbjIHvd0tvQRippvDRqE12OF9+QCrYf4dG/erj?=
 =?us-ascii?Q?iFCXQoxaeeYb5qMS+E1jUL8qIJKiagDypt0w1jeOzuqYtvQjknqqL/K0syt4?=
 =?us-ascii?Q?6VrIxQWXth9zxR1mbFAM3hEZN2pDViTRpY2adm1mf2alnTi4rnj9YT8XG+4f?=
 =?us-ascii?Q?9Sqs+Yg25MZD/PRf6bCC6Oo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6e4179-21fe-4fb8-8413-08d9f0a0fe35
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:34:10.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcdGZQLf68bGUaE8H3HOjl3ixrwtmKec1ecQwhVZtUpxRIZG60QSYLuR3wiT+Hqbgi7W+2HwF95B1adrd5ki7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:37AM -0600, Naveen Krishna Chatradhi wrote:
> On newer heterogeneous systems with AMD CPUs, the data fabrics of the GPUs
> are connected directly via custom links.
> 
> One such system, where Aldebaran GPU nodes are connected to the
> Family 19h, model 30h family of CPU nodes, the Aldebaran GPUs can report
> memory errors via SMCA banks.
> 
> Aldebaran GPU support was added to DRM framework
> https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html
> 
> The GPU nodes comes with HBM2 memory in-built, ECC support is enabled by
> default and the UMCs on GPU node are different from the UMCs on CPU nodes.
> 
> GPU specific ops routines are defined to extend the amd64_edac

This should be imperative, i.e. "Define GPU-specific ops..."

> module to enumerate HBM memory leveraging the existing edac and the
> amd64 specific data structures.
> 
> The UMC Phys on GPU nodes are enumerated as csrows and the UMC
> channels connected to HBM banks are enumerated as ranks.
> 
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Co-developed-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20210823185437.94417-4-nchatrad@amd.com
> 
> v6->v7:
> * Added GPU specific ops function definitions, based on the refactor.
> 
> v5->v6:
> * Added to support number of GPU northbridges with amd_gpu_nb_num()
> 
> v4->v5:
> * Removed else condition in per_family_init for 19h family
> 
> v3->v4:
> * Split "f17_addr_mask_to_cs_size" instead as did in 3rd patch earlier
> 
> v2->v3:
> * Bifurcated the GPU code from v2
> 
> v1->v2:
> * Restored line deletions and handled minor comments
> * Modified commit message and some of the function comments
> * variable df_inst_id is introduced instead of umc_num
> 
> v0->v1:
> * Modifed the commit message
> * Change the edac_cap
> * kept sizes of both cpu and noncpu together
> * return success if the !F3 condition true and remove unnecessary validation
> 
> 
>  drivers/edac/amd64_edac.c | 285 +++++++++++++++++++++++++++++++++-----
>  drivers/edac/amd64_edac.h |  21 +++
>  2 files changed, 273 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 54af7e38d26c..10efe726a959 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1012,6 +1012,12 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
>  /* Protect the PCI config register pairs used for DF indirect access. */
>  static DEFINE_MUTEX(df_indirect_mutex);
>  
> +/* Total number of northbridges if in case of heterogeneous systems */
> +static int amd_total_nb_num(void)
> +{
> +	return amd_nb_num() + amd_gpu_nb_num();
> +}
> +
>  /*
>   * Data Fabric Indirect Access uses FICAA/FICAD.
>   *
> @@ -1031,7 +1037,7 @@ static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *l
>  	u32 ficaa;
>  	int err = -ENODEV;
>  
> -	if (node >= amd_nb_num())
> +	if (node >= amd_total_nb_num())
>  		goto out;
>  
>  	F4 = node_to_amd_nb(node)->link;
> @@ -1732,6 +1738,11 @@ static unsigned long f17_determine_edac_cap(struct amd64_pvt *pvt)
>  	return edac_cap;
>  }
>  
> +static unsigned long gpu_determine_edac_cap(struct amd64_pvt *pvt)
> +{
> +	return EDAC_FLAG_EC;
> +}
> +
>  static void debug_display_dimm_sizes(struct amd64_pvt *, u8);
>  
>  static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
> @@ -1814,6 +1825,25 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>  	return cs_mode;
>  }
>  
> +static int gpu_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
> +{
> +	return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
> +}
> +
> +static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
> +{
> +	int size, cs = 0, cs_mode;
> +
> +	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
> +
> +	cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;

Why not call gpu_get_cs_mode() here?

> +
> +	for_each_chip_select(cs, ctrl, pvt) {
> +		size = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs);
> +		amd64_info(EDAC_MC ": %d: %5dMB\n", cs, size);
> +	}
> +}
> +
>  static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
>  {
>  	int dimm, size0, size1, cs0, cs1, cs_mode;
> @@ -1835,6 +1865,27 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
>  	}
>  }
>  
> +static void gpu_dump_misc_regs(struct amd64_pvt *pvt)
> +{
> +	struct amd64_umc *umc;
> +	u32 i, umc_base;
> +
> +	for_each_umc(i) {
> +		umc_base = gpu_get_umc_base(i, 0);
> +		umc = &pvt->umc[i];
> +
> +		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
> +		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
> +		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
> +		edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
> +
> +		gpu_debug_display_dimm_sizes(pvt, i);
> +	}
> +
> +	edac_dbg(1, "F0x104 (DRAM Hole Address): 0x%08x, base: 0x%08x\n",
> +		 pvt->dhar, dhar_base(pvt));
> +}
> +
>  static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  {
>  	struct amd64_umc *umc;
> @@ -1973,6 +2024,43 @@ static void default_prep_chip_selects(struct amd64_pvt *pvt)
>  	pvt->csels[1].m_cnt = 4;
>  }
>  
> +static void gpu_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	int umc;
> +
> +	for_each_umc(umc) {
> +		pvt->csels[umc].b_cnt = 8;
> +		pvt->csels[umc].m_cnt = 8;
> +	}
> +}
> +
> +static void gpu_read_umc_base_mask(struct amd64_pvt *pvt)
> +{
> +	u32 base_reg, mask_reg;
> +	u32 *base, *mask;
> +	int umc, cs;
> +
> +	for_each_umc(umc) {
> +		for_each_chip_select(cs, umc, pvt) {
> +			base_reg = gpu_get_umc_base(umc, cs) + UMCCH_BASE_ADDR;
> +			base = &pvt->csels[umc].csbases[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, base_reg, base)) {
> +				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
> +					 umc, cs, *base, base_reg);
> +			}
> +
> +			mask_reg = gpu_get_umc_base(umc, cs) + UMCCH_ADDR_MASK;
> +			mask = &pvt->csels[umc].csmasks[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask)) {
> +				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
> +					 umc, cs, *mask, mask_reg);
> +			}
> +		}
> +	}
> +}
> +
>  static void read_umc_base_mask(struct amd64_pvt *pvt)
>  {
>  	u32 umc_base_reg, umc_base_reg_sec;
> @@ -2172,6 +2260,11 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>  	pvt->dram_type = (pvt->dclr0 & BIT(16)) ? MEM_DDR3 : MEM_RDDR3;
>  }
>  
> +static void gpu_determine_memory_type(struct amd64_pvt *pvt)
> +{
> +	pvt->dram_type = MEM_HBM2;
> +}
> +
>  /* Get the number of DCT channels the memory controller is using. */
>  static int k8_early_channel_count(struct amd64_pvt *pvt)
>  {
> @@ -2504,6 +2597,19 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
>  	return channels;
>  }
>  
> +static int gpu_early_channel_count(struct amd64_pvt *pvt)
> +{
> +	int i, channels = 0;
> +
> +	/* The memory channels in case of GPUs are fully populated */
> +	for_each_umc(i)
> +		channels += pvt->csels[i].b_cnt;
> +
> +	amd64_info("MCT channel count: %d\n", channels);
> +
> +	return channels;
> +}
> +
>  static int ddr3_cs_size(unsigned i, bool dct_width)
>  {
>  	unsigned shift = 0;
> @@ -2631,11 +2737,46 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
>  		return ddr3_cs_size(cs_mode, false);
>  }
>  
> +static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
> +				  int csrow_nr, int dimm)
> +{
> +	u32 msb, weight, num_zero_bits;
> +	u32 addr_mask_deinterleaved;
> +	int size = 0;
> +
> +	/*
> +	 * The number of zero bits in the mask is equal to the number of bits
> +	 * in a full mask minus the number of bits in the current mask.
> +	 *
> +	 * The MSB is the number of bits in the full mask because BIT[0] is
> +	 * always 0.
> +	 *
> +	 * In the special 3 Rank interleaving case, a single bit is flipped
> +	 * without swapping with the most significant bit. This can be handled
> +	 * by keeping the MSB where it is and ignoring the single zero bit.
> +	 */
> +	msb = fls(addr_mask_orig) - 1;
> +	weight = hweight_long(addr_mask_orig);
> +	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
> +
> +	/* Take the number of zero bits off from the top of the mask. */
> +	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
> +
> +	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
> +	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
> +	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
> +
> +	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
> +	size = (addr_mask_deinterleaved >> 2) + 1;
> +
> +	/* Return size in MBs. */
> +	return size >> 10;
> +}
> +
>  static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  				    unsigned int cs_mode, int csrow_nr)
>  {
> -	u32 addr_mask_orig, addr_mask_deinterleaved;
> -	u32 msb, weight, num_zero_bits;
> +	u32 addr_mask_orig;

Please keep the lines from longest to shortest.

>  	int cs_mask_nr = csrow_nr;
>  	int dimm, size = 0;
>  
> @@ -2680,33 +2821,15 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	else
>  		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
>  
> -	/*
> -	 * The number of zero bits in the mask is equal to the number of bits
> -	 * in a full mask minus the number of bits in the current mask.
> -	 *
> -	 * The MSB is the number of bits in the full mask because BIT[0] is
> -	 * always 0.
> -	 *
> -	 * In the special 3 Rank interleaving case, a single bit is flipped
> -	 * without swapping with the most significant bit. This can be handled
> -	 * by keeping the MSB where it is and ignoring the single zero bit.
> -	 */
> -	msb = fls(addr_mask_orig) - 1;
> -	weight = hweight_long(addr_mask_orig);
> -	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
> -
> -	/* Take the number of zero bits off from the top of the mask. */
> -	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
> -
> -	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
> +	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, cs_mask_nr, dimm);
> +}
>  
> -	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
> -	size = (addr_mask_deinterleaved >> 2) + 1;
> +static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
> +				    unsigned int cs_mode, int csrow_nr)
> +{
> +	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
>  
> -	/* Return size in MBs. */
> -	return size >> 10;
> +	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
>  }
>  
>  static void read_dram_ctl_register(struct amd64_pvt *pvt)
> @@ -3703,6 +3826,11 @@ static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
>  	}
>  }
>  
> +/* ECC symbol size is not available on Aldebaran nodes */
> +static void gpu_determine_ecc_sym_sz(struct amd64_pvt *pvt)
> +{
> +}
> +
>  static void read_top_mem_registers(struct amd64_pvt *pvt)
>  {
>  	u64 msr_val;
> @@ -3724,6 +3852,25 @@ static void read_top_mem_registers(struct amd64_pvt *pvt)
>  	}
>  }
>  
> +static void gpu_read_mc_regs(struct amd64_pvt *pvt)
> +{
> +	u8 nid = pvt->mc_node_id;
> +	struct amd64_umc *umc;
> +	u32 i, umc_base;
> +
> +	/* Read registers from each UMC */
> +	for_each_umc(i) {
> +		umc_base = gpu_get_umc_base(i, 0);
> +		umc = &pvt->umc[i];
> +
> +		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
> +		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
> +		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
> +	}
> +
> +	amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
> +}
> +
>  /*
>   * Retrieve the hardware registers of the memory controller.
>   */
> @@ -3850,6 +3997,35 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
>  	return nr_pages;
>  }
>  
> +static int gpu_init_csrows(struct mem_ctl_info *mci)
> +{
> +	struct amd64_pvt *pvt = mci->pvt_info;
> +	struct dimm_info *dimm;
> +	int empty = 1;
> +	u8 umc, cs;
> +
> +	for_each_umc(umc) {
> +		for_each_chip_select(cs, umc, pvt) {
> +			if (!csrow_enabled(cs, umc, pvt))
> +				continue;
> +
> +			empty = 0;
> +			dimm = mci->csrows[umc]->channels[cs]->dimm;
> +
> +			edac_dbg(1, "MC node: %d, csrow: %d\n",
> +				 pvt->mc_node_id, cs);
> +
> +			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
> +			dimm->mtype = pvt->dram_type;
> +			dimm->edac_mode = EDAC_SECDED;
> +			dimm->dtype = DEV_X16;
> +			dimm->grain = 64;
> +		}
> +	}
> +
> +	return empty;
> +}
> +
>  static int init_csrows_df(struct mem_ctl_info *mci)
>  {
>  	struct amd64_pvt *pvt = mci->pvt_info;
> @@ -4190,6 +4366,12 @@ static bool f17_check_ecc_enabled(struct amd64_pvt *pvt)
>  		return true;
>  }
>  
> +/* ECC is enabled by default on GPU nodes */
> +static bool gpu_check_ecc_enabled(struct amd64_pvt *pvt)
> +{
> +	return true;
> +}
> +
>  static inline void
>  f1x_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
>  {
> @@ -4231,6 +4413,12 @@ f17_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
>  	}
>  }
>  
> +static inline void
> +gpu_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
> +{
> +	mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
> +}
> +
>  static void f1x_setup_mci_misc_attrs(struct mem_ctl_info *mci)
>  {
>  	struct amd64_pvt *pvt = mci->pvt_info;
> @@ -4251,6 +4439,22 @@ static void f1x_setup_mci_misc_attrs(struct mem_ctl_info *mci)
>  	mci->get_sdram_scrub_rate = get_scrub_rate;
>  }
>  
> +static void gpu_setup_mci_misc_attrs(struct mem_ctl_info *mci)
> +{
> +	struct amd64_pvt *pvt = mci->pvt_info;
> +
> +	mci->mtype_cap		= MEM_FLAG_HBM2;
> +	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
> +
> +	pvt->ops->determine_edac_ctl_cap(mci, pvt);
> +
> +	mci->edac_cap		= pvt->ops->determine_edac_cap(pvt);
> +	mci->mod_name		= EDAC_MOD_STR;
> +	mci->ctl_name		= pvt->ctl_name;
> +	mci->dev_name		= pci_name(pvt->F3);
> +	mci->ctl_page_to_phys	= NULL;
> +}
> +
>  /*
>   * returns a pointer to the family descriptor on success, NULL otherwise.
>   */
> @@ -4460,6 +4664,20 @@ static void per_family_init(struct amd64_pvt *pvt)
>  				pvt->f0_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0;
>  				pvt->f6_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6;
>  				pvt->max_mcs		= 4;
> +				pvt->ops->early_channel_count	= gpu_early_channel_count;
> +				pvt->ops->dbam_to_cs		= gpu_addr_mask_to_cs_size;
> +				pvt->ops->prep_chip_selects	= gpu_prep_chip_selects;
> +				pvt->ops->determine_memory_type	= gpu_determine_memory_type;
> +				pvt->ops->determine_ecc_sym_sz	= gpu_determine_ecc_sym_sz;
> +				pvt->ops->determine_edac_ctl_cap = gpu_determine_edac_ctl_cap;
> +				pvt->ops->determine_edac_cap	= gpu_determine_edac_cap;
> +				pvt->ops->setup_mci_misc_attrs	= gpu_setup_mci_misc_attrs;
> +				pvt->ops->get_cs_mode		= gpu_get_cs_mode;
> +				pvt->ops->ecc_enabled		= gpu_check_ecc_enabled;
> +				pvt->ops->get_base_mask		= gpu_read_umc_base_mask;
> +				pvt->ops->dump_misc_regs	= gpu_dump_misc_regs;
> +				pvt->ops->get_mc_regs		= gpu_read_mc_regs;
> +				pvt->ops->populate_csrows	= gpu_init_csrows;
>  				goto end_fam;
>  			} else {
>  				pvt->ctl_name		= "F19h_M30h";
> @@ -4581,9 +4799,10 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	if (pvt->channel_count < 0)
>  		return ret;
>  
> +	/* Define layers for CPU and GPU nodes */
>  	ret = -ENOMEM;
>  	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> -	layers[0].size = pvt->csels[0].b_cnt;
> +	layers[0].size = amd_gpu_nb_num() ? pvt->max_mcs : pvt->csels[0].b_cnt;

I think a flag in pvt->flags could be used here.

>  	layers[0].is_virt_csrow = true;
>  	layers[1].type = EDAC_MC_LAYER_CHANNEL;
>  
> @@ -4592,7 +4811,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	 * only one channel. Also, this simplifies handling later for the price
>  	 * of a couple of KBs tops.
>  	 */
> -	layers[1].size = pvt->max_mcs;
> +	layers[1].size = amd_gpu_nb_num() ? pvt->csels[0].b_cnt : pvt->max_mcs;
>  	layers[1].is_virt_csrow = false;
>

Thanks,
Yazen  
