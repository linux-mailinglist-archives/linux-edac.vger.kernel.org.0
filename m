Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6363F31ED
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhHTRDO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 13:03:14 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:38010
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233455AbhHTRDK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 13:03:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGDUx4ca21Fl6m4V6CqtHfD8saDIs1izU0/fFcrq4pZKu+vHjmnICGcu/fYS/RVaKIfxsf5eTEH0qcM1BUflK+K+FQgmlePkSgbv2WO3eMIWuETPWXAuCaVSS1tAN7/qmiNJzc1P50GaoNJN03s7St0v7PdDNnbCQhCcEK5g1ARyQDLbq/T2xMX7mPnOpQTfc0mgspd28jokMUMPSLMR5D85HYp/3rDQoK1fP+u9rYgKfrQ6qtPU1qxdgd33WR9iDc6T+5ZFOW9reAT75MQvvTf7VRgjToaQar366L2cgmVWoYzeLJli3C0TvZh06D9IIDpaIYnQAAStd+f3j9Igfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib5ATR0eZqEhw9h+e3hYbsYNz+gsmVRCzEYMxOpYRUU=;
 b=gqR50uao4vob/mD6kCGojQMzBIlqF9GhlPVE85sKAJTHvnE0mdhj38i+bPsA2ewhrRs6ZECWx1Ooevj7KAtzOd+UMKUJdXAlXzmjGw37VUa2fqjJFc3GBxjmBpCA4KVx2kPifE4Efd0gCDuX6v6j4TM88zk+wH2jTiEM+ZUtNcZir8SUc0EweYWq8qZXUh/VCs7ayNqNN7VnwAulzPZ2czxBlrbViSvlcr2crRTs+pefxy997SH2fbwzFaIwfMJVDCsc4jxdQ4UsAnbPeyUL+DBVoWmRfMUB9okvx2jt6mJWdelxIY02cvfEL/cBaCJEGnZPbzz9zau/mMSzjsrHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib5ATR0eZqEhw9h+e3hYbsYNz+gsmVRCzEYMxOpYRUU=;
 b=LF8YATQAlNweDCnWXtKBCLbFhR63X7PWrOP9WTqFkWS6jNdD/KugaRgEhTKueVH7ojN0bRP1dqmAnOrP9yB5BQ5zqplRnqeeaH/nuzxqRKg6E15P5bMhxJXLbs3ErRjrn1y9IFUUPov+YxZq9iAEVOt9wwS9d5F075EIEqTSRvk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0146.namprd12.prod.outlook.com (2603:10b6:405:59::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 17:02:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59%3]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 17:02:29 +0000
Date:   Fri, 20 Aug 2021 17:02:14 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v2 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Message-ID: <YR/gFuvMYnqDb95u@yaz-ubuntu>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
 <20210806074350.114614-4-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806074350.114614-4-nchatrad@amd.com>
X-ClientProxiedBy: BN6PR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:404:f7::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ubuntu (165.204.25.250) by BN6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:404:f7::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 17:02:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2813394-0d1d-4a7c-438d-08d963fc4b56
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB014670DA417334E88CB54C11F8C19@BN6PR1201MB0146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VmBrINTkMHISMghz+pUlRbF4BVmu5jeX18luT21o9NORHZKEJMdzzyozX//lwajbLn30erKj1OkBEdR1jSaW7w/zKFQ1PMicR6B3GMAP03kejHVVlsAR18lxVRgDb9JCPiEBpN01Or6sHj8lcMyhZq09HI6RtOrfYAbeb8wTyN0/8ISHxXcMWYgFWck7wya3kumSFwACi9uyapUXSufsNIgabhkbKCESlw2fP3xvSuBR3r5e23mHi7AOnLbLkkWWx8xe2JKy3rXKgTeqOaFPr5QaDjMb3vNZkWCzNUCsF9O6Rc7lza+lynEZguEAXl+bty/BaNFJXyM4VUvUn0ABRHzFbf/9YLi0ZPGO9SPFUWyAdY88J5/CaAmOvGneuDe/aEHhnWZntd8Pjvrd/lzUFiD6zEppQFhGioeaZ/gbvJ3vws1DwLB/r1lSuBNg7KKgcbc4Z3RDhLWFfjvll3wJj6rndB4P/Qz7F/4Zmb/kS46AMJQjHBcyPjl6agz3cz7ZYWiAqTMbNyLFnvvw6rWkHLld4JCbNgQ0CR/AtzpmtbckpbGTKLZzIoBPquglj3/AYcWOdOjcmV7HeeLXtZENlcNpQPZ2amWnuldt+iGb7YrkTowDoX8OY7O3+4+8MBa/aNK6VWQYECa1Rc3VIKgd0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(66946007)(8936002)(66476007)(33716001)(66556008)(6666004)(26005)(8676002)(478600001)(9686003)(316002)(4326008)(86362001)(6496006)(186003)(83380400001)(2906002)(6636002)(30864003)(44832011)(5660300002)(38100700002)(55016002)(956004)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOIWJwO4UvDXKbJIDLjMexoPYOvNMHond9XFrGxLG9BdjN6STpfpgwAMl/RP?=
 =?us-ascii?Q?TiF6ux5TX85eCZtapkkCbM7D/GMMjne+TONWU0ZDHQI7ds7bWkrdLD7suocA?=
 =?us-ascii?Q?6Unq946ZzrfUJnUcMbce2swnrnZB4HmIy5ybnw0JMERcvKjSf3TByMup/qRL?=
 =?us-ascii?Q?khLia/Z6l4KXsbHdtKEfEMEbBqQmGxSjWdQSGAioPN8Mp/91OWPPEryslbv/?=
 =?us-ascii?Q?LdnthhxT8MR2MFFLoxmPTDs5CvnoKBSFq2DYAkPCG7qE8jqY3TXysoC1hyCR?=
 =?us-ascii?Q?OjkVjaRQrM2kmYqrZ/ZA1hblSzhOQOQCUa3DWQxcthhr7Hc5zXChjfeQilg7?=
 =?us-ascii?Q?kfDIyrtNHuAs8rOMUR89bC1sJ8b2+nrjzF5eUZ0tE4c0B6SDC2YTHxC/ouvX?=
 =?us-ascii?Q?NNmiYzydqhKrWaosJxZs3lvs6spznhOWj+qVZ2VHjERlQwqeM9VPWOZU+ylK?=
 =?us-ascii?Q?egTDJ5shqxAvySgRPqSajBUHu9HxNRi8uyNUuNG2PxdAI31OFWH4s4Ybq7NY?=
 =?us-ascii?Q?Pdhx3b/oLwB3moIdec+k7Tyxra9PLiv1d37siorHRk63WR4ygELsoNezULYg?=
 =?us-ascii?Q?NhT597YTf+l/F7I371F5GitWueOeNcrONHU6Xt6vA3x9ITKrnQ+aCGr4ryRm?=
 =?us-ascii?Q?T1mWZayHpjAzyxJFpwN1haPW5HYzxUJFOjw/JPma9VFHsOLC0+lstQwS6BkX?=
 =?us-ascii?Q?QlhM62LgdzBHviYr/AAPNK9olX9ttjyW0OtNAEFT76qMeQBDYhCZVw4UERaw?=
 =?us-ascii?Q?XoTL+iejipMH25g9VpNSKWfcGcUQyKHY1NCRhLwH+6ofC7C95l1KnTOgwPHb?=
 =?us-ascii?Q?MEFuyW9SZkX6Wq7kACIbHWM3ADPbcuTN4LDmZGRYEJMTypL8Gjgb/Lkg5dbZ?=
 =?us-ascii?Q?AnzXObLJZzWtMpbhK7DQORxKidKJ/rgYKf4g+K50xnDizSa0IRWfeciD7d46?=
 =?us-ascii?Q?hhdpZvv2ahSx44etUPos4T9sHA7YkAecT36zLdBbYO/MPZg1EDUb1GSWlK8X?=
 =?us-ascii?Q?ae15EmOUo/XXDpcXZiaD85yHVF0ARTyditpr4VOpuQlOaqS1RtElk/66d46/?=
 =?us-ascii?Q?PftZJiFRxlzbJ1AdwrAu3qZr7ybp/hKXdpvkRtruhwzVI/nn/9lARlisPl2r?=
 =?us-ascii?Q?UZbXhoFfBw5MWgqUQhTXFTZwhbd1/ZyubNAMn8gToa6tqwvJm5uRCzqZwjrX?=
 =?us-ascii?Q?6nUg1NdUtVC2N85MqeIonwnrKybUZsuJf55SvU9QP6jcsQtRMrNxysYYO2OZ?=
 =?us-ascii?Q?W99qVoA+4vGPTnenFYq7pURW1yEd+2FQN2k0WNKbmuBNNs2ytV2JBEoqweTt?=
 =?us-ascii?Q?UcS5NIUkk3PvIG0TFZMQtHL7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2813394-0d1d-4a7c-438d-08d963fc4b56
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 17:02:29.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaeSq25ZFhw1EeKwxTvm2qizj6qdG9cWiB80BfnMJnaj4s8CTNeB66LsbVYPFsjXi3VA/ReQuDYa+tfrK+GMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0146
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 06, 2021 at 01:13:50PM +0530, Naveen Krishna Chatradhi wrote:
> On newer heterogeneous systems from AMD with GPU nodes interfaced
> with HBM2 memory are connected to the CPUs via custom links.
>

This sentence is not clear to me.
 
> This patch modifies the amd64_edac module to handle the HBM memory
> enumeration leveraging the existing edac and the amd64 specific data
> structures.
> 
> This patch does the following for non-cpu nodes:
> 1. Define PCI IDs and ops for Aldeberarn GPUs in family_types array.
> 2. The UMC Phys on GPU nodes are enumerated as csrows and the UMC channels
>    connected to HBMs are enumerated as ranks.
> 3. Define a function to find the UMCv2 channel number
> 4. Define a function to calculate base address of the UMCv2 registers
> 5. Add debug information for UMCv2 channel registers.
>

I don't think you need to say "This patch does..." and give a list. Just
write each point as a line in the commit message.
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> Changes since v1:
> 1. Modifed the commit message
> 2. Change the edac_cap
> 3. kept sizes of both cpu and noncpu together
> 4. return success if the !F3 condition true and remove unnecessary validation
> 5. declared is_noncpu as bool
> 6. modified the condition from channel/4 to channel>=4
> 7. Rearranged debug information for noncpu umcch registers
> 
>  drivers/edac/amd64_edac.c | 202 +++++++++++++++++++++++++++++++++-----
>  drivers/edac/amd64_edac.h |  27 +++++
>  2 files changed, 202 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index b03c33240238..2dd77a828394 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1979,6 +1979,9 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
>  
>  		if (umc_en_mask == dimm_ecc_en_mask)
>  			edac_cap = EDAC_FLAG_SECDED;
> +
> +		if (pvt->is_noncpu)
> +			edac_cap = EDAC_FLAG_SECDED;
>  	} else {
>  		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
>  			? 19
> @@ -2037,6 +2040,9 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>  {
>  	int cs_mode = 0;
>  
> +	if (pvt->is_noncpu)
> +		return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
> +
>  	if (csrow_enabled(2 * dimm, ctrl, pvt))
>  		cs_mode |= CS_EVEN_PRIMARY;
>  
> @@ -2056,6 +2062,15 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
>  
>  	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
>  
> +	if (pvt->is_noncpu) {
> +		cs_mode = f17_get_cs_mode(cs0, ctrl, pvt);
> +		for_each_chip_select(cs0, ctrl, pvt) {
> +			size0 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
> +			amd64_info(EDAC_MC ": %d: %5dMB\n", cs0, size0);
> +		}
> +		return;
> +	}
> +
>  	for (dimm = 0; dimm < 2; dimm++) {
>  		cs0 = dimm * 2;
>  		cs1 = dimm * 2 + 1;
> @@ -2080,10 +2095,15 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  		umc_base = get_umc_base(i);
>  		umc = &pvt->umc[i];
>  
> -		edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
> +		if (!pvt->is_noncpu)
> +			edac_dbg(1, "UMC%d DIMM cfg: 0x%x\n", i, umc->dimm_cfg);
>  		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
>  		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
>  		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
> +		if (pvt->is_noncpu) {
> +			edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
> +			goto dimm_size;
> +		}
>  
>  		amd_smn_read(pvt->mc_node_id, umc_base + UMCCH_ECC_BAD_SYMBOL, &tmp);
>  		edac_dbg(1, "UMC%d ECC bad symbol: 0x%x\n", i, tmp);
> @@ -2108,6 +2128,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  					i, 1 << ((tmp >> 4) & 0x3));
>  		}
>  
> + dimm_size:
>  		debug_display_dimm_sizes_df(pvt, i);
>  	}
>  
> @@ -2175,10 +2196,14 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
>  		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
>  	} else if (pvt->fam >= 0x17) {
>  		int umc;
> -

This looks like a stray change. Was it intentional?

>  		for_each_umc(umc) {
> -			pvt->csels[umc].b_cnt = 4;
> -			pvt->csels[umc].m_cnt = 2;
> +			if (pvt->is_noncpu) {
> +				pvt->csels[umc].b_cnt = 8;
> +				pvt->csels[umc].m_cnt = 8;
> +			} else {
> +				pvt->csels[umc].b_cnt = 4;
> +				pvt->csels[umc].m_cnt = 2;
> +			}
>  		}
>  
>  	} else {
> @@ -2187,6 +2212,31 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
>  	}
>  }
>  
> +static void read_noncpu_umc_base_mask(struct amd64_pvt *pvt)
> +{
> +	u32 base_reg, mask_reg;
> +	u32 *base, *mask;
> +	int umc, cs;
> +
> +	for_each_umc(umc) {
> +		for_each_chip_select(cs, umc, pvt) {
> +			base_reg = get_noncpu_umc_base(umc, cs) + UMCCH_BASE_ADDR;
> +			base = &pvt->csels[umc].csbases[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, base_reg, base))
> +				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
> +					 umc, cs, *base, base_reg);
> +

There should be {} here since the code spans multiple lines.

> +			mask_reg = get_noncpu_umc_base(umc, cs) + UMCCH_ADDR_MASK;
> +			mask = &pvt->csels[umc].csmasks[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask))
> +				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
> +					 umc, cs, *mask, mask_reg);

Same as above.

> +		}
> +	}
> +}
> +
>  static void read_umc_base_mask(struct amd64_pvt *pvt)
>  {
>  	u32 umc_base_reg, umc_base_reg_sec;
> @@ -2247,8 +2297,12 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>  
>  	prep_chip_selects(pvt);
>  
> -	if (pvt->umc)
> -		return read_umc_base_mask(pvt);
> +	if (pvt->umc) {
> +		if (pvt->is_noncpu)
> +			return read_noncpu_umc_base_mask(pvt);
> +		else
> +			return read_umc_base_mask(pvt);
> +	}
>  
>  	for_each_chip_select(cs, 0, pvt) {
>  		int reg0   = DCSB0 + (cs * 4);
> @@ -2294,6 +2348,10 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>  	u32 dram_ctrl, dcsm;
>  
>  	if (pvt->umc) {
> +		if (pvt->is_noncpu) {
> +			pvt->dram_type = MEM_HBM2;
> +			return;
> +		}

Needs a newline here.

>  		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
>  			pvt->dram_type = MEM_LRDDR4;
>  		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> @@ -2683,7 +2741,10 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
>  
>  	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
>  	for_each_umc(i)
> -		channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
> +		if (pvt->is_noncpu)
> +			channels += pvt->csels[i].b_cnt;
> +		else
> +			channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
>  
>  	amd64_info("MCT channel count: %d\n", channels);
>  
> @@ -2824,6 +2885,12 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	u32 msb, weight, num_zero_bits;
>  	int dimm, size = 0;
>  
> +	if (pvt->is_noncpu) {
> +		addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
> +		/* The memory channels in case of GPUs are fully populated */
> +		goto skip_noncpu;
> +	}
> +
>  	/* No Chip Selects are enabled. */
>  	if (!cs_mode)
>  		return size;
> @@ -2849,6 +2916,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	else
>  		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
>  
> + skip_noncpu:
>  	/*
>  	 * The number of zero bits in the mask is equal to the number of bits
>  	 * in a full mask minus the number of bits in the current mask.
> @@ -3594,6 +3662,16 @@ static struct amd64_family_type family_types[] = {
>  			.dbam_to_cs		= f17_addr_mask_to_cs_size,
>  		}
>  	},
> +	[ALDEBARAN_GPUS] = {
> +		.ctl_name = "ALDEBARAN",
> +		.f0_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0,
> +		.f6_id = PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6,
> +		.max_mcs = 4,
> +		.ops = {
> +			.early_channel_count	= f17_early_channel_count,
> +			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> +		}
> +	},
>  };
>  
>  /*
> @@ -3849,6 +3927,19 @@ static int find_umc_channel(struct mce *m)
>  	return (m->ipid & GENMASK(31, 0)) >> 20;
>  }
>  
> +/*
> + * The HBM memory managed by the UMCCH of the noncpu node
> + * can be calculated based on the [15:12]bits of IPID as follows

This comment doesn't make sense to me.

Maybe it'll help to give some more context. The CPUs have one channel
per UMC, so a UMC number is equivalent to a channel number. The GPUs
have 8 channels per UMC, so the UMC number no longer works as a channel
number. The channel number within a GPU UMC is given in MCA_IPID[15:12].
However, the IDs are split such that two UMC values go to one UMC, and
the channel numbers are split in two groups of four.

For example,
UMC0 CH[3:0] = 0x0005[3:0]000
UMC0 CH[7:4] = 0x0015[3:0]000
UMC1 CH[3:0] = 0x0025[3:0]000
UMC1 CH[7:4] = 0x0035[3:0]000

> + */
> +static int find_umc_channel_noncpu(struct mce *m)
> +{
> +	u8 umc, ch;
> +
> +	umc = find_umc_channel(m);
> +	ch = ((m->ipid >> 12) & 0xf);

Each of these can be on a single line when declared above.

Also, please leave a newline before the return.

> +	return umc % 2 ? (ch + 4) : ch;
> +}
> +
>  static void decode_umc_error(int node_id, struct mce *m)
>  {
>  	u8 ecc_type = (m->status >> 45) & 0x3;
> @@ -3856,6 +3947,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	struct amd64_pvt *pvt;
>  	struct err_info err;
>  	u64 sys_addr = m->addr;
> +	u8 umc_num;
>  
>  	mci = edac_mc_find(node_id);
>  	if (!mci)
> @@ -3868,7 +3960,17 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	if (m->status & MCI_STATUS_DEFERRED)
>  		ecc_type = 3;
>  
> -	err.channel = find_umc_channel(m);
> +	if (pvt->is_noncpu) {
> +		/* The UMCPHY is reported as csrow in case of noncpu nodes */
> +		err.csrow = find_umc_channel(m) / 2;
> +		/* UMCCH is managing the HBM memory */
> +		err.channel = find_umc_channel_noncpu(m);

I don't think "UMCPHY" or "UMCCH" a clear here. Like above, more context
should help. The GPUs have one Chip Select per UMC, so the UMC number can
be used as the Chip Select number. However, the UMC number is split in
the ID value as mentioned above, so that's why it's necessary to divide
by 2.

> +		umc_num = err.csrow * 8 + err.channel;

Now here "umc_num" is getting overloaded. The value in this line is not
"N" in UMCN, e.g. UMC0, UMC1, etc. It's an artificial value we construct
to have a global (within a GPU node) ID for each GPU memory channel.

This is used as the "DF Instance ID" input to the address translation
code. On CPUs this is "Channel"="UMC Number"="DF Instance ID". On GPUs,
this value is calculated according to the line above.

So I think "umc_num" should be renamed to something like "df_inst_id" to
be more explicit.

> +	} else {
> +		err.channel = find_umc_channel(m);
> +		err.csrow = m->synd & 0x7;
> +		umc_num = err.channel;
> +	}
>  
>  	if (!(m->status & MCI_STATUS_SYNDV)) {
>  		err.err_code = ERR_SYND;
> @@ -3884,9 +3986,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  			err.err_code = ERR_CHANNEL;
>  	}
>  
> -	err.csrow = m->synd & 0x7;
> -
> -	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, err.channel)) {
> +	if (umc_normaddr_to_sysaddr(&sys_addr, pvt->mc_node_id, umc_num)) {
>  		err.err_code = ERR_NORM_ADDR;
>  		goto log_error;
>  	}
> @@ -4013,15 +4113,20 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>  
>  	/* Read registers from each UMC */
>  	for_each_umc(i) {
> +		if (pvt->is_noncpu)
> +			umc_base = get_noncpu_umc_base(i, 0);
> +		else
> +			umc_base = get_umc_base(i);
>  
> -		umc_base = get_umc_base(i);
>  		umc = &pvt->umc[i];
> -

Another spurious line deletion?

> -		amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
>  		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
>  		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
>  		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
> -		amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
> +
> +		if (!pvt->is_noncpu) {
> +			amd_smn_read(nid, umc_base + UMCCH_DIMM_CFG, &umc->dimm_cfg);
> +			amd_smn_read(nid, umc_base + UMCCH_UMC_CAP_HI, &umc->umc_cap_hi);
> +		}
>  	}
>  }
>  
> @@ -4103,7 +4208,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  	determine_memory_type(pvt);
>  	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
>  
> -	determine_ecc_sym_sz(pvt);
> +	/* ECC symbol size is not available on NONCPU nodes */
> +	if (!pvt->is_noncpu)
> +		determine_ecc_sym_sz(pvt);
>  }
>  
>  /*
> @@ -4191,15 +4298,21 @@ static int init_csrows_df(struct mem_ctl_info *mci)
>  				continue;
>  
>  			empty = 0;
> -			dimm = mci->csrows[cs]->channels[umc]->dimm;
> +			if (pvt->is_noncpu) {
> +				dimm = mci->csrows[umc]->channels[cs]->dimm;
> +				dimm->edac_mode = EDAC_SECDED;
> +				dimm->dtype = DEV_X16;
> +			} else {
> +				dimm = mci->csrows[cs]->channels[umc]->dimm;
> +				dimm->edac_mode = edac_mode;
> +				dimm->dtype = dev_type;
> +			}
>  
>  			edac_dbg(1, "MC node: %d, csrow: %d\n",
>  					pvt->mc_node_id, cs);
>  
>  			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
>  			dimm->mtype = pvt->dram_type;
> -			dimm->edac_mode = edac_mode;
> -			dimm->dtype = dev_type;
>  			dimm->grain = 64;
>  		}
>  	}
> @@ -4464,7 +4577,9 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
>  
>  			umc_en_mask |= BIT(i);
>  
> -			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
> +			/* ECC is enabled by default on NONCPU nodes */
> +			if (pvt->is_noncpu ||

Can you skip all the bitmask stuff and just say "ecc_en=true" if on a
non-CPU node?

> +			    (umc->umc_cap_hi & UMC_ECC_ENABLED))
>  				ecc_en_mask |= BIT(i);
>  		}
>  
> @@ -4500,6 +4615,11 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
>  {
>  	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
>  
> +	if (pvt->is_noncpu) {
> +		mci->edac_ctl_cap |= EDAC_SECDED;
> +		return;
> +	}
> +
>  	for_each_umc(i) {
>  		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
>  			ecc_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
> @@ -4530,7 +4650,11 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
>  {
>  	struct amd64_pvt *pvt = mci->pvt_info;
>  
> -	mci->mtype_cap		= MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
> +	if (pvt->is_noncpu)
> +		mci->mtype_cap = MEM_FLAG_HBM2;
> +	else
> +		mci->mtype_cap = MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
> +
>  	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
>  
>  	if (pvt->umc) {
> @@ -4635,11 +4759,24 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  			fam_type = &family_types[F17_M70H_CPUS];
>  			pvt->ops = &family_types[F17_M70H_CPUS].ops;
>  			fam_type->ctl_name = "F19h_M20h";
> -			break;
> +		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
> +			if (pvt->is_noncpu) {
> +				int tmp = pvt->mc_node_id - NONCPU_NODE_INDEX;
> +
> +				fam_type = &family_types[ALDEBARAN_GPUS];
> +				pvt->ops = &family_types[ALDEBARAN_GPUS].ops;
> +				sprintf(pvt->buf, "Aldebaran#%ddie#%d", tmp / 2, tmp % 2);
> +				fam_type->ctl_name = pvt->buf;

I like the idea of giving unique names for each "MC". Maybe this can be
used on the CPU nodes too? I'll check this out. Thanks for the idea.

> +			} else {
> +				fam_type = &family_types[F19_CPUS];
> +				pvt->ops = &family_types[F19_CPUS].ops;
> +				fam_type->ctl_name = "F19h_M30h";
> +			}
> +		} else {
> +			fam_type = &family_types[F19_CPUS];
> +			pvt->ops = &family_types[F19_CPUS].ops;
> +			family_types[F19_CPUS].ctl_name = "F19h";
>  		}
> -		fam_type	= &family_types[F19_CPUS];
> -		pvt->ops	= &family_types[F19_CPUS].ops;
> -		family_types[F19_CPUS].ctl_name = "F19h";
>  		break;
>  
>  	default:
> @@ -4707,9 +4844,10 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	if (pvt->channel_count < 0)
>  		return ret;
>  
> +	/* Define layers for CPU and NONCPU nodes */
>  	ret = -ENOMEM;
>  	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> -	layers[0].size = pvt->csels[0].b_cnt;
> +	layers[0].size = pvt->is_noncpu ? fam_type->max_mcs : pvt->csels[0].b_cnt;
>  	layers[0].is_virt_csrow = true;
>  	layers[1].type = EDAC_MC_LAYER_CHANNEL;
>  
> @@ -4718,7 +4856,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  	 * only one channel. Also, this simplifies handling later for the price
>  	 * of a couple of KBs tops.
>  	 */
> -	layers[1].size = fam_type->max_mcs;
> +	layers[1].size = pvt->is_noncpu ? pvt->csels[0].b_cnt : fam_type->max_mcs;
>  	layers[1].is_virt_csrow = false;
>  
>  	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
> @@ -4763,6 +4901,9 @@ static int probe_one_instance(unsigned int nid)
>  	struct ecc_settings *s;
>  	int ret;
>  
> +	if (!F3)
> +		return 0;
> +
>  	ret = -ENOMEM;
>  	s = kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
>  	if (!s)
> @@ -4774,6 +4915,9 @@ static int probe_one_instance(unsigned int nid)
>  	if (!pvt)
>  		goto err_settings;
>  
> +	if (nid >= NONCPU_NODE_INDEX)
> +		pvt->is_noncpu = true;
> +
>  	pvt->mc_node_id	= nid;
>  	pvt->F3 = F3;
>  
> @@ -4847,6 +4991,10 @@ static void remove_one_instance(unsigned int nid)
>  	struct mem_ctl_info *mci;
>  	struct amd64_pvt *pvt;
>  
> +	/* Nothing to remove for the space holder entries */
> +	if (!F3)
> +		return;
> +
>  	/* Remove from EDAC CORE tracking list */
>  	mci = edac_mc_del_mc(&F3->dev);
>  	if (!mci)
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 85aa820bc165..c5532a6f0c34 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -126,6 +126,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
>  #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
>  #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0	0x14D0
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6	0x14D6
>  
>  /*
>   * Function 1 - Address Map
> @@ -298,6 +300,7 @@ enum amd_families {
>  	F17_M60H_CPUS,
>  	F17_M70H_CPUS,
>  	F19_CPUS,
> +	ALDEBARAN_GPUS,
>  	NUM_FAMILIES,
>  };
>  
> @@ -389,6 +392,9 @@ struct amd64_pvt {
>  	enum mem_type dram_type;
>  
>  	struct amd64_umc *umc;	/* UMC registers */
> +	char buf[20];
> +
> +	bool is_noncpu;
>  };
>  
>  enum err_codes {
> @@ -410,6 +416,27 @@ struct err_info {
>  	u32 offset;
>  };
>  
> +static inline u32 get_noncpu_umc_base(u8 umc, u8 channel)
> +{
> +	/*
> +	 * On the NONCPU nodes, base address is calculated based on
> +	 * UMC channel and the HBM channel.
> +	 *
> +	 * UMC channels are selected in 6th nibble
> +	 * UMC chY[3:0]= [(chY*2 + 1) : (chY*2)]50000;
> +	 *
> +	 * HBM channels are selected in 3rd nibble
> +	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
> +	 * HBM chX[7:4]= [Y+1]5X[3:0]000

The wording in this comment is inaccurate. There is no "UMC channel" and
"HBM channel". There is only "channel". On CPUs, there is one channel
per UMC, so UMC numbering equals channel numbering. On GPUs, there are
eight channels per UMC, so the channel numbering is different from UMC
numbering.

The notes are good overall, so I think it'll help to reference this
comment in amd64_edac.c where appropriate.

> +	 */
> +	umc *= 2;
> +
> +	if (channel >= 4)
> +		umc++;
> +
> +	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
> +}
> +
>  static inline u32 get_umc_base(u8 channel)
>  {
>  	/* chY: 0xY50000 */
> -- 

Thanks,
Yazen
