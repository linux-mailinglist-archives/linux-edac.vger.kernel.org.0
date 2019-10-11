Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53EA7D3D1A
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJKKPb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:15:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJKKPb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hwAR1Sr46cSaooqzU/ZAWX1QuPmPGh5n5goPhXbgX84=; b=CqYZPhQ8646YFp3Ha820yNtHl
        Q/IBaN2sO82C028r3cQGksf7M/GL/Dgt1xQxyZdEhgBkmrHRT/MjH6gMLUoVr4IOoeR53fQxdhRbP
        jRyQjW2fPKTn9rWWPMh0axSwPq4OSxzvpttwcpZn2tqEC/vw+iTicF1bUaEMsiz/EJNrRu3nXtDVL
        3i4cDEkQgaIL/F/mOBLgES0IB5JlKw1HwqS3UIq1yGPiaVCeIrjWUIH8067ABH+9s0EtqLgX1cSlz
        /UZBts90XbVn7MG2KMHCRQH8/TNw4ancp3jPx4HEv7dOQ+B/q9gFUeG5fcf7Rol87pfAihNhrKgcN
        idJc0GRqw==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIrxH-00034M-W1; Fri, 11 Oct 2019 10:15:28 +0000
Date:   Fri, 11 Oct 2019 07:15:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/19] EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
Message-ID: <20191011071523.1f121599@coco.lan>
In-Reply-To: <20191010202418.25098-5-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-5-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:12 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> No need to crash the system in case edac_mc_alloc() is called with
> invalid arguments, just warn and return. This would cause a checkpatch
> warning when touching the code later, so just fix it.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index c5240bb4c6c0..f2cbca77bc50 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -323,7 +323,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	int i, j, row, chn, n, len;
>  	bool per_rank = false;
>  
> -	BUG_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0);
> +	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> +		return NULL;
> +
>  	/*
>  	 * Calculate the total amount of dimms and csrows/cschannels while
>  	 * in the old API emulation mode



Thanks,
Mauro
