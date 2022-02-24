Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD284C347F
	for <lists+linux-edac@lfdr.de>; Thu, 24 Feb 2022 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiBXSTX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Feb 2022 13:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiBXSTX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Feb 2022 13:19:23 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9221179A0B;
        Thu, 24 Feb 2022 10:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXkXoI7L+WbFsvta8whiJUzq/qcr1Ie9prPSAcgPxP7iHQRAmPU+aGwtpR13PWCamhyrDslEjLC27Bb2yfqHGWgmDxbcLcJt14PzWuoaxfkizwwdiXGc94HZGr9EeiH0XjpCsEPqbJ27hWb0f6NLt3xamNtfqr2YFmWM1ml7kdFVJwSHn2u0DH9jh0p4yg6sPVMDyv177lkF2Ay04F0E1MZCiAWv95w36V/s6IXW7ucEgHnkBMRxTrOphpN16m/926MkXppWhXC+TcWaqnR7Lxtz6W8RLQladqIEi4Xfs3PJs24LnkuODWRccnDkmNg9LWF5SvJ0XszXv5iqpm6Fuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26BoLErwwggYKTMjJ7PQD7k247tft+A6Ow+Az9mngNQ=;
 b=n1+WiIQJ6AmD5k+MrfzaPolfzN2ZrCwabUCbZUe4pDZrkMvqkkRCcE5+2e1i9ekI3PY/pr5Q2thMzpcJ2NRLp+LBxaRnhm5ZzuhKdu8HsfAe1GNwWiZ0dK6KGRb40OhAt4CgMM4BVB7YYR4blM6sW8x23EWCpZmZdkQCse2Zj1C3hXgocTDNUbJLzlZNM1Ab3+J3jw/kbVnkvqmSKlgebLt0gcjFFCQhzuwIochjXntDGwY33O95Hzhm+djyLQ63ukBJLzAo3z/etkbIZGn8lbzNU7Jj9n5sOobDDvdKnM4LiKqUQMartSHWe8Go6K4XtNj7LdqtYegYw5D5HaoyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26BoLErwwggYKTMjJ7PQD7k247tft+A6Ow+Az9mngNQ=;
 b=be+f/EzzB4kduTKwcp+lPZPgoqEVMjaSCCrebxQdgwrHIaJX9uEIiJhXrZpdUdxEWg6uq61ImgKG2NSsvkp3UU1dsSeTPlr4eOqIUi1GskadHc8RgQ2AjMfvSuELwUAYxfN+DEdZTjOIx64ub27t9pYJGojKGdkzIg9sbS2X+lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 18:18:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5017.023; Thu, 24 Feb 2022
 18:18:49 +0000
Date:   Thu, 24 Feb 2022 18:18:45 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Message-ID: <YhfMBbsex8+cTnSE@yaz-ubuntu>
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-2-yazen.ghannam@amd.com>
 <YhafLB7Jw1Bul7YP@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhafLB7Jw1Bul7YP@zn.tnic>
X-ClientProxiedBy: CH2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:610:4d::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc9be765-fc23-4b46-7881-08d9f7c21aa8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1463:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB146370541A0A8CA1B44A2472F83D9@CY4PR12MB1463.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMojwKMllxL2Dhrc+cep0y0rLpTto+kDGyGmOGg27ezv+i4TtdU47qXaVC/L8EnrPhutElpiPgT2nPgUyJttXeZVHJUkot2pGJrut+m0Zf1REav2yQ0syCBizSxx1ZN5SZm4Ntpwr+UFkPnNxTKHk6EL5LQoTE8q5kSadeO4aW6q2jxTdGP1dcMsM6AARyGYEvK0SP7+mTobsRzoGhVCsTQoBfpLlTi8nh/MWXyqp/iR/+GO8B5KK8FujGOLNIrsllE3RvLd5x5005L0JFFS+3rPM0LwNWkmQ25XjpKJkVrNDEHgZzsU12sd7KuPa3deOdp/+PPzI4hKVjnKW39MPwTYNNcHG2Mfqlm3GlmRYkOgNa2Zgnua0hBr1hrIH1t9cT3sfn4aKzoS8aVNQnC6r/Ioxqx3UB56hQVgeOL4doGXy9+dxBoI8A3WP64j0R5kGOPig7guC3hGphSy6qelgujeOqzVuV4KxMHw/xrh1PF/YcBvahH1ZKTeJfCYbrYuXatY2/RIgBnHnkDIbJb+AzvU7yoNnZNgYCYEp+xtoGMGGEa+4bWK86kF2xGyRxfmNalIwzKSC4CLMNRpFPuTeGHGvvN18z5p4aGjE+0kxwsPjEjG3nBFPP3VH01E6PcA55l51xBJ+qwiy4fZJKkpJXeiE7g5ljB0MhZX63qGZVCiD1gS1EjEZ/kUD4VoGF1eqAb4DsV1Ul2vAzN7xfjj3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(44832011)(5660300002)(6916009)(9686003)(26005)(186003)(6512007)(2906002)(508600001)(33716001)(38100700002)(86362001)(6506007)(66476007)(6666004)(4326008)(8936002)(8676002)(66946007)(316002)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6KqmRRCHFvavoep1LX+FSEopke89BV8BnNjWyEziIMumC/q624ySKHe1Z9D?=
 =?us-ascii?Q?DPVi87Is8CRmf+XRjloyHhkDyMf0vseP5aJTzG0ZHXGy4ooO0VQWdnIQnHAh?=
 =?us-ascii?Q?zXpuqUcEDJpVNQ3BTQEZ5yF9kMAtIIGv+VOzPYwN7SBivvN8cUB1jX+8sStl?=
 =?us-ascii?Q?qbhLTbz8cmY3PFe23JBf3h+Oxa90h1zi2xEwQyrU2rD2KvobiJvbxqcXczCS?=
 =?us-ascii?Q?3iImzbug0sBobXGlPQPnXYriIrYKMJNLl912fFiHY1QXxuvpW/oF9ZjJpgQT?=
 =?us-ascii?Q?w6iD0iDo1hCGZBlgXkVyxNab+09zmI3YXCtlhnaCcdmaf7fTwOkhtOtNuaJT?=
 =?us-ascii?Q?U/msK1ZVG+8vuIMWKsXFOqgRsHNxKb9coDRTbW2fuxuVg26gjzir38OeIYZV?=
 =?us-ascii?Q?qlpTRRkYLo7fqwfUJ5wkHQPAKqWfKvLarBgpWKM/VaLZHbdqVQyXz7OJXyS3?=
 =?us-ascii?Q?x5PVtLQWDK+mArqBvCKOE8dfJ2RkBcms02JrpbVA86FD5HpgfRmEwXhO/l4p?=
 =?us-ascii?Q?h1omPl+A58a8KV0VMmbu309zr5oXAq8zBl32qCdghZY2SoByQMYlka7jvO0I?=
 =?us-ascii?Q?pkGInL/zj//0VRh0d5GsvMyI5+sMK4xstfsIldHhes0hNAaJGtrJDWQfzAgX?=
 =?us-ascii?Q?aE6FvqMEnsDnXtgVK1Kp1rQxFZ859DphePdWk+Ho5LBhx759quUdWi6imppL?=
 =?us-ascii?Q?2Zg1mkweD3b5EH0nghntGUCVcE5pdwbk3lO3GZkX1rWNt5eU2YRQQ/7CMtYi?=
 =?us-ascii?Q?sdZ6I8e4zaiyFAoiRd+4j5wlx/AGKjlRDYwNLsOXoKzxajxU2esZDYOJVDO/?=
 =?us-ascii?Q?z5N2kFFnABVVarzMRME0X7QhpnPyNJbS1+PRu64Qyo07gWFWisqtoGe9C51M?=
 =?us-ascii?Q?s/2yYLzlFe2BIKE0OzFVN9JMAtc+eL5s+bHus3vsSLTPO1/Uymb4TPDay4Po?=
 =?us-ascii?Q?wQ0Pgk2R1tgD59+uWFYcdFzXfZ6ReOULwb//vH6WZa2qV17oHCt/ZjF3CUgT?=
 =?us-ascii?Q?uRy12IQAIPVo11bIttmgAaCF0gD7681wqqewIlGgzhcVE+pbSkOGFKYK9C0n?=
 =?us-ascii?Q?y8jWYd7w6sb+d4a1Arb287C6gj21laC86y9XRlBq3J4vLaDaF0SaUnGEYuGh?=
 =?us-ascii?Q?HPdfMX4hHQDKyUkvvJfZ0yal3pMvgplc64iUOUqyragDk9jcFXuOuTzRdBUM?=
 =?us-ascii?Q?pL9KZabZuwc9ZzjUi0IN8U2Ll4cstS+O8quX2vnI42E2lwnsDf5/6FyiYR91?=
 =?us-ascii?Q?mRzLXrqDjBVG/EVfQ0jnXqH1rXAoR6AwhcoVOK6ogiFCOxToyAepyA7YS9hB?=
 =?us-ascii?Q?RN3NTb73dXdWAAO/ZMAPSRr5axaoSSIF1cEaAzZ6M0u6MIQwET/YylgS7r8e?=
 =?us-ascii?Q?uC5c9Xl6iL5Fsjaru9LsHy2uC1vfMnGNv9qOve1UKrn07LWHCeHqVNtzQlvn?=
 =?us-ascii?Q?ICJvaYtq/E5+kfOwi49M5O99FK19MmDFz9MOyxppZWadZNVbbUQPumsehvsl?=
 =?us-ascii?Q?3bA7uCsJq6vbkvo/b+Hjwg1UKmH8RRRBVu20Tv02dgHzDmqV4i0QKLpboeE0?=
 =?us-ascii?Q?fUjlWepe5ALjjAiRDHjgezwBSAHQ13Wuh0m6W8nnLIUTyrNBrZopiKFg8kdE?=
 =?us-ascii?Q?F+qhmc8FAEMwYXBEa8F6Zxs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9be765-fc23-4b46-7881-08d9f7c21aa8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 18:18:49.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jelfqO3K/Qdf5lgq8gVr3M5z53UTQ/TabGbuVEFqhPiORfqkyMTs2p/p2JyV8jpLfz6R5f0NnuJUuZsLQ6ZiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Feb 23, 2022 at 09:55:08PM +0100, Borislav Petkov wrote:
> On Wed, Feb 02, 2022 at 02:43:06PM +0000, Yazen Ghannam wrote:
> > +static void _determine_memory_type_df(struct amd64_umc *umc)
> 
> You don't need this function, right?
> 
> IOW, here's what I've applied:
> 

...

>  
> -static void determine_memory_type(struct amd64_pvt *pvt)
> +static void determine_memory_type_df(struct amd64_pvt *pvt)
>  {
> -	u32 dram_ctrl, dcsm;
> +	struct amd64_umc *umc;
> +	u32 i;
>  
> -	if (pvt->umc) {
> -		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
> -			pvt->dram_type = MEM_LRDDR4;
> -		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> -			pvt->dram_type = MEM_RDDR4;
> +	for_each_umc(i) {
> +		umc = &pvt->umc[i];
> +
> +		if (!(umc->sdp_ctrl & UMC_SDP_INIT)) {
> +			umc->dram_type = MEM_EMPTY;
> +			continue;
> +		}
> +
> +		if (umc->dimm_cfg & BIT(5))
> +			umc->dram_type = MEM_LRDDR4;
> +		else if (umc->dimm_cfg & BIT(4))
> +			umc->dram_type = MEM_RDDR4;
>  		else
> -			pvt->dram_type = MEM_DDR4;
> -		return;
> +			umc->dram_type = MEM_DDR4;
> +
> +		edac_dbg(1, "  UMC%d DIMM type: %s\n", i, edac_mem_types[umc->dram_type]);
>  	}
> +}

Ah, I see. You got rid of the extra helper function. Makes sense and looks
okay to me.

Thanks,
Yazen
