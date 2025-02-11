Return-Path: <linux-edac+bounces-3021-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EACA30759
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 10:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAC21886B0D
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1531F1519;
	Tue, 11 Feb 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L5j0VE4h"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3181F150E;
	Tue, 11 Feb 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266834; cv=none; b=BUafI7Nx2lV3o0LmMTAh9yjEVc+TzHXLF+kcLV07xnox9LZ903ZnoI658mwDZCZAo86mhMaMyPzwgoaCVNSvNByuE2plE+JP/m5tXD7EJAh7gyT06qlxrU1PdowL7QLaM8iXUAYZ3CErtjmPMHED9oliaJSBL3a/YL403OKQ/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266834; c=relaxed/simple;
	bh=AHCrooXBXlHWpIeCQivsvW9aQy5V5QBL+dmWRisULg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf+CAQSjEz+Dp8bH6XcYKo35Aue9SvCDOXVZADwFz6jeLzoSrXdiuWnRL2OdOSkeEnJ+1sCBOESqR1OpxoC5UX24TUuTfC2FRtwnYmeuIN7Kx8I0kPfP28dwpPy1TmiZB/ALD6XjCWnHTkyA9aglol6HptLj8RzB/oMJynv3jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L5j0VE4h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 81B9840E0223;
	Tue, 11 Feb 2025 09:40:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ix2aSEQ_Vhvq; Tue, 11 Feb 2025 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739266821; bh=/Ui5ddi3xqQeEKraSqGb5QScmLEt7W3syPLVh1Ld3pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5j0VE4hTZsCBolQNJ34IxvmlfktlaOSRptf+C9sMo66sD1qSm9zRJ11i4uj6y2ET
	 gLAAEZ6Og5M1FT8uhet1wjEBvHKiIkxvLl2P9YDhn7wnWKH+LJA1gfNrFVNImABCgt
	 GRBW2KV8IKEK+mge7xyf84SOxlz7EHpUW77yOs9YN+6Ke0/rNuHICRq6knDV/7JiiB
	 I2NVGs4TReoIonKib5VDYEx3CO4StXKsfWP8fQmoPmOJc2G9rP0LIcCpmPE+BwKOga
	 /Xskw7ztjCIpr6/VC6EBSdybPXj4USsupmhtrB1AFH8xF/2MDD/IAMcFtvsLXyESRJ
	 O7jH4QTJDb979mVvCE08eDG0WEvXxTufo0/ij1VCLwcmcM04gQYk2XHCnBlwfq/Jao
	 PSAsw16FZrILO5ScChASX8eAN4TTonkhmwlhHm8xyFXOKqrVTkYELW5zD0o7x/4j5y
	 WTvBVEvgEWt1+G08RRq2lG1+CRUZd7sqalDhUysWadFQ3u+3o5UF/kG9OUaAQn/5xm
	 8C2khD1nIylAl10/fw8UgOkIfmwPZz/YLjMNAtcHiFKCsy6+3DaoB2istIg45JSa8F
	 WXCWXr0CHPAQwAn+o9GbDM5BA3XcQ+4k4gITHr7BeekYGDGeELzQhwXHWBuXTQbIDm
	 H/Dx7quk7Ij6Df+W8c5qg3qo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BDD8540E01A3;
	Tue, 11 Feb 2025 09:40:08 +0000 (UTC)
Date: Tue, 11 Feb 2025 10:40:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v5 5/5] EDAC: Versal NET: Add support for error
 notification
Message-ID: <20250211094002.GAZ6sa8l_2BdJQfk0I@fat_crate.local>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
 <20250106053358.21664-6-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106053358.21664-6-shubhrajyoti.datta@amd.com>

On Mon, Jan 06, 2025 at 11:03:58AM +0530, Shubhrajyoti Datta wrote:
> Subject: Re: [PATCH v5 5/5] EDAC: Versal NET: Add support for error notification

Do a

  git log drivers/edac/

to get an idea how the subject format for that subsystem should be.

> The Versal NET edac listens to the notifications from NMC(Network

s/edac/EDAC/g

Check all your patches.

> management controller) on rpmsg.

I'm lucky Michal explains to me on internal chat what this all means.

Please write proper english and explain what "rpmsg" is.

> The driver registers on the error_edac channel.

What is "the error_edac channel"?

> Send a RAS event trace upon a notification. On reading the notification the
> user space application can decide on the response.  A sysfs reset entry is
> created for the same that sends an acknowledgment back to the NMC.

It says below "- remove reset". Please rewrite this commit message properly
- it is not write-only. Use LLM AI for the formulations.

> For reporting events register to the RAS framework. For memory mc events are
> used other events use non-standard events.

This basically explains what the patch does - I'd like to read why this
patch exists.

> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v5:
> Update the compatible
> Update the handle_error documentation
> 
> Changes in v4:
> Update the compatible
> 
> Changes in v3:
> make remove void
> 
> Changes in v2:
> - remove reset
> - Add the remote proc requests
> - remove probe_once
> - reorder the rpmsg registration
> - the data width , rank and number of channel is read from message.
> 
>  drivers/edac/Kconfig                |    9 +
>  drivers/edac/Makefile               |    1 +
>  drivers/edac/versalnet_rpmsg_edac.c | 1325 +++++++++++++++++++++++++++
>  3 files changed, 1335 insertions(+)
>  create mode 100644 drivers/edac/versalnet_rpmsg_edac.c

Why is this thing called "versalnet_rpmsg_edac.c"? Why not simply "versalnet_edac.c"?

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 06f7b43a6f78..4241936a8e7a 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -546,5 +546,14 @@ config EDAC_VERSAL
>  	  Support injecting both correctable and uncorrectable errors
>  	  for debugging purposes.
>  
> +config EDAC_VERSALNET
> +	tristate "AMD Versal NET EDAC"
> +	depends on CDX_CONTROLLER && ARCH_ZYNQMP
> +	help
> +	  Support for error detection and correction on the AMD Versal NET DDR
> +	  memory controller.
> +
> +	  The memory controller supports single bit error correction, double bit
> +	  error detection.

> Report various errors to the userspace.

That is superfluous - this text should only talk about your hw - not what
Linux does.

>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index f9cf19d8d13d..a8328522f9c3 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -86,3 +86,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
>  obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
> +obj-$(CONFIG_EDAC_VERSALNET)		+= versalnet_rpmsg_edac.o
> diff --git a/drivers/edac/versalnet_rpmsg_edac.c b/drivers/edac/versalnet_rpmsg_edac.c
> new file mode 100644
> index 000000000000..a54911f07c67
> --- /dev/null
> +++ b/drivers/edac/versalnet_rpmsg_edac.c
> @@ -0,0 +1,1325 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Versal NET memory controller driver
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/edac.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/ras.h>
> +#include <linux/rpmsg.h>
> +#include <linux/sizes.h>
> +#include <ras/ras_event.h>
> +#include <linux/remoteproc.h>
> +
> +#include "edac_module.h"
> +#include "../cdx/cdx.h"
> +#include "../cdx/controller/mcdi_functions.h"
> +#include "../cdx/controller/mcdi.h"
> +#include "../cdx/controller/mc_cdx_pcol.h"

This looks like a hack to make it work. 

Also, this seems to build too:

diff --git a/drivers/edac/versalnet_rpmsg_edac.c b/drivers/edac/versalnet_rpmsg_edac.c
index a54911f07c67..5998a677cecd 100644
--- a/drivers/edac/versalnet_rpmsg_edac.c
+++ b/drivers/edac/versalnet_rpmsg_edac.c
@@ -15,9 +15,9 @@
 
 #include "edac_module.h"
 #include "../cdx/cdx.h"
-#include "../cdx/controller/mcdi_functions.h"
+//#include "../cdx/controller/mcdi_functions.h"
 #include "../cdx/controller/mcdi.h"
-#include "../cdx/controller/mc_cdx_pcol.h"
+//#include "../cdx/controller/mc_cdx_pcol.h"
 
 /* Granularity of reported error in bytes */
 #define DDRMC5_EDAC_ERR_GRAIN			1


so it looks like you've been adding includes until it builds.

So, how about a proper export of functionality into the proper linux/
namespace like it is usually done?

> +/* Granularity of reported error in bytes */
> +#define DDRMC5_EDAC_ERR_GRAIN			1
> +#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_LEN	4 /* 4 bytes */
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
> +
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
> +union edac_info {

What is an "edac_info"?

> +	struct {
> +		u32 row0:6;
> +		u32 row1:6;
> +		u32 row2:6;
> +		u32 row3:6;
> +		u32 row4:6;
> +		u32 reserved:2;
> +	};
> +	struct {
> +		u32 col1:6;
> +		u32 col2:6;
> +		u32 col3:6;
> +		u32 col4:6;
> +		u32 col5:6;
> +		u32 reservedcol:2;
> +	};
> +	u32 i;
> +} __packed;
> +
> +/**
> + * struct ack - Acknowledgment information to report.
> + * @error_level:	Error level.
> + * @error_id:		Error id ectable error log information.

Unknown word [ectable] in comment.
Suggestions: ['eatable', 'editable', 'equatable', 'equitable', 'electable', 'equable', 'educable', 'octal', 'vegetable', 'equitably', 'edible', 'uneatable', 'quotable']

Use a spellchecker please.

> + * @next_action:	Next action to be taken.
> + */
> +struct ack {
> +	u32 error_level;
> +	u32 error_id;
> +	u32 next_action;
> +};
> +
> +/**
> + * struct ecc_status - ECC status information to report.
> + * @ceinfo:	Correctable error log information.
> + * @ueinfo:	Uncorrectable error log information.
> + * @channel:	Channel number.
> + * @error_type:	Error type information.
> + */
> +struct ecc_status {
> +	union ecc_error_info ceinfo[2];
> +	union ecc_error_info ueinfo[2];
> +	u8 channel;
> +	u8 error_type;
> +};
> +
> +/**
> + * struct edac_priv - DDR memory controller private instance data.

So it pertains to the memory controller not to EDAC. So call it that.

> + * @message:		Buffer for framing the event specific info.
> + * @ce_cnt:		Correctable error count.
> + * @ue_cnt:		UnCorrectable error count.
> + * @stat:		ECC status information.
> + * @lrank_bit:		Bit shifts for lrank bit.
> + * @rank_bit:		Bit shifts for rank bit.
> + * @row_bit:		Bit shifts for row bit.
> + * @col_bit:		Bit shifts for column bit.
> + * @bank_bit:		Bit shifts for bank bit.
> + * @grp_bit:		Bit shifts for group bit.
> + * @error_id:		The error id.
> + * @error_level:	The error level.
> + * @dwidth:		The dwidth.

Say what now? What is the "dwidth"?

> + * @part_len:		The subpart of the message received.
> + * @regs:		The registers sent on the rpmsg.
> + * @adec:		Address decode registers.
> + * @mci:		Memory controller interface.
> + * @ept:		rpmsg endpoint.
> + * @mcdi:		The mcdi handle.
> + * @work:		The work queue.
> + * @xfer_done:		The completion indicator for the rpmsg.
> + */
> +struct edac_priv {
> +	char message[DDRMC5_EDAC_MSG_SIZE];
> +	u32 ce_cnt;
> +	u32 ue_cnt;
> +	struct ecc_status stat;
> +	u32 lrank_bit[4];
> +	u32 rank_bit[2];
> +	u32 row_bit[18];
> +	u32 col_bit[11];
> +	u32 bank_bit[2];
> +	u32 grp_bit[3];
> +	u32 error_id;
> +	u32 error_level;
> +	enum dev_type dwidth;
> +	u32 part_len;
> +	u32 regs[REG_MAX];
> +	u32 adec[ADEC_MAX];
> +	struct mem_ctl_info *mci;
> +	struct rpmsg_endpoint *ept;
> +	struct cdx_mcdi *mcdi;
> +	struct work_struct work;
> +	struct completion xfer_done;
> +};
> +
> +enum error_ids {

I'm not sure those are really needed: they're used once and you can just as
well use the naked numbers with comments above them in the switch-case. For
example:

	/* FPX SPLITTER error */
        case 132 ... 139:
                snprintf(edac_priv->message, DDRMC5_EDAC_MSG_SIZE,
                         "Error type: FPX SPLITTER Error %d", error_id);

and so on.

> +	BOOT_CR = 0,
> +	BOOT_NCR = 1,
> +	FW_CR = 2,
> +	FW_NCR = 3,
> +	GSW_CR = 4,
> +	GSW_NCR = 5,
> +	CFU = 6,
> +	CFRAME = 7,
> +	PSM_CR = 8,
> +	PSM_NCR = 9,
> +	DDRMC5_MB_CR = 10,
> +	DDRMC5_MB_NCR = 11,
> +	NOCTYPE_CR = 12,
> +	NOCTYPE_NCR = 13,
> +	NOCUSER = 14,
> +	MMCM = 15,
> +	HNICX_CR = 16,
> +	HNICX_NCR = 17,
> +	DDRMC5_CR = 18,
> +	DDRMC5_NCR = 19,
> +	GT_CR = 20,
> +	GT_NCR = 21,
> +	PLSYSMON_CR = 22,
> +	PLSYSMON_NCR = 23,
> +	PL0 = 24,
> +	PL1 = 25,
> +	PL2 = 26,
> +	PL3 = 27,
> +	NPI_ROOT = 28,
> +	SSIT_ERR3 = 29,
> +	SSIT_ERR4 = 30,
> +	SSIT_ERR5 = 31,
> +	PMC_APB = 32,
> +	PMC_ROM = 33,
> +	MB_FATAL0 = 34,
> +	MB_FATAL1 = 35,
> +	PMC_CR = 36,
> +	PMC_NCR = 37,
> +	PMC_SMON0 = 39,
> +	PMC_SMON1 = 40,
> +	PMC_SMON2 = 41,
> +	PMC_SMON3 = 42,
> +	PMC_SMON4 = 43,
> +	PMC_SMON8 = 47,
> +	PMC_SMON9 = 48,
> +	CFI = 49,
> +	CFRAME_SEU_CRC = 50,
> +	CFRAME_SEU_ECC = 51,
> +	PMX_WWDT = 52,
> +	RTC_ALARM = 54,
> +	NPLL = 55,
> +	PPLL = 56,
> +	CLK_MON = 57,
> +	INT_PMX_CORR_ERR = 59,
> +	INT_PMX_UNCORR_ERR = 60,
> +	SSIT_ERR0 = 61,
> +	SSIT_ERR1 = 62,
> +	SSIT_ERR2 = 63,
> +	IOU_CR = 64,
> +	IOU_NCR = 65,
> +	DFX_UXPT_ACT = 66,
> +	DICE_CDI_PAR = 67,
> +	DEVIK_PRIV = 68,
> +	NXTSW_CDI_PAR = 69,
> +	DEVAK_PRIV = 70,
> +	DME_PUB_X = 71,
> +	DME_PUB_Y = 72,
> +	DEVAK_PUB_X = 73,
> +	DEVAK_PUB_Y = 74,
> +	DEVIK_PUB_X = 75,
> +	DEVIK_PUB_Y = 76,
> +	PCR_PAR = 77,
> +	PS_SW_CR = 96,
> +	PS_SW_NCR = 97,
> +	PSM_B_CR = 98,
> +	PSM_B_NCR = 99,
> +	MB_FATAL = 100,
> +	PSMX_CHK = 103,
> +	APLL1_LOCK = 104,
> +	APLL2_LOCK = 105,
> +	RPLL_LOCK = 106,
> +	FLXPLL_LOCK = 107,
> +	INT_PSM_CR = 108,
> +	INT_PSM_NCR = 109,
> +	USB_ERR = 110,
> +	LPX_DFX = 111,
> +	INT_LPD_CR = 113,
> +	INT_LPD_NCR = 114,
> +	INT_OCM_CR = 115,
> +	INT_OCM_NCR = 116,
> +	INT_FPD_CR = 117,
> +	INT_FPD_NCR = 118,
> +	INT_IOU_CR = 119,
> +	INT_IOU_NCR = 120,
> +	RPU_CLUSTERA_LS = 121,
> +	RPU_CLUSTERB_LS = 122,
> +	GIC_AXI = 123,
> +	GIC_ECC = 124,
> +	CPM_CR = 125,
> +	CPM_NCR = 126,
> +	FPD_CPI = 127,
> +	FPD_SWDT0 = 128,
> +	FPD_SWDT1 = 129,
> +	FPD_SWDT2 = 130,
> +	FPD_SWDT3 = 131,
> +	FPX_SPLITTER0_MEM_ERR = 132,
> +	FPX_SPLITTER0_AXI_ERR = 133,
> +	FPX_SPLITTER1_MEM_ERR = 134,
> +	FPX_SPLITTER1_AXI_ERR = 135,
> +	FPX_SPLITTER2_MEM_ERR = 136,
> +	FPX_SPLITTER2_AXI_ERR = 137,
> +	FPX_SPLITTER3_MEM_ERR = 138,
> +	FPX_SPLITTER3_AXI_ERR = 139,
> +	APU0 = 140,
> +	APU1 = 141,
> +	APU2 = 142,
> +	APU3 = 143,
> +	LPX_WWDT0 = 144,
> +	LPX_WWDT1 = 145,
> +	ADMA_LS_ERR = 146,
> +	IPI_ERR = 147,
> +	OCM0_CORR_ERR = 148,
> +	OCM1_CORR_ERR = 149,
> +	OCM0_UNCORR_ERR = 150,
> +	OCM1_UNCORR_ERR = 151,
> +	LPX_AFIFS_CORR_ERR = 152,
> +	LPX_AFIFS_UNCORR_ERR = 153,
> +	LPX_GLITCH_DET0 = 154,
> +	LPX_GLITCH_DET1 = 155,
> +	NOC_NMU_FIREWALL_WR_ERR = 156,
> +	NOC_NMU_FIREWALL_RD_ERR = 157,
> +	NOC_NSU_FIREWALL_ERR = 158,
> +	RPUA0_CORR_ERR = 163,
> +	RPUA0_MISC1 = 166,
> +	RPUA0_MISC2 = 167,
> +	RPUA1_CORR_ERR = 168,
> +	RPUA1_FATAL_ERR = 169,
> +	RPUA1_TIMEOUT_ERR = 170,
> +	RPUA1_MISC1 = 171,
> +	RPUA1_MISC2 = 172,
> +	RPUB0_CORR_ERR = 173,
> +	RPUB0_FATAL_ERR = 174,
> +	RPUB0_TIMEOUT_ERR = 175,
> +	RPUB0_MISC1 = 176,
> +	RPUB0_MISC2 = 177,
> +	RPUB1_CORR_ERR = 178,
> +	RPUB1_FATAL_ERR = 179,
> +	RPUB1_TIMEOUT_ERR = 180,
> +	RPUB1_MISC1 = 181,
> +	RPUB1_MISC2 = 182,
> +	RPU_PCIL_ERR = 184,
> +	FPX_AFIFS_CORR_ERR = 185,
> +	FPX_AFIFS_UNCORR_ERR = 186,
> +	FPD_CMN_1_ERR = 187,
> +	FPD_CMN_2_ERR = 188,
> +	FPD_CMN_3_ERR = 189,
> +	FPD_CML_ERR = 190,
> +	FPD_INTWRAP_ERR = 191,
> +	FPD_REST_MON_ERR = 192,
> +	LPD_MON_ERR = 193,
> +	AFIFM_FATAL_ERR = 194,
> +	LPX_AFIFM_NONFATAL_ERR = 195,
> +	FPX_AFIFM0_NONFATAL_ERR = 196,
> +	FPX_AFIFM1_NONFATAL_ERR = 197,
> +	FPX_AFIFM2_NONFATAL_ERR = 198,
> +	FPX_AFIFM3_NONFATAL_ERR = 199,
> +	RPU_CLUSTERA_ERR = 200,
> +	RPU_CLUSTERB_ERR = 201,
> +	HB_MON_0 = 224,
> +	HB_MON_1 = 225,
> +	HB_MON_2 = 226,
> +	HB_MON_3 = 227,
> +	PLM_EXCEPTION = 228,
> +	PCR_LOG_UPDATE = 230,
> +	ERROR_CRAM_CE = 231,
> +	ERROR_CRAM_UE = 232,
> +	ERROR_NPI_UE = 233,
> +};
> +
> +enum adec_info {

What is "ADEC"? Some permutaion of "EDAC"?

> +	CONF = 0,
> +	ADEC0,
> +	ADEC1,
> +	ADEC2,
> +	ADEC3,
> +	ADEC4,
> +	ADEC5,
> +	ADEC6,
> +	ADEC7,
> +	ADEC8,
> +	ADEC9,
> +	ADEC10,
> +	ADEC11,
> +	ADEC12,
> +	ADEC13,
> +	ADEC14,
> +	ADEC15,
> +	ADEC16,
> +	ADECILC,
> +};
> +
> +enum reg_info {
> +	ISR = 0,
> +	IMR,
> +	ECCR0_ERR_STATUS,
> +	ECCR0_ADDR_LO,
> +	ECCR0_ADDR_HI,
> +	ECCR0_DATA_LO,
> +	ECCR0_DATA_HI,
> +	ECCR0_PAR,
> +	ECCR1_ERR_STATUS,
> +	ECCR1_ADDR_LO,
> +	ECCR1_ADDR_HI,
> +	ECCR1_DATA_LO,
> +	ECCR1_DATA_HI,
> +	ECCR1_PAR,
> +	XMPU_ERR,
> +	XMPU_ERR_ADDR_L0,
> +	XMPU_ERR_ADDR_HI,
> +	XMPU_ERR_AXI_ID,
> +	ADEC_CHK_ERR_LOG,
> +};
> +
> +static void get_ddr_ce_error_info(u32 *error_data, struct edac_priv *priv)
> +{
> +	u32 regval, par, reghi;

"parity" is still short enough but a lot more understandable.

> +	struct ecc_status *p;
> +
> +	p = &priv->stat;
> +
> +	regval = error_data[ECCR0_ADDR_HI];
> +	reghi = regval & ECCR_UE_CE_ADDR_HI_ROW_MASK;

So "regval" should be "reglo"?

> +	regval = error_data[ECCR0_ADDR_LO];
> +	p->ceinfo[0].i = regval | (u64)reghi << 32;
> +
> +	par = error_data[ECCR0_PAR];
> +	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
> +		 reghi, regval, par);
> +
> +	regval = error_data[ECCR1_ADDR_LO];
> +	reghi = error_data[ECCR1_ADDR_HI];
> +	p->ceinfo[1].i = regval | (u64)reghi << 32;
> +
> +	par = error_data[ECCR1_PAR];
> +	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
> +		 reghi, regval, par);
> +}
> +
> +static void get_ddr_ue_error_info(u32 error_data[REGS_PER_CONTROLLER], struct edac_priv *priv)
				     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
What is that for?

> +{
> +	u32 regval, par, reghi;
> +	struct ecc_status *p;
> +
> +	p = &priv->stat;
> +
> +	regval = error_data[ECCR0_ADDR_LO];
> +	reghi = error_data[ECCR0_ADDR_HI];
> +	par = error_data[ECCR0_PAR];
> +
> +	p->ueinfo[0].i = regval | (u64)reghi << 32;
> +
> +	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
> +		 reghi, regval, par);
> +
> +	regval = error_data[ECCR1_ADDR_LO];
> +	reghi = error_data[ECCR1_ADDR_HI];
> +	p->ueinfo[1].i = regval | (u64)reghi << 32;
> +	par = error_data[ECCR1_PAR];
> +
> +	edac_dbg(2, "ERR DATA: 0x%08X%08X ERR DATA PARITY: 0x%08X\n",
> +		 reghi, regval, par);
> +}

Same comments as for get_ddr_ce_error_info().

Looking at those functions, you can actually merge them into one.

> +static bool get_ddr_ue_info(u32 error_data[REGS_PER_CONTROLLER], struct edac_priv *priv)
> +{
> +	u32 eccr0_val, eccr1_val, isr;
> +	struct ecc_status *p;
> +
> +	p = &priv->stat;
> +
> +	isr = error_data[ISR];
> +	if (!(isr & DDRMC5_IRQ_UE_MASK))
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
> +	get_ddr_ue_error_info(error_data, priv);
> +
> +	return true;
> +}
> +
> +static bool get_ddr_ce_info(u32 error_data[REGS_PER_CONTROLLER], struct edac_priv *priv)
> +{
> +	u32 eccr0_val, eccr1_val, isr;
> +	struct ecc_status *p;
> +
> +	p = &priv->stat;
> +
> +	isr = error_data[ISR];
> +	if (!(isr & DDRMC5_IRQ_CE_MASK))
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
> +	get_ddr_ce_error_info(error_data, priv);
> +
> +	return true;
> +}

Also unify into a single function. So basically the above 4 could be a single
function.

> +
> +/**
> + * handle_error - Handle Correctable and Uncorrectable errors.
> + * @priv:	DDR memory controller private instance data.
> + * @stat:	ECC status structure.
> + * @controller:	Controller number of the DDRMC5
> + *
> + * Handles ECC correctable and uncorrectable errors.
> + */
> +static void handle_error(struct edac_priv  *priv, struct ecc_status *stat, int controller)
> +{
> +	struct mem_ctl_info *mci = priv->mci;
> +	union ecc_error_info pinf;
> +	unsigned long pa;
> +	phys_addr_t pfn;
> +	int err;
> +
> +	if (stat->error_type == DDRMC5_ERR_TYPE_CE) {
> +		priv->ce_cnt++;
> +		pinf = stat->ceinfo[stat->channel];
> +		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 "Error type:%s Addr at %lx\n",
> +			 "CE", convert_to_physical(priv, pinf, controller));
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +				     1, 0, 0, 0, 0, 0, -1,
> +				     priv->message, "");
> +	}
> +
> +	if (stat->error_type == DDRMC5_ERR_TYPE_UE) {
> +		priv->ue_cnt++;
> +		pinf = stat->ueinfo[stat->channel];
> +		snprintf(priv->message, DDRMC5_EDAC_MSG_SIZE,
> +			 "Error type:%s Addr at %lx\n",
> +			 "UE", convert_to_physical(priv, pinf, controller));
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +				     1, 0, 0, 0, 0, 0, -1,
> +				     priv->message, "");
> +		pa = convert_to_physical(priv, pinf, controller);
> +		pfn = PHYS_PFN(pa);
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_FAILURE)) {
> +			err = memory_failure(pfn, MF_ACTION_REQUIRED);
> +			if (err)
> +				edac_dbg(2, "In fail of memory_failure %d\n", err);
> +			else
> +				edac_dbg(2, "Page at PA 0x%lx is hardware poisoned\n", pa);
> +		}
> +	}
> +
> +	memset(stat, 0, sizeof(*stat));

This is the wrong ordering - you either clear it on entry or the caller should
clear it - the caller should not rely on this function clearing it for the
next function it is going to call.

> +
> +/**
> + * mc_init - Initialize one driver instance.
> + * @mci:	EDAC memory controller instance.
> + * @pdev:	platform device.
> + *
> + * Perform initialization of the EDAC memory controller instance and
> + * related driver-private data associated with the memory controller the
> + * instance is bound to.

The stuff which needs commenting doesn't have any but the obvious ones have
comments which are more than necessary. :-\

> + */
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
> +	mci->dev_name = dev_name(&pdev->dev);
> +	mci->mod_name = "amd_edac";

Do:

git grep mod_name drivers/edac/

to get an idea how those names are chosen.

> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	init_csrows(mci);
> +}
> +
> +#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
> +
> +static int amd_rpmsg_send(struct cdx_mcdi *cdx_mcdi,
> +			  const struct cdx_dword *hdr, size_t hdr_len,
> +			  const struct cdx_dword *sdu, size_t sdu_len)

Used only once - fold it into the call site. And static functions don't need
silly name prefixes like "amd_".

> +{
> +	unsigned char *send_buf;
> +	int ret;
> +
> +	send_buf = kzalloc(hdr_len + sdu_len, GFP_KERNEL);
> +	if (!send_buf)
> +		return -ENOMEM;
> +
> +	memcpy(send_buf, hdr, hdr_len);
> +	memcpy(send_buf + hdr_len, sdu, sdu_len);
> +
> +	ret = rpmsg_send(cdx_mcdi->ept, send_buf, hdr_len + sdu_len);
> +	kfree(send_buf);
> +	return ret;
> +}
> +



> +static int get_ddr_config(u32 index, u32 *buffer, struct cdx_mcdi *amd_mcdi)
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
> +	if (ret)
> +		return ret;
> +	memcpy(buffer, MCDI_PTR(outbuf, EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES), (ADEC_NUM * 4));
> +	return 0;

Function returning a value which no one uses.

> +}
> +
> +static int amd_setup_mcdi(struct edac_priv *edac_priv)
> +{
> +	struct cdx_mcdi *amd_mcdi;
> +	int ret, i;
> +
> +	amd_mcdi = kzalloc(sizeof(*amd_mcdi), GFP_KERNEL);
> +	if (!amd_mcdi)
> +		return -ENOMEM;
> +
> +	/* Store the MCDI ops */

Useless comment.

> +	amd_mcdi->mcdi_ops = &mcdi_ops;
> +	/* MCDI FW: Initialize the FW path */

Ditto.

> +	ret = cdx_mcdi_init(amd_mcdi);
> +	if (ret)
> +		return ret;

And here you leaked amd_mcdi when you returned.

> +	amd_mcdi->ept = edac_priv->ept;
> +	edac_priv->mcdi = amd_mcdi;
> +
> +	for (i = 0; i < NUM_CONTROLLERS; i++)
> +		get_ddr_config(i, &edac_priv->adec[ADEC_NUM * i], amd_mcdi);
> +
> +	complete(&edac_priv->xfer_done);

That looks like a hack.

> +	return 0;

Ditto.

> +}
> +
> +static inline void process_bit(struct edac_priv *priv, unsigned int start, u32 regval)

You don't need "inline" - the compiler can decide that itself. And
"process_bit" needs a better name.

> +{
> +	union edac_info rows;
> +
> +	rows.i = regval;
> +	priv->row_bit[start] = rows.row0;
> +	priv->row_bit[start + 1] = rows.row1;
> +	priv->row_bit[start + 2] = rows.row2;
> +	priv->row_bit[start + 3] = rows.row3;
> +	priv->row_bit[start + 4] = rows.row4;
> +}
> +
> +static void setup_row_address_map(struct edac_priv *priv, u32 *error_data)
> +{
> +	union edac_info rows;
> +	u32 regval;
> +
> +	regval = error_data[ADEC6];
> +	process_bit(priv, 0, regval);
> +
> +	regval = error_data[ADEC7];
> +	process_bit(priv, 5, regval);
> +
> +	regval = error_data[ADEC8];
> +	process_bit(priv, 10, regval);
> +
> +	regval = error_data[ADEC9];
> +	rows.i = regval;
> +
> +	priv->row_bit[15] = rows.row0;
> +	priv->row_bit[16] = rows.row1;
> +	priv->row_bit[17] = rows.row2;
> +}
> +
> +static void setup_column_address_map(struct edac_priv *priv, u32 *error_data)
> +{
> +	union edac_info cols;
> +	u32 regval;
> +
> +	regval = error_data[ADEC9];
> +	priv->col_bit[0] = FIELD_GET(MASK_24, regval);
> +
> +	regval = error_data[ADEC10];
> +	cols.i = regval;
> +	priv->col_bit[1] = cols.col1;
> +	priv->col_bit[2] = cols.col2;
> +	priv->col_bit[3] = cols.col3;
> +	priv->col_bit[4] = cols.col4;
> +	priv->col_bit[5] = cols.col5;
> +
> +	regval = error_data[ADEC11];
> +	cols.i = regval;
> +	priv->col_bit[6] = cols.col1;
> +	priv->col_bit[7] = cols.col2;
> +	priv->col_bit[8] = cols.col3;
> +	priv->col_bit[9] = cols.col4;
> +	priv->col_bit[10] = cols.col5;
> +}

Why are those functions copying stuff around? Why aren't you using cols
directly?

> +static inline bool is_response(u8 *data)
> +{
> +	return (data[0] == MCDI_RESPONSE);
> +}

Zap that silly function.

> +
> +static struct rpmsg_device_id amd_rpmsg_id_table[] = {
> +	{ .name = "error_ipc" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(rpmsg, amd_rpmsg_id_table);
> +
> +static void amd_rpmsg_post_probe_work(struct work_struct *work)
> +{
> +	struct edac_priv *priv;
> +
> +	priv = container_of(work, struct edac_priv, work);
> +	amd_setup_mcdi(priv);
> +}

Why is probing a work item?

Explaining *that* is what a commit message is for - not for repeating useless
info.

> +static int amd_rpmsg_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_channel_info chinfo = {0};
> +	struct edac_priv *pg;
> +
> +	pg = (struct edac_priv *)amd_rpmsg_id_table[0].driver_data;
> +	chinfo.src = RPMSG_ADDR_ANY;
> +	chinfo.dst = rpdev->dst; /* NMC */

verify_comment_style: WARNING: No tail comments please:
 drivers/edac/versalnet_rpmsg_edac.c:1139 [+	chinfo.dst = rpdev->dst; /* NMC */]

Check your whole driver.

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
> +
> +	schedule_work(&pg->work);
> +
> +	return 0;
> +}
> +

> +static int mc_probe(struct platform_device *pdev)
> +{
> +	unsigned long time_left, wait_jiffies;
> +	u32 num_chans, rank, dwidth, config;
> +	struct device_node *r5_core_node;
> +	struct edac_mc_layer layers[2];
> +	struct mem_ctl_info *mci;
> +	struct edac_priv *priv;
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
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)priv;
> +	INIT_WORK(&priv->work, amd_rpmsg_post_probe_work);
> +	init_completion(&priv->xfer_done);
> +	rc = register_rpmsg_driver(&amd_rpmsg_driver);
> +	if (rc) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed to register RPMsg driver: %d\n", rc);
> +		goto free_rproc;
> +	}
> +	wait_jiffies = msecs_to_jiffies(10000);
> +	time_left = wait_for_completion_timeout(&priv->xfer_done, wait_jiffies);
> +	if (time_left == 0)
> +		goto free_rpmsg;

Yah, this needs explanation as to why it is there.

> +	for (i = 0; i < NUM_CONTROLLERS; i++) {
> +		config = priv->adec[CONF + i];
> +		num_chans = FIELD_GET(DDRMC5_NUM_CHANS_MASK, config);
> +		rank = FIELD_GET(DDRMC5_RANK_MASK, config);
> +		rank = 1 << rank;
> +		dwidth = FIELD_GET(DDRMC5_BUS_WIDTH_MASK, config);
> +		dt = get_dwidth(dwidth);
> +		if (dt != DEV_UNKNOWN)
> +			break;
> +	}

What is that loop supposed to do? Find the last controller before the one
with DEV_UNKNOWN device width and register that one?

> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = rank;
> +	layers[0].is_virt_csrow = true;
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = num_chans;
> +	layers[1].is_virt_csrow = false;
> +
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct edac_priv));
> +	if (!mci) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed memory allocation for mc instance\n");
> +		rc = -ENOMEM;
> +		goto free_rproc;
> +	}
> +	priv->mci = mci;
> +
> +	priv->dwidth = dt;
> +	mc_init(mci, pdev);
> +	rc = edac_mc_add_mc(mci);
> +	if (rc) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed to register with EDAC core\n");
> +		goto free_edac_mc;
> +	}

Yeah, in any case, this needs a lot more explanation how all the parts are
supposed to work together.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

