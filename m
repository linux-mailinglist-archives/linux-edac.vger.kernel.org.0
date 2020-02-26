Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA6170601
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2020 18:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgBZRZC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Feb 2020 12:25:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44215 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgBZRZC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Feb 2020 12:25:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so126604otj.11;
        Wed, 26 Feb 2020 09:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yb77lX4u8E1KgquIZ2ynLlBnmpMTUMg6FQSIil/Vxcs=;
        b=QeEfc/Wu4jFNwikKJxTa/zPs43H9fsZuo4E8+cyv6lC76EIF/LbCCgFMSVYKkx9jnH
         jqzoTfZNxgrTHaBsFghk6Cty4RvHepbOcxxmYesNxtMkrqRqfB0r9I7uPclLApCjhOFH
         sF5crVhhPj+u6WnFkkdPQr95Z5QP01f7NL90pmPjqho6fDE/Dbw3g95LdC4Lb64nWENG
         GdT1wUbJJ7j6DCHxzxREvDQmEsAbCBBU1VexAvPAornBsL8RMZk+JjyKEUQM68y3fmQN
         7devRRswrMmgEgNmY+a/Nf1v4VJSYBWF7vnNjq0/DGaeNG9OR8hO4EHU15r4U89AgfU7
         YFJg==
X-Gm-Message-State: APjAAAVSPp4y9E+jWgtWZcjPFG5v9vkMK9hUdoCFB2NKwiP7TsOiT9so
        gecaDfm9oo2mthOHEFfzDQ==
X-Google-Smtp-Source: APXvYqxh7OvOm+I6luRzH5Ps9jscYhc0/25GuLaMVgFT8ccRv6XeYmD+XjX31DFJisEiuomHvdre1A==
X-Received: by 2002:a9d:624e:: with SMTP id i14mr4079861otk.371.1582737900975;
        Wed, 26 Feb 2020 09:25:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a30sm964052otc.79.2020.02.26.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:24:59 -0800 (PST)
Received: (nullmailer pid 5983 invoked by uid 1000);
        Wed, 26 Feb 2020 17:24:57 -0000
Date:   Wed, 26 Feb 2020 11:24:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     sherry sun <sherry.sun@nxp.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, mark.rutland@arm.com,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: memory-controllers: Add i.MX8MP DDRC
 binding doc
Message-ID: <20200226172457.GA3267@bogus>
References: <1582267156-20189-1-git-send-email-sherry.sun@nxp.com>
 <1582267156-20189-2-git-send-email-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582267156-20189-2-git-send-email-sherry.sun@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 21, 2020 at 02:39:14PM +0800, sherry sun wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Add documentation for i.MX8MP DDRC binding based on synopsys_edac doc,
> which use the same memory-controller IP.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  .../devicetree/bindings/memory-controllers/synopsys.txt   | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
> index 9d32762c47e1..5c03959a451f 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
> @@ -6,16 +6,20 @@ bus width configurations.
>  The Zynq DDR ECC controller has an optional ECC support in half-bus width
>  (16-bit) configuration.
>  
> -These both ECC controllers correct single bit ECC errors and detect double bit
> +The i.MX8MP DDR ECC controller has an ECC support in 64-bit bus width
> +configurations.
> +
> +These all ECC controllers correct single bit ECC errors and detect double bit

All the ECC...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

>  ECC errors.
>  
>  Required properties:
>   - compatible: One of:
>  	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
>  	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
> +	- 'fsl,imx8mp-ddrc' : i.MX8MP DDR ECC controller
>   - reg: Should contain DDR controller registers location and length.
>  
> -Required properties for "xlnx,zynqmp-ddrc-2.40a":
> +Required properties for "xlnx,zynqmp-ddrc-2.40a" and "fsl,imx8mp-ddrc":
>   - interrupts: Property with a value describing the interrupt number.
>  
>  Example:
> -- 
> 2.17.1
> 
