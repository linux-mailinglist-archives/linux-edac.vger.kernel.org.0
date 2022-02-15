Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC224B73D5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 17:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiBOQoE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 11:44:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiBOQoD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 11:44:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19491019E8;
        Tue, 15 Feb 2022 08:43:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewhKCgX7fW/dcNMKwwyPagWVUyzGxrobz4XuKKv0ONdS7JJaTohJunoquf9OcK1QpyBnuO8DBuEscrd802KBYvgTkH8XMORmjxO9yVpeJrB1daOnH3/LQofq6Sg82fx8exbVXpwBWKcLG3jULyAVYcy12Hq07FTN1sXwAJSrH2NE5XGXtwRYx45ejWL84ZjI77hK5V73H8hY8g71afAnjxpy3e1iRCXBTP/OXcDRznNzYtLDxNY7lmeO/r51pods+soKOYbVhIzM15BYWEqkzohi6Izjkm0OUcYOgrIEGPdib38upXn8zHmlY5KC9uOxeYm2m6MDSaAihsjde7nsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tXet1Y9nGALT4m+ie3AkChUDCGnLfr6cLMuWlqWI4s=;
 b=AFWYKtC2LMYJbQMzidA7JdNlDUeg8BYSlgA/XFMCtgP+yJs5yTucMPkYRmmR+DR2e0D5BE3/bLixY7pbqkLqP5jLWeFNnnkVHMo0CXC4MGR7KkWJomie+VOpdnk8gAQQhkEZgGF9CZhNDoHDIP2ZhfjzK6XGy6fHhk/LSeHkTEEO4+phFREm4NZR5yDSaSP1DuN5FbPvvbFC6qJPq4RGIW5mnYRO4QbT4IKwiWWn7Eh7+fkWCg4Qdcbat+1MhRtF5H4Bud+1YH8A5pLotc1zNqMSPI+OVo6Nw2ipgywTH6JpwUWLppBTcgNSDUxfgIeuQkIhiHNxpRTlP3fxzPE2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tXet1Y9nGALT4m+ie3AkChUDCGnLfr6cLMuWlqWI4s=;
 b=XNawLbWWYZQhY+f5jpACKkNgkgocbSV5sMvsYHRAKEoXZisvYydfR/Os1h8TB+SRHW/a+tpVwhKJqUYrqP/d80HYv/WF2ThD9P44kcM8bMsv8ypWGypMYu5sgy5RTHD/Er1J/3ttSTuudjTGbZQXFmNbfmHLup+tzuLni4Alfec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BYAPR12MB2791.namprd12.prod.outlook.com (2603:10b6:a03:61::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 16:43:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 16:43:51 +0000
Date:   Tue, 15 Feb 2022 16:43:47 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 08/12] EDAC/amd64: Add Family ops to update GPU csrow
 and channel info
Message-ID: <YgvYQ5RKpx5hZAAN@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-9-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203174942.31630-9-nchatrad@amd.com>
X-ClientProxiedBy: CH2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:610:60::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70b3773-47a9-4737-fcca-08d9f0a258c5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2791:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB279119557A9A4D6AE32E5FDDF8349@BYAPR12MB2791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uow9vFboJ+eJOcdb1XRzxTZMtvTdy12qXvzq9eu40Zwb0P0momTKLR7Cj67eMHdxCkiL4sAnATgcaDGF9GKXXrQa4K7MFpwh5m49KqSPOSbYAOfpE+b7pWzt9TfgMQChm0vOxmHxHDibMvT4hIfe42DBBfE1o5qW7q3zT720mfKzFUxlBKJxE1EjJE4Pc3U/CKw7W6E2iCJHccHF5P0fMprRboOwlqE7etbBtfKrwuxrHHyzjfqCKwLJQSdcWGsQPr/qZ2QN3hmTDnBWSZ3gcYvo1iyh6PTlERi3HpadQ+ZwAPqC1tu2wdNOBDnR8NAcUFA+efScqnFvmPE1RJZCm0Rq7UjWWMXwegyIB+Pt7ourZgEDC4h/bPsk5NLVO0eiSni/z+kvpuXe9y+94Y69x0rlmuVJg1qsVo7+Z4ZxB+K8nf3xVP4I2xq487PseNiM9qMJjdx0Lxc1UxeBFsOQpu1LqBlcyIqC0AqCyzLzVktEbe7M1yK/u3kEmXLMDw2jraK9f9VkCF9s1+XgOYFDKFqmTd/Wm+cfFzL7uCmaScBZN35/ochvEqopCMQz/2bYsBk+gQii7Xr+vjXywi7w1xvAVUrBzg7FfJxQ1XU1LrbN7NO47bgwPPaBiAm+gOHzmUOaEl5ER+F7TFLOArPYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6486002)(6666004)(6636002)(44832011)(6506007)(6862004)(66946007)(4326008)(316002)(8676002)(9686003)(6512007)(66556008)(66476007)(508600001)(33716001)(5660300002)(38100700002)(186003)(8936002)(83380400001)(86362001)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EItWL2Gw+d7+VQ3iFlGCM4nJQo6F0zI+6+p9EANuHK5uFN47CXtdFDzx/hgh?=
 =?us-ascii?Q?EuvVldNXnGfVLi89Y3kvfa2Ccqcn22V8kG1cKrua6pHFjOSIuBSVyluOcUmA?=
 =?us-ascii?Q?uC5SD9x2n0/K4uSioQXF5ecCr8YVC+Q0makEPKUgLRU/F9yKp8DPLc9DaiIU?=
 =?us-ascii?Q?uDrexwQ03Z4C8r+KzKFqMAQ8Hswndv30zyT9nB1p7uc2DQil4Rv8ygOyfJzc?=
 =?us-ascii?Q?MAzMBG14xjQl2XYmjixTSl+ly6FE/twcVfPHHndl8WsCF5LGss+yWvqM4W3L?=
 =?us-ascii?Q?S1RHEHajkFKr5q8/SDr2zZACB/91kkdzWl4yqOOkhoosLPzOOiJElOHq13R/?=
 =?us-ascii?Q?FexlFCGZvOQBr9Tk1hnP6aqmAqS/d5g/cE2wm8e5FBKYDPzpEQ6NbFzs3LRc?=
 =?us-ascii?Q?AXRBK8SLFoMG6kbNL3ISrplAGbZK8TAqXlgHm4GqhmqKL6cRWuIiQO0RTBN8?=
 =?us-ascii?Q?yowk1NO7PFvyKp1t2ZbUvLq7vc0Vu6TRN9hHbomZQnvLjQiMXcEZDLUkyDt+?=
 =?us-ascii?Q?KaF361IFVQZ85KSAY+grma6tUEffKZwlBe0xp5IDWWu/tnBlVSfm+HKETXaR?=
 =?us-ascii?Q?X/uB25GU+s0YAKmX9aNj3G9NML+B3LVJ6gj5Pv3ofkvCAFYihDeCskbAXXnN?=
 =?us-ascii?Q?NueV6joa9CVXW5OEshbbJVowrmik4+6EHRvuLmd3rt4peYTpf+wii7Wje8At?=
 =?us-ascii?Q?nK/0G8C3APvzSANjomN660GySasGsKSQ7CcCRIxwl6ibT44e95spmUpSEXrH?=
 =?us-ascii?Q?3HAgrl2IHlPWxtDwdGmv3EeIyw0XaQfQuanxWqp6YZvBbK4blvjSkXRa0v7L?=
 =?us-ascii?Q?bhcC8Ky5zTnYfcwKpzJWvS9NGzoDDxtRj1/5nrpAQ/cXz6UikVCTTyIa6VWs?=
 =?us-ascii?Q?i4iK1wPW+Edd/KnssIVOSqPEniNJDCHsRDihkr3JwF6HGmRHP7CgJjzGqjk/?=
 =?us-ascii?Q?1U19TL67URfxTkr8uPVv4YFvhkJ9L7AB+fIs03Ma26kUiIwsid7Toah3j++z?=
 =?us-ascii?Q?FB7Ar5289Uie1ZmF+JHVA7xg19MdMbooooOYv5bP6XCpA5fNHVvi8aPZL8sT?=
 =?us-ascii?Q?jpXCMT9DQ6VUg3sLP9Ls1uAVxajAorJ5xyaOt3kJWWE1MUoOCEnLdz/O56LQ?=
 =?us-ascii?Q?aGJLCJti5s7mZTow/MOjjrNoifdk70//yssZSJkoutuSV+dgcWaHrF42c5nY?=
 =?us-ascii?Q?1YoUU/thTCoXOcEMDDdaKUQXR6ltrXaajQZeNaL6totMxo99Ued2gdSA+dFa?=
 =?us-ascii?Q?XI9HJJTJ9KXNGMo0PCYBsgefZByDFdk+7t5RBfa1Jsytv/w/IAOaz3yD0PS2?=
 =?us-ascii?Q?2M0xAi+iPfJ1RgI0HSk3jd+BpwQ49lkVKf4VOjCjDWjpD5b3F0JlF9xfP/rY?=
 =?us-ascii?Q?/0kjWYzLoPEMEH349OO+hb6wgk9JUs6hV/4xJKhZq7acybNv7PN+PfDUeKXC?=
 =?us-ascii?Q?FML/67pJW7AENVibVVL6wi/hHZEZuL4D3iIDTXxuqgya7erziWvUh61XK9km?=
 =?us-ascii?Q?fTVuY4HW5TwoKWrrnSRJ8Jhtw5K5Zgde3/5hBF3TQda9Dlf2xhn1/1Y5hR+8?=
 =?us-ascii?Q?8f0l6hQT0jEBqOW7mOacNdRoi8ISPhRq/kOXINVn6c4UasVFTdhqYzPnJnOp?=
 =?us-ascii?Q?4lpUAg/LfH3kbpphOFZyM5g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70b3773-47a9-4737-fcca-08d9f0a258c5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:43:51.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnoMgrcCMcD4jidBvqrLRNVQGaqeMjb4rrd6ecZHfiC+ByIx4MfR4ZoC1bj61ZxCVBrU9ZIG+uQhC6w4I8Cp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:38AM -0600, Naveen Krishna Chatradhi wrote:
> GPU node has 'X' number of PHYs and 'Y' number of channels.
> This results in 'X*Y' number of instances in the Data Fabric.
> Therefore the Data Fabric ID of an instance in GPU as below:
>   df_inst_id = 'X' * number of channels per PHY + 'Y'
> 
> On CPUs the Data Fabric ID of an instance on a CPU is equal to the
> UMC number. since the UMC number and channel are equal in CPU nodes,
> the channel can be used as the Data Fabric ID of the instance.
> 
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Co-developed-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> v1->v7:
> * New change in v7
> 
>  drivers/edac/amd64_edac.c | 60 +++++++++++++++++++++++++++++++++++++--
>  drivers/edac/amd64_edac.h |  2 ++
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 10efe726a959..241419a0be93 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3653,6 +3653,30 @@ static inline void decode_bus_error(int node_id, struct mce *m)
>  	__log_ecc_error(mci, &err, ecc_type);
>  }
>  
> +/*
> + * On CPUs, The Data Fabric ID of an instance is equal to the UMC number.
> + * And since the UMC number and channel are equal in CPU nodes, the channel can be used
> + * as the Data Fabric ID of the instance.
> + */
> +static int f17_df_inst_id(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
> +			  struct err_info *err)
> +{
> +	return err->channel;
> +}
> +
> +/*
> + * A GPU node has 'X' number of PHYs and 'Y' number of channels.
> + * This results in 'X*Y' number of instances in the Data Fabric.
> + * Therefore the Data Fabric ID of an instance can be found with the following formula:
> + * df_inst_id = 'X' * number of channels per PHY + 'Y'
> + *
> + */
> +static int gpu_df_inst_id(struct mem_ctl_info *mci, struct amd64_pvt *pvt,
> +			  struct err_info *err)
> +{
> +	return (err->csrow * pvt->channel_count / mci->nr_csrows) + err->channel;
> +}
> +

The DF Instance ID needs to get adjusted again later in the translation code
due to the fixed mapping of CSes to UMCs. Can that be done here instead? Also,
I assume that fixed mapping is unique to each product, so that would make it a
good fit for the family/pvt ops.

Thanks,
Yazen

