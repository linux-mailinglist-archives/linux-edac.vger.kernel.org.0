Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1C1D7B02
	for <lists+linux-edac@lfdr.de>; Mon, 18 May 2020 16:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgEROVw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 May 2020 10:21:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25237 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbgEROVw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 18 May 2020 10:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589811710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHNbcFWCieEeLSxuhK+E7+hlBHBUMz6/oq2Rv/oJB0w=;
        b=EXsT7zb7uaM83WMNb0JZaNYx+KjBf2WW39ooKPorevDH0iNbvw4sNaen2aj1djn7rKPu8I
        NjAlLX+nEZJGGccJqf2Lkp4G2dr4luzaO5fQ/YUzH1R+DFvW8VlnnkdkkPVqMqnpGOQtoj
        rLENFGI/FSeGxycPho+eOyRPC7kq1Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-j7MU4ls3O5q2A3d2vJgxcg-1; Mon, 18 May 2020 10:21:48 -0400
X-MC-Unique: j7MU4ls3O5q2A3d2vJgxcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263B4A0C08;
        Mon, 18 May 2020 14:21:47 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D952C6297D;
        Mon, 18 May 2020 14:21:46 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 6875DC0EBF; Mon, 18 May 2020 10:21:46 -0400 (EDT)
Date:   Mon, 18 May 2020 10:21:46 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Matthew Riley <mattdr@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1 1/1] EDAC/skx: Use the mcmtr register to retrieve
 close_pg/bank_xor_enable
Message-ID: <20200518142146.nfthkiydtvxi3mzi@redhat.com>
References: <20200515210146.1337-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515210146.1337-1-tony.luck@intel.com>
User-Agent: NeoMutt/20200501
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 15, 2020 at 02:01:46PM -0700, Tony Luck wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> The skx_edac driver wrongly uses the mtr register to retrieve two fields
> close_pg and bank_xor_enable. Fix it by using the correct mcmtr register
> to get the two fields.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Matthew Riley <mattdr@google.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
>  drivers/edac/i10nm_base.c |  2 +-
>  drivers/edac/skx_base.c   | 20 ++++++++------------
>  drivers/edac/skx_common.c |  6 +++---
>  drivers/edac/skx_common.h |  2 +-
>  4 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index ea8f2127e238..c8d11da85bec 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -175,7 +175,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci)
>  				 mtr, mcddrtcfg, imc->mc, i, j);
>  
>  			if (IS_DIMM_PRESENT(mtr))
> -				ndimms += skx_get_dimm_info(mtr, 0, dimm,
> +				ndimms += skx_get_dimm_info(mtr, 0, 0, dimm,
>  							    imc, i, j);
>  			else if (IS_NVDIMM_PRESENT(mcddrtcfg, j))
>  				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
> diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
> index 1ff22136cf72..2c7db95df326 100644
> --- a/drivers/edac/skx_base.c
> +++ b/drivers/edac/skx_base.c
> @@ -169,27 +169,23 @@ static const struct x86_cpu_id skx_cpuids[] = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
>  
> -#define SKX_GET_MTMTR(dev, reg) \
> -	pci_read_config_dword((dev), 0x87c, &(reg))
> -
> -static bool skx_check_ecc(struct pci_dev *pdev)
> +static bool skx_check_ecc(u32 mcmtr)
>  {
> -	u32 mtmtr;
> -
> -	SKX_GET_MTMTR(pdev, mtmtr);
> -
> -	return !!GET_BITFIELD(mtmtr, 2, 2);
> +	return !!GET_BITFIELD(mcmtr, 2, 2);
>  }
>  
>  static int skx_get_dimm_config(struct mem_ctl_info *mci)
>  {
>  	struct skx_pvt *pvt = mci->pvt_info;
> +	u32 mtr, mcmtr, amap, mcddrtcfg;
>  	struct skx_imc *imc = pvt->imc;
> -	u32 mtr, amap, mcddrtcfg;
>  	struct dimm_info *dimm;
>  	int i, j;
>  	int ndimms;
>  
> +	/* Only the mcmtr on the first channel is effective */
> +	pci_read_config_dword(imc->chan[0].cdev, 0x87c, &mcmtr);
> +
>  	for (i = 0; i < SKX_NUM_CHANNELS; i++) {
>  		ndimms = 0;
>  		pci_read_config_dword(imc->chan[i].cdev, 0x8C, &amap);
> @@ -199,14 +195,14 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci)
>  			pci_read_config_dword(imc->chan[i].cdev,
>  					      0x80 + 4 * j, &mtr);
>  			if (IS_DIMM_PRESENT(mtr)) {
> -				ndimms += skx_get_dimm_info(mtr, amap, dimm, imc, i, j);
> +				ndimms += skx_get_dimm_info(mtr, mcmtr, amap, dimm, imc, i, j);
>  			} else if (IS_NVDIMM_PRESENT(mcddrtcfg, j)) {
>  				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
>  							      EDAC_MOD_STR);
>  				nvdimm_count++;
>  			}
>  		}
> -		if (ndimms && !skx_check_ecc(imc->chan[0].cdev)) {
> +		if (ndimms && !skx_check_ecc(mcmtr)) {
>  			skx_printk(KERN_ERR, "ECC is disabled on imc %d\n", imc->mc);
>  			return -ENODEV;
>  		}
> diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
> index abc9ddd2b7d1..46be1a77bd1d 100644
> --- a/drivers/edac/skx_common.c
> +++ b/drivers/edac/skx_common.c
> @@ -303,7 +303,7 @@ static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
>  #define numrow(reg)	skx_get_dimm_attr(reg, 2, 4, 12, 1, 6, "rows")
>  #define numcol(reg)	skx_get_dimm_attr(reg, 0, 1, 10, 0, 2, "cols")
>  
> -int skx_get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
> +int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
>  		      struct skx_imc *imc, int chan, int dimmno)
>  {
>  	int  banks = 16, ranks, rows, cols, npages;
> @@ -323,8 +323,8 @@ int skx_get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
>  		 imc->mc, chan, dimmno, size, npages,
>  		 banks, 1 << ranks, rows, cols);
>  
> -	imc->chan[chan].dimms[dimmno].close_pg = GET_BITFIELD(mtr, 0, 0);
> -	imc->chan[chan].dimms[dimmno].bank_xor_enable = GET_BITFIELD(mtr, 9, 9);
> +	imc->chan[chan].dimms[dimmno].close_pg = GET_BITFIELD(mcmtr, 0, 0);
> +	imc->chan[chan].dimms[dimmno].bank_xor_enable = GET_BITFIELD(mcmtr, 9, 9);
>  	imc->chan[chan].dimms[dimmno].fine_grain_bank = GET_BITFIELD(amap, 0, 0);
>  	imc->chan[chan].dimms[dimmno].rowbits = rows;
>  	imc->chan[chan].dimms[dimmno].colbits = cols;
> diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
> index 19dd8c099520..78f8c1de0b71 100644
> --- a/drivers/edac/skx_common.h
> +++ b/drivers/edac/skx_common.h
> @@ -135,7 +135,7 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
>  
>  int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm);
>  
> -int skx_get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
> +int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
>  		      struct skx_imc *imc, int chan, int dimmno);
>  
>  int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,

Acked-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu

