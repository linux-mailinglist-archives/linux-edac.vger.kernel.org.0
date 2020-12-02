Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0372CB52C
	for <lists+linux-edac@lfdr.de>; Wed,  2 Dec 2020 07:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgLBGlk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 01:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgLBGlk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Dec 2020 01:41:40 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65295C0613CF;
        Tue,  1 Dec 2020 22:41:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 1so363203qka.0;
        Tue, 01 Dec 2020 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsQG66ogMkwZdKFQkQN61BxKHgVwTX3yIoCFi8hjgmk=;
        b=TmhU1G/civwSH2xVNR+wd8Tc38tSsSF/BEjXVOgCrgkDAX3yAgSHDI6iOmol8viFZ/
         V/LgV2Esto9D7YRAwpElOZDJN1nrefaMvZX1UfX2m68TLwwHjnvJc3AaXzRZ4duxgwt3
         oR4vtgwTOqk4ox6BrNdB15Fb/ud2oGwVdk7Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsQG66ogMkwZdKFQkQN61BxKHgVwTX3yIoCFi8hjgmk=;
        b=ZpguY7Vleqk4C1ovta0eBnHi9aoDWixO0M9X+rAecFJNevE9k2y2D7oDNFvaO5HXPo
         ieTmC/GQXPrnmpcQ3MbVxLHXxnkSr5eklL7bebg9bNHkHN9W49rJR3O4+KLZT/XsdWku
         R7+X9wF3ZtV+D7P2VeyKSqWOG0vO1Jk12x7hqhRoLSJ0R0Wlzml/m3i0rUrhfFkOUcrK
         Lwq8r9Y6jeIC2OSt/+VqV2o+WsRqWsS3j6kAJNfHdJOXUtR3z80sg5zBl/52Lbj/r9Vt
         WvmJstjz6Z+TYW1BWAD2mVRj9I9nEbJGNCWLNvI25Qb4Hsy5X8vRb9rB4HtkDHkjJG1T
         JEDQ==
X-Gm-Message-State: AOAM533F+XLj5rJxpHPEu1cbMmHZ5wQ9Nk9VwgixSVcaaWbMt0beiESY
        j3aGmDD0SFnFz6CfVxZG4b5zr7KrG68O98GIs6I=
X-Google-Smtp-Source: ABdhPJyHhjBvQ5jmIJOnO5MBEjtcEXfCH94HEH1dTW3C/wpL1Eixxs2Byoua6rHNv4K98W/gOC+5oELpg7lvVLVbCkc=
X-Received: by 2002:a37:6805:: with SMTP id d5mr1164392qkc.66.1606891259402;
 Tue, 01 Dec 2020 22:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
In-Reply-To: <20201202063612.21241-1-troy_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Dec 2020 06:40:47 +0000
Message-ID: <CACPK8XfySi5=r4e__djHg-LtFqhV7j+-Pp+t4zevro=KK0eBig@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: edac: aspeed-sdram-edac: Add
 ast2400/ast2600 support
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        leetroy@gmail.com, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2 Dec 2020 at 06:37, Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> Adding Aspeed AST2400 and AST2600 binding for edac driver.
>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../devicetree/bindings/edac/aspeed-sdram-edac.txt       | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> index 6a0f3d90d682..8ca9e0a049d8 100644
> --- a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> +++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> @@ -1,6 +1,6 @@
> -Aspeed AST2500 SoC EDAC node
> +Aspeed BMC SoC EDAC node
>
> -The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
> +The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
>  correction check).
>
>  The memory controller supports SECDED (single bit error correction, double bit
> @@ -11,7 +11,10 @@ Note, the bootloader must configure ECC mode in the memory controller.
>
>
>  Required properties:
> -- compatible: should be "aspeed,ast2500-sdram-edac"
> +- compatible: should be one of
> +       - "aspeed,ast2400-sdram-edac"
> +       - "aspeed,ast2500-sdram-edac"
> +       - "aspeed,ast2600-sdram-edac"
>  - reg:        sdram controller register set should be <0x1e6e0000 0x174>
>  - interrupts: should be AVIC interrupt #0
>
> --
> 2.17.1
>
