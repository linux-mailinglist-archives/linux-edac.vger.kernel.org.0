Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD1F5DCB
	for <lists+linux-edac@lfdr.de>; Sat,  9 Nov 2019 08:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfKIH2I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Nov 2019 02:28:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKIH2I (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Nov 2019 02:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4j3hTmax7mad/kEmIkt+tEDYzel5W1al3JAspAyNu+A=; b=TKe28YANSZuBn7sgl7v8/1Thd
        hcxHeiRQuHl6pzVY8zReuQeT9iRW3IoNpfKEYPvBc9T3An6h3DnWTFpDgn6qjbnuBZuMRbejpKnJE
        AqDvc0QUuw+gvPFIcC2GQ2/628+pJ6MY36DBdqcfmapucmaAmcRsQWJPGeVsV3+aJIex5Xx1LkL/J
        RX0vpDzRNSyHZz/JeyffjpczTsIogi+c9v34XHolCaTs0IdedMghPUAMf/1n+3AcZdJDe/wkBfROw
        1KNHWBVkwFYWhWJd/55FV2ebTWD4g7XwequaWDGl5KhtdtjI3SVWGXgB1fzeVfYEmHf0ikIKi1nLd
        SZ3GBtBCw==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTLAD-0006Ag-3Z; Sat, 09 Nov 2019 07:28:05 +0000
Date:   Sat, 9 Nov 2019 08:28:01 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 05/20] EDAC, mc: Remove needless zero string
 termination
Message-ID: <20191109082801.5d999284@kernel.org>
In-Reply-To: <20191106093239.25517-6-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
        <20191106093239.25517-6-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 6 Nov 2019 09:33:11 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Since this is a string already and strlen() has been used to advance
> the pointer, the end of the buffer is already zero terminated. Remove
> the needless zero string termination.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  drivers/edac/edac_mc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index f2cbca77bc50..8bfe76d1bdf1 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1183,7 +1183,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			}
>  			strcpy(p, dimm->label);
>  			p += strlen(p);
> -			*p = '\0';
>  
>  			/*
>  			 * get csrow/channel of the DIMM, in order to allow




Cheers,
Mauro
