Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B2241058
	for <lists+linux-edac@lfdr.de>; Mon, 10 Aug 2020 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgHJT30 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Aug 2020 15:29:26 -0400
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:50529
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729032AbgHJTKo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 Aug 2020 15:10:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUxMxQNhF2ZgeE6tchQHk89+pZxW0AQi2kUVdXOGNqN3EOc4G/mU6UrvkNB0puPyYPZauol2vhJyhtX9xg7cp/XjIRVHR0PPNFLM+nCAWRWlOM6cXfBZke/k0H/otbTqkQdUjhsOWJWXqsjHhSEg/DX50rbe7ssD+srQ0xuvuPvCphmPVxORvnbohR68VIbM1y/qI4vA39cHGujVU0WIfQouG0ZLYDG/DbGq840mAzdZlzhNrS6atstE38CvCom8IFtsJCibOR9hrzpMf/DWmmaagnxb4JzTa7pZZ5LDQCgn/tVjISaWGD+MozkkiiFbuj6xjWtNI/3fKZ6pX29JPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ntjwhA7BptFtWiLYwUI+RUuxlOOv5ibCRFTF4k0srI=;
 b=PHDAZSWHzb/Uyz9iMNYG0FZaqig6v30IctLtDpJcTQuZKQmqfJ6cdr49Q7KTFITh8GJPZve23S21OJVLGBMaz6yVP310XxAGSNuNZyN3EihBIGhox8WsRj6+4SMjQ0qOA3B/RDTChjEy35XLDS4DXjoDx34GrC2JS5gYBXVoH68aiMqPmOUmllOtV5/SkiXtFAZTUFOSRsf5pXhahaLlxWGO+VSfNh71jyotKoctWDT4+Z2uUjvA7DJKYW/3AcZCyrqnS8jdpEgokkB235iX3Upiit/RNxJQkBnno1bcWK0y1whNkvnaUxdf4/HO7B9onztHHWp5g/lYLC3DFBewXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ntjwhA7BptFtWiLYwUI+RUuxlOOv5ibCRFTF4k0srI=;
 b=KciQmHrJaEpT9zFOT1ZY/trJRx43CsJ1TwKiBVzzboSNd6bBh7NL4xh+yOWiQm/zbugeQa3wN/08WsmFe040BPY7UY6dvTNr22MoAP6Y71/uQfbWm2PWLMuuwGJkzpw2tMikRdNbXpRnBzB3RaD4O7uZBmROOBxNslnlMPxH0h4=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 19:10:41 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 19:10:41 +0000
Date:   Mon, 10 Aug 2020 14:10:31 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxian.1@bytedance.com
Subject: Re: [PATCH] x86/MCE/AMD, EDAC/mce_amd
Message-ID: <20200810190958.GA3406209@yaz-nikka.amd.com>
References: <20200809043559.9740-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809043559.9740-1-zhoufeng.zf@bytedance.com>
X-ClientProxiedBy: SA0PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:d3::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by SA0PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:d3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Mon, 10 Aug 2020 19:10:39 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ebb77e6-a9a8-4749-6acd-08d83d611312
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:
X-Microsoft-Antispam-PRVS: <BN8PR12MB29806965A375EF1382616B77F8440@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpAl2WMjmbep/ePIGreatztN8TDPqe0aoB/np0so4ZTeufAliFNkL2NtVjRHaxnSEgb9/mhI6TaIcB/g89od3t9ZZnRkMG9/A9C3X0tlUnFQKsJIYqZAtXVszC0avbVqn0K432QvgIDs37j41Z8UG5UA997oEb7I3WI/uRLOQmdQORBssgVp6/HKm9qxRXpdhdxVWr+ByuRTx3tDPYmi3tIdY8rhHyqaVRRqiCmpTwAwLBQq1I/hi/+606cL8wShDNwdVh+u8G+xgodCE/vl0R9JaPukv/D89sSoAGKQxh1m5avK56/mxFce0moeZLc2oE2mFSlioxCyMMA6ut6ClQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(5660300002)(4326008)(44832011)(55016002)(8676002)(186003)(478600001)(86362001)(16526019)(26005)(2906002)(6916009)(33656002)(7696005)(52116002)(956004)(66556008)(66476007)(83380400001)(66946007)(8936002)(6666004)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PI5g1Sem8AyPj/NBZqI62ATYSMJEVo/nbPI+McflN+5DEjO30FGW5KeB+kSvNUFlnyIzUhRHK8hzEI2gmxM/W3wyY7ZJzCy6dnweJLnFkWQmbmj9XxDA9+nZOWvUo85GgPWLgNGHRLAKpTbJ4KM4doV3mA/VQbaYYYRsQmY7XhjXtn/ntoO18tZXkq6DpdD2ramedpT8ehP3H2tG6MIvI/5vtyPC8m7laTyZYCT5vJ0K8BT408Gh2PkziGZAhlnLnWCBuiw6e4Kpe7yhKduy6PLR9D1USWJVXRWvzQXG4pJLpfXeVZCHzT7HBRVqawCqtY8cprOBJSEileeoADy9YNuDcH8tbsrGgr50HnjEyAf5J+8heG5s6RaqN/MhNfMBlcdYDA0ATWI381iskKycjQu83gRt58IpHYev6xilJDL50YQdRts/cANBmEvSG09xDVtoF1QxExpYjPjpbUbWb1djeV8En920fGspkFvxMXdiP9J7VqeWqfN1vFvdeKKdhc4XUA7NlypQhA8blOeaJLd15tNliC/nn7aL/Q7ti6VBkJAHu9Q5SenfzAT52jMqlf2cB2Ck0zQAdYDsS/q7fcn+fnHp4KEIC8x8FabJYL+UZ/jjU3sO+3z5YI/fbmG0CkOiRAC3sfn23UI1AE02Jg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebb77e6-a9a8-4749-6acd-08d83d611312
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 19:10:41.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuW7aJdO92v+WArJQ/qCRM32MMdMzJp515MhTiH30xkwjcE6PQ3V2ZZpL5SuRO0EJa3Ad0h/AyE4DhSqVvGCJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 09, 2020 at 12:35:59PM +0800, Feng zhou wrote:
> From: zhoufeng <zhoufeng.zf@bytedance.com>
> 
> The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
> later systems. This function is used in amd64_edac_mod to do
> system-specific decoding for DRAM ECC errors. The function takes a
> "NodeId" as a parameter.
> 
> In AMD documentation, NodeId is used to identify a physical die in a
> system. This can be used to identify a node in the AMD_NB code and also
> it is used with umc_normaddr_to_sysaddr().
> 
> However, the input used for decode_dram_ecc() is currently the NUMA node
> of a logical CPU. so this will cause the address translation function to
> fail or report incorrect results.
> 
> Signed-off-by: zhoufeng <zhoufeng.zf@bytedance.com>
> ---
>  drivers/edac/mce_amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 325aedf46ff2..73c805113322 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -996,7 +996,7 @@ static void decode_smca_error(struct mce *m)
>  	}
>  
>  	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
> -		decode_dram_ecc(cpu_to_node(m->extcpu), m);
> +		decode_dram_ecc(topology_physical_package_id(m->extcpu), m);

This will break on Naples systems, because the NodeId and the physical
package ID will not match.

I can send a patch soon that will work for Naples, Rome, and later
systems.

Thanks,
Yazen
