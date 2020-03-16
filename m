Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A30186821
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 10:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgCPJpT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 05:45:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36112 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgCPJpT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 05:45:19 -0400
Received: from zn.tnic (p200300EC2F06AB0069F33882ABEAD541.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:69f3:3882:abea:d541])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D7781EC0A9C;
        Mon, 16 Mar 2020 10:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584351917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=er1/yi3HrpV0pKbBvQNLcsrrISJcbRo0gz2JglnSHYA=;
        b=SOcDdD2uAhMLX8/rfv4mvESr5GbRTWbfRrTXCC88Pt0fDoZQSqQso/kcaBSYgoHy0kqxAB
        fXNKH7mfYE1lj471zikh1Mj5MewzDJLeai9M17WecqslbNwPYsoJLSl4YDlukuAuDpueyD
        d+AzHVyTwd2rKLzYpU2AtZcTQ94unhQ=
Date:   Mon, 16 Mar 2020 10:45:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] EDAC/ghes: Create an own device for each mci
Message-ID: <20200316094527.GD26126@zn.tnic>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-11-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306151318.17422-11-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 06, 2020 at 04:13:17PM +0100, Robert Richter wrote:
> Each edac mc must have a unique device for identification (see
> add_mc_to_global_list()). This 1:1 mapping between parent device and
> mci is a limitation for supporting multiple instances created by the
> ghes driver. Solve this by creating an own device in between of the
> ghes parent and the mci struct, this allows a 1:n mapping between
> both.
> 
> Implement this using a platform device as this is the least possible
> effort to create and free a device. It shows up nicely in sysfs:
> 
>  # find /sys/ -name ghes_mc*
>  /sys/devices/platform/GHES.0/ghes_mc.1
>  /sys/devices/platform/GHES.0/ghes_mc.0
>  /sys/bus/platform/devices/ghes_mc.1
>  /sys/bus/platform/devices/ghes_mc.0
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index cd61b8ae49f6..64220397296e 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -539,6 +539,8 @@ static struct acpi_platform_list plat_list[] = {
>  static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
>  					int num_dimm)
>  {
> +	struct platform_device_info pdevinfo;
> +	struct platform_device *pdev;
>  	struct edac_mc_layer layers[1];
>  	struct mem_ctl_info *mci;
>  	struct ghes_mci *pvt;
> @@ -547,13 +549,23 @@ static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
>  	layers[0].size = num_dimm;
>  	layers[0].is_virt_csrow = true;
>  
> +	pdevinfo	= (struct platform_device_info){
> +		.parent	= dev,
> +		.name	= "ghes_mc",
> +		.id	= mc_idx,
> +	};

You can statically allocate that one once at the top of the file and
assign ->parent and ->id each time before calling the function below.

> +
> +	pdev = platform_device_register_full(&pdevinfo);
> +	if (IS_ERR(pdev))
> +		goto fail;
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
