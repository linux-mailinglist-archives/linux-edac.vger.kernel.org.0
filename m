Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCDB1F5A23
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jun 2020 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgFJRTP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jun 2020 13:19:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:47811 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgFJRTO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 10 Jun 2020 13:19:14 -0400
IronPort-SDR: sR9lifVVQCTHBATsQZWehFn7wpOFphzJN8y+abrU6aDd+CHM2lrZdJwIu3IzPg8UlXQlmy4YXn
 s0P+QMXUcu/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:19:14 -0700
IronPort-SDR: kx5x97zDI+jMG/eqid0UpxmxpyBmfYSZ6mzpplV3XC3EcPNgDsT2z0Zg8KYyLp7tK2r1pHyElA
 jjaDzawW/gvA==
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="447585617"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 10:19:13 -0700
Date:   Wed, 10 Jun 2020 10:19:12 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        rrichter@marvell.com
Subject: Re: [PATCH] EDAC/mc: call edac_inc_ue_error() before panic
Message-ID: <20200610171912.GB1474@agluck-desk2.amr.corp.intel.com>
References: <20200610065846.3626-1-zhenzhong.duan@gmail.com>
 <20200610065846.3626-2-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610065846.3626-2-zhenzhong.duan@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 10, 2020 at 02:58:46PM +0800, Zhenzhong Duan wrote:
> By calling edac_inc_ue_error() before panic, we get a correct UE error
> count for core dump analysis.

Looks accurate, and I'll add the patch to be applied. But I wonder
how big a problem it is. Isn't most of the information deriveable
from the panic message?

> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  drivers/edac/edac_mc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 75ede27..c1f23c2 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1011,6 +1011,8 @@ static void edac_ue_error(struct edac_raw_error_desc *e)
>  			e->other_detail);
>  	}
>  
> +	edac_inc_ue_error(e);
> +
>  	if (edac_mc_get_panic_on_ue()) {
>  		panic("UE %s%son %s (%s page:0x%lx offset:0x%lx grain:%ld%s%s)\n",
>  			e->msg,
> @@ -1020,8 +1022,6 @@ static void edac_ue_error(struct edac_raw_error_desc *e)
>  			*e->other_detail ? " - " : "",
>  			e->other_detail);
>  	}
> -
> -	edac_inc_ue_error(e);
>  }
>  
>  static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int chan)
> -- 
> 1.8.3.1
> 
