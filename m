Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038442486A1
	for <lists+linux-edac@lfdr.de>; Tue, 18 Aug 2020 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHROCz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Aug 2020 10:02:55 -0400
Received: from mail-dm6nam08on2052.outbound.protection.outlook.com ([40.107.102.52]:28801
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbgHROCx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 Aug 2020 10:02:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSIEz0P/LE9/v0iSKaEaknLAZEBglawmT0SVCiB8K0+IgXEygiVpQfuEm7zkQZEsJtvbGisJhHkLhPxsVxT+VXB6uLt7z8damBp60i4kmpokCUMYwflw1j+3KJr+0CchoxQxKiZmq2PObakc9vn8Bg+Fs0k091p0XwtJ5EF8R3B6TBtKTccRsnsthHEHlyHIiGHk7QKQeDYAYWa10337ADmikcT9QGu78UZC4XhLS3ThEvMNMU/Omh1iaHKSsexJ7ZhTgGg+yS1P0CWCsb2lj5bbaB6OSUXtdyGnCKRy7eEi7fKTGjzMwjOgle6epxjORvazV3MNLzocc8HOh18RZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BiT3dLTvzHzZLK1PEe3wxLJOM3gnIwIv+Zjxd/lm4=;
 b=T4VJb//jOp7NkTSAOmUnajsbQbrMPLsg/YC4zzEL4JFjV/FEIgvpmtKZtID1TySnEprgxuAWdnEj8zIeP+bOQQrManCpY6nz4N47mpXOA1ZVLRL9UP0RJ1MKqYovF/POkeVgJsvU9i3AQTqwCspWKWUq2Ut0XGDGNilx/5z0DL2Gpjm+1da7mlak1sy7u++YF3V2F/7LPPZCEW+Ztaigab4tpHKVbs46Xfcu+/vix5xjPH6dKlcsa6alahPJuceT1caBQUTQZhzY84KB+aNllAL70q9NBiyqGJSFgHNyfHHY5TBG1LJs9d1FmHPOECtRRmgeAVgRI5SwFemXGxFjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BiT3dLTvzHzZLK1PEe3wxLJOM3gnIwIv+Zjxd/lm4=;
 b=2b8j/RcKVh2m52frVr1bx/prA7gKAsAxi21axh5K+9fOJXECfr6OlL+dHrYSwLYijBhxwtlb2QfrakMX2BViq/Fd/6IF6q5Z5ghAATD2d9p6LdCV2uSEXTn5AZUumrmnUSEKitNetzkP3Bf0K3fNy0dSSluF1Sn+UGBnYqzS5zQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Tue, 18 Aug
 2020 14:02:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.024; Tue, 18 Aug 2020
 14:02:50 +0000
Date:   Tue, 18 Aug 2020 09:02:37 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 2/2] x86/MCE/AMD Support new memory interleaving schemes
 during address translation
Message-ID: <20200818140237.GA2670997@yaz-nikka.amd.com>
References: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
 <20200814191449.183998-3-Yazen.Ghannam@amd.com>
 <20200815091336.GB2444151@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815091336.GB2444151@gmail.com>
X-ClientProxiedBy: DM6PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:5:bc::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13 via Frontend Transport; Tue, 18 Aug 2020 14:02:49 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6cf0a3c-14eb-45e2-715a-08d8437f64c6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB31720D4BF4383F4DB58CD87CF85C0@BN8PR12MB3172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqVNWGz4s/SDSi3eiThdfbaQO0+DN86dfl0bxAzmJL+neo5dyksff5/omxUD/IDnyALM3q4oN6AcWGqWnU+YZ9iXuS6DaoAwPOFk06o9nHuzSrzX0Kq+YwMSOJsF+FE/r3uJ45Ty/lRAxCUaAf7CaCyeEqPKuzmoEgGdS/ZEmPvVRHAjDGQ5IgoCG0eo6XBMA9cpsQlCyKlB9yRdACoHYMz83VeExyHJjt0MW+/qHr92EjbY4gKBZy9LBetIJSUP6kcc/ZIA5i84w8CpRK6TrUBewaGSlUhaWUn0vhy42Z8YW/s/FQ5WhzWfcnJ8bSW0lVm+1MTxvluz5N5UXIPivw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(6666004)(478600001)(83380400001)(86362001)(26005)(52116002)(1076003)(956004)(7696005)(33656002)(4326008)(55016002)(44832011)(66556008)(66946007)(316002)(66476007)(6916009)(5660300002)(8936002)(186003)(2906002)(16526019)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Q5TXKBPDLwrw5BmlRkfVXUYxETZ9acA3T09pdg3XbL9CvZOzOeHdn+dH+sXLrS0AOoNQ1UHa+7nvY80YfYcC5b7rmT+RL0bH5lVF41eVzKBnDoHTju0SVrloTM1NBXK138ZsSa8k3BY9QENOzfmkxpUZVY5jrrxgQTbs8FwMQvSiJdH4WPj4IS3i9dUb0uqhMD/o3M/p9Xt54e/Bs6FUVSh7G4mkjp7Cii31+rzuQjBB68KxQKxwVZggoB2u4iwCOKZi+fytD79Dxw1GPgn0DmC3xEYsfxRgBIDpxg82cYUNn4BCd4c9Y0692p/qSajLnrxGhepYsS/99tna04SMVAGRQ599wmkRq+kcu0jira6Otgx++Mcir0ITJ4uo6Ap4IZQxJC322TKIYbX2HVlvAQgAMvqIRfgjaizTQbyymY5Lci3paXacQz6luEmQZUmEBUFXFHXE6jHyO41jv+YxJZaPIy0+Cai8qlRIVBmWHoGFoPwLzIfPiQt0wM4MGNGG/7MHxbdabs2lA2s78Vi0W6Ntj2AWlRXru4YE7Rv/MGuZeXVEGyxPdF/Ltig5BlzXFxx0+Xqb4HwR5mVRC+5TlVD6LK/VRJO1tPKp/Msry8nWRV1Ar8GkhCAzxSvZ5UKM0gCegkJp/GW96n6LtjMgDA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cf0a3c-14eb-45e2-715a-08d8437f64c6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 14:02:50.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwvZhEwLyVPlC0MkrFlxXRj71q2qL1jIbGoDEpJCUSZX+mlLL7MDfJlgJmGWg5ROLE2NTpQcEnsVrGXaMNJ+Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Aug 15, 2020 at 11:13:36AM +0200, Ingo Molnar wrote:
> 
> * Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> 
> > +     /* Read D18F1x208 (System Fabric ID Mask 0). */
> > +     if (amd_df_indirect_read(nid, 1, 0x208, umc, &tmp))
> > +             goto out_err;
> > +
> > +     /* Determine if system is a legacy Data Fabric type. */
> > +     legacy_df = !(tmp & 0xFF);
> 
> 1)
> 
> I see this pattern in a lot of places in the code, first the magic 
> constant 0x208 is explained a comment, then it is *repeated* and used 
> it in the code...
> 
> How about introducing an obviously named enum for it instead, which 
> would then be self-documenting, saving the comment and removing magic 
> numbers:
> 
> 	if (amd_df_indirect_read(nid, 1, AMD_REG_FAB_ID, umc, &reg_fab_id))
> 		goto out_err;
> 
> (The symbolic name should be something better, I just guessed 
> something quickly.)
> 
> Please clean this up in a separate patch, not part of the already 
> large patch that introduces a new feature.
>

Okay, will do.

> 2)
> 
> 'tmp & 0xFF' is some sort of fabric version ID value, with a value of 
> 0 denoting legacy (pre-Rome) systems, right?
> 
> How about making that explicit:
> 
> 	df_version = reg_fab_id & 0xFF;
> 
> I'm pretty sure such a version ID might come handy later on, should 
> there be quirks or new capabilities with the newer systems ...
> 

Not exactly. The register field is Read-as-Zero on legacy systems. The
versions are 2 and 3 where 2 is the "legacy" version. But I can make
this change.

For example:

	df_version = reg_fab_id & 0xFF ? 3 : 2;

> 
> >  			ret_addr -= hi_addr_offset;
> > @@ -728,23 +740,31 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
> >  	}
> >  
> >  	lgcy_mmio_hole_en = tmp & BIT(1);
> > -	intlv_num_chan	  = (tmp >> 4) & 0xF;
> > -	intlv_addr_sel	  = (tmp >> 8) & 0x7;
> > -	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
> >  
> > -	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
> > -	if (intlv_addr_sel > 3) {
> > -		pr_err("%s: Invalid interleave address select %d.\n",
> > -			__func__, intlv_addr_sel);
> > -		goto out_err;
> > +	if (legacy_df) {
> > +		intlv_num_chan	  = (tmp >> 4) & 0xF;
> > +		intlv_addr_sel	  = (tmp >> 8) & 0x7;
> > +	} else {
> > +		intlv_num_chan    = (tmp >> 2) & 0xF;
> > +		intlv_num_dies	  = (tmp >> 6) & 0x3;
> > +		intlv_num_sockets = (tmp >> 8) & 0x1;
> > +		intlv_addr_sel	  = (tmp >> 9) & 0x7;
> >  	}
> >  
> > +	dram_base_addr	  = (tmp & GENMASK_ULL(31, 12)) << 16;
> > +
> >  	/* Read D18F0x114 (DramLimitAddress). */
> >  	if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &tmp))
> >  		goto out_err;
> >  
> > -	intlv_num_sockets = (tmp >> 8) & 0x1;
> > -	intlv_num_dies	  = (tmp >> 10) & 0x3;
> > +	if (legacy_df) {
> > +		intlv_num_sockets = (tmp >> 8) & 0x1;
> > +		intlv_num_dies	  = (tmp >> 10) & 0x3;
> > +		dst_fabric_id	  = tmp & 0xFF;
> > +	} else {
> > +		dst_fabric_id	  = tmp & 0x3FF;
> > +	}
> > +
> >  	dram_limit_addr	  = ((tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
> 
> Could we please structure this code in a bit more readable fashion?
> 
> 1)
> 
> Such as not using the meaningless 'tmp' variable name to first read 
> out DramOffset, then DramLimitAddress?
> 

IIRC, the "tmp" variable come to be in the review for the patch which
added this function. There are a few places where the register name and
the value needed have the same or similar name. For example,
DramLimitAddress is the register name and also a field within the
register. So we'd have a reg_dram_limit_addr and val_dram_limit_addr.
The "tmp" variable removes the need for the "reg_" variable.

But I think this can be reworked so that the final variable name is
reused. The register value can read into the variable, extra fields can
be extracted from it, and the final value can be adjusted as needed.

> How about naming them a bit more obviously, and retrieving them in a 
> single step:
> 
>         if (amd_df_indirect_read(nid, 0, 0x1B4, umc, &reg_dram_off))
>                 goto out_err;
> 
>         /* Remove HiAddrOffset from normalized address, if enabled: */
>         if (reg_dram_off & BIT(0)) {
>                 u64 hi_addr_offset = (tmp & GENMASK_ULL(31, 20)) << 8;
> 
>                 if (norm_addr >= hi_addr_offset) {
>                         ret_addr -= hi_addr_offset;
>                         base = 1;
>                 }
>         }
> 
>         if (amd_df_indirect_read(nid, 0, 0x114 + (8 * base), umc, &reg_dram_lim))
>                 goto out_err;
> 
> ('reg' stands for register value - but 'val' would work too.)
> 
> Side note: why is the above code using BIT() and GENMASK_UUL() when 
> all the other and new code is using fixed masks? Use one of these 
> versions instead of a weird mix ...
> 

I'll clean this up. Also, there are a lot of places where bit fields are
extracted. I think this can be made into a macro.

> 2)
> 
> Then all the fabric version dependent logic could be consolidated 
> instead of being spread out:
> 
> 	if (df_version) {
> 		intlv_num_chan    = (reg_dram_off >>  2) & 0xF;
> 		intlv_num_dies    = (reg_dram_off >>  6) & 0x3;
> 		intlv_num_sockets = (reg_dram_off >>  8) & 0x1;
> 		intlv_addr_sel    = (reg_dram_off >>  9) & 0x7;
> 
> 		dst_fabric_id     = (reg_dram_lim >>  0) & 0x3FF;
> 	} else {
> 		intlv_num_chan    = (reg_dram_off >>  4) & 0xF;
> 		intlv_num_dies    = (reg_dram_lim >> 10) & 0x3;
> 		intlv_num_sockets = (reg_dram_lim >>  8) & 0x1;
> 		intlv_addr_sel    = (reg_dram_off >>  8) & 0x7;
> 
> 		dst_fabric_id     = (reg_dram_lim >>  0) & 0xFF;
> 	}
> 
> Also note a couple of more formatting & ordering edits I did to the 
> code, to improve the structure. My copy & paste job is untested 
> though.
> 

Okay.

> 3)
> 
> Notably, note how the new code on current systems is the first branch 
> - that's the most interesting code most of the time anyaway, legacy 
> systems being legacy.
> 

Understood.

> BTW., please do any such suggested code flow and structure clean-up 
> patches first in the series, then introduce the new logic, to make it 
> easier to verify.
>

Will do.

Thanks,
Yazen
