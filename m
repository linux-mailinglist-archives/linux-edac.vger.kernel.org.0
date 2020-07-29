Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31BA23270B
	for <lists+linux-edac@lfdr.de>; Wed, 29 Jul 2020 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2Vll (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Jul 2020 17:41:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:21440 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2Vlk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 Jul 2020 17:41:40 -0400
IronPort-SDR: cOR5lNJQTPJWU8PL9icwfhbXMaAL/c6spL4v+nTJh4BONmMoyEbvZUqenAvRKI9XMo/3dh8pXm
 QtgJowHSwgMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236368740"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="236368740"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 14:41:40 -0700
IronPort-SDR: 9ZNHdzBPqCNFFW1X5KT/A4BaV3wcJGvZFtV/GIb3Hf2amUHOVsSUAvEmGRGOx/rlEyTPhlu+XT
 rjfdK/P6whJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="290672455"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2020 14:41:39 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: edac: socfpga: transfer SoCFPGA EDAC
 maintainership
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de
References: <20200729174511.4256-1-dinguyen@kernel.org>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <cf3a5ec4-2f7f-e559-b863-1cb73877c978@linux.intel.com>
Date:   Wed, 29 Jul 2020 16:41:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729174511.4256-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 7/29/20 12:45 PM, Dinh Nguyen wrote:
> Thor Thayer is leaving Intel and will no longer be able to maintain the
> EDAC for SoCFPGA, thus transfer maintainership to Dinh Nguyen.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0569cf304ca..c53fc9febf12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2466,7 +2466,7 @@ S:	Maintained
>   F:	drivers/clk/socfpga/
>   
>   ARM/SOCFPGA EDAC SUPPORT
> -M:	Thor Thayer <thor.thayer@linux.intel.com>
> +M:	Dinh Nguyen <dinguyen@kernel.org>
>   S:	Maintained
>   F:	drivers/edac/altera_edac.
>   
Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
