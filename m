Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE422F782
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgG0SO3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 14:14:29 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38659 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgG0SO3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Jul 2020 14:14:29 -0400
Received: by mail-il1-f195.google.com with SMTP id s21so13903498ilk.5;
        Mon, 27 Jul 2020 11:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPmxfYQDyT8r9CcnowDVVykigkQ+z869mGL3I9FOWwo=;
        b=BdhgMsN66sRBooFq8ZkMQzcEIrYFHI4dS9ClZo+YjP37BDflDMJklDk/hbKpN0KUG1
         j3WT6FAI5vHxe26gzwRxYnnqNFqVfJ8L4ivkBlZJ3tiyxQhCtA9CGPzuUzVE8WQ/QkVe
         TaSNnVkcrATxn+Bp3P6mi46TADFKzvFlKdxn0IOZ/9Xj1MBMX2DF0DQEAKdyJHtt8wVY
         gNy/qWr9roVJ3JzWDAQrfAoVqaXlyse88xJFABdTOiwi2qMTPFmIvsQEYAtHtZ33IIj5
         kkrRHi7tx3uYAK1YQGIyEMgo24k+f1LsLewXKMNvDejRkJUafCQqIFGR6gx5pzW/prRc
         HOGQ==
X-Gm-Message-State: AOAM5328fCAoqGwOninl8eb2emrVgV1F/5kVkSgGp55kl8ZFXbUEVUkT
        OB+IcYIGp+heiAevl5tnOg==
X-Google-Smtp-Source: ABdhPJwOPsDlRJNd39fzhlpbhYZJWTt8o2fLoFjCpKxHuendknVSAZX52OcisWkASIdYEOtqu66cqA==
X-Received: by 2002:a05:6e02:545:: with SMTP id i5mr20290346ils.59.1595873668199;
        Mon, 27 Jul 2020 11:14:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b11sm1133142ile.32.2020.07.27.11.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:14:27 -0700 (PDT)
Received: (nullmailer pid 639381 invoked by uid 1000);
        Mon, 27 Jul 2020 18:14:24 -0000
Date:   Mon, 27 Jul 2020 12:14:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@kernel.org, davem@davemloft.net, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, ronenk@amazon.com, james.morse@arm.com,
        bp@alien8.de, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, hhhawa@amazon.com, hanochu@amazon.com,
        mark.rutland@arm.com, eitan@amazon.com, will@kernel.org,
        nicolas.ferre@microchip.com, jonnyc@amazon.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v8 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20200727181424.GA639053@bogus>
References: <20200726191555.5210-1-talel@amazon.com>
 <20200726191555.5210-2-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726191555.5210-2-talel@amazon.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, 26 Jul 2020 22:15:54 +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/edac/amazon,al-mc-edac.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.example.dt.yaml: example-0: edac@f0080000:reg:0: [0, 4027056128, 0, 65536] is too long


See https://patchwork.ozlabs.org/patch/1336532

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

