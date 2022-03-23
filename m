Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB84E578B
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 18:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbiCWRfH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343610AbiCWRfG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 13:35:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12892574A7
        for <linux-edac@vger.kernel.org>; Wed, 23 Mar 2022 10:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9eHCbmADBBf53Smx8ILI4KEN4FnbVXhX6XURIU4i2x8gH6eERTKUiCVVejFVGI5p7imk2nPI+xFlZb0z9NTtwwtubsUUaR3TwvIkEFZYqsA4+RSAmU6t2ubfI4WjoFXeUc2+1fGOP1tx9njC/t5jQ4CIFiQrdIq9fX968gMiofYdpZFa/3yWY1aEFXXZiXJPP1DyDV8fMrXiYSeAzKm5z+dH1N3WSJ8pDHFlI9gM7JhghLH44wmo9vg7uhWW1Mq7lEiiMbpC259/xgqBQcEgTJJOBscRG5OKzYNg/4FO5RabdFxYV2dKdWhZDFAmg7+/PCKUYK58oygMiEYrUgNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxjDHVXUFbKQngd9xST+CSnk3WcoXus88tV7BPK5ttg=;
 b=eDQgQCUeg4VfMEfD9L7XrGplF4oOZJqJQKNiXHM5RgSoOMxARcUcQ0G4LhqJ5ChEOBEmuutBlfUDwE0a+eaFeuffcePdbMTtEbhAgva86IN550bsdeI1pOjLJb2LxihzermvcWBZiFYhLmPEoZqHlo1e6GdR/9nP+xWabVp46Cup43kdPTIpdF2G8RgIauj0OR6lfQ66MxJGYkY1zUY0kyhdigv7ReZJvmoMELWjUwM6fhp8+Me2H9tv4m+Cql8/cX98zVRp8roGMHGB4RL+kEyxVQzcK/DPwIfmXgtluJ4afFCGIbCUOAWi5UgxRfZypn8vufjjwZtAOKCpx905Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxjDHVXUFbKQngd9xST+CSnk3WcoXus88tV7BPK5ttg=;
 b=adgM2ZRnJpTOKtKA+H57vNz6ChT9wKWSATFEbyEuNo/+iQJz7w8pj5XEV6R7cFWj9C2LJUJkI5jZ6yjWmBTC+vBFRmyx8G9nnp5D76PsWtnkYqIqgUmWnV6fE1vSxS4r78f18qs1qJwl/6jcAh7xUc44MNF1UVGQp7QKY8kdJ9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MWHPR12MB1597.namprd12.prod.outlook.com (2603:10b6:301:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 17:33:33 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 17:33:33 +0000
Date:   Wed, 23 Mar 2022 17:33:18 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 02/14] EDAC/amd64: Add get_base_mask() into pvt->ops
Message-ID: <YjtZ3h7jd9gu1Vya@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-3-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-3-nchatrad@amd.com>
X-ClientProxiedBy: BL1PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117c3c6b-4cbf-4f21-a302-08da0cf340a3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1597:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1597D178C1021FA0C8531AE5F8189@MWHPR12MB1597.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40nTUWRsDs3zza0DIDNbzkf0ipTl32P4rA7lVAhrtd1z9EQ8MuVW6Z/qA5auCd82hcZA4rsHvHilztq41ikyvEG0u1sn/Fquu7QJrtGr4097kymyJJzWF/DyvmOaPksOqrlbNKqvEjrReWQd4VlivxH+VxhwhUb4WkiOAX/CiS8f86sunmxNZL+yR+fmNWkZ/zStR1cCMza/BHZeUjEzeVSUqtMR87n5ifL08FkumqXJX7K4nDcl16vci49HaODKNLJ4yk+ehcfHh3r4iwf90uRFTgdwe28HYGcls9ZLuaLVmqEVphlcKEGcytPHioB6GS5PrSuNQG3OYNVEI4VdQnn0cXX8hlJRgVWP6GixI04vxmfsUoqITrZArBA72huEXhmP/4PtNOYtxaa2WTH/XVc1oTpmI5N0uU20sjrrR0uOeJpp2sGzw/v757nsZme4X2H7eRG+6Dy6Y3QpmqDKq9lUjjzqDpszCfwboG0/q4KFR4kJEJFRwIn/CKEGVtNGcIS8wlJwm8LKLdV99gNyas+h6UQueZqnngkiv9ovL0K+B4TRJXKUkfgFs6P39SBa/D2HKbXRQi2v7Jrx6ETF6BLeOU4F98HZVkUnrZwB6Pw8X6o6PNOiEFszBrLXD0fsDb2rNs4l/WYTq9YtaAAPGf/KwllVy3l9NtCbrq+cnZQb9O/i0jpyj+MP+Ywk7YKP6ujLzcgc3qKgK2NK1D34Pq1oLWWYz9tx3bRzI/8l024=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6666004)(44832011)(2906002)(33716001)(26005)(186003)(508600001)(83380400001)(6506007)(38100700002)(966005)(6486002)(9686003)(6512007)(5660300002)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(6862004)(8936002)(316002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvN3QjyfWMf4BlKsgev1rxoR8JUCxoUbyFHzavfi18VzFTmP05/io6bn8yza?=
 =?us-ascii?Q?iNtVZUttU+r9HcEki5kcCjBVrJcvaGE8X83MkWCO1C9KB9i+kpzn9qsR4S/G?=
 =?us-ascii?Q?9z1xxD9Wquq4NavlD4TJyiDK4Alox1lx3Z+j99FyoTGhPP32DP/E77B/0Lop?=
 =?us-ascii?Q?oI+q2igjRee/IX0gb4j3H274+GkVQynACsrPf/V98kXk4B2/JmvC5TS8v6qP?=
 =?us-ascii?Q?yzJZ+t+v/nHpw6w8/gj+mRIcgoeqXVxNxEIZLT0lPgaJnwKufIbcQEG1L8if?=
 =?us-ascii?Q?cxRutcKOCk59N7oBizEA4XapNpPXpca0kahMe6r94J6ZqhqOKLYmVfN6q6q0?=
 =?us-ascii?Q?NZstKA15qb7ztz3zqoxkOGdQ6C6uWf7JofBeAGhDmIYLwLnElfXlTaYKUJuL?=
 =?us-ascii?Q?GEsKuliCXl64yQJqj+i4rnD2xWAZbaJP27hs4ubj9WtXI8DkElPv29yTlxZq?=
 =?us-ascii?Q?C6tpHcbHosEG5OaiDWjcmVBdGY+C4dOAducg0Qe46gFKNmQ2LtbT8Biz6Lqi?=
 =?us-ascii?Q?5h9tgS3uCjyBGv8U5F9tMNXI9EThhJ71ZHRJZSL4X3Kc2tYE59VWkTFcLaCs?=
 =?us-ascii?Q?XFDGPVcqiSXQsWUkNXbrJRDKOo/SwiaaCdPMKOo8BAniCgAYOzKsqaHTfdFU?=
 =?us-ascii?Q?rsgkyl3//JGKKxElwCSPvpmiX9bJZ9M4BHNRA9+4RGlV8FFyhIFVpg+77yJa?=
 =?us-ascii?Q?eUWig9ORqZENkLhMSF/yZa4VjnKyV2DdD/DxCJ9xQTY7BZ5e3ePf1aYxCDCt?=
 =?us-ascii?Q?DXEAyxCEX5P6BVaRVQ9G1hZdu7cKNi+DgdHVnmTRna60bnsezQDTzYAZQnbw?=
 =?us-ascii?Q?zRjXL7cqmwjdC4KuzvqS9ocMz9X8ZEpRzsRHePdEd7COjm/RuXDco9z1Suj8?=
 =?us-ascii?Q?OGcQkkJNIBf8TCwEjpCzYzxaxbUWKzT0/FjJ4m3+C0gPe51KHMRciEygrQdR?=
 =?us-ascii?Q?agRkZ+EMSmzGqwg1oCX70L2J/MpOeSs7xWSsnotsdGSxx8yYBitc7dQ0t/PD?=
 =?us-ascii?Q?HyWYYwpzBik5Y5pFZcYMVjxLDrR/8dfGh8nnjNi4jlEodx++gDJPDzHlncwd?=
 =?us-ascii?Q?Zny5++4JNxYBmrS1RHUabIhjhOiA4DPL3frxTuh+hDFG7HRQvsQ3sXd4xK/C?=
 =?us-ascii?Q?sP1aPapb/j37qitQLMtq4vyLaYoBa8qsQ82kKqcxa4quRtXBOs1bZf2B3Cwl?=
 =?us-ascii?Q?onFuhD9e+oPvIoY4H5obhoP0vK5AcC/JAp6wuMjSqrCB/hS0QDogf+Pm+Njg?=
 =?us-ascii?Q?s0W4X5GEPsEg//E+tvHJ2LeqOrtq9k6uXLkRDsOMHBFf0XODOXfqJ4SpKX5v?=
 =?us-ascii?Q?yyBdsAsBJiE3egaXNeSDxilgAsA8TvUZ+G+UYrQBVU8E6T5mL93BUTRA8EsM?=
 =?us-ascii?Q?w8axGWj29jcQy2A4jzDC0n3szazZGnZYibtfpOCCIsyLiE4N4e4q2v9U50uY?=
 =?us-ascii?Q?pXAzP6COa4u7Ov/Cpftp/ANwnQDDTV/x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117c3c6b-4cbf-4f21-a302-08da0cf340a3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 17:33:32.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGHtbUj9M2li08wOEdc+ic35uJcopfFrcYNyrFUk8QQjLhumDmQnGtpnmjgJmO7nG6radW9Up6ARGXhuIpoHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1597
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:42PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for get_base_mask() in pvt->ops
> and assign family specific get_base_mask() definitions appropriately.
>

The commit message should include why the change is needed and not just what
the change is. A few of my patches have similar feedback, so it's fresh in my
mind. :)
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 22 ++++++++++++++++------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index b21f43a3ec98..985c59d23a20 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1570,11 +1570,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>  {
>  	int cs;
>  
> -	prep_chip_selects(pvt);
> -
> -	if (pvt->umc)
> -		return read_umc_base_mask(pvt);
> -
>  	for_each_chip_select(cs, 0, pvt) {
>  		int reg0   = DCSB0 + (cs * 4);
>  		int reg1   = DCSB1 + (cs * 4);
> @@ -3287,7 +3282,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  	}
>  
>  skip:
> -	read_dct_base_mask(pvt);
> +	prep_chip_selects(pvt);
> +
> +	pvt->ops->get_base_mask(pvt);
>  
>  	determine_memory_type(pvt);
>  	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
> @@ -3763,6 +3760,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->early_channel_count		= k8_early_channel_count;
>  		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
>  		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
> +		pvt->ops->get_base_mask			= read_dct_base_mask;
>  		break;
>  
>  	case 0x10:
> @@ -3772,6 +3770,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->early_channel_count		= f1x_early_channel_count;
>  		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
>  		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
> +		pvt->ops->get_base_mask			= read_dct_base_mask;
>  		break;
>  
>  	case 0x15:
> @@ -3796,6 +3795,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		}
>  		pvt->ops->early_channel_count		= f1x_early_channel_count;
>  		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
> +		pvt->ops->get_base_mask			= read_dct_base_mask;
>  		break;
>  
>  	case 0x16:
> @@ -3811,6 +3811,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->early_channel_count		= f1x_early_channel_count;
>  		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
>  		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
> +		pvt->ops->get_base_mask			= read_dct_base_mask;
>  		break;
>  
>  	case 0x17:
> @@ -3840,6 +3841,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	case 0x18:
>  		pvt->ops->early_channel_count		= f17_early_channel_count;
>  		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
> +		pvt->ops->get_base_mask			= read_umc_base_mask;
>  
>  		if (pvt->fam == 0x18) {
>  			pvt->ctl_name			= "F18h";
> @@ -3875,6 +3877,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		}
>  		pvt->ops->early_channel_count		= f17_early_channel_count;
>  		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
> +		pvt->ops->get_base_mask			= read_umc_base_mask;

The function pointer is get_base_mask() and the helper functions are
read_{dct,umc}_base_mask(). I think the naming should be more consistent.
Either read_base_mask()/read_{dct,umc}_base_mask() or
get_base_mask()/get_{dct,umc}_base_mask().

>  		break;
>  
>  	default:
> @@ -3882,6 +3885,13 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		return -ENODEV;
>  	}
>  
> +	/* ops required for all the families */
> +	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
> +	    !pvt->ops->get_base_mask) {
> +		edac_dbg(1, "Common helper routines not defined.\n");
> +		return -EFAULT;
> +	}
> +

I think it'd be clearer if we define an ops struct with default, "do nothing"
functions and statically include this in struct pvt. These can then be
overwritten in per_family_init(). I think this would avoid the need to check
that each function is set and the need to dynamically allocate the ops struct.

Thanks,
Yazen
