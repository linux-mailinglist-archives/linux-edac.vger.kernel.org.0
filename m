Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AD4E9BED
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 18:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiC1QKL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiC1QKJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 12:10:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C413D3C
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 09:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMwBthvw/LmrEi8mpHm/yHAWsw/pa4XcAY64kGg2NDHDtbkOcIjT3Q9xYjOslzyPgZp7DgD7AxEbYpfuS83sCo1jYjNmxmGt2s3QJ4LwfMmHuq6LtFvQVcipRNz2iuCh+WrkvLthLPWd/9LmqDM5vVkzJZJKXIX+gKmvp0Gyo7aodjXfvYcWTCtcz4TDtZ7HxQYQ2RBaOqNwDK8U6QJ9vlRntUYRoTF3H1Bz618S0dnZ4FPQ/MmcSSTxGMbw7A6J5xwHE1uZlKY1EvmQHmpIAuJvO6QTFeahhnMCwnqwJpEz6zIpegBvxh5Ph7e9MdRcwBtd1JIpn/1XOTthebha/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6O3x/P0NW1WkH8WGc+4hjGNPaMBcM1Z2WcChIwVqVZo=;
 b=XHwQmUMQjVKw8+x3yI7BAM+Y53o5fA/EjU0GjQ+I3yL9haNNkicNlZ4vRPdTCiLL1hXDwpAevE+WwqpJzOMitHlK/79jcHTzShg90EOzNq4sOzUjZAcKHqg4Vu9eQnbUdNl+qG+L2UKuRzEMtSR+R4k98wjLNJ6dBZ82RJ0e32HO0KTYVpwTo+27h+jd3kCBT15UbMkipMuYyFgOwNKBJqtKG8gEb+dKFX25U1gKXRP3oS13hqlPHM5BqiMYRYJpcnd2sGj4lMYJzI5tjOrsvRaMEXx6dFHiNU3VhbDJIuSA11vPoi0CP3Kk/E4HgaN2zvlNJ/RT/bGDNlJMR3RBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6O3x/P0NW1WkH8WGc+4hjGNPaMBcM1Z2WcChIwVqVZo=;
 b=sBJmLJiTY2PN99mP5ZgsvKU5MfOEO5us5B/fBtAxxJ3URXmQBEYJ5gJ+39T3Yj/+fqRres/sWLCQsQ2biMiATcUBx+V2iAs3S1DAzB8XnXK+03X+yv4r3YZWo2s9GZ0xczhD+TYC/e3XPC+Jbc/J5I1pWY5L/BdAh1KsQaRrpsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 16:08:22 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:08:22 +0000
Date:   Mon, 28 Mar 2022 16:08:07 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 06/14] EDAC/amd64: Add get_mc_regs() into pvt->ops
Message-ID: <YkHdZ1UWh9o016j1@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-7-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-7-nchatrad@amd.com>
X-ClientProxiedBy: BL0PR0102CA0049.prod.exchangelabs.com
 (2603:10b6:208:25::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecb1b68f-b96d-4ce9-8300-08da10d52e7c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1661A8D3789834CBF97BD3EAF81D9@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9b2Mco3HVDrG+6F3M1Pdxyf8dlu1PUoDz5kazUBPi2D4QlhWmRY5FwtDzZku95Ln3pN+LVs/rntsMPlvbojEJiIkscQ34XZ6Hw0Wqiw+ONIadF3lHUy5q/hUBtRig9O3QmgPIxksPHsxjtG6BufDXScngTnpdFJ1jjhJ/Vc1w/W/jVO1qVpGSWTsjbXuhItmv3EagUsts7JmV3AVKAbvc0FX2pEnoH4XeuhOPqsYxoRlCP2zJmhC24CK2lUx6hvzv/9M1531Lh9tWqhJ8CLij83TSIVOqYm+GRSGbHZfko8hY01BGRnc2KZvTTJtIXEyDyBog9LoEvcnpJA+Y4E57o0Zt1Hnzlok3v8tQMQfqUlWV6j/YQpLBJBcDUdWhG4pWlu6Ek5h5FUodWkb/5Id2/sST1JBGCqUmBewbTT1CZ72/zMT9Vkl1Iy//sKZu+WaAsao7mkG1a/ADIk4MZa+KApj2iH/FswKsaCnb7s77KpRxRHW+wz2fOy/lbxPh75v9YYcp70IP18YHZ5drQtZHdlX0CcgOeHvtHRt6IBypw63bNhcpCQQIiHnT/DnMbccxz51IpH51FoYOjiXvuCfmHMM5/LxTRm4NRRxYUmxRcQwaW7+mOtfD8/r9yCMo5nISdT0l2DpxD++r3PfXYE5WFHVqE1ApKcVqs0DdKPztzFOGzpjvKZXsanpz2ICG42Wi6GXnaT5DUzeke9yhf4QtNqx7Iflk1tqWKHXdd4l6Ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(186003)(44832011)(6486002)(966005)(38100700002)(26005)(83380400001)(8936002)(33716001)(508600001)(6636002)(86362001)(2906002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(6512007)(6862004)(9686003)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Xl0BAbQ4bGI4XD10JO7Pnk7AtY0UDqgbK4IoK/mrb1og7KlXrL6O5BRIKL+?=
 =?us-ascii?Q?0BIN1nzHAcPsdVfsxu/++AsG6PSca6BzPVRAUM9XLz3x9AgqP1Pei3t4QFa0?=
 =?us-ascii?Q?qzANWRiYsD/D+T8Dwd7NSAgIMjKkf72J/6cd9v4TV2qDLam6ubsQIrwq7XLJ?=
 =?us-ascii?Q?q920QewwavSh+Dx1sGx6zxU/b93z+L2VwkrSGre09W91QFhMJ27Ht5SfvheC?=
 =?us-ascii?Q?NJIpSTOiIkvtmtj/uh1FjaWnjGViL5Y2wr0XYE0LmEqL6YKOykO00aw4EmvF?=
 =?us-ascii?Q?OiN6DdzeTCkoeW4wdhKDxLdLAgn6poZVPo3U1Eefsu5AkiCi+WFo66fZIz6U?=
 =?us-ascii?Q?Id64fLc7hCCWFpkyJv//tBOzYG51nWam92JcvyXu8G24gT7f6cebC/+Alq0K?=
 =?us-ascii?Q?50x1hp4iFdz8IztAuOdrffuZxA2lcrqM8vF+V1MX+7HxWxnL3NL0Wz/ph5+E?=
 =?us-ascii?Q?JjpDqqmEO4NeERbscvZmIk7HTHvZxtavr6WINdF9CHCytPU869auGq/LpI/i?=
 =?us-ascii?Q?ZbIvNP9+VDGXNaIrk+fNafWSh4DAWzqCXMvFocRE+YQNtg57a73rBl4F2qXD?=
 =?us-ascii?Q?ewtXsOC9WvJhkknFXxB8sbAwYBOEPxcxthENp1M5QQlZO6dqkeAzgtGN0A/p?=
 =?us-ascii?Q?aKZsdVOvjSdm7Ux3Px7hCXBZbWODYYbBAFSHhjvI9R5zxNpVOvYccac286Mz?=
 =?us-ascii?Q?9QL5q/XDR3wTi24ZYhBO76+NwQj5BGIyaZ+7uAV0UUnFaRDNgtJhxQlR8f46?=
 =?us-ascii?Q?oEq227z6G2NAM8N/vIeHw8Q0mmZ6QV+6cIQKTS5j9/uGobGzwKbYhE4/VpxM?=
 =?us-ascii?Q?8YCod+grIrCdR3FFRKakn2jI3UDvbHIbn/toKo77PpCQH6MSkWYOZW8icuZz?=
 =?us-ascii?Q?34NTd0AV/oJaGnuFlgtP9w8MVMKmJYl+/yd4WOL8/a+jM6McIqMKhfdFZSlZ?=
 =?us-ascii?Q?1njXkFJ1bIs0W7PvaMGAWRHEqVHxMOvrf8rpbD7+V4M2Z5SHFkfi2jKD9Yvc?=
 =?us-ascii?Q?/9SvR9jWW5aO2dh+GzxiDtg0u279J560GlIK0QIrjDH14t4o57cm7T2a457g?=
 =?us-ascii?Q?VXhSYjo3TLb0kNAdd5gzHmLX5TlhBq/wkOPe7eipd6xgn1fNQ9XKnwPz9jX3?=
 =?us-ascii?Q?+EdKe1Xoc59s4bA9QF7zKyxWjBF5iyE6K5QSqnHIUj0dr+xoYlTviKSyPLE7?=
 =?us-ascii?Q?i2S5A9vZebtOkDOkFeTYO3OMq3/BCDXCPnKuTH47+BFIAJza8CGInPvekztH?=
 =?us-ascii?Q?/aY5Q+LNjgZG/fZatwQZnVxL0irPx+dfkN/tyIjV2ssoeEN4VoE/E9XFmksA?=
 =?us-ascii?Q?VKpovh3Z9hed+k8Ng498+UybfMD1t6RdObqbSvqQTZ8njpsOVzqhV+WveQAZ?=
 =?us-ascii?Q?K4IWuptYxaH45t+OrxN5i/phPSzNDRLfm+4IrjKVXIRVwb7vSBBvxKeIakQs?=
 =?us-ascii?Q?J9NhwVFI/HgYbl0f8wfAp0lq9qdmlmcKwo9MqOGwp3cXiIupZtU1daokvi1L?=
 =?us-ascii?Q?mJThGthPGaDTeGIPRPEaqkLstm1lzlF8sOSKA4PpWYkkFTByGCyw8lFYwCYZ?=
 =?us-ascii?Q?EcTQwPdiCBZFXcpGJ6DQfdIUTEqZQo3PrNza6SYAr1iyM6ZqCGM2syL8GPJU?=
 =?us-ascii?Q?lYHZwRR2NojMqm2l+J4y4Dl+XS8VD59eWBGvxnoEnNUBJ8xGVKVjdKOi3BO0?=
 =?us-ascii?Q?/b9BHIhPzVC+5D+aY+pVTBDtaHeh59vXjyA3m4lzN39cOQ8H0DLq2kaSsHHO?=
 =?us-ascii?Q?MRHr5wJjcw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb1b68f-b96d-4ce9-8300-08da10d52e7c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:08:22.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwwTAU1RjjR9umdlo6K5i12D7gWYtitv3mRxy7XsLL5SPyLp9P6p/E8dX9KRWBQZoqGa36OGEagP087Ny3gPWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:46PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for get_mc_regs() in pvt->ops and assign
> family specific get_mc_regs() definitions appropriately.
> 

Please include the "why".

> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 77 +++++++++++++++++++++------------------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 43 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 69c33eb17e4f..713ffe763e64 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3214,6 +3214,27 @@ static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
>  	}
>  }
>  
> +static void read_top_mem_registers(struct amd64_pvt *pvt)
> +{
> +	u64 msr_val;
> +
> +	/*
> +	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
> +	 * those are Read-As-Zero.
> +	 */
> +	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
> +	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
> +
> +	/* Check first whether TOP_MEM2 is enabled: */
> +	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
> +	if (msr_val & BIT(21)) {
> +		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
> +		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
> +	} else {
> +		edac_dbg(0, "  TOP_MEM2 disabled\n");
> +	}

These two values are not used by any code within this module. They are only
used in debug print statements and debug sysfs entries. I think this code
should just be removed. An expert user who wants to know TOM and TOM2 can use
another method, like msr-tools, rather than recompile a kernel with
CONFIG_EDAC_DEBUG, etc.

> +}
> +
>  /*
>   * Retrieve the hardware registers of the memory controller.
>   */
> @@ -3235,6 +3256,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>  		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
>  		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
>  	}
> +
> +	amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);

"dhar" is not used by any code for Zen-based systems. I think this line can be
dropped. Reading "dhar" should still be preserved for legacy systems.

This is also the only use of PCI F0. So all the F0 IDs can be removed too. I
have a patch for this as part of some general code clean up. Let's include
that with this set also. I think removing TOM/TOM2 code can be included too.

>  }
>  
>  /*
> @@ -3244,30 +3267,8 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>  static void read_mc_regs(struct amd64_pvt *pvt)
>  {
>  	unsigned int range;
> -	u64 msr_val;
>  
> -	/*
> -	 * Retrieve TOP_MEM and TOP_MEM2; no masking off of reserved bits since
> -	 * those are Read-As-Zero.
> -	 */
> -	rdmsrl(MSR_K8_TOP_MEM1, pvt->top_mem);
> -	edac_dbg(0, "  TOP_MEM:  0x%016llx\n", pvt->top_mem);
> -
> -	/* Check first whether TOP_MEM2 is enabled: */
> -	rdmsrl(MSR_AMD64_SYSCFG, msr_val);
> -	if (msr_val & BIT(21)) {
> -		rdmsrl(MSR_K8_TOP_MEM2, pvt->top_mem2);
> -		edac_dbg(0, "  TOP_MEM2: 0x%016llx\n", pvt->top_mem2);
> -	} else {
> -		edac_dbg(0, "  TOP_MEM2 disabled\n");
> -	}
> -
> -	if (pvt->umc) {
> -		__read_mc_regs_df(pvt);
> -		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
> -
> -		goto skip;
> -	}
> +	read_top_mem_registers(pvt);
>  
>  	amd64_read_pci_cfg(pvt->F3, NBCAP, &pvt->nbcap);
>  
> @@ -3308,16 +3309,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  		amd64_read_dct_pci_cfg(pvt, 1, DCLR0, &pvt->dclr1);
>  		amd64_read_dct_pci_cfg(pvt, 1, DCHR0, &pvt->dchr1);
>  	}
> -
> -skip:
> -	pvt->ops->prep_chip_selects(pvt);
> -
> -	pvt->ops->get_base_mask(pvt);
> -
> -	pvt->ops->determine_memory_type(pvt);
> -	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
> -
> -	pvt->ops->determine_ecc_sym_sz(pvt);
>  }
>  
>  /*
> @@ -3792,6 +3783,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
>  		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>  		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
> +		pvt->ops->get_mc_regs			= read_mc_regs;

The function names should be more consistent: either both get or read.

The read_mc_regs() function is used for systems with DCTs (i.e. legacy). This
can be included in the name.

>  		break;
>  
>  	case 0x10:
> @@ -3805,6 +3797,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
>  		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>  		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
> +		pvt->ops->get_mc_regs			= read_mc_regs;
>  		break;
>  
>  	case 0x15:
> @@ -3834,6 +3827,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->get_base_mask			= read_dct_base_mask;
>  		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>  		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
> +		pvt->ops->get_mc_regs			= read_mc_regs;
>  		break;
>  
>  	case 0x16:
> @@ -3853,6 +3847,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
>  		pvt->ops->determine_memory_type		= f1x_determine_memory_type;
>  		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
> +		pvt->ops->get_mc_regs			= read_mc_regs;
>  		break;
>  
>  	case 0x17:
> @@ -3886,6 +3881,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
>  		pvt->ops->determine_memory_type		= f17_determine_memory_type;
>  		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
> +		pvt->ops->get_mc_regs			= __read_mc_regs_df;

The underscore prefix can be removed, since this is no longer a helper
function. Also, the "df" suffix can be removed when changing the name.

Maybe something like this:

pvt->ops->read_mc_regs()    <--- This reads memory controller registers.

read_dct_regs()    <--- Used for DRAM Controllers (DCTs).

read_umc_regs()    <--- Used for Unified Memory Controllers (UMCs).

>  
>  		if (pvt->fam == 0x18) {
>  			pvt->ctl_name			= "F18h";
> @@ -3925,6 +3921,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
>  		pvt->ops->determine_memory_type		= f17_determine_memory_type;
>  		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
> +		pvt->ops->get_mc_regs			= __read_mc_regs_df;
>  		break;
>  
>  	default:
> @@ -3935,7 +3932,8 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	/* ops required for all the families */
>  	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
>  	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
> -	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz) {
> +	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
> +	    !pvt->ops->get_mc_regs) {
>  		edac_dbg(1, "Common helper routines not defined.\n");
>  		return -EFAULT;
>  	}
> @@ -3972,7 +3970,16 @@ static int hw_info_get(struct amd64_pvt *pvt)
>  	if (ret)
>  		return ret;
>  
> -	read_mc_regs(pvt);
> +	pvt->ops->get_mc_regs(pvt);
> +
> +	pvt->ops->prep_chip_selects(pvt);
> +
> +	pvt->ops->get_base_mask(pvt);
> +
> +	pvt->ops->determine_memory_type(pvt);
> +	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);

This line should be included in determine_memory_type(). It should be called
for each PVT on legacy systems and for each UMC on current systems.

Thanks,
Yazen
