Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C521036D83
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2019 09:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFFHmP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 03:42:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40310 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHmP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jun 2019 03:42:15 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so560489ioc.7;
        Thu, 06 Jun 2019 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2P7+9BrsV7BFobAF6Gcf5hOBXDyVsf7Cw11pqeBfG0=;
        b=lhHIkf2p/bhc9lWToqafMcafzKV+1jJqbUCG7KNnGqFyzeGt/DTmAF2+xs4d33W5/v
         7iBI9jnRJGEJ4oFuU42IfmcB1VjOoRLb86BoiUrqPN5UlJ+h1zk5dVfF8Htjh3rcE2yv
         A89dNT+HybPHVCM0z+ynLI1HEYDQ3s4ZlPXi3gzGp3y+kFW3SKAkMaMtmrxXWbZQbXaB
         qEDcCsrPo8rcVxCEbcxqpYw5gyTNNnfjI46gezgvpGnRj0lhgO2iQLJjbz2T6Qhyjg/a
         xtjIzO6o4JywE81qxr5HEgraSdy2BM5Ko6Gx3GzaV6FndQOGynmNEy4negaMR6caGjel
         24QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2P7+9BrsV7BFobAF6Gcf5hOBXDyVsf7Cw11pqeBfG0=;
        b=Bccff4a02kI+fsnSgs544EzMSxo6ipGBq9abL5sc+qL2JqCSjg/+Q+TI3yy6wCOP0m
         QcuJkQ8V2kazbC/a8JlHzobKFO4Q9OMGp5Yn4K9vlNrayunGLc3CgiL2PEgpO1o4/UCJ
         2OHGznYFlA6Dtzng7coVsaZzSPFj1MEUnTz/4SINSzWS1GEZjRbZ7NLTD+WhkthktDDz
         NsA90fwEj3VD8O89XzxOCpAqFmITk8tfBD0IIdzjea1Okjz6JydpG0oRBmtzyWQ3AVXn
         PQ7ypcnIbdjYXfueBrWH48sd49snCCR8n/gdEpwIw/mwIXO3U7xJ3cY6XX59N2IDBc8r
         aBHA==
X-Gm-Message-State: APjAAAV7f0zdp6AD6FoNmhCMi68jhFr9nc+9aa1iSNz3uiCaJMYA5CTN
        nnM7ngChwULADBagZAbIYqilILF3w7rdhgZ1Uw==
X-Google-Smtp-Source: APXvYqy6Ko9syXmU0XkEyDc/Q2Tk12TRz8+zmvPobBbovp2+NfN8I44+rRcRfj31jwt3e23eYV98CO+eDjREb/FXK1w=
X-Received: by 2002:a5d:9251:: with SMTP id e17mr8467626iol.21.1559806934290;
 Thu, 06 Jun 2019 00:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190605141253.38554-1-ghung.quanta@gmail.com> <20190605141253.38554-2-ghung.quanta@gmail.com>
In-Reply-To: <20190605141253.38554-2-ghung.quanta@gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Thu, 6 Jun 2019 10:41:46 +0300
Message-ID: <CAKKbWA71P+afSiWPoth90-Ydq4DBmxSK_yTRWSN+FPw10CqFAQ@mail.gmail.com>
Subject: Re: [PATCH 5.2 v2 2/2] dt-binding: edac: add NPCM ECC documentation
To:     George Hung <ghung.quanta@gmail.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>, paulmck@linux.ibm.com,
        Patrick Venture <venture@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        "William A. Kennington III" <wak@google.com>, davem@davemloft.net,
        Tomer Maimon <tomer.maimon@nuvoton.com>,
        Avi Fishman <Avi.Fishman@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 5, 2019 at 5:19 PM George Hung <ghung.quanta@gmail.com> wrote:
>
> Add device tree documentation for Nuvoton BMC ECC
>
> Signed-off-by: George Hung <ghung.quanta@gmail.com>

Reviewed-by: Avi Fishman <avifishman70@gmail.com>

> ---
>  .../bindings/edac/npcm7xx-sdram-edac.txt        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt
>
> diff --git a/Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt b/Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt
> new file mode 100644
> index 000000000000..dd4dac59a5bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/npcm7xx-sdram-edac.txt
> @@ -0,0 +1,17 @@
> +Nuvoton NPCM7xx SoC EDAC device driver
> +
> +The Nuvoton NPCM7xx SoC supports DDR4 memory with/without ECC and the driver
> +uses the EDAC framework to implement the ECC detection and corrtection.
> +
> +Required properties:
> +- compatible:  should be "nuvoton,npcm7xx-sdram-edac"
> +- reg:         Memory controller register set should be <0xf0824000 0x1000>
> +- interrupts:  should be MC interrupt #25
> +
> +Example:
> +
> +       mc: memory-controller@f0824000 {
> +               compatible = "nuvoton,npcm7xx-sdram-edac";
> +               reg = <0xf0824000 0x1000>;
> +               interrupts = <0 25 4>;
> +       };
> --
> 2.21.0
>


-- 
Regards,
Avi
