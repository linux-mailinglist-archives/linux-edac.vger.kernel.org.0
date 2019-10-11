Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E006AD3E74
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 13:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJKL3c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 07:29:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfJKL3c (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 07:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2gnrnq0b1cJHF7UrkY83zB5NvhPCkH+k9lh4yFFL/IM=; b=DDNekGf9eQ66f2JHleru+yee5
        N8UdvTRkKyH10olnWISCQVkCVJyfLW5DJfKua+A+tuqU7ROwqWPgtTOlTS66sCAI8ezJWCPcaN6Dv
        z/MwufnUVYijP8EdhAoTS+GcXvuHlbA7eoUj9+LVC+XRVur33Wuc2kZvGNi4ZdNSWlfuMZ4Mb/sKT
        s/nypfmQIfy/pwIUGpjpgqODRL88cx+bSasQFvQsCYIUcLaMEohH2paaE+A50TF6xsjdUwkejsUvY
        HCKRHAjxyyWF0BXJ5pfn2mGA2m6efQ/0mjVKe4MB6dO7rMezHA1lB1bev9WIeQ1+IiK50wrpI/MNC
        t0eZlJxbg==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIt6j-0002jK-JH; Fri, 11 Oct 2019 11:29:18 +0000
Date:   Fri, 11 Oct 2019 08:29:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 19/19] EDAC, Documentation: Describe CPER module
 definition and DIMM ranks
Message-ID: <20191011082913.6514e126@coco.lan>
In-Reply-To: <20191010202418.25098-20-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-20-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:42 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Update on CPER DIMM naming convention and DIMM ranks.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/admin-guide/ras.rst | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
> index 2b20f5f7380d..26e02a59f0f4 100644
> --- a/Documentation/admin-guide/ras.rst
> +++ b/Documentation/admin-guide/ras.rst
> @@ -330,9 +330,12 @@ There can be multiple csrows and multiple channels.
>  
>  .. [#f4] Nowadays, the term DIMM (Dual In-line Memory Module) is widely
>    used to refer to a memory module, although there are other memory
> -  packaging alternatives, like SO-DIMM, SIMM, etc. Along this document,
> -  and inside the EDAC system, the term "dimm" is used for all memory
> -  modules, even when they use a different kind of packaging.
> +  packaging alternatives, like SO-DIMM, SIMM, etc. The UEFI
> +  specification (Version 2.7) defines a memory module in the Common
> +  Platform Error Record (CPER) section to be an SMBIOS Memory Device
> +  (Type 17). Along this document, and inside the EDAC system, the term
> +  "dimm" is used for all memory modules, even when they use a
> +  different kind of packaging.
>  
>  Memory controllers allow for several csrows, with 8 csrows being a
>  typical value. Yet, the actual number of csrows depends on the layout of
> @@ -349,12 +352,14 @@ controllers. The following example will assume 2 channels:
>  	|            |  ``ch0``  |  ``ch1``  |
>  	+============+===========+===========+
>  	| ``csrow0`` |  DIMM_A0  |  DIMM_B0  |
> -	+------------+           |           |
> -	| ``csrow1`` |           |           |
> +	|            |   rank0   |   rank0   |
> +	+------------+     -     |     -     |
> +	| ``csrow1`` |   rank1   |   rank1   |
>  	+------------+-----------+-----------+
>  	| ``csrow2`` |  DIMM_A1  | DIMM_B1   |
> -	+------------+           |           |
> -	| ``csrow3`` |           |           |
> +	|            |   rank0   |   rank0   |
> +	+------------+     -     |     -     |
> +	| ``csrow3`` |   rank1   |   rank1   |
>  	+------------+-----------+-----------+
>  
>  In the above example, there are 4 physical slots on the motherboard
> @@ -374,11 +379,13 @@ which the memory DIMM is placed. Thus, when 1 DIMM is placed in each
>  Channel, the csrows cross both DIMMs.
>  
>  Memory DIMMs come single or dual "ranked". A rank is a populated csrow.
> -Thus, 2 single ranked DIMMs, placed in slots DIMM_A0 and DIMM_B0 above
> -will have just one csrow (csrow0). csrow1 will be empty. On the other
> -hand, when 2 dual ranked DIMMs are similarly placed, then both csrow0
> -and csrow1 will be populated. The pattern repeats itself for csrow2 and
> -csrow3.
> +In the example above 2 dual ranked DIMMs are similarly placed. Thus,
> +both csrow0 and csrow1 are populated. On the other hand, when 2 single
> +ranked DIMMs are placed in slots DIMM_A0 and DIMM_B0, then they will
> +have just one csrow (csrow0) and csrow1 will be empty. The pattern
> +repeats itself for csrow2 and csrow3. Also note that some memory
> +controller doesn't have any logic to identify the memory module, see
> +``rankX`` directories below.
>  
>  The representation of the above is reflected in the directory
>  tree in EDAC's sysfs interface. Starting in directory



Thanks,
Mauro
