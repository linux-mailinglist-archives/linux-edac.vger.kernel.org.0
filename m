Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58511105B4B
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 21:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKUUnx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 15:43:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37319 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUUnx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 21 Nov 2019 15:43:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id d5so4224437otp.4;
        Thu, 21 Nov 2019 12:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlY1A8YgbiK+60pvRJ8DUoVbvF7KpED+RvNVlOCutDw=;
        b=g1YcJRBDjxoNd2WGDbRAba/cyBuLWWmgudEDRgg+mzaJoavRwL6DfKDu3gwulH7NkM
         RygfoTBcLRUc9vF2Ocv5IrzYQMDntBxYxDJsp2/PQac11OU5W2D9MXoKa8uuk6mlc3rw
         6+iiJjiBnReLDkFlA4LNgN1AMkTcCUG8we70OGAhyusaxAqfTaKi9lNZqu7+PIGNAZ91
         SLhc+j+l/f7pn6ZXjZHbl6WGznbAxYQvXMNdQGA9NFO8ebUaZBn5Onnjo2L8xCR6bV5e
         szUvWJQYzxr/IcvJNnTy3gFTI59n8ETdY0e7DhMavyE2bVEi1XJDhidej2tsKXbyPZ7X
         UgSw==
X-Gm-Message-State: APjAAAX5yvqbMSrodWgLq3NHVUOtWe9gCi0eSDT2MaLeJ3GgFHiZJim1
        9esJTVK6hDimmyMSUPZEWQ==
X-Google-Smtp-Source: APXvYqz7zeXYFjWtkAp64VlSzXcHl1NJpaBwIHih5lkI+qSuWC4igd8Twoc2Iepnvc1i+AZuUUZQXg==
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr8235445otq.312.1574369032176;
        Thu, 21 Nov 2019 12:43:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a10sm1354822otf.72.2019.11.21.12.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:43:51 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:43:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     bp@alien8.de, james.morse@arm.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, linux-edac@vger.kernel.org, sashal@kernel.org,
        hangl@microsoft.com, lewan@microsoft.com, ruizhao@microsoft.com,
        scott.branden@broadcom.com, yuqing.shen@broadcom.com,
        ray.jui@broadcom.com, shji@microsoft.com, wangglei@gmail.com
Subject: Re: [PATCH v7 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <20191121204350.GA26174@bogus>
References: <f947d821-8e67-dcc7-d753-5b04d099792d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f947d821-8e67-dcc7-d753-5b04d099792d@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Nov 17, 2019 at 06:10:43PM -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v7:
>          - Added arm prefix to the interrupt-config property
> 
> ---
>  .../devicetree/bindings/edac/arm-dmc520.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/arm-dmc520.txt b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
> new file mode 100644
> index 000000000000..476cf8b76f2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/arm-dmc520.txt
> @@ -0,0 +1,26 @@
> +* ARM DMC-520 EDAC node
> +
> +Required properties:
> +- compatible  : "brcm,dmc-520", "arm,dmc-520".
> +- reg   : Address range of the DMC-520 registers.
> +- interrupts  : DMC-520 interrupt numbers. The example below specifies
> +     two interrupt lines for dram_ecc_errc_int and
> +     dram_ecc_errd_int.
> +- arm,interrupt-config : This is an array of interrupt masks. For each of the
> +     above interrupt line, add one interrupt mask element to
> +     it. That is, there is a 1:1 mapping from each interrupt
> +     line to an interrupt mask. An interrupt mask can represent
> +     multiple interrupts being enabled. Refer to interrupt_control
> +     register in DMC-520 TRM for interrupt mapping. In the example
> +     below, the interrupt configuration enables dram_ecc_errc_int
> +     and dram_ecc_errd_int. And each interrupt is connected to
> +     a separate interrupt line.

Looking at this again, I think I now understand what you are trying to 
do. Your mask is just what interrupt line each one is. We have a 
standard way of doing this either by using indices of 'interrupts' or 
with interrupt-names. The latter probably works best in this case.

You need to define *all* the interrupt-names:
combined
ram_ecc_errc
ram_ecc_errd
dram_ecc_errc
dram_ecc_errd
failed_access
failed_prog
link_err
temperature_event
arch_fsm
phy_request

I'm not sure if all the '*_oflow' interrupts should be listed too. It 
doesn't seem all that useful to get a 2nd interrupt.

Your node should list all that are hooked up in the h/w, not just the 
ones you need for EDAC.

Rob
