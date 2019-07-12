Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E751B67249
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfGLPZW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Jul 2019 11:25:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:22320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfGLPZW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 12 Jul 2019 11:25:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 08:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; 
   d="scan'208";a="365639538"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2019 08:25:20 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH 1/3] Documentation: dt: edac: Add reg to S10 SDRAM node
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org
References: <1562711090-900-1-git-send-email-thor.thayer@linux.intel.com>
 <1562711090-900-2-git-send-email-thor.thayer@linux.intel.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <803a63f8-c096-f1ec-7a80-c54d6c1f6281@linux.intel.com>
Date:   Fri, 12 Jul 2019 10:27:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1562711090-900-2-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 7/9/19 5:24 PM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Include the register offset and size in the Stratix10 SDRAM node
> to be consistent with other ECC modules.
> Previously had to follow the phandle to get the register size/offset.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>   Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> index 8f52206cfd2a..dd6ba6c020a7 100644
> --- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> +++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> @@ -256,6 +256,7 @@ Subcomponents:
>   SDRAM ECC
>   Required Properties:
>   - compatible : Should be "altr,sdram-edac-s10"
> +- reg        : Address and size for ECC block registers.
>   - interrupts : Should be single bit error interrupt.
>   
>   On-Chip RAM ECC
> @@ -313,8 +314,9 @@ Example:
>   		#interrupt-cells = <2>;
>   		ranges;
>   
> -		sdramedac {
> +		sdramedac@0xf8011100 {
>   			compatible = "altr,sdram-edac-s10";
> +			reg = <0xf8011100 0xc0>;
>   			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> 
Please disregard this patch, there is a simpler solution that I will 
submit shortly.
