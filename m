Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757062471E7
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbgHQSfd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 14:35:33 -0400
Received: from mail-eopbgr700047.outbound.protection.outlook.com ([40.107.70.47]:2729
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390320AbgHQSfT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Aug 2020 14:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx0Okg1vV8FOLAya++uNxovB63eD1dwxo0w6q09327i2MaimbCsDdc4OxDE1lZk7c5vck+9A4qJrAmyJOg5HJX0njQzzfkB4LybYzX+Hho+m32yEXNkcpSK32uZDo2PG3ns5yy/Vswy88OlRDv5OaeWp6tcHBXkd+dnSF9w1oRVipK0EIPkfPGKznQmKoiRv/D6z2xF8YbsThHZMFKRgbz2WEpwO+pwPI1por2Seq1Nor+coSNsrV0avC7dbmcG5fE4lFABCBTtAlWgU/GA7EW8Bprj2iNavbYqlNhPMwtpBZDnpxcosymzVxY75tWaLJyNOhMa0uHp7GtON61C4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G09ZnVi1G7c6Ho0oFbI14TEH+zc2lnl5h7VBw9CBjWw=;
 b=QVDJ4BEj2TvP6bo+7Zbh4Eg4Gt4ujLap1nXqaUU30QP9dJZPhE17vUe2Pa6esk4cSDhEJpmYqteLm4E+dgfgmf/f3fsL9/OIA4KF0hJIaU1vci07A3ld9TTKEY8J8thEyOQxQ26RMR6Ayb3xkC3nQWN/pV4JzTNWLm/784ec2oiao9B2cRxEQCJjEsEVevGIaIXkVrWvqP4on1Iwfz2afmMlx8B7trHSIsQL6+PwZq9rX7vcDfbOXfm6e3usiyr+b1rb9EXsL8ojOr6Mca9Jgp9h0zTl61gQPBnLHW6jPhxzSl+hIHHTH04rzXJUE+06bkMaFVAfS+iVcKlxDjHjnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G09ZnVi1G7c6Ho0oFbI14TEH+zc2lnl5h7VBw9CBjWw=;
 b=4ET3fsCp7Xc5G7OriJ0lADYsPKy8KFMhJSu3i7g9MnThHEDPlCFZLNZi36f6RvwCIQcIW51hovZzdkpvCDtGv7j3Q+bPhnYlyb84lqxpRmYN+ohhUKA+mvw6paLr4oAXTrThIcPPu31znKZVBlh5jlornjtBMuGaNrxct9/+6eM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Mon, 17 Aug
 2020 18:35:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.024; Mon, 17 Aug 2020
 18:35:16 +0000
Date:   Mon, 17 Aug 2020 13:35:05 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/2] x86/MCE/AMD, EDAC/mce_amd: Use AMD NodeId for
 Family17h+ DRAM Decode
Message-ID: <20200817183401.GA1304633@yaz-nikka.amd.com>
References: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
 <20200814191449.183998-2-Yazen.Ghannam@amd.com>
 <20200815084212.GA2444151@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815084212.GA2444151@gmail.com>
X-ClientProxiedBy: DM5PR06CA0074.namprd06.prod.outlook.com (2603:10b6:3:4::12)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by DM5PR06CA0074.namprd06.prod.outlook.com (2603:10b6:3:4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 18:35:15 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96b041ae-02c5-4651-7d13-08d842dc48f2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB118736D61604C8733E320D83F85F0@BN6PR12MB1187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlx4InTSPoR3+xdY1l2Jfbtem4v7pu1bUppfV8vyMGEzfCZRZfIr0TgoD2yRytlcb/C+FnajswVSSLVm0lu7gNZbd2zzM8HYWlzOvuL9FVlR2G4GuXt1WFhFNUpfTqO+A5hL1J8/pFe9Tt9CjymCrAq9V6oXLYxjRBvxsiPK2KLJDYJ2swjA8GOi73IZFaqSgnK3u4MGs/a2yuGXYK16GWypDzVpE/cXWeTFEgKn1Le72ox0mB7O0qcctBFTq8f2WtwdhPMNr9por30Up6Nyx9b8maNoesg6TSXLDELgffmBOvrRCxUMg+wg8EZp9vJkrvBCDB+csqAtGyEDKabB2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(186003)(16526019)(8676002)(8936002)(7696005)(52116002)(316002)(55016002)(26005)(66946007)(956004)(44832011)(86362001)(6666004)(1076003)(83380400001)(2906002)(4326008)(478600001)(33656002)(66476007)(66556008)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JC+qa4N5mdB7SkzS312Zt1xQIyj6E43kdYKUM2dEdXx3BtiTyXqEI898KliD2QfMy3Bf4cliHyRQ6P+3lX52KH7lDkXR7+EY/zIXqKdAA1QwFcE1wtKC7eR5NeAhFqC9uUFuqrgbBCIIZqC/dBVT9T8k3+G8U4bjKZJFnfN40HaToRSor1pGnloAjwf2tT3TEVqNCns0IolptVzvDedJq8cFDi4MaAP0Lafh6mTk8Nn9zpuXX90zIVr34Jx5pMSB7UHeqW19MV2YtAuron/RhmB11ChiIsWPGB3M+N5EAirceOG8X3PAfwyPc33qMldwjHinpqOgw2RjlwUG3GCYXg4wqj9JWqLtxPLlmcAEeyr48IllmXxLv5u4FH+jtkk2pbkIuzAImjYPyZ8lKEdKeZguwj/B2PaNyTzCUq+AfrI7FsNxyrGuPlCRxBmBZVgFeA9UsfujXWSfm93HHPmipJOOLihinuc0rsTeo+m+mwLqtwz/OXuVgQR7OAzsNK/8nWyvf5lsaJ4ZuQWgqWPg1nOAx6y5GlIe7flJNJeQf2MpD+8g5XnhjjFe5q6kRXooeTIqkoOLz2nSh+mVAlb+kNeXKlOVZCwS35/uiukZKR7R1kcycBhNwwKTL/FPYTw6obsTTS/AS73tuxqgfKsJpg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b041ae-02c5-4651-7d13-08d842dc48f2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 18:35:15.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZlp1sO8E4CBaEVj57O5uQijtGz6kAUP01WOc0g4xpjp2eOVcd1YlWky6Ow3utQ269GB2or+aZVBS4iEb2sTtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Aug 15, 2020 at 10:42:12AM +0200, Ingo Molnar wrote:
> 
> * Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> 
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
> > later systems. This function is used in amd64_edac_mod to do
> > system-specific decoding for DRAM ECC errors. The function takes a
> > "NodeId" as a parameter.
> > 
> > In AMD documentation, NodeId is used to identify a physical die in a
> > system. This can be used to identify a node in the AMD_NB code and also
> > it is used with umc_normaddr_to_sysaddr().
> > 
> > However, the input used for decode_dram_ecc() is currently the NUMA node
> > of a logical CPU. In the default configuration, the NUMA node and
> > physical die will be equivalent, so this doesn't have an impact. But the
> > NUMA node configuration can be adjusted with optional memory
> > interleaving schemes. This will cause the NUMA node enumeration to not
> > match the physical die enumeration. The mismatch will cause the address
> > translation function to fail or report incorrect results.
> > 
> > Save the "NodeId" as a percpu value during init in AMD MCE code. Export
> > a function to return the value which can be used from modules like
> > edac_mce_amd.
> > 
> > Fixes: fbe63acf62f5 ("EDAC, mce_amd: Use cpu_to_node() to find the node ID")
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/include/asm/mce.h    |  2 ++
> >  arch/x86/kernel/cpu/mce/amd.c | 11 +++++++++++
> >  drivers/edac/mce_amd.c        |  2 +-
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > index cf503824529c..92527cc9ed06 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -343,6 +343,8 @@ extern struct smca_bank smca_banks[MAX_NR_BANKS];
> >  extern const char *smca_get_long_name(enum smca_bank_types t);
> >  extern bool amd_mce_is_memory_error(struct mce *m);
> >  
> > +extern u8 amd_cpu_to_node(unsigned int cpu);
> > +
> >  extern int mce_threshold_create_device(unsigned int cpu);
> >  extern int mce_threshold_remove_device(unsigned int cpu);
> >  
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index 99be063fcb1b..524edf81e287 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -202,6 +202,9 @@ static DEFINE_PER_CPU(unsigned int, bank_map);
> >  /* Map of banks that have more than MCA_MISC0 available. */
> >  static DEFINE_PER_CPU(u32, smca_misc_banks_map);
> >  
> > +/* CPUID_Fn8000001E_ECX[NodeId] used to identify a physical node/die. */
> > +static DEFINE_PER_CPU(u8, node_id);
> > +
> >  static void amd_threshold_interrupt(void);
> >  static void amd_deferred_error_interrupt(void);
> >  
> > @@ -233,6 +236,12 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
> >  
> >  }
> >  
> > +u8 amd_cpu_to_node(unsigned int cpu)
> > +{
> > +	return per_cpu(node_id, cpu);
> > +}
> > +EXPORT_SYMBOL_GPL(amd_cpu_to_node);
> > +
> >  static void smca_configure(unsigned int bank, unsigned int cpu)
> >  {
> >  	unsigned int i, hwid_mcatype;
> > @@ -240,6 +249,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
> >  	u32 high, low;
> >  	u32 smca_config = MSR_AMD64_SMCA_MCx_CONFIG(bank);
> >  
> > +	this_cpu_write(node_id, cpuid_ecx(0x8000001e) & 0xFF);
> 
> So we already have this magic number used for a similar purpose, in 
> amd_get_topology():
> 
>                 cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
> 
>                 node_id  = ecx & 0xff;
>

Yes, that's right. I did have a patch that tried to leverage the
existing topology variables. But it wasn't working for all targeted
systems. So I thought to have something local to the AMD MCA code in
order to avoid messing with the topology code just for this feature.

> Firstly, could we please at least give 0x8000001e a proper symbolic 
> name, use it in hygon.c too (which AFAIK is derived from AMD anyway), 
> and then use it in these new patches?
> 

Sure, but all places that use a symbolic name for a CPUID leaf define it
locally. Should the same be done here? Or should there be common place
for all the defines like in <asm/cpufeatures.h> or maybe a new header
file?

> Secondly, why not stick node_id into struct cpuinfo_x86, where the MCA 
> code can then use it without having to introduce a new percpu data 
> structure?
> 

I think this would be the simplest approach. I can write it. Also, the
amd_get_nb_id() function could then be replaced with this.

> There's also the underlying assumption that there's only ever going to 
> be 256 nodes, which limitation I'm sure we'll hear about in a couple 
> of years as not being quite enough. ;-)
> 

Yeah, CPU topology seems very fractal-like. :)

> So less hardcoding and more generalizations please.
> 

Will do.

Thanks,
Yazen
