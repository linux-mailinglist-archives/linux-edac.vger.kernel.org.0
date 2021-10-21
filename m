Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F7B4366E4
	for <lists+linux-edac@lfdr.de>; Thu, 21 Oct 2021 17:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJUP6S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Oct 2021 11:58:18 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:50428
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229597AbhJUP6R (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Oct 2021 11:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6HmNztu/Lsk8gkFHQcbhLeQeL3WXpA3MZBdtA4/fudZWA7j15P5BOIj7oeXVkl3HiDJUZx8rOTumi4v2eQnEKQH/499vbah4W0xXmEMTFtgVwqikydg/jmLmOaXIyxVcrAaHZy7mLUIqYw3x1xHdZOeGf4hIxyFEnhQx9gsqqMfugCAC2H30hY4hhe/QUvHo1gmgPySw47RmTdljkfSRZJFVByY77E4EUmUJ4/6MCqrILGzGWkvcKrPuAagbcPruqSh0yZMU65uywyyaTbs/SsK74qdPCKUo5/ZpbxuwaPRbBfPK+F+pc19bLxFFC9Kj1dmj8Rhnqar9bnGjYNPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foiweXKig2XnjUS/iGDQP1IYMQqk7YqU0kTRCAaqZas=;
 b=N3eHZhqoAHgIvETd6EkkfGSfnvnJhrcrS/HcPBPJPyAY2W1P8Vry3KLVcpvQXaphPYZRYV7clxynTZEZiOqGqY81UhdbbkRmE+O4M5h5+eT62anAoQsSogGmpmuO9oSxjmKYN8rld4FmXkyj95B2qV4R7zMrdQE7SQvBd5wsF13AvDsKeKx2Kg3qL0i0vcrjzH7XA8F8xwX3+cnaUzqoDj+rgcQ0ZMJsfImjskVmOyZtEPZZIspXvr8UvO5WSFBPeGg7YLbkp5IqBTy1FmXKJqFEK816t0bJQx9ZCLYbpxeuKfOgNi9oWiv3ohsRuEpbl+poZ8BVEu0lYqMaw9qo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foiweXKig2XnjUS/iGDQP1IYMQqk7YqU0kTRCAaqZas=;
 b=D8M33dkHc+LglQ/t3OACCdOakEISPmY20X4VARBZLaFyl6kSUowEUQ0ANPuZ+UeY/3rinOuEYiZp6wmZNoJPbQpQh2dtNAyMuhRQquwn5UZwXkbMafX4IULVr9lVOBtJbZ+onAD013dyGECkCIjs32hsbeeG+ZvX3vnDCQQNPx8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1316.namprd12.prod.outlook.com (2603:10b6:404:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 15:55:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 15:55:59 +0000
Date:   Thu, 21 Oct 2021 15:55:51 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v4 2/4] EDAC/mce_amd: Extract node id from MCA_IPID
Message-ID: <YXGNh4gfWbZSJHkK@yaz-ubuntu>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
 <20211014185400.10451-3-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014185400.10451-3-nchatrad@amd.com>
X-ClientProxiedBy: BL1PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BL1PR13CA0101.namprd13.prod.outlook.com (2603:10b6:208:2b9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 15:55:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6199a100-4b09-4c7a-c5f2-08d994ab4685
X-MS-TrafficTypeDiagnostic: BN6PR12MB1316:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13163A72C3BEDCBCBA2104D8F8BF9@BN6PR12MB1316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2Ni/cRdAZFCe0ygmTbbYYT6tb8osb8+yjkJGZi9Wr5miruEr8tEgfyYXDid8Woxz/78xH7IKn+WOBX9LcUGism1B6woSk9FNC6lyCtM7MjW3DnxbjjO+3RaY3YyAcjhkzzvPm/ygeHmujUm19MlUYIaamAwjAG8VoLhD/HseEmRoVY9LGuxGqTvZHFpyVP7NUqJM+EVTU2rpd9w6sUhvMALpijsk5fyUuQmXcvO7TD5R4y4ZlSqqckO1VgKAX6DQt/BH50RUL7cfopRRbk6326EXFpJl8SP3WCbEbfeFa8JmL3o0m4Oc9uUNclPirJhLOfcDFojECYUcxmP2usUEzU/Kkjwna2bKE6PMvqKIb/NGb/XQ2f/hnc+qN0I3b+CRoLJiCuQUHF+8yYh6wcZ7TufXsjiBZGSPby/uE/WWXhLKH4AILyU0Opg2qDftLLFlZ1zchXB3VZQ8yBz3T5VT/Ckkh15g8rK1wfS+90bDxSrjKdQaAwwMOoa609DCeZMKwMjt7qgVzar5wlHXOmzfakFXxqMKakF7nZHlwhlfP5o8x1SfDnqFhRo2mploVBd2nYnwK6gYmzFZ0srGiSOx8+tiQV7L7p/PI6Ov5yyvh3IwlokAeWciFJDs4owE7FxpHntJlR6G4RUQfcAHt5JRPohiql/FBr6cF+THaLINW3Y/x0O3iBoaepdIJS6TjVsrBvkSFCYzrydonz2KOqso48RDR+LwAjvRvrY2ipzf8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6496006)(6636002)(6666004)(66946007)(966005)(508600001)(8936002)(956004)(26005)(6862004)(38100700002)(8676002)(44832011)(9686003)(83380400001)(4326008)(5660300002)(55016002)(316002)(66476007)(33716001)(86362001)(66556008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nGRDYpw1MCvCKzHMN9+3EbqZgRbzJo3t4m1ZbD8NtSmn1yp2ZUnmt968SKCK?=
 =?us-ascii?Q?AJqput9FXOVVA7lwoqoZgn91RjUDzHlBWj0gIbnmAd58oSzGmOK8jAujYITa?=
 =?us-ascii?Q?iG7xq45NdVxBqKJSs6T0qSPsEt2cHPMm6kysl2Q8QmUIsEc+jXVbcQC2zE7y?=
 =?us-ascii?Q?9onyslsPPZgx/88WzpB/arukGKE4yAkN7qs0fO9dGLLsRjwIgxfhRSidEt6g?=
 =?us-ascii?Q?kB5N82LvonQI5hr35vQ931KfSZdVmo2OqoRkg40lqmqx/vNDC+PV9/fLbJEz?=
 =?us-ascii?Q?LKTuRQ1MDWUeVUn5aU4j4kzzjxWEzDhHzEP9Hh9GfPqo0vBNWKJWJkFN2rZI?=
 =?us-ascii?Q?ncsszox/bU7mF4pLEju2LNiXbWtq5PcWGUl7NpJLGDYXQ7zHFmtCj1X8kreL?=
 =?us-ascii?Q?X8CUkUOGgItVIoSDT1R3QbRE/yG5Pj6GDdTH5XG/W6YJ48dxpwfMbrceYbAG?=
 =?us-ascii?Q?4U5DjynhDmllpUvOqlitWNA9RD/lkBnhevPCuBYOEgdyciN0dss5aXiqifwe?=
 =?us-ascii?Q?i2RK76kwVlxGLmN5ghL3eT3SWcjLXp/+931ZP3SasJVSbJnZtON5XgX6sela?=
 =?us-ascii?Q?LPF/oApREU5Eb/a7AcoJobAVv1pE232V6+oXewGprl0Y/43FOVeHdYp7Ifx0?=
 =?us-ascii?Q?PLcj15K5ft04xn1cf+rH25qmf0n4PUzhoGqPHS/NCZwigi+IufPSZSws+Wss?=
 =?us-ascii?Q?zYBSJiobVRh8fAM4c62jRRe6qFE/rce/fkDR5QlAbXeVRdPhGqfYR/QYv4GK?=
 =?us-ascii?Q?64mtSlL96t2yUDkqVa870LjlmKbcWcCk6GiNFHs66Q0RTNictCiiTBwJlf+K?=
 =?us-ascii?Q?zRqOzd7FJ7/UKewygxzeAOnjgfWV3cpogZDNLQVfGUgkvys/vHfVKFTDRbY0?=
 =?us-ascii?Q?JBv0K03pr/ETXU6H564HQfOiRXKfvQlrasKqgfcU15qp1lXuxAyrykjX+GFV?=
 =?us-ascii?Q?D4v7ZRDP+kUAVMSDiBSoaVE3WS4+ag8eGF8JFwAVi7/IxOsh4kwEAp0qD03N?=
 =?us-ascii?Q?6bjdarDm0ioUBSgR4z8tmI2R48RYBHfgDaiApLO7HCrppIY8zYkiAVytXWey?=
 =?us-ascii?Q?nVCceYerSl0TpdcTfhrWFc6CPd7BfLFW8ENao7iGJU7qk7r2vENOPKdEhz73?=
 =?us-ascii?Q?KqEp4lxghA7WJv0CaGhQi9khvpXgGNoouk/ltg9RwDip5Me5NipKybFwigtl?=
 =?us-ascii?Q?dyv+GudXWyP+AYJblx7sr8mya3R/rFHMrZvhy4RD1tJaJRQ6r+sOrH0cAZ5s?=
 =?us-ascii?Q?hiOxEw0cjdPK6D0pKFjxc6RuLgmVey6TqGWHVldG/bVEHjgyYOZtRGyOCSkb?=
 =?us-ascii?Q?5zmdL+rK9fyKPHbSsXajuF7mzrz98RMUk0OFzhLeW6Nw6uyalYYmUtRwYZDW?=
 =?us-ascii?Q?rGFlvdZHLhDWjigTRltEPeJk2W4d9RPvl8bKHvIAOyy3lJZ/neNqBEah4xwX?=
 =?us-ascii?Q?HwADrMghGX4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6199a100-4b09-4c7a-c5f2-08d994ab4685
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:55:59.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1316
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 15, 2021 at 12:23:58AM +0530, Naveen Krishna Chatradhi wrote:
> On SMCA banks of the GPU nodes, the node id information is
> available in register MCA_IPID[47:44](InstanceIdHi).
> 
> Convert the hardware node ID to a value used by Linux
> where GPU nodes are sequencially after the CPU nodes.
> 
> Co-developed-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Link: https://lkml.kernel.org/r/20210823185437.94417-3-nchatrad@amd.com
> ---
> Changes since v3:
> 1. Use APIs from amd_nb to identify the gpu_node_start_id and cpu_node_count.
>    Which is required to map the hardware node id to node id enumerated by Linux.
> 
> Changes since v2:
> 1. Modified subject and commit message
> 2. Added Reviewed by Yazen Ghannam
> 
> Changes since v1:
> 1. Modified the commit message
> 2. rearranged the conditions before calling decode_dram_ecc()
> 
>  drivers/edac/mce_amd.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 67dbf4c31271..af6caa76adc7 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -2,6 +2,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> +#include <asm/amd_nb.h>
>  #include <asm/cpu.h>
>  
>  #include "mce_amd.h"
> @@ -1072,8 +1073,27 @@ static void decode_smca_error(struct mce *m)
>  	if (xec < smca_mce_descs[bank_type].num_descs)
>  		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
>  
> -	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
> -		decode_dram_ecc(topology_die_id(m->extcpu), m);
> +	if (xec == 0 && decode_dram_ecc) {
> +		int node_id = 0;
> +
> +		if (bank_type == SMCA_UMC) {
> +			node_id = topology_die_id(m->extcpu);
> +		} else if (bank_type == SMCA_UMC_V2) {
> +			/*
> +			 * SMCA_UMC_V2 exists on GPU nodes, extract the node id
> +			 * from register MCA_IPID[47:44](InstanceIdHi).
> +			 * The InstanceIdHi field represents the instance ID of the GPU.
> +			 * Which needs to be mapped to a value used by Linux,
> +			 * where GPU nodes are simply numerically after the CPU nodes.
> +			 */
> +			node_id = ((m->ipid >> 44) & 0xF) -
> +				   amd_gpu_node_start_id() + amd_cpu_node_count();
> +		} else {
> +			return;
> +		}
> +
> +		decode_dram_ecc(node_id, m);
> +	}
>  }
>  
>  static inline void amd_decode_err_code(u16 ec)
> -- 

This looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
