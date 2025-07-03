Return-Path: <linux-edac+bounces-4307-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2EAF7EE3
	for <lists+linux-edac@lfdr.de>; Thu,  3 Jul 2025 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D3416CCB4
	for <lists+linux-edac@lfdr.de>; Thu,  3 Jul 2025 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25A288C96;
	Thu,  3 Jul 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O6cynbqK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0D25A2AE;
	Thu,  3 Jul 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563902; cv=none; b=f9HPtksX8sjTTtVLPUF+RvfhG/el0IHmzathUODGkcQOOvbf+z1P0MmgDX9hfoSHpsa18pxhaRQLu0FzMZgmxpn88+8tdpMxPpBqL2Ik3nb7pw6E4PaNO8dmxF59+HmK/bbuICir2AIS6HWbQ+HwAd3aXMPOp/qGJ55P/KLmqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563902; c=relaxed/simple;
	bh=7j7b9LoT0Wl/DQtoKaazAvRtXWBaQcSxZ3vswhteke8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DULNhzyXdvD94hT1TFtapNpNwlviFL7hNPTAZY6uux1pQJp33sdXF+qYjGxnyWGYNCeRxkUpz7fjLgN4Beg6/Is6yJQqPDaUBUa5nVcTc8folMxGf13pEgusRCD86imKsHOLUpJTI3l2h7VhuN8kS5Ecl9YeH/JVGPhaKxtFnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O6cynbqK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0E19C40E0218;
	Thu,  3 Jul 2025 17:31:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6tU8hwDafprf; Thu,  3 Jul 2025 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751563885; bh=sOpKiGgTOOwvwZOumD6cNfiQkSlVJhafzqWxficYVJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6cynbqK8OdQiqozg/L2UQYI/JuqgEKtqj1JPmSdqugiGHoA4PhIWENBJQdbWgeob
	 8FI1TP62Wh7DbDi/uYOJQt79F3wUsSzxhBUuJosMcPL431zBaNlEH8O81igF+UIzuk
	 Bapiooa8/kiLk5Di5Bap/RmGniH/LT6Aa4/usOWDfpDjNTK6sDlY3daW4XRXK3b9qB
	 XoMTP5DWQjXbu+LMQWbc+I4T8ZEkLb6Nh4WWUvXdVHffyArdMIH5sSR+QRpSMaVBLK
	 bTWZNJ5+lewgdMneHY5+mwNg36mL7lN9tpaCQpPi33jagDqA6A9vcp28Qn+cOxdDjh
	 2BxthYjY2gWG5/Yr8CxTbK1lMpsH4vknJAoEclPeK8ZHUKrXcdcMHBWCsX+f80CeuR
	 337MQG8aDZ1NYiXaB/GG32G6h2JS7T88FBMTkZ2Xhl/liuzkRLBbtigOHd18JKCOPr
	 HIwgrj416a6czvi6KrCcsyONg8csAI9it+XoO8z1m09AOErOfZExFQ66Pb02N+hb47
	 tdu++eJBtnZkMK8sNUd5eBrWmLhuasykY2zLmq7ttiQus56gAa3Y6QYmPJ6bH4Y5sA
	 zeFlXcNxbhcBVfRVrEbmhFosw/G9Y1E/fjq1iklTZ7LICIDcM2zhgeCG8deRmoPFGG
	 ADuA2UnZZ80JYRnNQCCuAKhE=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCA4040E00DC;
	Thu,  3 Jul 2025 17:31:10 +0000 (UTC)
Date: Thu, 3 Jul 2025 19:31:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-edac@vger.kernel.org, git@amd.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v7 5/5] EDAC/VersalNET: Add support for error notification
Message-ID: <20250703173105.GLaGa-WQCESDNsqygm@fat_crate.local>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
 <20250529070017.7288-6-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529070017.7288-6-shubhrajyoti.datta@amd.com>

On Thu, May 29, 2025 at 12:30:17PM +0530, Shubhrajyoti Datta wrote:
> Hardware errors can corrupt the RAM or other system components, without
> detection it can lead to crashes and system failure, this driver helps in
> reporting of errors to user space, triggering corrective actions.

Kinda useless paragraph.

>  drivers/edac/Kconfig              |   11 +
>  drivers/edac/Makefile             |    1 +
>  drivers/edac/versalnet_edac.c     | 1108 +++++++++++++++++++++++++++++
>  include/linux/cdx/edac_cdx_pcol.h |   28 +

I'd need a MAINTAINERS entry for this driver so that you can get CCed on
fixes. And I'd need that email to be responsive and not stuff to disappear
into the void. If it does and no one cares for it, I don't have a problem with
removing this driver again from the tree.

> +/* Granularity of reported error in bytes */
> +#define DDRMC5_EDAC_ERR_GRAIN			1
> +#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_LEN	4
> +
> +#define DDRMC5_EDAC_MSG_SIZE			256
> +
> +#define DDRMC5_IRQ_CE_MASK			GENMASK(18, 15)
> +#define DDRMC5_IRQ_UE_MASK			GENMASK(14, 11)
> +
> +#define DDRMC5_RANK_1_MASK			GENMASK(11, 6)
> +#define MASK_24					GENMASK(29, 24)
> +#define MASK_0					GENMASK(5, 0)
> +
> +#define DDRMC5_LRANK_1_MASK			GENMASK(11, 6)
> +#define DDRMC5_LRANK_2_MASK			GENMASK(17, 12)
> +#define DDRMC5_BANK1_MASK			GENMASK(11, 6)
> +#define DDRMC5_GRP_0_MASK			GENMASK(17, 12)
> +#define DDRMC5_GRP_1_MASK			GENMASK(23, 18)
> +
> +#define ECCR_UE_CE_ADDR_HI_ROW_MASK		GENMASK(10, 0)
> +
> +#define DDRMC5_MAX_ROW_CNT			18
> +#define DDRMC5_MAX_COL_CNT			11
> +#define DDRMC5_MAX_RANK_CNT			2
> +#define DDRMC5_MAX_LRANK_CNT			4
> +#define DDRMC5_MAX_BANK_CNT			2
> +#define DDRMC5_MAX_GRP_CNT			3
> +
> +#define DDRMC5_REGHI_ROW			7
> +#define DDRMC5_EACHBIT				1
> +#define DDRMC5_ERR_TYPE_CE			0
> +#define DDRMC5_ERR_TYPE_UE			1
> +#define DDRMC5_HIGH_MEM_EN			BIT(20)
> +#define DDRMC5_MEM_MASK				GENMASK(19, 0)
> +#define DDRMC5_X16_BASE				256
> +#define DDRMC5_X16_ECC				32
> +#define DDRMC5_X16_SIZE				(DDRMC5_X16_BASE + DDRMC5_X16_ECC)
> +#define DDRMC5_X32_SIZE				576
> +#define DDRMC5_HIMEM_BASE			(256 * SZ_1M)
> +#define DDRMC5_ILC_HIMEM_EN			BIT(28)
> +#define DDRMC5_ILC_MEM				GENMASK(27, 0)
> +#define DDRMC5_INTERLEAVE_SEL			GENMASK(3, 0)
> +#define DDRMC5_BUS_WIDTH_MASK			GENMASK(19, 18)
> +#define DDRMC5_NUM_CHANS_MASK			BIT(17)
> +#define DDRMC5_RANK_MASK			GENMASK(15, 14)
> +#define DDRMC5_DWIDTH_MASK			GENMASK(5, 4)
> +
> +#define AMD_MIN_BUF_LEN				0x28
> +#define AMD_ERROR_LEVEL				2
> +#define AMD_ERRORID				3
> +#define TOTAL_ERR_LENGTH			5
> +#define AMD_MSG_ERR_OFFSET			8
> +#define AMD_MSG_ERR_LENGTH			9
> +#define AMD_ERR_DATA				10
> +#define MCDI_RESPONSE				0xFF
> +
> +#define ERR_NOTIFICATION_MAX			96
> +#define REG_MAX					152
> +#define ADEC_MAX				152
> +#define NUM_CONTROLLERS				8
> +#define REGS_PER_CONTROLLER			19
> +#define ADEC_NUM				19
> +#define MC_CMD_EDAC_GET_OVERALL_DDR_CONFIG	2
> +#define BUFFER_SZ				80
> +
> +#define XDDR5_BUS_WIDTH_64			0
> +#define XDDR5_BUS_WIDTH_32			1
> +#define XDDR5_BUS_WIDTH_16			2

For all those defines above:

 - remove the unused ones
 - remove "EDAC" from the name
 - shorten them

which will allow you to have shorter lines in general and vertical alignment
will be closer to the left.

> +
> +#define AMD_ERR				"[VERSAL_EDAC_ERR_ID: %d] Error type:"

This is not now this is done - see the edac_*_printk() macros in
drivers/edac/edac_mc.h. You could use them, extend them and so on. No need for
homegrown hackery.

> +/**
> + * struct ecc_error_info - ECC error log information.
> + * @burstpos:		Burst position.
> + * @lrank:		Logical Rank number.
> + * @rank:		Rank number.
> + * @group:		Group number.
> + * @bank:		Bank number.
> + * @col:		Column number.
> + * @row:		Row number.
> + * @rowhi:		Row number higher bits.
> + * @i:			ECC error info.

That's the combined vector of all the above bits - "ECC error info" is too
generic.

> + */
> +union ecc_error_info {
> +	struct {
> +		u32 burstpos:3;
> +		u32 lrank:4;
> +		u32 rank:2;
> +		u32 group:3;
> +		u32 bank:2;
> +		u32 col:11;
> +		u32 row:7;
> +		u32 rowhi;
> +	};
> +	u64 i;
> +} __packed;
> +
> +/**
> + * struct row_col_mapping - Row and column bit positions in ADEC(address decoder) registers.
> + * @row0:		Row0 bit position.
> + * @row1:		Row1 bit position.
> + * @row2:		Row2 bit position.
> + * @row3:		Row3 bit position.
> + * @row4:		Row4 bit position.
> + * @reserved:		Unused bits.
> + * @col1:		Column 1 bit position.
> + * @col2:		Column 2 bit position.
> + * @col3:		Column 3 bit position.
> + * @col4:		Column 4 bit position.
> + * @col5:		Column 5 bit position.
> + * @reservedcol:	Unused column bits.
> + * @i:			ADEC register info.
> + */

Simply:

/*
 * Row and column bit positions in ADEC (address decoder) registers.
 */

Please think what would be the most optimal comment content for readers: a lot
of repetitive und useless gunk or proper variable naming and comment *helping*
to explain what the struct is.

...

> +static bool get_ddr_info(u32 *error_data, struct mc_priv *priv)
> +{
> +	u32 reglo, reghi, parity, eccr0_val, eccr1_val, isr;
> +	struct ecc_status *p;
> +
> +	p = &priv->stat;
> +
> +	isr = error_data[ISR];
> +
> +	if (!(isr & (DDRMC5_IRQ_UE_MASK | DDRMC5_IRQ_CE_MASK)))
> +		return false;
> +
> +	eccr0_val = error_data[ECCR0_ERR_STATUS];
> +	eccr1_val = error_data[ECCR1_ERR_STATUS];
> +
> +	if (!eccr0_val && !eccr1_val)
> +		return false;
> +
> +	if (!eccr0_val)
> +		p->channel = 1;
> +	else
> +		p->channel = 0;
> +
> +	reglo = error_data[ECCR0_ADDR_LO];
> +	reghi = error_data[ECCR0_ADDR_HI];
> +	if ((isr & DDRMC5_IRQ_CE_MASK))

What are those double-brackets for?

> +		p->ceinfo[0].i = reglo | (u64)reghi << 32;
> +	else if ((isr & DDRMC5_IRQ_UE_MASK))

Ditto. Audit your whole driver pls.

> +		p->ueinfo[0].i = reglo | (u64)reghi << 32;
> +
> +	parity = error_data[ECCR0_PAR];
> +	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",

So you can shorten the second one only to "PARITY"?

> +		 reghi, reglo, parity);
> +
> +	reglo = error_data[ECCR1_ADDR_LO];
> +	reghi = error_data[ECCR1_ADDR_HI];
> +	if ((isr & DDRMC5_IRQ_CE_MASK))
> +		p->ceinfo[1].i = reglo | (u64)reghi << 32;
> +	else if ((isr & DDRMC5_IRQ_UE_MASK))
> +		p->ueinfo[1].i = reglo | (u64)reghi << 32;
> +
> +	parity = error_data[ECCR1_PAR];
> +	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",

Ditto.

> +		 reghi, reglo, parity);
> +
> +	return true;
> +}

...

> +/**
> + * handle_error - Handle Correctable and Uncorrectable errors.
> + * @priv:	DDR memory controller private instance data.
> + * @stat:	ECC status structure.
> + * @controller:	Controller number of the DDRMC5
> + * @error_data:	the DDRMC5 ADEC address decoder register data
> + *
> + * Handles ECC correctable and uncorrectable errors.
> + */
> +static void handle_error(struct mc_priv  *priv, struct ecc_status *stat,
> +			 int controller, int *error_data)
> +{
> +	struct mem_ctl_info *mci = priv->mci;
> +	union ecc_error_info pinf;
> +	unsigned long pa;
> +	phys_addr_t pfn;
> +	int err;
> +
> +	if (stat->error_type == DDRMC5_ERR_TYPE_CE) {
> +		pinf = stat->ceinfo[stat->channel];
> +		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 "Error type:%s Controller %d Addr at %lx\n",
> +			 "CE", controller, convert_to_physical(priv, pinf, controller, error_data));
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +				     1, 0, 0, 0, 0, 0, -1,
> +				     priv->message, "");
> +	}
> +
> +	if (stat->error_type == DDRMC5_ERR_TYPE_UE) {
> +		pinf = stat->ueinfo[stat->channel];
> +		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 "Error type:%s controller %d Addr at %lx\n",
> +			 "UE", controller, convert_to_physical(priv, pinf, controller, error_data));
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +				     1, 0, 0, 0, 0, 0, -1,
> +				     priv->message, "");
> +		pa = convert_to_physical(priv, pinf, controller, error_data);
> +		pfn = PHYS_PFN(pa);
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
> +			err = memory_failure(pfn, MF_ACTION_REQUIRED);
> +			if (err)
> +				edac_dbg(2, "In fail of memory_failure %d\n", err);

"memory_failure() error: %d"

> +			else
> +				edac_dbg(2, "Page at PA 0x%lx is hardware poisoned\n", pa);
> +		}
> +	}
> +}
> +
> +/**
> + * init_csrows - Initialize the csrow data.
> + * @mci:	EDAC memory controller instance.
> + *
> + * Initialize the chip select rows associated with the EDAC memory
> + * controller instance.
> + */
> +static void init_csrows(struct mem_ctl_info *mci)

Merge it into its only caller.

> +{
> +	struct mc_priv *priv = mci->pvt_info;
> +	struct csrow_info *csi;
> +	struct dimm_info *dimm;
> +	u32 row;
> +	int ch;
> +
> +	for (row = 0; row < mci->nr_csrows; row++) {
> +		csi = mci->csrows[row];
> +		for (ch = 0; ch < csi->nr_channels; ch++) {
> +			dimm = csi->channels[ch]->dimm;
> +			dimm->edac_mode = EDAC_SECDED;
> +			dimm->mtype = MEM_DDR5;
> +			dimm->grain = DDRMC5_EDAC_ERR_GRAIN;
> +			dimm->dtype = priv->dwidth;
> +		}
> +	}
> +}
> +
> +static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
> +{
> +	mci->pdev = &pdev->dev;
> +	platform_set_drvdata(pdev, mci);
> +
> +	/* Initialize controller capabilities and configuration */
> +	mci->mtype_cap = MEM_FLAG_DDR5;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_HW_SRC;
> +	mci->scrub_mode = SCRUB_NONE;
> +
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->ctl_name = "amd_ddr_controller";

"VersalNET DDR5 controller"

or something more specific.

> +	mci->dev_name = dev_name(&pdev->dev);
> +	mci->mod_name = "versalnet_edac";
> +
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	init_csrows(mci);
> +}
> +
> +#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
> +
> +static unsigned int amd_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
> +{
> +	return MCDI_RPC_TIMEOUT;
> +}
> +
> +static void amd_mcdi_request(struct cdx_mcdi *cdx,

No need for function prefixes of static functions. Audit your whole driver
pls.

> +			     const struct cdx_dword *hdr, size_t hdr_len,
> +			     const struct cdx_dword *sdu, size_t sdu_len)
> +{
> +	unsigned char *send_buf;

	void *send_buf;

> +	int ret;
> +
> +	send_buf = kzalloc(hdr_len + sdu_len, GFP_KERNEL);
> +	if (!send_buf)
> +		return;
> +
> +	memcpy(send_buf, hdr, hdr_len);
> +	memcpy(send_buf + hdr_len, sdu, sdu_len);
> +
> +	ret = rpmsg_send(cdx->ept, send_buf, hdr_len + sdu_len);
> +	if (ret)
> +		dev_err(&cdx->rpdev->dev, "Failed to send rpmsg data\n");

<---- newline here.

> +	kfree(send_buf);
> +}
> +
> +static const struct cdx_mcdi_ops mcdi_ops = {
> +	.mcdi_rpc_timeout = amd_mcdi_rpc_timeout,
> +	.mcdi_request = amd_mcdi_request,
> +};
> +
> +static void get_ddr_config(u32 index, u32 *buffer, struct cdx_mcdi *amd_mcdi)
> +{
> +	size_t outlen;
> +	int ret;
> +
> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_EDAC_GET_DDR_CONFIG_IN_LEN);
> +	MCDI_DECLARE_BUF(outbuf, BUFFER_SZ);
> +
> +	MCDI_SET_DWORD(inbuf, EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX, index);
> +
> +	ret = cdx_mcdi_rpc(amd_mcdi, MC_CMD_EDAC_GET_DDR_CONFIG, inbuf, sizeof(inbuf),
> +			   outbuf, sizeof(outbuf), &outlen);
> +	if (!ret)
> +		memcpy(buffer, MCDI_PTR(outbuf, EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES),

Those EDAC_GET* bla names are too long. Shorten pls.

> +		       (ADEC_NUM * 4));
> +}
> +
> +static void amd_setup_mcdi(struct mc_priv *mc_priv)
> +{
> +	struct cdx_mcdi *amd_mcdi;
> +	int ret, i;
> +
> +	amd_mcdi = kzalloc(sizeof(*amd_mcdi), GFP_KERNEL);
> +	if (!amd_mcdi)
> +		return;
> +
> +	amd_mcdi->mcdi_ops = &mcdi_ops;
> +	ret = cdx_mcdi_init(amd_mcdi);
> +	if (ret) {
> +		kfree(amd_mcdi);
> +		return;
> +	}
> +
> +	amd_mcdi->ept = mc_priv->ept;
> +	mc_priv->mcdi = amd_mcdi;

Where does that amd_mcdi get freed?

> +
> +	for (i = 0; i < NUM_CONTROLLERS; i++)
> +		get_ddr_config(i, &mc_priv->adec[ADEC_NUM * i], amd_mcdi);
> +}
> +
> +static const guid_t amd_versalnet_guid = GUID_INIT(0x82678888, 0xa556, 0x44f2,
> +						 0xb8, 0xb4, 0x45, 0x56, 0x2e,
> +						 0x8c, 0x5b, 0xec);
> +
> +static int amd_rpmsg_cb(struct rpmsg_device *rpdev, void *data,
> +			int len, void *priv, u32 src)
> +{
> +	struct mc_priv *mc_priv = dev_get_drvdata(&rpdev->dev);
> +	const guid_t *sec_type = &guid_null;
> +	u32 length, offset, error_id;
> +	u32 *result = (u32 *)data;
> +	struct ecc_status *p;
> +	int i, j, k, sec_sev;
> +	u32 *adec_data;
> +
> +	if (*(u8 *)data == MCDI_RESPONSE) {
> +		cdx_mcdi_process_cmd(mc_priv->mcdi, (struct cdx_dword *)data, len);
> +		return 0;
> +	}
> +
> +	sec_sev = result[AMD_ERROR_LEVEL];
> +	error_id = result[AMD_ERRORID];
> +	length = result[AMD_MSG_ERR_LENGTH];
> +	offset = result[AMD_MSG_ERR_OFFSET];
> +
> +	if (result[TOTAL_ERR_LENGTH] > length) {
> +		if (!mc_priv->part_len)
> +			mc_priv->part_len = length;
> +		else
> +			mc_priv->part_len += length;
> +		/*
> +		 * The data can come in 2 stretches. Construct the regs from 2
> +		 * messages the offset indicates the offset from which the data is to
> +		 * be taken
> +		 */
> +		for (i = 0 ; i < length; i++) {
> +			k = offset + i;
> +			j = AMD_ERR_DATA + i;
> +			mc_priv->regs[k] = result[j];
> +		}
> +		if (mc_priv->part_len < result[TOTAL_ERR_LENGTH])
> +			return 0;
> +		mc_priv->part_len = 0;
> +	}
> +
> +	mc_priv->error_id = error_id;
> +	mc_priv->error_level = result[AMD_ERROR_LEVEL];
> +
> +	switch (error_id) {
> +	/* GSW Non-Correctable error */

No need for those comments - the strings are already there.

> +	case 5:
> +		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 AMD_ERR "General Software Non-Correctable error", error_id);
> +		break;
> +	/* CFU error */
> +	case 6:
> +		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 AMD_ERR "CFU error", error_id);
> +		break;
> +	/* CFRAME error */
> +	case 7:
> +		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 AMD_ERR "CFRAME error", error_id);
> +		break;
> +	/* Microblaze correctable error */
> +	case 10:
> +		snprintf(mc_priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 AMD_ERR "DDRMC Microblaze Correctable ECC error", error_id);
> +		break;

...

> +static int amd_rpmsg_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_channel_info chinfo = {0};
					^^^^^^

Why clear it if you're initializing all its members below?

> +	struct mc_priv *pg;
> +
> +	pg = (struct mc_priv *)amd_rpmsg_id_table[0].driver_data;
> +	chinfo.src = RPMSG_ADDR_ANY;
> +	chinfo.dst = rpdev->dst;
> +	strscpy(chinfo.name, amd_rpmsg_id_table[0].name,
> +		strlen(amd_rpmsg_id_table[0].name));
> +
> +	pg->ept = rpmsg_create_ept(rpdev, amd_rpmsg_cb, NULL, chinfo);
> +	if (!pg->ept)
> +		return dev_err_probe(&rpdev->dev, -ENXIO,
> +			      "Failed to create ept for channel %s\n",
> +			      chinfo.name);
> +
> +	dev_set_drvdata(&rpdev->dev, pg);
> +	return 0;
> +}
> +
> +static void amd_rpmsg_remove(struct rpmsg_device *rpdev)
> +{
> +	struct mc_priv *mc_priv = dev_get_drvdata(&rpdev->dev);
> +
> +	rpmsg_destroy_ept(mc_priv->ept);
> +	dev_set_drvdata(&rpdev->dev, NULL);
> +}
> +
> +static struct rpmsg_driver amd_rpmsg_driver = {
> +	.drv.name = KBUILD_MODNAME,
> +	.probe = amd_rpmsg_probe,
> +	.remove = amd_rpmsg_remove,
> +	.callback = amd_rpmsg_cb,
> +	.id_table = amd_rpmsg_id_table,
> +};
> +
> +/**
> + * get_dwidth - Return the controller memory width.
> + * @width:	data width read from the config reg.
> + *
> + * Get the EDAC device type width appropriate for the controller
> + * configuration.
> + *
> + * Return: a device type width enumeration.
> + */
> +static enum dev_type get_dwidth(u32 width)

Merge it into its single caller.

> +{
> +	enum dev_type dt;
> +
> +	switch (width) {
> +	case XDDR5_BUS_WIDTH_16:
> +		dt = DEV_X16;
> +		break;
> +	case XDDR5_BUS_WIDTH_32:
> +		dt = DEV_X32;
> +		break;
> +	case XDDR5_BUS_WIDTH_64:
> +		dt = DEV_X64;
> +		break;
> +	default:
> +		dt = DEV_UNKNOWN;
> +	}
> +
> +	return dt;
> +}
> +
> +static int mc_probe(struct platform_device *pdev)
> +{
> +	u32 num_chans, rank, dwidth, config;
> +	struct device_node *r5_core_node;
> +	struct edac_mc_layer layers[2];
> +	struct mem_ctl_info *mci;
> +	struct mc_priv *priv;
> +	struct rproc *rp;
> +	enum dev_type dt;
> +	int rc, i;
> +
> +	r5_core_node = of_parse_phandle(pdev->dev.of_node, "amd,rproc", 0);
> +	if (!r5_core_node) {
> +		dev_err(&pdev->dev, "amd,rproc: invalid phandle\n");
> +		return -EINVAL;
> +	}
> +
> +	rp = rproc_get_by_phandle(r5_core_node->phandle);
> +	if (!rp)
> +		return -EPROBE_DEFER;
> +
> +	rc = rproc_boot(rp);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Failed to attach to remote processor\n");
> +		rproc_put(rp);
> +		return rc;
> +	}
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)priv;
> +	rc = register_rpmsg_driver(&amd_rpmsg_driver);
> +	if (rc) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed to register RPMsg driver: %d\n", rc);
> +		goto free_rproc;
> +	}
> +
> +	amd_setup_mcdi(priv);

This function can fail. Why isn't it returning success/failure and why aren't
you checking it here?

> +	for (i = 0; i < NUM_CONTROLLERS; i++) {
> +		config = priv->adec[CONF + i * ADEC_NUM];
> +		num_chans = FIELD_GET(DDRMC5_NUM_CHANS_MASK, config);
> +		rank = FIELD_GET(DDRMC5_RANK_MASK, config);
> +		rank = 1 << rank;

merge the two:

		rank = 1 << FIELD_GET...


> +		dwidth = FIELD_GET(DDRMC5_BUS_WIDTH_MASK, config);
> +		dt = get_dwidth(dwidth);
> +
> +		/* Find the first enabled device and register that one. */
> +		if (dt != DEV_UNKNOWN) {

Save an indentation level:

		if (dt == DEV_UNKNOWN)
			continue;

		layers...

> +			layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +			layers[0].size = rank;
> +			layers[0].is_virt_csrow = true;
> +			layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +			layers[1].size = num_chans;
> +			layers[1].is_virt_csrow = false;
> +
> +			mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +					    sizeof(struct mc_priv));
> +			if (!mci) {
> +				edac_printk(KERN_ERR, EDAC_MC,
> +					    "Failed memory allocation for mc instance\n");
> +				rc = -ENOMEM;
> +				goto free_rpmsg;
> +			}
> +
> +			priv->mci = mci;
> +			priv->dwidth = dt;
> +			mc_init(mci, pdev);
> +			rc = edac_mc_add_mc(mci);
> +			if (rc) {
> +				edac_printk(KERN_ERR, EDAC_MC,
> +					    "Failed to register with EDAC core\n");
> +				goto free_edac_mc;

This is wrong as it frees only the current mci which the loop has allocated.
You need to loop back from i to 0, free all those previous mcis and unwind all
the setup work properly.

> +			}
> +			return 0;
> +		}
> +	}
> +
> +	return 0;
> +
> +free_edac_mc:
> +	edac_mc_free(mci);
> +free_rpmsg:
> +	unregister_rpmsg_driver(&amd_rpmsg_driver);
> +free_rproc:
> +	rproc_shutdown(rp);
> +	return rc;
> +}
> +
> +static void mc_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct mc_priv *priv = mci->pvt_info;
> +
> +	unregister_rpmsg_driver(&amd_rpmsg_driver);
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +	rproc_shutdown(priv->mcdi->r5_rproc);

Why isn't this a loop over NUM_CONTROLLERS unwinding all the stuff mc_probe()
has done, in the reverse order?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

