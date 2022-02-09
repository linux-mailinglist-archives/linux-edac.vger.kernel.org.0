Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEC4B0126
	for <lists+linux-edac@lfdr.de>; Thu, 10 Feb 2022 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiBIXXg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Feb 2022 18:23:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBIXXe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Feb 2022 18:23:34 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D64E061460;
        Wed,  9 Feb 2022 15:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUPp+EpKBpJOpM7NAR1FwD/42VWxQ9XRcifNboCJlV16kpRh9/cSipnjB0WdHJQFRkTsHTmgyVFCYlF4hu39vGODHGyeihZKWft1DDeYFyLVX7N/hi+HlexGRnsNkdES3lnaPcqdnaua7oghQySwCJRw1CSCtrYv9bhTp9OBh2cuhVQpzHkldsGe62bcO+qOw60DBqDCO5Gmv6x3woe50YCAx6gT3QQ3guqXJykG7G6APLwgaAjB3rzuZtADXYc/+eMZhcy9nUN5Ppg/wk8muomM9QFauzmljyM4xt7+0O2RRceJY0zY9WnTCI67F2rQa15H8gPki45C5U144ytynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRoT7twlDy/RPWTVWMbM1gkBGOtqChXYX1JB7P1loRA=;
 b=S7W7r8NgZK9BrpVqj4oy9phFXHs5uUsxtx41+WRgwZScexCllbMX6IdHCD7lhV36QblBcJYQT7MjhQXxB1mCzbXw9kfFjiumJsBrum9zzpDHm2XpFoZ20a4xCqctPx9hX9vHQVD0nNj5IwctB6B+uBgCjmVqnmUBvIe3EX8SoJF+RUuMhmI3dKkExsUwAOEYp7oqecexqkVopT7Rjh767PAOr6iydIuvlcy7lDLcFRxWzf6pVatuQKSuMnDYSnnCWENXoi2eZlrVpKyoXTTY7QLi9sWD7lwpZTrOnbFZCycpuosdtbgEVTFCYH8d7SM6eANRiTB4XC1EX6BYfIo9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRoT7twlDy/RPWTVWMbM1gkBGOtqChXYX1JB7P1loRA=;
 b=MvsAosx5aY4KdFz0zLI95cZp/jfEw7xpJBXgHsSqC1jm5EYttOb61yTV9/qC6FaGVZ3Y6PqkcOJGnDhnt/TLriEOd0DxCugPTpYxKaCUhvue6o4YHpYwTWtj48Bcqe2qk1NQ6aIK7nLJqRNjqXu+sSDRsAwjrRjhzHXUtoa6PB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 23:23:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:23:23 +0000
Date:   Wed, 9 Feb 2022 23:23:12 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v7 02/12] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YgRM4J8yr7cKG37q@yaz-ubuntu>
References: <20220203174942.31630-1-nchatrad@amd.com>
 <20220203174942.31630-3-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203174942.31630-3-nchatrad@amd.com>
X-ClientProxiedBy: CH2PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:610:59::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340ef022-215c-45dd-22d7-08d9ec232a8e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1280B416BB0E1AA04152B0A4F82E9@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZG5k5n0m12HBuB44gP0keYnDXPh3IblvanlCx53kY8zH0lR6qIeJvSc7xKiNMwwF3dCWDKtcpss8/3Afllbkaq38o8fSaoPHZFc6t9MvuH0haze0lR8FArZw7EMqRQ/mEnS/1/jg3cAStyjgvgHAA6HoN0awYrapdJCVfNPk1fcho+XjPQx9iJQ5vYDRUjdnRWs6ykErGC4o2Ry8fFv29fD/ncN5HDdoCBiTJHc21/bTpcdJMHA9HQYJajzJsnH8x8jTm4sjt9BTTY3Mz+/KqzTjMN7TVamYc3INcjLp4VQr5cK/VHzDkeB8ulZPKpf5vddlQpRaRERHcTPSN2GK9I5vBLXSg6BWn+REIgVosz+WR+Qv5dpa5WhTXH25XAheOVLb87FV0CofD0RkwZEMGCnUHUFyxF5AvoBbvLkD9ZFF3bdldat9vjzXrSo1Iefm9R/yNGQKDAUGi6E0X2rqUB5KzHOeOx7pF+PXImBPneOuASVm3UXHtshQPZXWMw1kImLPU9VoXigz8JB1KR94IvrhdCYcgo+RCWEGCkWXLf9P98IM/Rnx135LVeeX6gpQolrcBs2dyWPYUu9pNTCpyntPa8Oc9EccwJCrCDEBSD2CfnuiI1s4rJmmHDksnl839FcKz8nniugw/w2G7GhP2McdKk4pHCgYEWUlMQI+7ELQ4V/qDbXcSthBC8O8XNYzm8SqAFK2A5C+FRn7MukDWUJr8z/O6cmMboJKwSRQui8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(186003)(33716001)(6636002)(316002)(66946007)(30864003)(44832011)(38100700002)(2906002)(26005)(5660300002)(9686003)(6506007)(6486002)(966005)(6512007)(8936002)(86362001)(508600001)(6666004)(83380400001)(4326008)(66556008)(6862004)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CsMKDpl9DsJ5RgCUeEKxmuBj0VA/oY4PeE2NCXlKQhkHyWvsZfIIVilchyD?=
 =?us-ascii?Q?MjJ3/leb8OMPQyOhpdoNwSv1cnLmHuR9cF30meEYOyfP7iyNU7hFV6n3npv3?=
 =?us-ascii?Q?t3OggH2IyznbOxQ1Ua39o9BhsF3gYwhBa52M8ZbgnYvsus16GjbOQyaBGMiE?=
 =?us-ascii?Q?3FY4ykP9eT1+022CVqEUGr1evhr/RitIzP1KITG1+705Ukfb/hnhal2rLjSm?=
 =?us-ascii?Q?X+jDIuPzYnJqRnd0wE5dBNo+ul0DIu6vasIfx/eGc96kIZRUK8DXRb5h8xR9?=
 =?us-ascii?Q?qwOL2zZyjzpEHMaTJiIT8jLVYYgD9JYpPi8EK+Wcp77RpGoQDphnzqBZukNM?=
 =?us-ascii?Q?8PP+7N2xxz+mhgrGGGvD9ZUHFcqulJSiOF/vsU6KCVaf3QHfUwn3dDQ0r0tR?=
 =?us-ascii?Q?dWR3/e72D3fx07IIl8w8+C9Ibw3txJO3qkFCXmleulSpHahmW2eWbhyDcO+j?=
 =?us-ascii?Q?wmf+9HOet4mfIMUev3xvUrGVjKypA635P2H1lvdZAxDnE08WFxwYrzYxKZ3Z?=
 =?us-ascii?Q?OlGQ+2NcZ/Y+kmclmautu3JDOymtEbzdJR6CetMI1QtjZqEZuZHFJceOxDdd?=
 =?us-ascii?Q?pcvUfcrkpx2sP3Jn1z5FZfDt6ZNKDoztBY6kr8rLQnoeni3mQupivcowLskV?=
 =?us-ascii?Q?dUyC9XxhF17egp+FHK9FRQd+AF4ENYiuABQ0SBXNn4Gu9NwhXnQN51eJErLf?=
 =?us-ascii?Q?YCTtQFlVNo8L2WBSOPT1rR5lOEvX1XYvBPyK0JqpVzaSEBfwyJDG3D+709Kx?=
 =?us-ascii?Q?JMhXx8Y5pxbRvTSbD4CBr3U2BRJrbwL6jtlnp8GXUehFE6fyYRhcWv0B7wCC?=
 =?us-ascii?Q?R0v6AriLzSpBzAbkzUH9jraKlHNwuXpzpFvjVq8TINRpJJXwGloY2YG1XPKs?=
 =?us-ascii?Q?Uj6nXdiBFt8275Om//PD7jug3uZHiqF98oeIgq2CL0U6ikXpr7uYnvA9+jYh?=
 =?us-ascii?Q?48dADNRh8NDdvi5mTOBCPAxakjpBqwc1uEOM0wyV4Mb4JuaDxDJ4R8ZFiZhg?=
 =?us-ascii?Q?kAKQO1q+s561RzC8Uj9RLkBbUnMJMiCSvibKLf585rG3w6YNh9ooWfdsWTdm?=
 =?us-ascii?Q?kgWzemLZq1QcFt8ZWwxiE3Kh+jCm8+IINOXxbUx8yGu9xjX0xzUSNq2ZJOe2?=
 =?us-ascii?Q?ZOMlBqoDuZKPvqYLcnlfo284Ucffah6WNEuFYOhCbKsR6eSLqRI2SoFTL6hh?=
 =?us-ascii?Q?N6ptrpUVlI0BWwbUlxJ305ldz1TVdCxDTFpcUiksEzbGVonj/Wd+FQjbEsIp?=
 =?us-ascii?Q?SD3n3u4ZZugJHVNmLY7R2wguf77XYBQoJpMbsTbUX3DsKURl64pSpPSQNk9H?=
 =?us-ascii?Q?h0i1VplFTu8UZi+44uZmlWIjlUXpOx5T+2X5sJkmVXe7jbW3WySHSCdoM7kQ?=
 =?us-ascii?Q?aAwF5Z+AvrXfbkSeDMEKsqd++2tLnifo1bYqIgp++mCqC8LDNHjnbnCLIOnf?=
 =?us-ascii?Q?HPzZgTemIaj+P0ISVKf9p1ShE6Xjee9KMV7TDSCJUOaVzP98gmwdaEIwTv7r?=
 =?us-ascii?Q?iyxn2QCvgj64+9CFiVb2iu51D3alLycAukpt2LfgJU/qiB9+hZiLgYyc148i?=
 =?us-ascii?Q?KfmYuGZdT+W/cItKBksZ5GxL2K3dRq7mE8tiyKShihO4iSmCrWXXB4sSxMyT?=
 =?us-ascii?Q?2zdOKWe6olTCo6qFOK1ZW10=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340ef022-215c-45dd-22d7-08d9ec232a8e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:23:23.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vd7aBT9A7nGqqBKLe5dpa9mM5vARuG7KlahEXlun1X4XVu9xI4oKjBlixMwblDMhuhza8Z/yJ/iip2gRmjjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 11:49:32AM -0600, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On newer systems the CPUs manage MCA errors reported from the GPUs.
> Enumerate the GPU nodes with the AMD NB framework to support EDAC.
> 
> GPU nodes are enumerated in sequential order based on the PCI hierarchy,
> and the first GPU node is assumed to have an "AMD Node ID" value after
> CPU Nodes are fully populated.
> 
> Aldebaran is an AMD GPU, GPU drivers are part of the DRM framework
> https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html
> 
> Each Aldebaran GPU has 2 Data Fabrics, which are enumerated as 2 nodes.
> With this implementation detail, the Data Fabric on the GPU nodes can be
> accessed the same way as the Data Fabric on CPU nodes.
> 
> Handled new device support and enumeration by calling separate function

s/Handled/handle/

> in init_amd_nbs with completely separate data structures.

s/init_amd_nbs/init_amd_nbs()/

Function names should have "()" to clearly show they are functions.

> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Co-developed-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20211028130106.15701-2-nchatrad@amd.com
> 
> v6->v7:
> * API amd_gpu_node_start_id() introduced to reuse in future patches.
> 
> v5->v6:
> * Defined seperate structure for GPU NBs and handled GPu enumearation
>   seperately by defining new function amd_cache_gpu_devices
> * Defined amd_get_gpu_node_id which will be used by mce module
> 
> v4->v5:
> * Modified amd_get_node_map() and checking return value
> 
> v3->v4:
> * renamed struct name from nmap to nodemap
> * split amd_get_node_map and addressed minor comments
> 
> v2->v3:
> * Use word "gpu" instead of "noncpu" in the patch
> * Do not create pci_dev_ids arrays for gpu nodes
> * Identify the gpu node start index from DF18F1 registers on the GPU nodes.
>   Export cpu node count and gpu start node id
> 
> v1->v2:
> * Added Reviewed-by Yazen Ghannam
> 
> v0->v1
> * Modified the commit message and comments in the code
> * Squashed patch 1/7: "x86/amd_nb: Add Aldebaran device to PCI IDs"
> 
> 
>  arch/x86/include/asm/amd_nb.h |   9 ++
>  arch/x86/kernel/amd_nb.c      | 149 +++++++++++++++++++++++++++++++++-
>  include/linux/pci_ids.h       |   1 +
>  3 files changed, 155 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 00d1a400b7a1..cb8bc59d17a0 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -73,6 +73,12 @@ struct amd_northbridge_info {
>  	struct amd_northbridge *nb;
>  };
>  
> +struct amd_gpu_nb_info {
> +	u16 gpu_num;
> +	struct amd_northbridge *gpu_nb;
> +	u16 gpu_node_start_id;

The members should be aligned with tabs.

Is the "gpu" prefix needed for the members since the struct type indicates
this?

Also, I think grouping members with similar types and leaving pointers to the
end may help avoid padding, etc.

> +};
> +
>  #define AMD_NB_GART			BIT(0)
>  #define AMD_NB_L3_INDEX_DISABLE		BIT(1)
>  #define AMD_NB_L3_PARTITIONING		BIT(2)
> @@ -80,8 +86,11 @@ struct amd_northbridge_info {
>  #ifdef CONFIG_AMD_NB
>  
>  u16 amd_nb_num(void);
> +u16 amd_gpu_nb_num(void);
> +u16 amd_gpu_node_start_id(void);
>  bool amd_nb_has_feature(unsigned int feature);
>  struct amd_northbridge *node_to_amd_nb(int node);
> +int amd_get_gpu_node_system_id(u64 ipid);
>  
>  static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
>  {
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 020c906f7934..dfa7c7516321 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -20,6 +20,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
>  #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
>  #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT 0x14bb
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> @@ -30,6 +31,14 @@
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4 0x14d4
> +
> +/* GPU Data Fabric ID Device 24 Function 1 */
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1 0x14d1
> +
> +/* DF18xF1 register on Aldebaran GPU */
> +#define REG_LOCAL_NODE_TYPE_MAP		0x144
> +
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -104,6 +113,21 @@ static const struct pci_device_id hygon_nb_link_ids[] = {
>  	{}
>  };
>  
> +static const struct pci_device_id amd_gpu_root_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_gpu_misc_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_gpu_link_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
> +	{}
> +};
> +
>  const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
>  	{ 0x00, 0x18, 0x20 },
>  	{ 0xff, 0x00, 0x20 },
> @@ -112,6 +136,8 @@ const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
>  };
>  
>  static struct amd_northbridge_info amd_northbridges;
> +/* GPU specific structure declaration */
> +static struct amd_gpu_nb_info amd_gpu_nbs;
>  
>  u16 amd_nb_num(void)
>  {
> @@ -119,6 +145,20 @@ u16 amd_nb_num(void)
>  }
>  EXPORT_SYMBOL_GPL(amd_nb_num);
>  
> +/* Total number of GPU nbs in a system */
> +u16 amd_gpu_nb_num(void)
> +{
> +	return amd_gpu_nbs.gpu_num;
> +}
> +EXPORT_SYMBOL_GPL(amd_gpu_nb_num);
> +
> +/* Start index of hardware provided GPU node ID */
> +u16 amd_gpu_node_start_id(void)
> +{
> +	return amd_gpu_nbs.gpu_node_start_id;
> +}
> +EXPORT_SYMBOL_GPL(amd_gpu_node_start_id);
> +
>  bool amd_nb_has_feature(unsigned int feature)
>  {
>  	return ((amd_northbridges.flags & feature) == feature);
> @@ -127,10 +167,60 @@ EXPORT_SYMBOL_GPL(amd_nb_has_feature);
>  
>  struct amd_northbridge *node_to_amd_nb(int node)
>  {
> -	return (node < amd_northbridges.num) ? &amd_northbridges.nb[node] : NULL;
> +	if (node < amd_northbridges.num)
> +		return &amd_northbridges.nb[node];
> +	else if (node >= amd_northbridges.num &&
> +		 node < amd_gpu_nbs.gpu_num + amd_northbridges.num)
> +		return &amd_gpu_nbs.gpu_nb[node - amd_northbridges.num];
> +	else
> +		return NULL;
>  }
>  EXPORT_SYMBOL_GPL(node_to_amd_nb);
>  
> +/*
> + * On SMCA banks of the GPU nodes, the hardware node id information is
> + * available in register MCA_IPID[47:44](InstanceIdHi).
> + *
> + * Convert the hardware node ID to a value used by linux where
> + * GPU nodes are sequentially after the CPU nodes.
> + */
> +int amd_get_gpu_node_system_id(u64 ipid)
> +{
> +	return ((ipid >> 44 & 0xF) - amd_gpu_node_start_id()
> +				   + amd_northbridges.num);
> +}
> +EXPORT_SYMBOL_GPL(amd_get_gpu_node_system_id);

Why does this function need to be in amd_nb.c?

It seems like it's only needed in EDAC. And the necessary info is already
being exported.

> +
> +/*
> + * AMD CPUs and GPUs whose data fabrics can be connected via custom xGMI
> + * links, come with registers to gather local and remote node type map info.
> + *
> + * This function, reads the register in DF function 1 from "Local Node Type"
> + * which refers to GPU node.
> + */
> +static int amd_gpu_df_nodemap(void)

The purpose of this function is to find the "gpu_node_start_id", so I think
the function name should reflect that.

> +{
> +	struct pci_dev *pdev;
> +	u32 tmp;
> +
> +	pdev = pci_get_device(PCI_VENDOR_ID_AMD,
> +			      PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, NULL);
> +	if (!pdev) {
> +		pr_debug("DF Func1 PCI device not found on this node.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp))
> +		goto out;
> +	amd_gpu_nbs.gpu_node_start_id = tmp & 0xFFF;
> +
> +	return 0;
> +out:
> +	pr_warn("PCI config access failed\n");
> +	pci_dev_put(pdev);

Shouldn't this "put" also happen on the success path?

> +	return -ENODEV;
> +}
> +
>  static struct pci_dev *next_northbridge(struct pci_dev *dev,
>  					const struct pci_device_id *ids)
>  {
> @@ -147,7 +237,7 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
>  	struct pci_dev *root;
>  	int err = -ENODEV;
>  
> -	if (node >= amd_northbridges.num)
> +	if (node >= amd_northbridges.num + amd_gpu_nbs.gpu_num)
>  		goto out;
>  
>  	root = node_to_amd_nb(node)->root;
> @@ -210,14 +300,14 @@ int amd_cache_northbridges(void)
>  	}
>  
>  	misc = NULL;
> -	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
> +	while ((misc = next_northbridge(misc, misc_ids)))
>  		misc_count++;
>  
>  	if (!misc_count)
>  		return -ENODEV;
>  
>  	root = NULL;
> -	while ((root = next_northbridge(root, root_ids)) != NULL)
> +	while ((root = next_northbridge(root, root_ids)))

I think these last two changes aren't necessary for this feature.

>  		root_count++;
>  
>  	if (root_count) {
> @@ -292,6 +382,56 @@ int amd_cache_northbridges(void)
>  }
>  EXPORT_SYMBOL_GPL(amd_cache_northbridges);
>  
> +int amd_cache_gpu_devices(void)
> +{
> +	const struct pci_device_id *misc_ids = amd_gpu_misc_ids;
> +	const struct pci_device_id *link_ids = amd_gpu_link_ids;
> +	const struct pci_device_id *root_ids = amd_gpu_root_ids;
> +	struct pci_dev *root, *misc, *link;
> +	struct amd_northbridge *gpu_nb;
> +	u16 misc_count = 0;
> +	u16 root_count = 0;
> +	int ret;
> +	u16 i;
> +
> +	if (amd_gpu_nbs.gpu_num)
> +		return 0;
> +
> +	ret = amd_gpu_df_nodemap();
> +	if (ret)
> +		return ret;
> +
> +	misc = NULL;
> +	while ((misc = next_northbridge(misc, misc_ids)))
> +		misc_count++;
> +
> +	if (!misc_count)
> +		return -ENODEV;
> +
> +	root = NULL;
> +	while ((root = next_northbridge(root, root_ids)))
> +		root_count++;
> +
> +	gpu_nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	if (!gpu_nb)
> +		return -ENOMEM;
> +
> +	amd_gpu_nbs.gpu_nb = gpu_nb;
> +	amd_gpu_nbs.gpu_num = misc_count;
> +
> +	link = NULL, misc = NULL, root = NULL;
> +	for (i = amd_northbridges.num; i < (amd_northbridges.num + amd_gpu_nbs.gpu_num); i++) {
> +		node_to_amd_nb(i)->root = root =
> +			next_northbridge(root, root_ids);
> +		node_to_amd_nb(i)->misc = misc =
> +			next_northbridge(misc, misc_ids);
> +		node_to_amd_nb(i)->link = link =
> +			next_northbridge(link, link_ids);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_cache_gpu_devices);

I don't think this needs to be exported since it's called in init_amd_nbs()
below.

A module can use amd_nb_num() to see if anything was initialized rather than
calling amd_cache_*() again.

The existing callers of amd_cache_*() functions need to be cleaned up.

> +
>  /*
>   * Ignores subdevice/subvendor but as far as I can figure out
>   * they're useless anyways
> @@ -497,6 +637,7 @@ static __init int init_amd_nbs(void)
>  {
>  	amd_cache_northbridges();
>  	amd_cache_gart();
> +	amd_cache_gpu_devices();
>  
>  	fix_erratum_688();
>

...

Thanks,
Yazen  
