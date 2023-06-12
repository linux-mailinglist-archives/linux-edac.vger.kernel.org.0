Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEDE72C2B0
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jun 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjFLLQ2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jun 2023 07:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjFLLQO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Jun 2023 07:16:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CBF86A0;
        Mon, 12 Jun 2023 04:04:34 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D44581EC00F8;
        Mon, 12 Jun 2023 13:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686567867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T5nu9ZiswE8RQGkFS+4IJ1ouiCYUZY13HPLb8yI2yYA=;
        b=W8nu84eTQvRnF4UeMz24J1cC/kFA7UM8HvnIScr0+6ShSg/m9dBxHr/AR2+sIojoCny6Fx
        +MucpbBbReK/MKa7gk+pV7AahSZ3LiEPafYMxq6uVzDcQrjpg20xayNjtwcJprHZj3pOav
        g11YP2oAJPTUU3rG4HuXXhYWtHMbyeM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686567866; bh=T5nu9ZiswE8RQGkFS+4IJ1ouiCYUZY13HPLb8yI2yYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikUWVJffQiCr88x+Hnv0MZdtPiDa8ZUbowg/PIC/eVozysKk3SHxztfxvdVn9oHbo
         2c6G7xZxO8Jr+66yEpo1w6U0tcMUbSst+7SXc+0y045AwbO5m2qPhPDrWpsVyGhoTX
         V0KlSjUZcpRUPRwFB7secNmlWkXMzhRC1c9o3gPb1ARdBClu5ktMwkVtnNMEZjKaxh
         0yQ8PRcwWwiyEDrkd6dii6zh5LjqxmAXbC8sIxCGuLWgqUbNHZowElNQuUzuXZeyNZ
         yObK5b0MkZPXrWyvWbW1VTNOw1f+UO3/pDCI72sT9TtsoZgY5NR+eYxvCy5r3kymNA
         3scktC3xgYzodIKWcWD2W3Z3QoAejgSVj4KHHfymnD9ZhPwec5aRnwJTUmUD/bRbFY
         xaieyDoSqieP/ro+HlpZN3AV0D08AlzX2KEVPNLMO0Drp6fohmaWJnRsMOkwBk6ea9
         gn9bAlKn2fOLWcCbt4hvWgr+XqZBO0g1PGCs+Weu183bt+qpeHdBckjpVjL8bplXKJ
         SpNY2ML/EPJaxvVUfGBlV67nuOLcT5t9pQTTYdbr0xuTwSpgkxpvv3oG2AECE9fhsf
         AbDXWErEprnRwmGJ/+B3AnRB/b0d0zMal7acrgICjYc5T93VN+YvEDON0825Ajr9Zt
         ymxQOB6ieMSpIIE8nWHqyi50=
Received: from zn.tnic (p200300eA971dc508329c23FFFEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c508:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4567740E01E6;
        Mon, 12 Jun 2023 11:04:05 +0000 (UTC)
Date:   Mon, 12 Jun 2023 13:04:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marvin Lin <milkfafa@gmail.com>
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com
Subject: Re: [PATCH v18 1/3] ARM: dts: nuvoton: Add node for NPCM memory
 controller
Message-ID: <20230612110401.GPZIb7oZPdsPGFzSDc@fat_crate.local>
References: <20230111093245.318745-1-milkfafa@gmail.com>
 <20230111093245.318745-2-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230111093245.318745-2-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 11, 2023 at 05:32:43PM +0800, Marvin Lin wrote:
> Add node for memory controller present on Nuvoton NPCM SoCs. The
> memory controller supports single bit error correction and double bit
> error detection.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

I guess this needs an Ack from OF folks if it is going to go through the
EDAC tree ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
