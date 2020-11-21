Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACD52BBF19
	for <lists+linux-edac@lfdr.de>; Sat, 21 Nov 2020 13:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgKUM6J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Nov 2020 07:58:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33692 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgKUM6I (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 21 Nov 2020 07:58:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id n12so7956810otk.0;
        Sat, 21 Nov 2020 04:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zT5nsXtgRT2unke0UjU+1nY/84bCqRoQDrr11fu7upI=;
        b=T0ZVeTkh+q/YkyTSP5xHfzJ9nEj++n/vMbyHbGFkNAGbgrWuaf1kn07EM1YAknIsYj
         1DXhOtbv1yVcKCJheps8dohhjQMon4NI5L29zQDhpEnvY7MqBcKLdBH6BxwUllxYxqj/
         6J7mjDKta/O5c65EnFTpRWIVBLBG6MJ+EmCV7w1ggBmvlAukeVWsp7XFH07zG4TPUT5V
         kYlg0gwo9HhcUDlSg6FTU79JXp3PzNr7MMOsrQKcpToiAj9gFAxQC0w9NR16eAwJsZzg
         pCl+MOTy2U4pj8GHUMoasMNNPBuWYP6chGzCot4hwPNOnmTdj+Nf2vLV5u6H7Yby1Sm9
         /CWw==
X-Gm-Message-State: AOAM5336KMoh9DsOAOjF3v8glVmiNRyv+NMKVL8LPg08co1Nwvkya4OM
        yJm0JnfGAhttTBD4QIDMFuAbCQJ9/w==
X-Google-Smtp-Source: ABdhPJyi6QF+v9vmlx3hcllz6h1KrSCTbE0w4UYo9A5MQQ+ajL0XRK+lVCrpTxHMBmU04hODW5FWWQ==
X-Received: by 2002:a9d:3ef7:: with SMTP id b110mr16411634otc.333.1605963487924;
        Sat, 21 Nov 2020 04:58:07 -0800 (PST)
Received: from xps15 ([2607:fb90:5feb:6270:cdf7:680e:59f2:6ccd])
        by smtp.gmail.com with ESMTPSA id a20sm3071403otp.54.2020.11.21.04.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 04:58:07 -0800 (PST)
Received: (nullmailer pid 2085798 invoked by uid 1000);
        Sat, 21 Nov 2020 12:58:01 -0000
Date:   Sat, 21 Nov 2020 06:58:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     devicetree@vger.kernel.org, palmer@dabbelt.com, mchehab@kernel.org,
        james.morse@arm.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        bp@alien8.de, linux-edac@vger.kernel.org, paul.walmsley@sifive.com,
        tony.luck@intel.com, rric@kernel.org, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: riscv: Add DT documentation for SiFive
 Bus Error Unit
Message-ID: <20201121125801.GA2085750@robh.at.kernel.org>
References: <1605182457-86046-1-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605182457-86046-1-git-send-email-yash.shah@sifive.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 12 Nov 2020 17:30:55 +0530, Yash Shah wrote:
> Add DT json-schema for SiFive Bus Error unit present in FU740-C000 chip
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/riscv/sifive-beu.yaml      | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-beu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
