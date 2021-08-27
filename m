Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628BC3F9873
	for <lists+linux-edac@lfdr.de>; Fri, 27 Aug 2021 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245033AbhH0LbU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Aug 2021 07:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245022AbhH0LbR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Aug 2021 07:31:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF93C061757;
        Fri, 27 Aug 2021 04:30:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111700c1d95049050d293f.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:c1d9:5049:50d:293f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E46B1EC01FC;
        Fri, 27 Aug 2021 13:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630063821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mieD9AaupQiM3S7jcJtbERv6ODLu0SQudufqyxcRdXM=;
        b=fHMjTwlfOQCQ2dXvNijoozQ7Ruo7dTfsM6sSBPt2dTGkhV3ygsS5/5Isl//qdm2Rp3lZi9
        BNbpXOH2BBDNRKCHxFGGANjcSl/zTuNxcLEZ9ZKi9CtEYt7xa+fzp2e7SIlSj5Z2zvTO7o
        Cs7gAmZ9EmIrruqGmZ1v5BJTZsgEd+4=
Date:   Fri, 27 Aug 2021 13:30:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Yazen.Ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 3/3] EDAC/amd64: Enumerate memory on noncpu nodes
Message-ID: <YSjM8b9vvkmRew94@zn.tnic>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-4-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823185437.94417-4-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 24, 2021 at 12:24:37AM +0530, Naveen Krishna Chatradhi wrote:
> On newer heterogeneous systems the data fabrics of the CPUs and GPUs
> are connected directly via a custom links.
> 
> This patch modifies the amd64_edac module to handle the HBM memory
> enumeration leveraging the existing edac and the amd64 specific data
> structures.
> 
> Define PCI IDs and ops for Aldeberarn GPUs in family_types array.
> The UMC Phys on GPU nodes are enumerated as csrows and the UMC channels
> connected to HBMs are enumerated as ranks.
> Define a function to find the UMCv2 channel number.
> Define a function to calculate base address of the UMCv2 registers.
> ECC is enabled by default on HBM's.
> Adds debug information for UMCv2 channel registers.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

What is more, a commit message should not explain *what* the patch is
doing - that should be obvious from the diff itself. Rather, it should
concentrate more on the *why* it is doing it.

> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>

This SOB chain is wrong. It suggests Muralidhara is the author but his
 From: like in patch 1 is missing here.

> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Changes since v2:
> 1. Restored line deletions and handled minor comments
> 2. Modified commit message and some of the function comments
> 3. variable df_inst_id is introduced instead of umc_num
> 
>  drivers/edac/amd64_edac.c | 219 +++++++++++++++++++++++++++++++++-----
>  drivers/edac/amd64_edac.h |  28 +++++
>  2 files changed, 222 insertions(+), 25 deletions(-)

...

> @@ -1097,6 +1103,15 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
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

No, define a separate debug_display_dimm_sizes_gpu() and put all the
GPU-specific dumping in there instead of sprinkling them around the code
like that.

> +
>  	for (dimm = 0; dimm < 2; dimm++) {
>  		cs0 = dimm * 2;
>  		cs1 = dimm * 2 + 1;
> @@ -1121,10 +1136,15 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)

Ditto: __dump_misc_regs_gpu()

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

...

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
> +			if (!amd_smn_read(pvt->mc_node_id, base_reg, base)) {
> +				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
> +					 umc, cs, *base, base_reg);
> +			}
> +
> +			mask_reg = get_noncpu_umc_base(umc, cs) + UMCCH_ADDR_MASK;
> +			mask = &pvt->csels[umc].csmasks[cs];
> +
> +			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask)) {
> +				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
> +					 umc, cs, *mask, mask_reg);
> +			}
> +		}
> +	}
> +}

This code pretty-much duplicates what read_umc_base_mask() does - pls
add a common helper which is used by both CPU and GPU.

> +
>  static void read_umc_base_mask(struct amd64_pvt *pvt)
>  {
>  	u32 umc_base_reg, umc_base_reg_sec;
> @@ -1288,8 +1341,12 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
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
> @@ -1335,6 +1392,11 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>  	u32 dram_ctrl, dcsm;
>  
>  	if (pvt->umc) {
> +		if (pvt->is_noncpu) {
> +			pvt->dram_type = MEM_HBM2;
> +			return;
> +		}

I don't like this sprinkling of "if (pvt->is_noncpu)" everywhere,
at all. Please define a separate read_mc_regs_df() or so which
contains only the needed functionalty which you can carve out from
read_mc_regs().

> +
>  		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
>  			pvt->dram_type = MEM_LRDDR4;
>  		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> @@ -1724,7 +1786,10 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
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

No, a separate gpu_early_channel_count() is needed here. There's a
reason for those function pointers getting assigned depending on family.

> @@ -1865,6 +1930,12 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	u32 msb, weight, num_zero_bits;
>  	int dimm, size = 0;
>  
> +	if (pvt->is_noncpu) {
> +		addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
> +		/* The memory channels in case of GPUs are fully populated */
> +		goto skip_noncpu;
> +	}
> +

Ditto.

>  	/* No Chip Selects are enabled. */
>  	if (!cs_mode)
>  		return size;
> @@ -1890,6 +1961,7 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	else
>  		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
>  
> + skip_noncpu:
>  	/*
>  	 * The number of zero bits in the mask is equal to the number of bits
>  	 * in a full mask minus the number of bits in the current mask.
> @@ -2635,6 +2707,16 @@ static struct amd64_family_type family_types[] = {
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

Here you define those GPU-specific function pointers which you then call.

> @@ -2890,6 +2972,30 @@ static int find_umc_channel(struct mce *m)
>  	return (m->ipid & GENMASK(31, 0)) >> 20;
>  }
>  
> +/*
> + * The CPUs have one channel per UMC, So a UMC number is equivalent to a
> + * channel number. The NONCPUs have 8 channels per UMC, so the UMC number no
> + * longer works as a channel number.
> + * The channel number within a NONCPU UMC is given in MCA_IPID[15:12].
> + * However, the IDs are split such that two UMC values go to one UMC, and
> + * the channel numbers are split in two groups of four.
> + *
> + * Refer comment on get_noncpu_umc_base() from amd64_edac.h
> + *
> + * For example,
> + * UMC0 CH[3:0] = 0x0005[3:0]000
> + * UMC0 CH[7:4] = 0x0015[3:0]000
> + * UMC1 CH[3:0] = 0x0025[3:0]000
> + * UMC1 CH[7:4] = 0x0035[3:0]000
> + */
> +static int find_umc_channel_noncpu(struct mce *m)
> +{
> +	u8 umc = find_umc_channel(m);
> +	u8 ch = ((m->ipid >> 12) & 0xf);
> +
> +	return umc % 2 ? (ch + 4) : ch;
> +}
> +
>  static void decode_umc_error(int node_id, struct mce *m)
>  {
>  	u8 ecc_type = (m->status >> 45) & 0x3;
> @@ -2897,6 +3003,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	struct amd64_pvt *pvt;
>  	struct err_info err;
>  	u64 sys_addr;
> +	u8 df_inst_id;

You don't need that variable and can work with err.channel just fine.

>  	mci = edac_mc_find(node_id);
>  	if (!mci)
> @@ -2909,7 +3016,22 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	if (m->status & MCI_STATUS_DEFERRED)
>  		ecc_type = 3;
>  
> -	err.channel = find_umc_channel(m);
> +	if (pvt->is_noncpu) {
> +		/*
> +		 * The NONCPUs have one Chip Select per UMC, so the UMC number
> +		 * can used as the Chip Select number. However, the UMC number
> +		 * is split in the ID value so it's necessary to divide by 2.
> +		 */
> +		err.csrow = find_umc_channel(m) / 2;
> +		err.channel = find_umc_channel_noncpu(m);
> +		/* On NONCPUs, instance id is calculated as below. */
> +		df_inst_id = err.csrow * 8 + err.channel;

		err.channel += err.csrow * 8;

tadaaa!

> +	} else {
> +		/* On CPUs, "Channel"="UMC Number"="DF Instance ID". */
> +		err.channel = find_umc_channel(m);
> +		err.csrow = m->synd & 0x7;
> +		df_inst_id = err.channel;
> +	}
>  
>  	if (!(m->status & MCI_STATUS_SYNDV)) {
>  		err.err_code = ERR_SYND;
> @@ -2925,9 +3047,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  			err.err_code = ERR_CHANNEL;
>  	}
>  
> -	err.csrow = m->synd & 0x7;
> -
> -	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
> +	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, df_inst_id, &sys_addr)) {
>  		err.err_code = ERR_NORM_ADDR;
>  		goto log_error;
>  	}
> @@ -3054,15 +3174,21 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
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
>  
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
> @@ -3144,7 +3270,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
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
> @@ -3232,15 +3360,21 @@ static int init_csrows_df(struct mem_ctl_info *mci)

No, separate function: init_csrows_gpu()

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
> @@ -3505,7 +3639,9 @@ static bool ecc_enabled(struct amd64_pvt *pvt)
>  
>  			umc_en_mask |= BIT(i);
>  
> -			if (umc->umc_cap_hi & UMC_ECC_ENABLED)
> +			/* ECC is enabled by default on NONCPU nodes */
> +			if (pvt->is_noncpu ||
> +			    (umc->umc_cap_hi & UMC_ECC_ENABLED))
>  				ecc_en_mask |= BIT(i);

Separate function pls.

I guess you get the idea - you simply define a separate function for
the family you're adding support for instead of sprinkling if (bla)
everywhere.

If functionality is duplicated, you define a common helper.

Feel free to ask if something's unclear.

...

> @@ -3804,6 +3963,9 @@ static int probe_one_instance(unsigned int nid)
>  	struct ecc_settings *s;
>  	int ret;
>  
> +	if (!F3)
> +		return 0;
> +
>  	ret = -ENOMEM;
>  	s = kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
>  	if (!s)
> @@ -3815,6 +3977,9 @@ static int probe_one_instance(unsigned int nid)
>  	if (!pvt)
>  		goto err_settings;
>  
> +	if (nid >= NONCPU_NODE_INDEX)
> +		pvt->is_noncpu = true;

This is silly and error-prone. Proper detection should happen in
per_family_init() and there you should read out from the hardware
whether this is a GPU or a CPU node.

Then, you should put an enum type in amd64_family_type which has

 { FAM_TYPE_CPU, FAM_TYPE_GPU, ... }

etc and the places where you need to check whether it is CPU or a GPU,
test those types.

> +
>  	pvt->mc_node_id	= nid;
>  	pvt->F3 = F3;
>  
> @@ -3888,6 +4053,10 @@ static void remove_one_instance(unsigned int nid)
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
> index 85aa820bc165..0844f004c90b 100644
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

A 20 char buffer in every pvt structure just so that you can sprintf
into it when it is a GPU? Err, I don't think so.

You can do the same thing as with the CPUs - the same string for every
pvt instance.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
