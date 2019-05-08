Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500A41826B
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEHWsJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 May 2019 18:48:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:63589 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfEHWsI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 May 2019 18:48:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 15:48:08 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2019 15:48:07 -0700
Date:   Wed, 8 May 2019 15:48:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: remove redundant update of tad_base
Message-ID: <20190508224807.GA25404@agluck-desk>
References: <20190508224201.27120-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508224201.27120-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 08, 2019 at 11:42:01PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable tad_base is being set to a value that is never read
> and is being over-written on the next iteration of a for-loop.
> This assignment is therefore redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/edac/sb_edac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 9353c3fc7c05..6aa4b1b73a15 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -1513,7 +1513,6 @@ static int knl_get_dimm_capacity(struct sbridge_pvt *pvt, u64 *mc_sizes)
>  						sad_actual_size[mc] += tad_size;
>  					}
>  				}
> -				tad_base = tad_limit+1;
>  			}
>  		}
>  

Looks good to me.

Acked-by: Tony Luck <tony.luck@intel.com>
