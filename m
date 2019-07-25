Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449C97570D
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jul 2019 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfGYShO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Jul 2019 14:37:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGYShO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Jul 2019 14:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7pPb5PLfzbPY4AG/pHdgzIH0FJYaW95a3t1HB4wXvpY=; b=QuhNwSLZ327yNlj9vBU7euh1u
        ko9pQpYQYwbiaZ3sODQkVRHR5jSHaQ5Vhs8bHWLssSFm0g9v/Ws1KmYsk2KHfcIr4zcBHZ7RsmaBZ
        ed5dKX3uUg82bSg3Ke1bUI+aA+nqdfQfpuXiS9Rm2p3/uehsLK7IT823xOZ6KjAB2y1jMgzS2GfSx
        Ha2v96RY1As6H5xIBnqITUlS/nkQ/j8eeqfJr3k6n3qaW1HFz7Sy81ifaffRsLaZypKYgagvuDcZY
        IoJfZry7UmERtn5NCSFDBXg3MrfnsmRM/hfsLtRpvD3hWT7qTIQI7AbjkWqjH1Zz6WtmiwDjnKFwZ
        TrNjbmwcw==;
Received: from [179.95.31.157] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqiby-0004et-Ga; Thu, 25 Jul 2019 18:37:06 +0000
Date:   Thu, 25 Jul 2019 15:36:58 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     <thor.thayer@linux.intel.com>, <bp@alien8.de>,
        <james.morse@arm.com>, <rric@kernel.org>, <morbidrsa@gmail.com>,
        <ralf@linux-mips.org>, <david.daney@cavium.com>,
        <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <ckadabi@codeaurora.org>, <vnkgutta@codeaurora.org>,
        <jglauber@cavium.com>, <khuong@os.amperecomputing.com>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [RFC 1/1] edac: Add a counter parameter for
 edac_device_handle_ue/ce()
Message-ID: <20190725153658.084ea1aa@coco.lan>
In-Reply-To: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
References: <1563187987-5847-1-git-send-email-hhhawa@amazon.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Mon, 15 Jul 2019 13:53:07 +0300
Hanna Hawa <hhhawa@amazon.com> escreveu:

> Add a counter parameter in order to avoid losing errors count for edac
> device, the error count reports the number of errors reported by an edac
> device similar to the way MC_EDAC do.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  drivers/edac/altera_edac.c      | 20 ++++++++++++--------
>  drivers/edac/amd8111_edac.c     |  6 +++---
>  drivers/edac/cpc925_edac.c      |  4 ++--
>  drivers/edac/edac_device.c      | 18 ++++++++++--------
>  drivers/edac/edac_device.h      |  8 ++++++--
>  drivers/edac/highbank_l2_edac.c |  4 ++--
>  drivers/edac/mpc85xx_edac.c     |  4 ++--
>  drivers/edac/mv64x60_edac.c     |  4 ++--
>  drivers/edac/octeon_edac-l2c.c  | 20 ++++++++++----------
>  drivers/edac/octeon_edac-pc.c   |  6 +++---
>  drivers/edac/qcom_edac.c        |  8 ++++----
>  drivers/edac/thunderx_edac.c    | 10 +++++-----
>  drivers/edac/xgene_edac.c       | 26 +++++++++++++-------------
>  13 files changed, 74 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 8816f74..747dd43 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -616,12 +616,12 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
>  	if (irq == drvdata->sb_irq) {
>  		if (priv->ce_clear_mask)
>  			writel(priv->ce_clear_mask, drvdata->base);
> -		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
> +		edac_device_handle_ce(dci, 1, 0, 0, drvdata->edac_dev_name);
>  		ret_value = IRQ_HANDLED;
>  	} else if (irq == drvdata->db_irq) {
>  		if (priv->ue_clear_mask)
>  			writel(priv->ue_clear_mask, drvdata->base);
> -		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
> +		edac_device_handle_ue(dci, 1, 0, 0, drvdata->edac_dev_name);
>  		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
>  		ret_value = IRQ_HANDLED;
>  	} else {
> @@ -919,13 +919,15 @@ static irqreturn_t __maybe_unused altr_edac_a10_ecc_irq(int irq, void *dev_id)
>  	if (irq == dci->sb_irq) {
>  		writel(ALTR_A10_ECC_SERRPENA,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ce(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
>  
>  		return IRQ_HANDLED;
>  	} else if (irq == dci->db_irq) {
>  		writel(ALTR_A10_ECC_DERRPENA,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ue(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
>  		if (dci->data->panic)
>  			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
>  
> @@ -1308,14 +1310,16 @@ static irqreturn_t altr_edac_a10_l2_irq(int irq, void *dev_id)
>  		regmap_write(dci->edac->ecc_mgr_map,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_SB);
> -		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ce(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
>  
>  		return IRQ_HANDLED;
>  	} else if (irq == dci->db_irq) {
>  		regmap_write(dci->edac->ecc_mgr_map,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_MB);
> -		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		edac_device_handle_ue(dci->edac_dev, 1, 0, 0,
> +				      dci->edac_dev_name);
>  		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
>  
>  		return IRQ_HANDLED;
> @@ -1652,12 +1656,12 @@ static irqreturn_t altr_edac_a10_ecc_irq_portb(int irq, void *dev_id)
>  	if (irq == ad->sb_irq) {
>  		writel(priv->ce_clear_mask,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ce(ad->edac_dev, 0, 0, ad->edac_dev_name);
> +		edac_device_handle_ce(ad->edac_dev, 1, 0, 0, ad->edac_dev_name);
>  		return IRQ_HANDLED;
>  	} else if (irq == ad->db_irq) {
>  		writel(priv->ue_clear_mask,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
> -		edac_device_handle_ue(ad->edac_dev, 0, 0, ad->edac_dev_name);
> +		edac_device_handle_ue(ad->edac_dev, 1, 0, 0, ad->edac_dev_name);
>  		return IRQ_HANDLED;
>  	}
>  
> diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
> index b5786cf..e595fab 100644
> --- a/drivers/edac/amd8111_edac.c
> +++ b/drivers/edac/amd8111_edac.c
> @@ -303,7 +303,7 @@ static void amd8111_lpc_bridge_check(struct edac_device_ctl_info *edac_dev)
>  		val8 |= IO_CTRL_1_CLEAR_MASK;
>  		edac_pci_write_byte(dev, REG_IO_CTRL_1, val8);
>  
> -		edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +		edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  	}
>  
>  	if (at_compat_reg_broken == 0) {
> @@ -315,8 +315,8 @@ static void amd8111_lpc_bridge_check(struct edac_device_ctl_info *edac_dev)
>  			out8 |= AT_COMPAT_CLRIOCHK;
>  		if (out8 > 0) {
>  			__do_outb(out8, REG_AT_COMPAT);
> -			edac_device_handle_ue(edac_dev, 0, 0,
> -						edac_dev->ctl_name);
> +			edac_device_handle_ue(edac_dev, 1, 0, 0,
> +					      edac_dev->ctl_name);
>  		}
>  	}
>  }
> diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
> index 3c0881a..eb74865 100644
> --- a/drivers/edac/cpc925_edac.c
> +++ b/drivers/edac/cpc925_edac.c
> @@ -682,7 +682,7 @@ static void cpc925_cpu_check(struct edac_device_ctl_info *edac_dev)
>  	cpc925_printk(KERN_INFO, "APIMASK		0x%08x\n", apimask);
>  	cpc925_printk(KERN_INFO, "APIEXCP		0x%08x\n", apiexcp);
>  
> -	edac_device_handle_ue(edac_dev, 0, 0, edac_dev->ctl_name);
> +	edac_device_handle_ue(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
>  
>  /******************** HT Link err device****************************/
> @@ -756,7 +756,7 @@ static void cpc925_htlink_check(struct edac_device_ctl_info *edac_dev)
>  		__raw_writel(HT_LINKERR_DETECTED,
>  				dev_info->vbase + REG_LINKERR_OFFSET);
>  
> -	edac_device_handle_ce(edac_dev, 0, 0, edac_dev->ctl_name);
> +	edac_device_handle_ce(edac_dev, 1, 0, 0, edac_dev->ctl_name);
>  }
>  
>  static struct cpc925_dev_info cpc925_devs[] = {
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 65cf2b9..d1de296 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -556,7 +556,8 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
>  }
>  
>  void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +			   u16 error_count, int inst_nr, int block_nr,
> +			   const char *msg)
>  {
>  	struct edac_device_instance *instance;
>  	struct edac_device_block *block = NULL;
> @@ -582,12 +583,12 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>  
>  	if (instance->nr_blocks > 0) {
>  		block = instance->blocks + block_nr;
> -		block->counters.ce_count++;
> +		block->counters.ce_count += error_count;
>  	}
>  
>  	/* Propagate the count up the 'totals' tree */
> -	instance->counters.ce_count++;
> -	edac_dev->counters.ce_count++;
> +	instance->counters.ce_count += error_count;
> +	edac_dev->counters.ce_count += error_count;
>  
>  	if (edac_device_get_log_ce(edac_dev))
>  		edac_device_printk(edac_dev, KERN_WARNING,
> @@ -598,7 +599,8 @@ void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>  EXPORT_SYMBOL_GPL(edac_device_handle_ce);
>  
>  void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
> -			int inst_nr, int block_nr, const char *msg)
> +			   u16 error_count, int inst_nr, int block_nr,
> +			   const char *msg)
>  {
>  	struct edac_device_instance *instance;
>  	struct edac_device_block *block = NULL;
> @@ -624,12 +626,12 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>  
>  	if (instance->nr_blocks > 0) {
>  		block = instance->blocks + block_nr;
> -		block->counters.ue_count++;
> +		block->counters.ue_count += error_count;
>  	}
>  
>  	/* Propagate the count up the 'totals' tree */
> -	instance->counters.ue_count++;
> -	edac_dev->counters.ue_count++;
> +	instance->counters.ue_count += error_count;
> +	edac_dev->counters.ue_count += error_count;

Patch itself looks a good idea, but maybe it should rise a WARN()
if error_count == 0.

That applies for both CE and UE error logic.

Thanks,
Mauro
