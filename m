Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB762D93
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 03:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfGIBlB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Jul 2019 21:41:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38271 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfGIBlA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Jul 2019 21:41:00 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so39689197ioa.5;
        Mon, 08 Jul 2019 18:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fpLbSng1uN6X7o4b5xQuv3f/Fj2KEoI/i2jodHhjdM=;
        b=IEIEf5+5vI41Gt3a2VyPVqnQI7JapuukjjmTZi1Lzk747APtM8MTAr/pYoPiyDDtMi
         hdsS3liAMEfKjJR2hjslSepLuMeDZCEf4wPrqYQU8m19I3Bwba/rBvkgq6aukqex4JZE
         uB+r35WO3a8f8J44jK4odgiT9um8lvvibSqYbtDvkb6RlUUUgLysLAM7GJu/yN968QE4
         JJ/LQJNQHS2DyScQwZchfOWy+TxTgRpzXePNOLQ9SaUjqhq2XbrjfRruOeU5JHldzXTF
         M3Cl+6907b1K+uVMChYOnaCqzzrWbX4SqK7SCQ3JhXB5Kn894X5OZuWBMxZ4oNfrUwU1
         yBhA==
X-Gm-Message-State: APjAAAXOxGSid3/yhgBNdNeUKEKhUKdUpLdjxPtqf2R407TmwsR+TJtQ
        t85pd2SioUHDz4LN3YQZI+scbS4=
X-Google-Smtp-Source: APXvYqwXjNg2CA80+uLWD4z0UL3VPDGz/jzUkMpvESID16KJ5KddPNLxNm0TuJc/0RtYi0YQQa3HZQ==
X-Received: by 2002:a02:22c6:: with SMTP id o189mr23689060jao.35.1562636459755;
        Mon, 08 Jul 2019 18:40:59 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l2sm14566219ioh.20.2019.07.08.18.40.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:40:59 -0700 (PDT)
Date:   Mon, 8 Jul 2019 19:40:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     George Hung <ghung.quanta@gmail.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        benjaminfair@google.com, wak@google.com, Avi.Fishman@nuvoton.com,
        tomer.maimon@nuvoton.com, openbmc@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5.2 v2 2/2] dt-binding: edac: add NPCM ECC documentation
Message-ID: <20190709014058.GA30269@bogus>
References: <20190605141253.38554-1-ghung.quanta@gmail.com>
 <20190605141253.38554-2-ghung.quanta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605141253.38554-2-ghung.quanta@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 05, 2019 at 10:12:53PM +0800, George Hung wrote:
> Add device tree documentation for Nuvoton BMC ECC
> 
> Signed-off-by: George Hung <ghung.quanta@gmail.com>
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
> +- compatible:	should be "nuvoton,npcm7xx-sdram-edac"

Is this for the whole SDRAM controller or just ECC related registers? 
In the former case, the naming should just reflect the block name and 
not a Linux term.

> +- reg:		Memory controller register set should be <0xf0824000 0x1000>
> +- interrupts:	should be MC interrupt #25
> +
> +Example:
> +
> +	mc: memory-controller@f0824000 {
> +		compatible = "nuvoton,npcm7xx-sdram-edac";
> +		reg = <0xf0824000 0x1000>;
> +		interrupts = <0 25 4>;
> +	};
> -- 
> 2.21.0
> 
