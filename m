Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7A301315
	for <lists+linux-edac@lfdr.de>; Sat, 23 Jan 2021 05:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhAWEqH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Jan 2021 23:46:07 -0500
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:10240
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbhAWEqF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 22 Jan 2021 23:46:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USwE52CRoIKYxEA36iMtvZAfzW5+8wiSiQ0dAfTa+wPcJKZLeb4FTJ5G3NJNXeLH3w5iQ5Wxup1shEoZ7urgmqDXBlfZL/LH32gEyj2L84i6wc7L9+2gv2EnD1prdvUAPRGpInUaTEl/EDiUek6yMt5UQ7InYvyjguV529QiBXUP6al09MUEYFzBRuGKVK0nAMo3Rc/xPn6UxBqcSRdGxqfO6MDf0i04QFcBlF690lhzc1d2pdwucQjBm1B5DnN5KUZ+OYIGhRGuyPyBm/NrN2R7reGUSYgMUTOzpSxRqTWnxnq7qSHGPrynZGRQKXaLe/UenIxvkzJVd9uPMuSqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7SAWqHfsktGVxfvgVRwdUHU+gWvsgIb1zgFs7B5eQ0=;
 b=h+XURHzS+0QlW3esYJlMxlIei+40eMse2MqnhWjMDcofkZj/DAgGMZqhpHZNlxzm2u+uFhBhgWQt6Z96iJFppEa81wmO2USW4VbH65jT1z/GBN1XqZoUirP+x9odRlrIjSedAhnp0G+E044WgMPwaAAJqhcTvpoCb7iIV1NOa820hgreJvrCH6XdrwHLI+48Q+DUr5V5syAfaeUB2Do0Xa7jYpED0+9aXnZEXx044IUrjRp0yat6z9+5brKksIBmU/60URlaMwdPJWDWid+mzbp11TeqNc2Yri2u5H9B7lG8FuvQDT0kB6bj+z1Usn9E4cGdhtoALwG4Kdgrda6c7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7SAWqHfsktGVxfvgVRwdUHU+gWvsgIb1zgFs7B5eQ0=;
 b=4OzQFX94drvdnMFzh7LuryOtTgGwfnaRsounUNu2Z8Q5L6G2B+b5osAJrAXDnXmWijyNBGhehUQFNPrjIyAvH518du/KG9j994cVD2eeTyvviv2s2zlY+fXtCCmoSAgS2Ad3u6mEjhDwTfFKPNuAeiRK9Pi9hBff1UVIr0KG2nU=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Sat, 23 Jan
 2021 04:45:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::866:baa9:f17d:d6b4]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::866:baa9:f17d:d6b4%3]) with mapi id 15.20.3763.017; Sat, 23 Jan 2021
 04:45:11 +0000
Date:   Fri, 22 Jan 2021 22:45:02 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: EDAC instances probing
Message-ID: <20210123044502.GA869026@yaz-nikka.amd.com>
References: <20201211181915.GD25974@zn.tnic>
 <20201211203520.GA2128@yaz-nikka.amd.com>
 <20201211205850.GH25974@zn.tnic>
 <20210113203316.GI16960@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113203316.GI16960@zn.tnic>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:806:121::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SN7PR04CA0077.namprd04.prod.outlook.com (2603:10b6:806:121::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Sat, 23 Jan 2021 04:45:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 647f0ec9-6bce-4e83-5809-08d8bf59aac6
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:
X-Microsoft-Antispam-PRVS: <BN7PR12MB28360D4D3DB6C8F1AB315527F8BF0@BN7PR12MB2836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YI6cpM7Zc39FIeHyVBabvu4BVDtGnoAeLFMgmQh6PLt7Dncaw7W5EQsFwHEOT6v9L7QOQ9JY3x9T330Rf2A62kLqs0l+lUt83q40TGEeN/KoGfCqXYGan2zgZ213pHmaTqkSNS5ZDEF1cl0+Adzc38BLh1YLISq623g1xTjW79fqCMWIzPwuyJpfZpwAeWBcLsOd3A/9kL6jBSxqoBT/dKKLRrodbIBmEvdlIXot0+Wlf4y8bKN2a0rKSaTCFmPIH41yhyFV0czMelHm9R+pu+ga7dDCCQG6tTOaHYdMvPlic92QHNj2pg4B/UyqWiqx8m2XoeR5PFshOKdQVzy2pE4x12aL6LWDPHKF0pqjK3Gn5ycGSTfdHObQqZDRlaH3Nokm+zXYtncVNhNm+ZmecQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(8936002)(6916009)(33656002)(5660300002)(956004)(16526019)(54906003)(66556008)(6666004)(186003)(66476007)(66946007)(478600001)(83380400001)(44832011)(316002)(3480700007)(55016002)(7116003)(4326008)(26005)(1076003)(7696005)(86362001)(2906002)(8676002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KVdT649eiIMzqCa0lO27bMRcz9+ihRVVLpU3a1lRcnhSAZef/bDGbTRGRyty?=
 =?us-ascii?Q?HLsw293DGCOyr6HVzVn7YGDsxqUBthCob7FDiZeuMFRb6qfYnax8aS9nxxEA?=
 =?us-ascii?Q?2eBYK6B8IpouHLcb8XJFfy8dfM1ebyVi7L+11Vo4Ebhv6ImedV45tAn0l9JJ?=
 =?us-ascii?Q?3l/6ZQcaVuXex9RNx2I0kbQJ/xVpFi7I2q60ynkk8uyRCI4kqDOmhSfVGbWR?=
 =?us-ascii?Q?T/vqrczPRm8oAJBP8qzppPNnYplnuPC4Urg4rI6S801+nKuKsR+Ml+yQqYOx?=
 =?us-ascii?Q?kN72fBtTXcW+dVJPBZnPZzWIOrPHwaLl+U+TJyywTl7sTy+Bm5Rsyc9iKzoI?=
 =?us-ascii?Q?4ab1rzdXeT8/hBGQA61blIV+MfBcn86/tGXuSXsnXJOY9jNoFkOKaZbSUmcZ?=
 =?us-ascii?Q?pp8i6sZ6oK2B+cuU4j9vB7nRvUPq6YPm8X4MWd6QWMloPZX4G8NlShKmblc+?=
 =?us-ascii?Q?mASzC949IGu/qG0rRM8hbvWobO3E0+qEvTJl29mSdqtczKq8JgdnUTggfUIj?=
 =?us-ascii?Q?cQQCG6Z39So2RH/rXlMm1fKefjLv/UXNI7GsZSl+pXne2zNiW16kSb0oRpc9?=
 =?us-ascii?Q?0Won5DE2DNqdweVDBzdoq5jBWU5B68t8EofhFToxyJcgC55ZvRWYb3Zu5pCc?=
 =?us-ascii?Q?s3co2Q+O6SZnhgT40MClEhdkkd5HMd7tCdB0I/fyl/SeeaSLolHBifP+h84Q?=
 =?us-ascii?Q?6TDMoHPse5zF/ev8X5nKwhRqt8d5KKyioVQYOCI+ETqtqn3dWUAKjrgnBREQ?=
 =?us-ascii?Q?j7SJsrO0i4locRoGGL1N05GXYP8ejxB6t0Zh49jlEJ89/ES8rPd1LImCLzgI?=
 =?us-ascii?Q?7JZ5pSfyQDMmDQDQPXJfiJbscECZKurqnCWrX3NDh6ZQ1hFOcnZJ9nI2TB0b?=
 =?us-ascii?Q?QmzMqQ2sreQI5DJ5PyWx+I6dCIKANyC6hcCPyL/TO1xncPlGPq5H+cIeTvky?=
 =?us-ascii?Q?lnzDAEhxwriZK9eRiBYkACxoqHprfZif62/+vBZWZSlXCFdtFGT+JPIWsjqm?=
 =?us-ascii?Q?wXF8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647f0ec9-6bce-4e83-5809-08d8bf59aac6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2021 04:45:11.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jj/kdHwTN3nUUQsMCYe55bzgsR12LqztyYkyGdbFPGeh9PMozLjB9t37TkHX756prXYrksee0itLOJJCBGycQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 13, 2021 at 09:33:16PM +0100, Borislav Petkov wrote:
> I'm soo stupid. Usually I do the simplest solution but this time it has
> escaped me.
> 
> But I caught it now:
> 
> ---
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 9868f95a5622..105d00b27be2 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3528,8 +3528,7 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
>  				     MSR_IA32_MCG_CTL, nid);
>  	}
>  
> -	amd64_info("Node %d: DRAM ECC %s.\n",
> -		   nid, (ecc_en ? "enabled" : "disabled"));
> +	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
>  
>  	if (!ecc_en || !nb_mce_en)
>  		return false;
> @@ -3689,11 +3688,6 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  		return NULL;
>  	}
>  
> -	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
> -		     (pvt->fam == 0xf ?
> -				(pvt->ext_model >= K8_REV_F  ? "revF or later "
> -							     : "revE or earlier ")
> -				 : ""), pvt->mc_node_id);
>  	return fam_type;
>  }
>  
> @@ -3867,6 +3861,12 @@ static int probe_one_instance(unsigned int nid)
>  
>  	dump_misc_regs(pvt);
>  
> +	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
> +		     (pvt->fam == 0xf ?
> +				(pvt->ext_model >= K8_REV_F  ? "revF or later "
> +							     : "revE or earlier ")
> +				 : ""), pvt->mc_node_id);
> +
>  	return ret;
>  
>  err_enable:
> 
> --

I like it. I tested it out on one of my server systems, and it seems to
work well.

Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
