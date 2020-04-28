Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F581BBBE7
	for <lists+linux-edac@lfdr.de>; Tue, 28 Apr 2020 13:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgD1LHK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Apr 2020 07:07:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47434 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD1LHJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Apr 2020 07:07:09 -0400
Received: from zn.tnic (p200300EC2F0EA50005F31991FCF74C40.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a500:5f3:1991:fcf7:4c40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EB821EC0CE4;
        Tue, 28 Apr 2020 13:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588072028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6yM3ywV4SHYRhMID8a0485MgrxeuX8DEuZQLHvXZu6Q=;
        b=JMxXKhjn18H3V9nLLHLvhBv7M38fREPnFGpmQ/rKPlrxu3FxzTLqpP8b50grNQYfWT85Cw
        XgwLzTnKZ3tM6dRdrUvBwrJmkxNPMoIiz82Ihj/jG3OWo/eOhQ9B89fILz4RVTFYORo0RB
        3y/So7HpASg3dOx1fp6J5wslbr2xbgg=
Date:   Tue, 28 Apr 2020 13:06:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     robh+dt@kernel.org
Cc:     Talel Shenhar <talel@amazon.com>, mchehab@kernel.org,
        james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, hhhawa@amazon.com,
        ronenk@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        eitan@amazon.com
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20200428110659.GA11272@zn.tnic>
References: <20200224134132.23924-1-talel@amazon.com>
 <20200224134132.23924-2-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224134132.23924-2-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 24, 2020 at 03:41:31PM +0200, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/edac/amazon,al-mc-edac.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> new file mode 100644
> index 000000000000..20505f37c9f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only

WARNING: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
#36: FILE: Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml:1:
+# SPDX-License-Identifier: GPL-2.0-only

Hi Rob, should I listen to checkpatch or ignore it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
