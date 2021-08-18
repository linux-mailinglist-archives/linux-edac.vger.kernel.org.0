Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696623F090C
	for <lists+linux-edac@lfdr.de>; Wed, 18 Aug 2021 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhHRQ1H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Aug 2021 12:27:07 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43861 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHRQ1G (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Aug 2021 12:27:06 -0400
Received: by mail-ot1-f49.google.com with SMTP id x10-20020a056830408a00b004f26cead745so4750310ott.10;
        Wed, 18 Aug 2021 09:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ofqhQAE5ziey+TSgey3tU1oJ0+I7JswXZYpYeGHRXw=;
        b=aOWehDbXtOeB98m2f4yVIz7CId8HR89cUTasCAJDr5ZSLdGmMSN0AUBg5rbDB6vzzR
         pijPNy6nT8nfnnMfXb0wnRxhYUyVnFKpQpBoFzHwm0IToyL9lu5UcCIESYEe4j9LJ4DW
         /2l01vshP/C75vRt0G7ajlupxymL1Zoyitx4rcS+Be2pgCX45GsI/0a7+sFbuyr4KaGl
         XXiWu0Nn7QTMTDsqUnZOGQvRfhuHCFqe5AJ/Qx4MEyoP8ddYGpV8qNmm7NCjgY7qw+Oe
         AJRbVotpVuu3ehpf2XBHFE/ksrRKNxFwqD4xyaAaw6DV0SJW9eDah1q/x7dvIgFXmRUm
         Ekfg==
X-Gm-Message-State: AOAM5327R5HnvTAuwx53/g86KBdDe9maNfN57p1TwSGuVqsf1puNMpc4
        jwiCKK92mA81OMqWC2xAeg==
X-Google-Smtp-Source: ABdhPJwMKMPrLWKCpenk91db+fCe7ateEr8j812vmY4exQ+NNCP3Nlt4XpwwheERA/wBvxAf4XsGgg==
X-Received: by 2002:a9d:75c2:: with SMTP id c2mr7605833otl.287.1629303991417;
        Wed, 18 Aug 2021 09:26:31 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i19sm23670ooe.44.2021.08.18.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:26:30 -0700 (PDT)
Received: (nullmailer pid 2714781 invoked by uid 1000);
        Wed, 18 Aug 2021 16:26:29 -0000
Date:   Wed, 18 Aug 2021 11:26:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Robert Richter <rric@kernel.org>,
        Jan Luebbe <jlu@pengutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/2] dt-bindings: memory: convert Marvell MVEBU SDRAM
 controller to dtschema
Message-ID: <YR00tUpqXD7HeY7P@robh.at.kernel.org>
References: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817093807.59531-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 17 Aug 2021 11:38:06 +0200, Krzysztof Kozlowski wrote:
> Convert Marvell MVEBU SDRAM controller bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../marvell,mvebu-sdram-controller.yaml       | 31 +++++++++++++++++++
>  .../mvebu-sdram-controller.txt                | 21 -------------
>  2 files changed, 31 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/marvell,mvebu-sdram-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mvebu-sdram-controller.txt
> 

Applied, thanks!
